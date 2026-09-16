package com.microfinance.service;

import com.microfinance.dto.*;
import com.microfinance.exception.InvalidPolicyStateException;
import com.microfinance.exception.LockInPeriodActiveException;
import com.microfinance.exception.PolicyNotFoundException;
import com.microfinance.model.*;
import com.microfinance.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.transaction.Transactional;
import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.util.List;
import java.util.stream.Collectors;

/**
 * MisRenewalService — core business logic for MIS lifecycle:
 *   createMisPolicy → monthly payout → maturity → renew / prematureClose
 */
@Service
public class MisRenewalService {

    // ── Configurable rates from application.properties ────────────────────
    @Value("${mis.tds.rate:10.0}")
    private double tdsRate;

    @Value("${mis.tds.threshold.yearly:5000.0}")
    private double tdsThresholdYearly;

    @Value("${mis.premature.penalty.rate:1.0}")
    private double defaultPenaltyRate;

    // ── Repositories ─────────────────────────────────────────────────────
    @Autowired private MisPolicyRepo misPolicyRepo;
    @Autowired private MisPayoutLedgerRepo ledgerRepo;
    @Autowired private MisClosureAuditRepo closureAuditRepo;
    @Autowired private CreateSavingAccountRepo savingAccountRepo;
    @Autowired private MisDepositePMRepo misDepositePMRepo;

    private static final DateTimeFormatter DATE_FMT = DateTimeFormatter.ofPattern("yyyy-MM-dd");

    // ════════════════════════════════════════════════════════════════════════
    //  1. CREATE MIS POLICY
    // ════════════════════════════════════════════════════════════════════════

    /**
     * Creates a MisPolicy from a request DTO.
     * Called internally by PolicyManagementService when schemeType=MIS,
     * or directly via REST POST /api/mis/policies.
     */
    @Transactional
    public MisPolicy createMisPolicy(MisPolicyRequestDto req) {
        LocalDate startDate = LocalDate.parse(req.getStartDate(), DATE_FMT);

        // Pull plan config for lockIn, payoutDay, penalty if planId given
        int lockInMonths = req.getLockInMonths() != null ? req.getLockInMonths() : 0;
        int payoutDay    = req.getPayoutDay()    != null ? req.getPayoutDay()    : startDate.getDayOfMonth();

        if (req.getPlanId() != null) {
            MISDepositPM plan = misDepositePMRepo.findById(req.getPlanId()).orElse(null);
            if (plan != null) {
                if (plan.getLockInMonths() != null) lockInMonths = plan.getLockInMonths();
                if (plan.getPayoutDay()    != null) payoutDay    = plan.getPayoutDay();
            }
        }

        // Calculate monthly payout: (principal × rate) / 1200
        BigDecimal principal    = req.getPrincipalAmount().setScale(2, RoundingMode.HALF_UP);
        BigDecimal rate         = req.getInterestRate().setScale(2, RoundingMode.HALF_UP);
        BigDecimal monthlyPayout = principal.multiply(rate)
                .divide(BigDecimal.valueOf(1200), 2, RoundingMode.HALF_UP);

        // Maturity date
        LocalDate maturityDate = startDate.plusMonths(req.getTenureMonths());

        // Generate policy number: MIS-YYYY-NNNNNN
        String policyNumber = generatePolicyNumber();

        MisPolicy policy = new MisPolicy();
        policy.setPolicyNumber(policyNumber);
        policy.setCustomerId(req.getCustomerId());
        policy.setCustomerName(req.getCustomerName());
        policy.setPlanId(req.getPlanId());
        policy.setPlanName(req.getPlanName());
        policy.setPrincipalAmount(principal);
        policy.setInterestRate(rate);
        policy.setTenureMonths(req.getTenureMonths());
        policy.setStartDate(startDate);
        policy.setMaturityDate(maturityDate);
        policy.setMonthlyPayoutAmount(monthlyPayout);
        policy.setPayoutDay(payoutDay);
        policy.setLockInMonths(lockInMonths);
        policy.setStatus("ACTIVE");
        policy.setLinkedAccountId(req.getLinkedAccountId() != null ? req.getLinkedAccountId() : req.getCustomerId());
        policy.setNomineeName(req.getNomineeName());
        policy.setNomineeRelation(req.getNomineeRelation());
        policy.setAddInvestmentId(req.getAddInvestmentId());

        return misPolicyRepo.save(policy);
    }

    // ════════════════════════════════════════════════════════════════════════
    //  2. FETCH METHODS
    // ════════════════════════════════════════════════════════════════════════

    public List<MisPolicyResponseDto> getAllPolicies() {
        return misPolicyRepo.findAll().stream().map(this::toDto).collect(Collectors.toList());
    }

    public MisPolicyResponseDto getPolicyById(Long id) {
        MisPolicy policy = misPolicyRepo.findById(id)
                .orElseThrow(() -> new PolicyNotFoundException(id));
        return toDto(policy);
    }

    public List<MisPolicyResponseDto> getPoliciesByCustomer(String customerId) {
        return misPolicyRepo.findByCustomerId(customerId)
                .stream().map(this::toDto).collect(Collectors.toList());
    }

    public List<MisPayoutLedger> getLedgerByPolicyId(Long policyId) {
        misPolicyRepo.findById(policyId).orElseThrow(() -> new PolicyNotFoundException(policyId));
        return ledgerRepo.findByPolicyIdOrderByPayoutDateDesc(policyId);
    }

    // ════════════════════════════════════════════════════════════════════════
    //  3. SUMMARY
    // ════════════════════════════════════════════════════════════════════════

    public MisSummaryDto getSummary(Long policyId) {
        MisPolicy p = misPolicyRepo.findById(policyId)
                .orElseThrow(() -> new PolicyNotFoundException(policyId));

        BigDecimal totalInterest = ledgerRepo.sumInterestByPolicyId(policyId);
        BigDecimal totalTds      = ledgerRepo.sumTdsByPolicyId(policyId);
        BigDecimal totalPaid     = ledgerRepo.sumNetPaidByPolicyId(policyId);

        LocalDate today = LocalDate.now();
        List<MisPayoutLedger> ledger = ledgerRepo.findByPolicyIdOrderByPayoutDateDesc(policyId);
        LocalDate progressDate = (ledger != null && !ledger.isEmpty()) ? ledger.get(0).getPayoutDate() : (p.getStartDate() != null ? p.getStartDate() : today);

        long daysUntilMaturity = (p.getMaturityDate() != null) ? Math.max(0, ChronoUnit.DAYS.between(progressDate, p.getMaturityDate())) : 0;

        // Lock-in: check if progressDate < startDate + lockInMonths
        LocalDate lockInEnd = (p.getStartDate() != null ? p.getStartDate() : today).plusMonths(p.getLockInMonths() != null ? p.getLockInMonths() : 0);
        boolean lockInActive = progressDate.isBefore(lockInEnd);

        // Next payout date
        String nextPayout = calculateNextPayoutDate(p, today);

        MisSummaryDto dto = new MisSummaryDto();
        dto.setPolicyNumber(p.getPolicyNumber());
        dto.setCustomerName(p.getCustomerName());
        dto.setTotalInvested(p.getPrincipalAmount());
        dto.setTotalInterestEarned(totalInterest);
        dto.setTotalTdsDeducted(totalTds);
        dto.setTotalAmountPaid(totalPaid);
        dto.setNextPayoutDate(nextPayout);
        dto.setDaysUntilMaturity(daysUntilMaturity);
        dto.setCurrentStatus(p.getStatus());
        dto.setMonthlyPayoutAmount(p.getMonthlyPayoutAmount());
        dto.setLockInActive(lockInActive);
        dto.setLockInEndsOn(lockInEnd.toString());
        return dto;
    }

    // ════════════════════════════════════════════════════════════════════════
    //  4. MONTHLY PAYOUT PROCESSING (called by scheduler)
    // ════════════════════════════════════════════════════════════════════════

    @Transactional
    public void processMonthlyPayouts() {
        LocalDate today = LocalDate.now();

        // First: check for matured policies
        List<MisPolicy> matured = misPolicyRepo.findMaturedActivePolicies(today);
        for (MisPolicy p : matured) {
            try {
                processMisMaturity(p);
            } catch (Exception e) {
                System.err.println("MIS Maturity error for policy " + p.getPolicyNumber() + ": " + e.getMessage());
            }
        }

        // Then: process regular monthly payouts
        int dayOfMonth = today.getDayOfMonth();
        List<MisPolicy> duePolicies = misPolicyRepo.findActiveByPayoutDay(dayOfMonth);

        for (MisPolicy p : duePolicies) {
            try {
                processSinglePayout(p, today);
            } catch (Exception e) {
                System.err.println("MIS Payout error for policy " + p.getPolicyNumber() + ": " + e.getMessage());
            }
        }
    }

    @Transactional
    public void processSinglePayout(MisPolicy p, LocalDate payoutDate) {
        // Duplicate payout guard
        if (ledgerRepo.existsByPolicyIdAndPayoutDate(p.getId(), payoutDate)) {
            return;
        }

        BigDecimal interest = p.getMonthlyPayoutAmount().setScale(2, RoundingMode.HALF_UP);

        // TDS: check annual interest vs threshold
        BigDecimal yearlyInterestSoFar = ledgerRepo.sumInterestByPolicyId(p.getId());
        BigDecimal annualInterest = p.getMonthlyPayoutAmount().multiply(BigDecimal.valueOf(12));
        BigDecimal tdsDeducted = BigDecimal.ZERO;

        boolean tdsApplicable = annualInterest.compareTo(BigDecimal.valueOf(tdsThresholdYearly)) > 0;
        if (tdsApplicable) {
            tdsDeducted = interest.multiply(BigDecimal.valueOf(tdsRate / 100))
                    .setScale(2, RoundingMode.HALF_UP);
        }

        BigDecimal netPaid = interest.subtract(tdsDeducted).setScale(2, RoundingMode.HALF_UP);

        // Credit savings account
        creditSavingsAccount(p.getLinkedAccountId(), netPaid,
                "MIS Interest payout: " + p.getPolicyNumber());

        // Create ledger entry
        MisPayoutLedger ledger = new MisPayoutLedger();
        ledger.setPolicyId(p.getId());
        ledger.setPayoutDate(payoutDate);
        ledger.setInterestAmount(interest);
        ledger.setTdsDeducted(tdsDeducted);
        ledger.setNetPaid(netPaid);
        ledger.setStatus("PAID");
        ledgerRepo.save(ledger);

        System.out.println("MIS Payout: " + p.getPolicyNumber() + " | Gross: " + interest +
                " | TDS: " + tdsDeducted + " | Net: " + netPaid);
    }

    /**
     * Adds the next monthly payout for a policy on-demand (month-by-month testing & admin payout addition).
     * Automatically calculates the next payout date based on policy start date and previous payout history.
     */
    @Transactional
    public MisPayoutLedger addNextPayout(Long policyId) {
        MisPolicy p = misPolicyRepo.findById(policyId)
                .orElseThrow(() -> new IllegalArgumentException("MIS Policy not found with ID: " + policyId));

        if (!"ACTIVE".equals(p.getStatus())) {
            throw new IllegalStateException("Policy " + p.getPolicyNumber() + " is not ACTIVE (status: " + p.getStatus() + "). Cannot add payout.");
        }

        LocalDate startDate = p.getStartDate() != null ? p.getStartDate() : LocalDate.now();
        int targetDay = startDate.getDayOfMonth();

        List<MisPayoutLedger> existingLedger = ledgerRepo.findByPolicyIdOrderByPayoutDateDesc(policyId);
        LocalDate nextPayoutDate;

        if (existingLedger != null && !existingLedger.isEmpty()) {
            LocalDate lastPayoutDate = existingLedger.get(0).getPayoutDate();
            nextPayoutDate = lastPayoutDate.plusMonths(1);
        } else {
            nextPayoutDate = startDate.plusMonths(1);
        }

        int maxDay = nextPayoutDate.lengthOfMonth();
        int dayToUse = Math.min(targetDay, maxDay);
        nextPayoutDate = nextPayoutDate.withDayOfMonth(dayToUse);

        if (p.getMaturityDate() != null && nextPayoutDate.isAfter(p.getMaturityDate())) {
            throw new IllegalStateException("Cannot add payout: Next payout date (" + nextPayoutDate + 
                    ") is after policy maturity date (" + p.getMaturityDate() + ").");
        }

        if (ledgerRepo.existsByPolicyIdAndPayoutDate(p.getId(), nextPayoutDate)) {
            throw new IllegalStateException("Payout for policy " + p.getPolicyNumber() + 
                    " on date " + nextPayoutDate + " already exists.");
        }

        processSinglePayout(p, nextPayoutDate);

        List<MisPayoutLedger> updatedLedger = ledgerRepo.findByPolicyIdOrderByPayoutDateDesc(policyId);
        return updatedLedger.isEmpty() ? null : updatedLedger.get(0);
    }

    // ════════════════════════════════════════════════════════════════════════
    //  5. MATURITY PROCESSING
    // ════════════════════════════════════════════════════════════════════════

    @Transactional
    public void processMisMaturity(MisPolicy policy) {
        // Credit principal amount to account
        creditSavingsAccount(policy.getLinkedAccountId(), policy.getPrincipalAmount(),
                "MIS Maturity principal return: " + policy.getPolicyNumber());

        // Update policy status
        policy.setStatus("MATURED");
        misPolicyRepo.save(policy);

        // Record maturity closure audit
        MisClosureAudit audit = new MisClosureAudit();
        audit.setPolicyId(policy.getId());
        audit.setClosureType("MATURITY");
        audit.setClosureDate(LocalDate.now());
        audit.setPenaltyApplied(BigDecimal.ZERO);
        audit.setRefundAmount(policy.getPrincipalAmount());
        audit.setReason("Automatic maturity processing");
        closureAuditRepo.save(audit);

        System.out.println("MIS Maturity processed: " + policy.getPolicyNumber() +
                " | Principal returned: " + policy.getPrincipalAmount());
    }

    // ════════════════════════════════════════════════════════════════════════
    //  6. PREMATURE CLOSURE
    // ════════════════════════════════════════════════════════════════════════

    @Transactional
    public MisClosureAudit prematureClose(Long policyId, String reason) {
        MisPolicy policy = misPolicyRepo.findById(policyId)
                .orElseThrow(() -> new PolicyNotFoundException(policyId));

        if (!"ACTIVE".equals(policy.getStatus())) {
            throw new InvalidPolicyStateException(
                    "Premature closure not allowed. Policy status is: " + policy.getStatus());
        }

        LocalDate today = LocalDate.now();
        int lockIn = policy.getLockInMonths() != null ? policy.getLockInMonths() : 0;
        LocalDate lockInEnd = policy.getStartDate().plusMonths(lockIn);

        if (today.isBefore(lockInEnd)) {
            throw new LockInPeriodActiveException(
                    "Lock-in period is active until " + lockInEnd + ". Premature closure not allowed.");
        }

        // Determine penalty rate: use plan's configured rate if available, else application.properties default
        BigDecimal penaltyRate = BigDecimal.valueOf(defaultPenaltyRate);
        if (policy.getPlanId() != null) {
            MISDepositPM plan = misDepositePMRepo.findById(policy.getPlanId()).orElse(null);
            if (plan != null && plan.getPrematureClosurePenaltyRate() != null) {
                penaltyRate = plan.getPrematureClosurePenaltyRate();
            }
        }

        BigDecimal principal = policy.getPrincipalAmount();
        BigDecimal penalty   = principal.multiply(penaltyRate.divide(BigDecimal.valueOf(100), 4, RoundingMode.HALF_UP))
                .setScale(2, RoundingMode.HALF_UP);
        BigDecimal refund    = principal.subtract(penalty).setScale(2, RoundingMode.HALF_UP);

        // Credit refund to savings account
        creditSavingsAccount(policy.getLinkedAccountId(), refund,
                "MIS Premature closure refund: " + policy.getPolicyNumber());

        // Update policy status
        policy.setStatus("PREMATURELY_CLOSED");
        misPolicyRepo.save(policy);

        // Create closure audit
        MisClosureAudit audit = new MisClosureAudit();
        audit.setPolicyId(policyId);
        audit.setClosureType("PREMATURE");
        audit.setClosureDate(today);
        audit.setPenaltyApplied(penalty);
        audit.setRefundAmount(refund);
        audit.setReason(reason);
        return closureAuditRepo.save(audit);
    }

    // ════════════════════════════════════════════════════════════════════════
    //  7. RENEWAL
    // ════════════════════════════════════════════════════════════════════════

    @Transactional
    public MisPolicy renewPolicy(Long oldPolicyId) {
        MisPolicy old = misPolicyRepo.findById(oldPolicyId)
                .orElseThrow(() -> new PolicyNotFoundException(oldPolicyId));

        if (!"MATURED".equals(old.getStatus())) {
            throw new InvalidPolicyStateException(
                    "Only MATURED policies can be renewed. Current status: " + old.getStatus());
        }

        // Create new policy using same terms, start date = today
        MisPolicyRequestDto req = new MisPolicyRequestDto();
        req.setCustomerId(old.getCustomerId());
        req.setCustomerName(old.getCustomerName());
        req.setPlanId(old.getPlanId());
        req.setPlanName(old.getPlanName());
        req.setPrincipalAmount(old.getPrincipalAmount());
        req.setInterestRate(old.getInterestRate());
        req.setTenureMonths(old.getTenureMonths());
        req.setStartDate(LocalDate.now().toString());
        req.setPayoutDay(old.getPayoutDay());
        req.setLockInMonths(old.getLockInMonths());
        req.setLinkedAccountId(old.getLinkedAccountId());
        req.setNomineeName(old.getNomineeName());
        req.setNomineeRelation(old.getNomineeRelation());

        MisPolicy newPolicy = createMisPolicy(req);
        newPolicy.setRenewedFromPolicyId(oldPolicyId);
        misPolicyRepo.save(newPolicy);

        // Close old policy
        old.setStatus("CLOSED");
        misPolicyRepo.save(old);

        System.out.println("MIS Renewal: " + old.getPolicyNumber() + " → " + newPolicy.getPolicyNumber());
        return newPolicy;
    }

    // ════════════════════════════════════════════════════════════════════════
    //  INTERNAL HELPERS
    // ════════════════════════════════════════════════════════════════════════

    /**
     * Credits the given amount to the customer's savings account.
     * Reuses the same savings account lookup pattern as the existing investment service.
     */
    private void creditSavingsAccount(String customerId, BigDecimal amount, String description) {
        if (customerId == null || customerId.trim().isEmpty()) {
            System.err.println("MIS: No linked account — skipping credit. " + description);
            return;
        }
        List<CreateSavingsAccount> accounts = savingAccountRepo.findBySelectByCustomer(customerId);
        if (accounts == null || accounts.isEmpty()) {
            System.err.println("MIS: Savings account not found for customer: " + customerId + " — " + description);
            return;
        }
        CreateSavingsAccount acc = accounts.get(0);
        double currentBalance = 0.0;
        try {
            currentBalance = acc.getBalance() != null ? Double.parseDouble(acc.getBalance()) : 0.0;
        } catch (NumberFormatException ignored) {}

        double newBalance = currentBalance + amount.doubleValue();
        acc.setBalance(String.valueOf(newBalance));
        savingAccountRepo.save(acc);
        System.out.println("MIS Credit: " + amount + " → Account of " + customerId +
                " | New balance: " + newBalance + " | " + description);
    }

    /** Generates a unique MIS policy number: MIS-YYYY-NNNNNN */
    private String generatePolicyNumber() {
        int year = LocalDate.now().getYear();
        long maxId = misPolicyRepo.getMaxId() + 1;
        return String.format("MIS-%d-%06d", year, maxId);
    }

    /** Calculates next payout date for an ACTIVE policy based on start date and payout history */
    private String calculateNextPayoutDate(MisPolicy p, LocalDate today) {
        if (!"ACTIVE".equals(p.getStatus())) return null;
        LocalDate startDate = p.getStartDate() != null ? p.getStartDate() : today;
        int targetDay = startDate.getDayOfMonth();

        List<MisPayoutLedger> ledger = ledgerRepo.findByPolicyIdOrderByPayoutDateDesc(p.getId());
        LocalDate nextDate;
        if (ledger != null && !ledger.isEmpty()) {
            nextDate = ledger.get(0).getPayoutDate().plusMonths(1);
        } else {
            nextDate = startDate.plusMonths(1);
        }

        int dayToUse = Math.min(targetDay, nextDate.lengthOfMonth());
        nextDate = nextDate.withDayOfMonth(dayToUse);

        if (p.getMaturityDate() != null && nextDate.isAfter(p.getMaturityDate())) {
            return "Matured (All payouts done)";
        }
        return nextDate.toString();
    }

    /** Converts entity to response DTO */
    public MisPolicyResponseDto toDto(MisPolicy p) {
        MisPolicyResponseDto dto = new MisPolicyResponseDto();
        dto.setId(p.getId());
        dto.setPolicyNumber(p.getPolicyNumber());
        dto.setCustomerId(p.getCustomerId());
        dto.setCustomerName(p.getCustomerName());
        dto.setPlanId(p.getPlanId());
        dto.setPlanName(p.getPlanName());
        dto.setPrincipalAmount(p.getPrincipalAmount());
        dto.setInterestRate(p.getInterestRate());
        dto.setTenureMonths(p.getTenureMonths());
        dto.setStartDate(p.getStartDate() != null ? p.getStartDate().toString() : null);
        dto.setMaturityDate(p.getMaturityDate() != null ? p.getMaturityDate().toString() : null);
        dto.setMonthlyPayoutAmount(p.getMonthlyPayoutAmount());
        dto.setPayoutDay(p.getPayoutDay());
        dto.setLockInMonths(p.getLockInMonths());
        dto.setStatus(p.getStatus());
        dto.setLinkedAccountId(p.getLinkedAccountId());
        dto.setNomineeName(p.getNomineeName());
        dto.setNomineeRelation(p.getNomineeRelation());
        dto.setRenewedFromPolicyId(p.getRenewedFromPolicyId());
        LocalDate today = LocalDate.now();
        List<MisPayoutLedger> ledger = ledgerRepo.findByPolicyIdOrderByPayoutDateDesc(p.getId());
        LocalDate progressDate = (ledger != null && !ledger.isEmpty()) ? ledger.get(0).getPayoutDate() : (p.getStartDate() != null ? p.getStartDate() : today);
        if (p.getMaturityDate() != null) {
            dto.setDaysUntilMaturity(Math.max(0, ChronoUnit.DAYS.between(progressDate, p.getMaturityDate())));
        }
        dto.setNextPayoutDate(calculateNextPayoutDate(p, today));
        return dto;
    }
}
