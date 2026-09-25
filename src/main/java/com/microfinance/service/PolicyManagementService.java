package com.microfinance.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import java.util.Optional;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;

import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.PolicyManagementDto;
import com.microfinance.dto.MisPolicyRequestDto;
import com.microfinance.model.AddnewinvestmentPM;
import com.microfinance.model.CreateSavingsAccount;
import com.microfinance.model.DailyDepositPM;
import com.microfinance.model.DailyPremiumRenewalPM;
import com.microfinance.model.FixedDepositPM;
import com.microfinance.model.FlexibleRenewal;
import com.microfinance.model.FullMaturity;
import com.microfinance.model.MISDepositPM;
import com.microfinance.model.MisPayoutLedger;
import com.microfinance.model.MisPolicy;
import com.microfinance.model.addCustomer;
import com.microfinance.model.MisClosureAudit;
import com.microfinance.model.PolicyRenewal;
import com.microfinance.model.RecurringDepositPM;
import com.microfinance.repository.AddCustomerRepo;
import com.microfinance.repository.AddInvestmentRepo;
import com.microfinance.repository.CreateSavingAccountRepo;
import com.microfinance.repository.DailyDepositPMRepo;
import com.microfinance.repository.DailyPremiumRenewalRepo;
import com.microfinance.repository.FixedDepositPMRepo;
import com.microfinance.repository.FlexibleRenewalRepo;
import com.microfinance.repository.FullMaturityRepo;
import com.microfinance.repository.MisClosureAuditRepo;
import com.microfinance.repository.MisDepositePMRepo;
import com.microfinance.repository.MisPayoutLedgerRepo;
import com.microfinance.repository.MisPolicyRepo;
import com.microfinance.repository.PolicyRenewalRepo;
import com.microfinance.repository.RecurringDepositRepo;

@Service
public class PolicyManagementService {
	@Autowired
	CreateSavingAccountRepo createSavingAccountRepo;

	@Autowired
	DailyDepositPMRepo dailyDepositPMRepo;

	@Autowired
	RecurringDepositRepo recurringDepositRepo;

	@Autowired
	FixedDepositPMRepo fixedDepositPMRepo;

	@Autowired
	MisDepositePMRepo misDepositePMRepo;

	@Autowired
	AddInvestmentRepo addinvestmentrepo;

	@Autowired
	PolicyRenewalRepo policyRenewalRepo;

	@Autowired
	DailyPremiumRenewalRepo dailyPremiumRenewalRepo;

	@Autowired
	FlexibleRenewalRepo flexibleRenewalRepo;

	@Autowired
	FullMaturityRepo fullMaturityRepo;

	// MIS Renewal Service — injected for auto-policy creation on MIS investment
	@Autowired
	MisRenewalService misRenewalService;

	// MIS repositories — used to extend policy-code lookups for MIS policies
	@Autowired
	MisPolicyRepo misPolicyRepo;

	@Autowired
	MisPayoutLedgerRepo misPayoutLedgerRepo;

	@Autowired
	AddCustomerRepo addCustomerRepo;

	@Autowired
	MisClosureAuditRepo misClosureAuditRepo;

	@Value("${mis.tds.rate:10.0}")
	private double misTdsRate;

	@Value("${mis.tds.threshold.yearly:100.0}")
	private double misTdsThresholdYearly;

	@Value("${mis.premature.penalty.rate:5.0}")
	private double misDefaultPenaltyRate;

	public boolean saveRecuringDailyDeposite(RecurringDepositPM deposit) {
		try {
			recurringDepositRepo.save(deposit);
			return true;
		} catch (Exception e) {
			e.printStackTrace(); // Log actual error
			return false;
		}
	}

	public List<RecurringDepositPM> getAllData1() {
		// TODO Auto-generated method stub
		return recurringDepositRepo.findAll();
	}

	// fixed deposite of the service
	public boolean saveFixedDeposite(FixedDepositPM fixedDepositPM) {
		// TODO Auto-generated method stub
		try {
			fixedDepositPMRepo.save(fixedDepositPM);
			return true;
		} catch (Exception e) {
			e.printStackTrace(); // Log actual error
			return false;
		}
	}

	// feacth all data of the fixed deposite
	public List<FixedDepositPM> getAllFixeddata() {
		// TODO Auto-generated method stub
		return fixedDepositPMRepo.findAll();
	}

	// daily Deposite save service
	public boolean savedailydeposite(DailyDepositPM dailyDepositPM) {
		// TODO Auto-generated method stub
		try {
			dailyDepositPMRepo.save(dailyDepositPM);
			return true;
		} catch (Exception e) {
			e.printStackTrace(); // Log actual error
			return false;
		}
	}

	// feacth all data of the daily deposite
	public List<DailyDepositPM> getAlldailydepositedata() {
		// TODO Auto-generated method stub
		return dailyDepositPMRepo.findAll();
	}

	// MIS Deposite save service
	public boolean savemistdeposite(MISDepositPM misDepositPM) {
		try {
			misDepositePMRepo.save(misDepositPM);
			return true;
		} catch (Exception e) {
			e.printStackTrace(); // Log actual error
			return false;
		}
	}

	public List<MISDepositPM> getAllMISDepositData() {
		// TODO Auto-generated method stub
		return misDepositePMRepo.findAll();
	}

	public DailyDepositPM getDailyDepositById(Long id) {
		// TODO Auto-generated method stub
		return dailyDepositPMRepo.findById(id).orElse(null);
	}

	public DailyDepositPM updateDailyDeposit(Long id, DailyDepositPM updatedData) {
		// TODO Auto-generated method stub

		return dailyDepositPMRepo.findById(id).map(existing -> {
			existing.setPlanCodeDD(updatedData.getPlanCodeDD());
			existing.setMinimumDeposit(updatedData.getMinimumDeposit());
			existing.setRateOfInterest(updatedData.getRateOfInterest());
			existing.setInstallmentType(updatedData.getInstallmentType());
			existing.setPlanNameDD(updatedData.getPlanNameDD());
			existing.setCommissionOnNew(updatedData.getCommissionOnNew());
			existing.setRenewalCommission(updatedData.getRenewalCommission());
			existing.setDdterm(updatedData.getDdterm());
			existing.setInterestInterval(updatedData.getInterestInterval());
			existing.setTotalPaid(updatedData.getTotalPaid());
			existing.setMaturityAmount(updatedData.getMaturityAmount());
			existing.setFlexiblePlan(updatedData.getFlexiblePlan());
			existing.setGraceDays(updatedData.getGraceDays());
			existing.setPenaltyRate(updatedData.getPenaltyRate());
			existing.setStatusOfPlan(updatedData.getStatusOfPlan());

			return dailyDepositPMRepo.save(existing); // Fixed here
		}).orElse(null);
	}

	public boolean deleteDailyDeposit(Long id) {
		// TODO Auto-generated method stub
		if (dailyDepositPMRepo.existsById(id)) {
			dailyDepositPMRepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

	// edit by id reccuring deposite
	public RecurringDepositPM getRecurringDepositById(Long id) {
		// TODO Auto-generated method stub
		return recurringDepositRepo.findById(id).orElse(null);
	}

	// update the reccuring deposite service
	public RecurringDepositPM updateRecurringDeposit(Long id, RecurringDepositPM updatedData) {
		Optional<RecurringDepositPM> existingOptional = recurringDepositRepo.findById(id);

		if (existingOptional.isPresent()) {
			RecurringDepositPM existing = existingOptional.get();

			// 🔁 Update all fields manually
			existing.setPlanCodeRD(updatedData.getPlanCodeRD());
			existing.setPlanNameRD(updatedData.getPlanNameRD());
			existing.setMinimumAmountRD(updatedData.getMinimumAmountRD());
			existing.setRateOfInterestRD(updatedData.getRateOfInterestRD());
			existing.setInstallmentTypeRD(updatedData.getInstallmentTypeRD());
			existing.setRdterm(updatedData.getRdterm());
			existing.setCommissionOnNewRD(updatedData.getCommissionOnNewRD());
			existing.setRenewalCommissionRD(updatedData.getRenewalCommissionRD());
			existing.setComponentIntervalRD(updatedData.getComponentIntervalRD());
			existing.setTotalPaidRD(updatedData.getTotalPaidRD());
			existing.setMaturityAmountRD(updatedData.getMaturityAmountRD());
			existing.setFlexiblePlanRD(updatedData.getFlexiblePlanRD());
			existing.setGraceDaysRD(updatedData.getGraceDaysRD());
			existing.setPenaltyfineRD(updatedData.getPenaltyfineRD());
			existing.setStatusOfPlanRD(updatedData.getStatusOfPlanRD());

			// Save updated object
			return recurringDepositRepo.save(existing);
		} else {
			return null; // ❌ ID not found
		}
	}

	// delete the recurring deposit service

	public boolean deleteRecurringDeposit(Long id) {
		if (recurringDepositRepo.existsById(id)) {
			recurringDepositRepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

	// Fetch the data fixed deposit service

	public FixedDepositPM getFixedDepositById(Long id) {
		// TODO Auto-generated method stub
		return fixedDepositPMRepo.findById(id).orElse(null);
	}

	public FixedDepositPM updateFixedDeposit(Long id, FixedDepositPM updatedData) {
		Optional<FixedDepositPM> existingOptional = fixedDepositPMRepo.findById(id);

		if (existingOptional.isPresent()) {
			FixedDepositPM existing = existingOptional.get();

			// Update all fields
			existing.setPlanCodeFD(updatedData.getPlanCodeFD());
			existing.setPlanNameFD(updatedData.getPlanNameFD());
			existing.setMinimumAmountFD(updatedData.getMinimumAmountFD());
			existing.setRateOfInterestFD(updatedData.getRateOfInterestFD());
			existing.setFdterm(updatedData.getFdterm());
			existing.setInstallmentTypeFD(updatedData.getInstallmentTypeFD());
			existing.setCommissionOnNewFD(updatedData.getCommissionOnNewFD());
			existing.setComponentIntervalFD(updatedData.getComponentIntervalFD());
			existing.setTotalPaidFD(updatedData.getTotalPaidFD());
			existing.setMaturityAmountFD(updatedData.getMaturityAmountFD());
			existing.setFlexiblePlanFD(updatedData.getFlexiblePlanFD());
			existing.setRenewalCommissionFD(updatedData.getRenewalCommissionFD());
			existing.setGraceDaysFD(updatedData.getGraceDaysFD());
			existing.setPenltyfineFD(updatedData.getPenltyfineFD());
			existing.setStatusOfPlanFD(updatedData.getStatusOfPlanFD());

			return fixedDepositPMRepo.save(existing); // save updated data
		}

		return null; // not found
	}

	public boolean deleteFixedDeposit(Long id) {
		if (fixedDepositPMRepo.existsById(id)) {
			fixedDepositPMRepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

	public MISDepositPM getMISDepositById(Long id) {
		// TODO Auto-generated method stub
		return misDepositePMRepo.findById(id).orElse(null);
	}

	public MISDepositPM updateMISDeposit(Long id, MISDepositPM updatedData) {
		// TODO Auto-generated method stub
		Optional<MISDepositPM> existingOptional = misDepositePMRepo.findById(id);

		if (existingOptional.isPresent()) {
			MISDepositPM existing = existingOptional.get();

			// Set fields from updatedData to existing
			existing.setPlanCodeMD(updatedData.getPlanCodeMD());
			existing.setPlanNameMD(updatedData.getPlanNameMD());
			existing.setRateOfInterestMD(updatedData.getRateOfInterestMD());
			existing.setInstallmentTypeMD(updatedData.getInstallmentTypeMD());
			existing.setMinimumAmountMD(updatedData.getMinimumAmountMD());
			existing.setMaturityROIMD(updatedData.getMaturityROIMD());
			existing.setMisTerm(updatedData.getMisTerm());
			existing.setMISIntROIMD(updatedData.getMISIntROIMD());
			existing.setMISIntervalMD(updatedData.getMISIntervalMD());
			existing.setMISInterestMD(updatedData.getMISInterestMD());
			existing.setMaturityAmountMD(updatedData.getMaturityAmountMD());
			existing.setFlexiblePlanMD(updatedData.getFlexiblePlanMD());
			existing.setCommissionOnNewMD(updatedData.getCommissionOnNewMD());
			existing.setRenewalCommissionMD(updatedData.getRenewalCommissionMD());
			existing.setStatusOfPlanMDRD2(updatedData.getStatusOfPlanMDRD2());
			// Update new MIS configuration fields
			existing.setLockInMonths(updatedData.getLockInMonths());
			existing.setPayoutDay(updatedData.getPayoutDay());
			existing.setPrematureClosurePenaltyRate(updatedData.getPrematureClosurePenaltyRate());

			return misDepositePMRepo.save(existing);
		}
		return null;

	}

	public boolean deleteMISDeposit(Long id) {
		if (misDepositePMRepo.existsById(id)) {
			misDepositePMRepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

	// Ashwini
	/*
	 * public List<AddnewinvestmentPM> getAddInvestmentDetails() { // TODO
	 * Auto-generated method stub return addinvestmentrepo.findAll(); }
	 */

	public List<String> getSchemeNameBySchemeType(String drd) {
		List<DailyDepositPM> allDrdPlans = dailyDepositPMRepo.findBydrd(drd);
		return allDrdPlans.stream()
				.filter(p -> p != null && p.getPlanNameDD() != null)
				.map(DailyDepositPM::getPlanNameDD).distinct().collect(Collectors.toList());
	}

	public List<String> getRRDBySchemeType(String rd) {
		List<RecurringDepositPM> allRrdPlans = recurringDepositRepo.findByrd(rd);
		return allRrdPlans.stream()
				.filter(p -> p != null && p.getPlanNameRD() != null)
				.map(RecurringDepositPM::getPlanNameRD).distinct().collect(Collectors.toList());
	}

	public List<String> getFRDBySchemeType(String fd) {
		List<FixedDepositPM> allFrdPlans = fixedDepositPMRepo.findByfd(fd);
		return allFrdPlans.stream()
				.filter(p -> p != null && p.getPlanNameFD() != null)
				.map(FixedDepositPM::getPlanNameFD).distinct().collect(Collectors.toList());
	}

	public List<String> getMISRDBySchemeType(String mis) {
		String targetMis = (mis != null && !mis.trim().isEmpty()) ? mis.trim() : "MIS";
		List<MISDepositPM> allMisrdPlans = misDepositePMRepo.findByMisFlexible(targetMis);
		return allMisrdPlans.stream()
				.filter(p -> p != null && p.getPlanNameMD() != null && !p.getPlanNameMD().trim().isEmpty())
				.map(MISDepositPM::getPlanNameMD).distinct().collect(Collectors.toList());
	}

	public DailyDepositPM getDDTermAndInterestRate(String planNameDD) {
		return dailyDepositPMRepo.findByplanNameDD(planNameDD);
	}

	public List<AddnewinvestmentPM> getAddInvestmentDetails() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public RecurringDepositPM getRDTermAndInterestRate(String planNameRD) {
		return recurringDepositRepo.findByplanNameRD(planNameRD);
	}

	public FixedDepositPM getFDTermAndInterestRate(String planNameFD) {
		return fixedDepositPMRepo.findByplanNameFD(planNameFD);
	}

	public MISDepositPM getMISTermAndInterestRate(String planNameMD) {
		return misDepositePMRepo.findByplanNameMD(planNameMD);
	}

	public List<AddnewinvestmentPM> findByBranch(String branchName) {
		// TODO Auto-generated method stub
		List<AddnewinvestmentPM> list = addinvestmentrepo.findByBranchName(branchName);
		return list;
	}

	public AddnewinvestmentPM getDetailsById(Long id) {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findById(id).orElse(null);
	}

	public AddnewinvestmentPM saveInvestment(AddnewinvestmentPM investment) {
		return addinvestmentrepo.save(investment);
	}

	public List<DailyDepositPM> getAllDDTerm() {
		// TODO Auto-generated method stub
		return dailyDepositPMRepo.findAll();
	}

	public List<AddnewinvestmentPM> getAllInvestments() {
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> getAllPolicyManagementData() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> x() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> getApprovedInvestments() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findByIsApprovedTrue();
	}

	public List<AddnewinvestmentPM> getApprovedRDPolicies() {
		return addinvestmentrepo.findApprovedRDPolicies();
	}

	public List<AddnewinvestmentPM> getApprovedFDPolicies() {
		return addinvestmentrepo.findApprovedFDPolicies();
	}

	public List<AddnewinvestmentPM> getApprovedDDPolicies() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findApprovedDDPolicies();
	}

	public List<AddnewinvestmentPM> getAllRdRenewalData() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> getAllDdRenewalData() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> getAllFdRenewalData() {
		// TODO Auto-generated method stub
		return addinvestmentrepo.findAll();
	}

	public List<AddnewinvestmentPM> getAllApprovedPolicies() {
		// Original approved policies (RD, FD, DRD, MIS, etc. from AddnewinvestmentPM)
		List<AddnewinvestmentPM> result = new java.util.ArrayList<>(addinvestmentrepo.findByIsApprovedTrue());

		// Track existing policy codes already in result to avoid duplicates
		java.util.Set<String> existingCodes = new java.util.HashSet<>();
		for (AddnewinvestmentPM item : result) {
			if (item.getPolicyCode() != null && !item.getPolicyCode().trim().isEmpty()) {
				existingCodes.add(item.getPolicyCode().trim().toUpperCase());
			}
		}

		// Also include ACTIVE MIS policies from mis_policy table that are not already present
		List<MisPolicy> misPolicies = misPolicyRepo.findByStatus("ACTIVE");
		for (MisPolicy mis : misPolicies) {
			AddnewinvestmentPM linkedInv = null;
			if (mis.getAddInvestmentId() != null) {
				linkedInv = addinvestmentrepo.findById(mis.getAddInvestmentId()).orElse(null);
			}

			String codeToUse = null;
			if (linkedInv != null && linkedInv.getPolicyCode() != null && !linkedInv.getPolicyCode().trim().isEmpty()) {
				codeToUse = linkedInv.getPolicyCode().trim();
			} else if (mis.getPolicyNumber() != null && !mis.getPolicyNumber().trim().isEmpty()) {
				codeToUse = mis.getPolicyNumber().trim();
			}

			if (codeToUse != null && !existingCodes.contains(codeToUse.toUpperCase())) {
				if (linkedInv != null) {
					result.add(linkedInv);
				} else {
					AddnewinvestmentPM dto = mapMisPolicyToInvestment(mis);
					dto.setPolicyCode(codeToUse);
					result.add(dto);
				}
				existingCodes.add(codeToUse.toUpperCase());
			}
		}
		return result;
	}

	/**
	 * Looks up a policy by policyCode — first in the original AddnewinvestmentPM table,
	 * then in mis_policy (and resolves linked investment). Returns empty if not found in either.
	 */
	public Optional<AddnewinvestmentPM> findByPolicyCode(String policyCode) {
		if (policyCode == null || policyCode.trim().isEmpty())
			return Optional.empty();

		String normalizedCode = policyCode.trim();

		// First: try original AddnewinvestmentPM table directly by policyCode (case-insensitive)
		Optional<AddnewinvestmentPM> existing = addinvestmentrepo.findAll().stream()
				.filter(p -> p.getPolicyCode() != null && p.getPolicyCode().trim().equalsIgnoreCase(normalizedCode))
				.findFirst();
		if (existing.isPresent()) return existing;

		// Second: try mis_policy table by policyNumber (or legacy MIS-YYYY-NNNNNN format)
		Optional<MisPolicy> mis = misPolicyRepo.findByPolicyNumberIgnoreCase(normalizedCode);
		if (!mis.isPresent()) {
			mis = misPolicyRepo.findByPolicyNumber(normalizedCode);
		}
		if (mis.isPresent()) {
			MisPolicy mp = mis.get();
			if (mp.getAddInvestmentId() != null) {
				Optional<AddnewinvestmentPM> linkedInv = addinvestmentrepo.findById(mp.getAddInvestmentId());
				if (linkedInv.isPresent()) {
					return linkedInv;
				}
			}
			return Optional.of(mapMisPolicyToInvestment(mp));
		}

		return Optional.empty();
	}

	/** Finds MIS payout ledger entries by policy number (for Investment Transaction Slip) */
	public List<MisPayoutLedger> findMisPayoutLedger(String policyNumber) {
		if (policyNumber == null || policyNumber.trim().isEmpty()) return Collections.emptyList();
		String code = policyNumber.trim();

		// 1. Try direct match in misPolicyRepo by policyNumber
		Optional<MisPolicy> directMis = misPolicyRepo.findByPolicyNumberIgnoreCase(code);
		if (!directMis.isPresent()) {
			directMis = misPolicyRepo.findByPolicyNumber(code);
		}
		if (directMis.isPresent()) {
			return misPayoutLedgerRepo.findByPolicyIdOrderByPayoutDateDesc(directMis.get().getId());
		}

		// 2. Lookup AddnewinvestmentPM by policyCode -> find linked MisPolicy via addInvestmentId
		Optional<AddnewinvestmentPM> inv = addinvestmentrepo.findAll().stream()
				.filter(p -> p.getPolicyCode() != null && p.getPolicyCode().trim().equalsIgnoreCase(code))
				.findFirst();
		if (inv.isPresent()) {
			Long addInvId = inv.get().getId();
			Optional<MisPolicy> misByInv = misPolicyRepo.findByAddInvestmentId(addInvId);
			if (!misByInv.isPresent()) {
				misByInv = misPolicyRepo.findAll().stream()
						.filter(m -> addInvId.equals(m.getAddInvestmentId()))
						.findFirst();
			}
			if (misByInv.isPresent()) {
				return misPayoutLedgerRepo.findByPolicyIdOrderByPayoutDateDesc(misByInv.get().getId());
			}
		}

		return Collections.emptyList();
	}

	/**
	 * Finds MIS policy and payout data mapped to PolicyRenewal records for the Investment Transaction Slip.
	 * Accurately maps Customer Name, Policy Amount, Renewal Date, Policy Type, Normal or Premature Maturity Amount,
	 * Start Date, Policy Term, Maturity Date, Customer Code, Contact No, Total Deposit, Installments Paid, Approved, and Branch Name.
	 */
	public List<PolicyRenewal> findMisRenewalData(String policyCode) {
		if (policyCode == null || policyCode.trim().isEmpty()) {
			return Collections.emptyList();
		}
		String code = policyCode.trim();

		// 1. Try finding MisPolicy entity
		MisPolicy mis = misPolicyRepo.findByPolicyNumberIgnoreCase(code)
				.orElseGet(() -> misPolicyRepo.findByPolicyNumber(code).orElse(null));

		// 2. Try finding AddnewinvestmentPM
		AddnewinvestmentPM inv = addinvestmentrepo.findByPolicyCode(code).orElse(null);
		if (inv == null) {
			inv = addinvestmentrepo.findAll().stream()
					.filter(p -> p.getPolicyCode() != null && p.getPolicyCode().trim().equalsIgnoreCase(code))
					.findFirst().orElse(null);
		}

		if (mis == null && inv != null) {
			Long addInvId = inv.getId();
			mis = misPolicyRepo.findByAddInvestmentId(addInvId)
					.orElseGet(() -> misPolicyRepo.findAll().stream()
							.filter(m -> addInvId.equals(m.getAddInvestmentId()))
							.findFirst().orElse(null));
		}

		if (mis == null && inv == null) {
			return Collections.emptyList();
		}

		// Customer Code
		String customerCode = mis != null && mis.getCustomerId() != null && !mis.getCustomerId().trim().isEmpty()
				? mis.getCustomerId().trim()
				: (inv != null && inv.getMemberSelection() != null ? inv.getMemberSelection().trim() : "");

		// Customer Name
		String customerName = mis != null && mis.getCustomerName() != null && !mis.getCustomerName().trim().isEmpty()
				? mis.getCustomerName().trim()
				: (inv != null && inv.getCustomerName() != null ? inv.getCustomerName().trim() : "");

		// Contact No and Branch Name
		String contactNo = "";
		String branchName = "";
		if (!customerCode.isEmpty()) {
			List<addCustomer> custs = addCustomerRepo.findByMemberCode(customerCode);
			if (custs != null && !custs.isEmpty()) {
				addCustomer c = custs.get(0);
				if (c.getContactNo() != null) contactNo = c.getContactNo();
				if (c.getBranchName() != null) branchName = c.getBranchName();
				if (customerName.isEmpty() && c.getCustomerName() != null) {
					customerName = c.getCustomerName();
				}
			}
		}
		if (inv != null) {
			if (contactNo.isEmpty() && inv.getContactNo() != null) {
				contactNo = inv.getContactNo();
			}
			if (inv.getBranchName() != null && !inv.getBranchName().trim().isEmpty()) {
				branchName = inv.getBranchName();
			}
		}

		// Policy Principal Amount
		BigDecimal principal = BigDecimal.ZERO;
		if (mis != null && mis.getPrincipalAmount() != null) {
			principal = mis.getPrincipalAmount();
		} else if (inv != null && inv.getPolicyAmount() != null && !inv.getPolicyAmount().trim().isEmpty()) {
			try {
				principal = new BigDecimal(inv.getPolicyAmount().trim());
			} catch (Exception ignored) {}
		}

		// Tenure Months
		int tenureMonths = 0;
		if (mis != null && mis.getTenureMonths() != null) {
			tenureMonths = mis.getTenureMonths();
		} else if (inv != null && inv.getSchemeTerm() != null && !inv.getSchemeTerm().trim().isEmpty()) {
			try {
				tenureMonths = Integer.parseInt(inv.getSchemeTerm().trim());
			} catch (Exception ignored) {}
		}

		// Start Date
		String startDate = "";
		if (mis != null && mis.getStartDate() != null) {
			startDate = mis.getStartDate().toString();
		} else if (inv != null && inv.getPolicyStartDate() != null) {
			startDate = inv.getPolicyStartDate();
		}

		// Maturity Date
		String maturityDate = "";
		if (mis != null && mis.getMaturityDate() != null) {
			maturityDate = mis.getMaturityDate().toString();
		} else if (inv != null && inv.getMaturityDate() != null && !inv.getMaturityDate().trim().isEmpty()) {
			maturityDate = inv.getMaturityDate();
		} else if (!startDate.isEmpty() && tenureMonths > 0) {
			try {
				maturityDate = LocalDate.parse(startDate).plusMonths(tenureMonths).toString();
			} catch (Exception ignored) {}
		}

		// Interest Rate
		BigDecimal interestRate = BigDecimal.ZERO;
		if (mis != null && mis.getInterestRate() != null) {
			interestRate = mis.getInterestRate();
		} else if (inv != null && inv.getRoi() != null && !inv.getRoi().trim().isEmpty()) {
			try {
				interestRate = new BigDecimal(inv.getRoi().trim());
			} catch (Exception ignored) {}
		}

		// Calculate Maturity Amount
		Double maturityAmount;
		if (mis != null && "PREMATURELY_CLOSED".equalsIgnoreCase(mis.getStatus())) {
			List<MisClosureAudit> audits = misClosureAuditRepo.findByPolicyId(mis.getId());
			if (audits != null && !audits.isEmpty() && audits.get(0).getRefundAmount() != null) {
				maturityAmount = audits.get(0).getRefundAmount().doubleValue();
			} else {
				BigDecimal penaltyRate = BigDecimal.valueOf(misDefaultPenaltyRate);
				if (mis.getPlanId() != null) {
					MISDepositPM plan = misDepositePMRepo.findById(mis.getPlanId()).orElse(null);
					if (plan != null && plan.getPrematureClosurePenaltyRate() != null) {
						penaltyRate = plan.getPrematureClosurePenaltyRate();
					}
				}
				BigDecimal penalty = principal.multiply(penaltyRate.divide(BigDecimal.valueOf(100), 4, RoundingMode.HALF_UP))
						.setScale(2, RoundingMode.HALF_UP);
				BigDecimal refund = principal.subtract(penalty).setScale(2, RoundingMode.HALF_UP);
				maturityAmount = refund.doubleValue();
			}
		} else {
			BigDecimal monthlyPayout = mis != null ? mis.getMonthlyPayoutAmount() : null;
			if (monthlyPayout == null && interestRate.compareTo(BigDecimal.ZERO) > 0) {
				monthlyPayout = principal.multiply(interestRate)
						.divide(BigDecimal.valueOf(1200), 2, RoundingMode.HALF_UP);
			}
			if (monthlyPayout == null) monthlyPayout = BigDecimal.ZERO;

			BigDecimal annualInterest = monthlyPayout.multiply(BigDecimal.valueOf(12));
			BigDecimal monthlyTds = BigDecimal.ZERO;
			if (annualInterest.compareTo(BigDecimal.valueOf(misTdsThresholdYearly)) > 0) {
				monthlyTds = monthlyPayout.multiply(BigDecimal.valueOf(misTdsRate / 100))
						.setScale(2, RoundingMode.HALF_UP);
			}

			BigDecimal totalInterest = monthlyPayout.multiply(BigDecimal.valueOf(tenureMonths)).setScale(2, RoundingMode.HALF_UP);
			BigDecimal totalTds = monthlyTds.multiply(BigDecimal.valueOf(tenureMonths)).setScale(2, RoundingMode.HALF_UP);
			BigDecimal normalMaturity = principal.add(totalInterest).subtract(totalTds).setScale(2, RoundingMode.HALF_UP);
			maturityAmount = normalMaturity.doubleValue();
		}

		// Approved status
		boolean approved = inv != null ? inv.isApproved() : (mis != null && !"PREMATURELY_CLOSED".equalsIgnoreCase(mis.getStatus()));

		// Installments paid count & Ledger records
		List<MisPayoutLedger> ledgers = mis != null
				? misPayoutLedgerRepo.findByPolicyIdOrderByPayoutDateDesc(mis.getId())
				: Collections.emptyList();

		int paidCount = (int) ledgers.stream().filter(l -> "PAID".equalsIgnoreCase(l.getStatus())).count();

		List<PolicyRenewal> list = new ArrayList<>();

		if (!ledgers.isEmpty()) {
			List<MisPayoutLedger> sortedLedgers = ledgers.stream()
					.sorted(Comparator.comparing(MisPayoutLedger::getPayoutDate))
					.collect(Collectors.toList());

			for (MisPayoutLedger ledger : sortedLedgers) {
				PolicyRenewal pr = new PolicyRenewal();
				pr.setPolicyCode(code);
				pr.setClientName(customerName);
				pr.setPolicyAmount(principal.doubleValue());
				pr.setRenewalDate(ledger.getPayoutDate() != null ? ledger.getPayoutDate().toString() : "");
				pr.setPolicyType("MIS");
				pr.setMaturityAmount(maturityAmount);
				pr.setTotalDeposit(principal.doubleValue());
				pr.setPolicyDate(startDate);
				pr.setPolicyTerm(tenureMonths + " months");
				pr.setMaturityDate(maturityDate);
				pr.setCustomerCode(customerCode);
				pr.setContactNo(contactNo);
				pr.setPaymentDue(0.0);
				pr.setNoOfInstPaid(paidCount);
				pr.setApproved(approved);
				pr.setBranchname(branchName);
				list.add(pr);
			}
		} else {
			PolicyRenewal pr = new PolicyRenewal();
			pr.setPolicyCode(code);
			pr.setClientName(customerName);
			pr.setPolicyAmount(principal.doubleValue());
			pr.setRenewalDate(startDate);
			pr.setPolicyType("MIS");
			pr.setMaturityAmount(maturityAmount);
			pr.setTotalDeposit(principal.doubleValue());
			pr.setPolicyDate(startDate);
			pr.setPolicyTerm(tenureMonths + " months");
			pr.setMaturityDate(maturityDate);
			pr.setCustomerCode(customerCode);
			pr.setContactNo(contactNo);
			pr.setPaymentDue(0.0);
			pr.setNoOfInstPaid(0);
			pr.setApproved(approved);
			pr.setBranchname(branchName);
			list.add(pr);
		}

		return list;
	}

	/** Maps a MisPolicy entity to AddnewinvestmentPM shape so the same IRB UI/JS can render it */
	private AddnewinvestmentPM mapMisPolicyToInvestment(MisPolicy mis) {
		String code = mis.getPolicyNumber();
		if (mis.getAddInvestmentId() != null) {
			AddnewinvestmentPM inv = addinvestmentrepo.findById(mis.getAddInvestmentId()).orElse(null);
			if (inv != null && inv.getPolicyCode() != null && !inv.getPolicyCode().trim().isEmpty()) {
				code = inv.getPolicyCode().trim();
			}
		}

		AddnewinvestmentPM dto = new AddnewinvestmentPM();
		dto.setPolicyCode(code);
		dto.setCustomerName(mis.getCustomerName());
		dto.setMemberSelection(mis.getCustomerId());
		dto.setPolicyStartDate(mis.getStartDate() != null ? mis.getStartDate().toString() : null);
		dto.setMaturityDate(mis.getMaturityDate() != null ? mis.getMaturityDate().toString() : null);
		dto.setPolicyAmount(mis.getPrincipalAmount() != null ? mis.getPrincipalAmount().toPlainString() : null);
		dto.setDepositAmount(mis.getPrincipalAmount() != null ? mis.getPrincipalAmount().toPlainString() : null);
		dto.setRoi(mis.getInterestRate() != null ? mis.getInterestRate().toPlainString() : null);
		dto.setSchemeTerm(mis.getTenureMonths() != null ? mis.getTenureMonths() + " Months" : null);
		dto.setSchemeType("MIS");
		dto.setSchemeName(mis.getPlanName());
		dto.setSchemeCode(mis.getPlanName());
		dto.setSuggestedNominee(mis.getNomineeName());
		dto.setRelation(mis.getNomineeRelation());
		dto.setSchemeMode("Monthly");
		// Monthly payout as "paid amount" (interest per month)
		dto.setPaidAmount(mis.getMonthlyPayoutAmount() != null ? mis.getMonthlyPayoutAmount().toPlainString() : null);
		dto.setApproved("ACTIVE".equalsIgnoreCase(mis.getStatus()) || "MATURED".equalsIgnoreCase(mis.getStatus()));
		return dto;
	}

	public AddnewinvestmentPM updateInstalmentDetails(String policyCode, String DepositAmount) {
		Optional<AddnewinvestmentPM> optionalInvestment = addinvestmentrepo.findByPolicyCode(policyCode);

		if (optionalInvestment.isPresent()) {
			AddnewinvestmentPM investment = optionalInvestment.get();

			// Set the new deposit amount
			investment.setDepositAmount(DepositAmount);

			// Increment lastInstPaid
			try {
				int last = Integer
						.parseInt(investment.getLastInstPaid() == null || investment.getLastInstPaid().isEmpty() ? "0"
								: investment.getLastInstPaid());
				investment.setLastInstPaid(String.valueOf(last + 1));
			} catch (NumberFormatException e) {
				investment.setLastInstPaid("1");
			}

			// Save and return updated investment
			return addinvestmentrepo.save(investment);
		}

		return null; // or throw custom exception if you prefer
	}

	public List<FlexibleRenewal> findBypolicyCode(String policyCode) {
		return flexibleRenewalRepo.findByPolicyCode(policyCode);
	}

	public List<DailyPremiumRenewalPM> findDailyData(String policyCode) {
		return dailyPremiumRenewalRepo.findByPolicyCode(policyCode);
	}

	public List<PolicyRenewal> findRenewalData(String policyCode) {
		return policyRenewalRepo.findByPolicyCode(policyCode);
	}

	@Transactional
	public ApiResponse<AddnewinvestmentPM> saveandupdateAddInvestmentDetails(PolicyManagementDto policyManagementDto,
			String image1, String image2) {
		// TODO Auto-generated method stub
		AddnewinvestmentPM addnewinvestmentPM = new AddnewinvestmentPM();
		boolean isNew = true;

		// Check if the ClientMaster is being updated
		if (policyManagementDto.getId() != null && policyManagementDto.getId() > 0) {
			addnewinvestmentPM = addinvestmentrepo.findById(policyManagementDto.getId())
					.orElse(new AddnewinvestmentPM());
			isNew = false;
		}

		// Handle Saving Account payment deduction on new investment creation
		String paymentBy = policyManagementDto.getPaymentBy();
		if (isNew && paymentBy != null && ("savingaccount".equalsIgnoreCase(paymentBy.replaceAll("\\s+", ""))
				|| "saving account".equalsIgnoreCase(paymentBy))) {
			String memberCode = policyManagementDto.getMemberSelection();
			if (memberCode == null || memberCode.trim().isEmpty()) {
				return ApiResponse.error(HttpStatus.BAD_REQUEST,
						"Customer selection is required for Saving Account payment.");
			}

			List<CreateSavingsAccount> accounts = createSavingAccountRepo.findBySelectByCustomer(memberCode);
			if (accounts == null || accounts.isEmpty()) {
				return ApiResponse.error(HttpStatus.BAD_REQUEST, "No Saving Account found for Customer: " + memberCode);
			}

			CreateSavingsAccount savingAcc = accounts.get(0);
			double accountBalance = 0.0;
			if (savingAcc.getBalance() != null && !savingAcc.getBalance().trim().isEmpty()) {
				try {
					accountBalance = Double.parseDouble(savingAcc.getBalance());
				} catch (NumberFormatException e) {
					accountBalance = 0.0;
				}
			}

			double investmentAmount = 0.0;
			String amtStr = policyManagementDto.getPolicyAmount();
			if (amtStr == null || amtStr.trim().isEmpty()) {
				amtStr = policyManagementDto.getPaidAmount();
			}
			if (amtStr != null && !amtStr.trim().isEmpty()) {
				try {
					investmentAmount = Double.parseDouble(amtStr);
				} catch (NumberFormatException e) {
					investmentAmount = 0.0;
				}
			}

			if (accountBalance < investmentAmount) {
				return ApiResponse.error(HttpStatus.BAD_REQUEST,
						"Insufficient Saving Account balance! Available Balance: " + accountBalance + ", Required: "
								+ investmentAmount);
			}

			// Deduct balance safely
			accountBalance -= investmentAmount;
			savingAcc.setBalance(String.valueOf(accountBalance));
			createSavingAccountRepo.save(savingAcc);
		}

		// Map fields from DTO to entity
		addnewinvestmentPM.setPolicyCode(policyManagementDto.getPolicyCode());
		addnewinvestmentPM.setPolicyStartDate(policyManagementDto.getPolicyStartDate());
		addnewinvestmentPM.setMemberSelection(policyManagementDto.getMemberSelection());
		addnewinvestmentPM.setCustomerName(policyManagementDto.getCustomerName());
		addnewinvestmentPM.setDateofBirth(policyManagementDto.getDateofBirth());
		addnewinvestmentPM.setRelationDetails(policyManagementDto.getRelationDetails());
		addnewinvestmentPM.setContactNo(policyManagementDto.getContactNo());
		addnewinvestmentPM.setSuggestedNominee(policyManagementDto.getSuggestedNominee());
		addnewinvestmentPM.setAgeOfNominee(policyManagementDto.getAgeOfNominee());
		addnewinvestmentPM.setRelation(policyManagementDto.getRelation());
		addnewinvestmentPM.setAddress(policyManagementDto.getAddress());
		addnewinvestmentPM.setDistrict(policyManagementDto.getDistrict());
		addnewinvestmentPM.setState(policyManagementDto.getState());
		addnewinvestmentPM.setPinCode(policyManagementDto.getPinCode());
		addnewinvestmentPM.setTds(policyManagementDto.getTds());
		addnewinvestmentPM.setBranchName(policyManagementDto.getBranchName());
		addnewinvestmentPM.setModeOfOperation(policyManagementDto.getModeOfOperation());
		addnewinvestmentPM.setJointMemCode(policyManagementDto.getJointMemCode());
		addnewinvestmentPM.setJointName(policyManagementDto.getJointName());
		addnewinvestmentPM.setMaturityDate(policyManagementDto.getMaturityDate());
		addnewinvestmentPM.setSchemeType(policyManagementDto.getSchemeType());
		addnewinvestmentPM.setSchemeTerm(policyManagementDto.getSchemeTerm());
		addnewinvestmentPM.setSchemeMode(policyManagementDto.getSchemeMode());
		addnewinvestmentPM.setRoi(policyManagementDto.getRoi());
		addnewinvestmentPM.setPolicyAmount(policyManagementDto.getPolicyAmount());
		addnewinvestmentPM.setDepositAmount(policyManagementDto.getDepositAmount());
		addnewinvestmentPM.setIntroMCode(policyManagementDto.getIntroMCode());
		addnewinvestmentPM.setMaturityAmount(policyManagementDto.getMaturityAmount());
		addnewinvestmentPM.setMISInterest(policyManagementDto.getMISInterest());
		addnewinvestmentPM.setPaidAmount(policyManagementDto.getPaidAmount());
		addnewinvestmentPM.setLastInstPaid(policyManagementDto.getLastInstPaid());

		addnewinvestmentPM.setPaymentBy(policyManagementDto.getPaymentBy());
		addnewinvestmentPM.setSchemeCode(policyManagementDto.getSchemeCode());
		addnewinvestmentPM.setRemark(policyManagementDto.getRemark());
		addnewinvestmentPM.setAgent(policyManagementDto.getAgent());
		addnewinvestmentPM.setSmsSend(policyManagementDto.getSmsSend());
		// Set photo path (already fetched)
		if (image1 != null && !image1.isEmpty()) {
			addnewinvestmentPM.setImage1(image1);
		}

		// Handle signature upload
		if (image2 != null && !image2.isEmpty()) {
			addnewinvestmentPM.setImage2(image2);
		}

		// Save entity to the database
		AddnewinvestmentPM saveaddinvestmentPM = addinvestmentrepo.save(addnewinvestmentPM);

		// ── MIS: auto-create MisPolicy when scheme type is MIS and this is a new investment
		if (isNew && "MIS".equalsIgnoreCase(policyManagementDto.getSchemeType())) {
			try {
				MISDepositPM misPlan = null;
				if (policyManagementDto.getSchemeName() != null) {
					misPlan = misDepositePMRepo.findByplanNameMD(policyManagementDto.getSchemeName());
				}

				MisPolicyRequestDto misReq = new MisPolicyRequestDto();
				misReq.setPolicyNumber(saveaddinvestmentPM.getPolicyCode());
				misReq.setCustomerId(policyManagementDto.getMemberSelection());
				misReq.setCustomerName(policyManagementDto.getCustomerName());
				misReq.setPlanName(policyManagementDto.getSchemeName());
				if (misPlan != null) misReq.setPlanId(misPlan.getId());

				// Principal amount
				String amtStr = policyManagementDto.getPolicyAmount();
				if (amtStr == null || amtStr.isEmpty()) amtStr = policyManagementDto.getDepositAmount();
				misReq.setPrincipalAmount(new java.math.BigDecimal(amtStr != null && !amtStr.isEmpty() ? amtStr : "0"));

				// Interest rate
				String roiStr = policyManagementDto.getRoi();
				if (roiStr == null || roiStr.isEmpty()) roiStr = policyManagementDto.getMISInterest();
				misReq.setInterestRate(new java.math.BigDecimal(roiStr != null && !roiStr.isEmpty() ? roiStr : "0"));

				// Tenure (try from schemeTerm, fallback to misPlan)
				int tenureMonths = 12;
				try {
					if (policyManagementDto.getSchemeTerm() != null && !policyManagementDto.getSchemeTerm().isEmpty()) {
						tenureMonths = Integer.parseInt(policyManagementDto.getSchemeTerm().replaceAll("[^0-9]", ""));
					} else if (misPlan != null && misPlan.getMisTerm() != null) {
						tenureMonths = Integer.parseInt(misPlan.getMisTerm().replaceAll("[^0-9]", ""));
					}
				} catch (NumberFormatException ignored) {}
				misReq.setTenureMonths(tenureMonths);

				// Start date
				String startDate = policyManagementDto.getPolicyStartDate();
				if (startDate == null || startDate.isEmpty()) startDate = java.time.LocalDate.now().toString();
				misReq.setStartDate(startDate);

				// Plan-level fields
				if (misPlan != null) {
					misReq.setLockInMonths(misPlan.getLockInMonths());
					misReq.setPayoutDay(misPlan.getPayoutDay());
				}

				// Nominee and linked account
				misReq.setNomineeName(policyManagementDto.getSuggestedNominee());
				misReq.setNomineeRelation(policyManagementDto.getRelation());
				misReq.setLinkedAccountId(policyManagementDto.getMemberSelection());
				misReq.setAddInvestmentId(saveaddinvestmentPM.getId());

				MisPolicy misPolicy = misRenewalService.createMisPolicy(misReq);
				System.out.println("MIS Policy auto-created: " + misPolicy.getPolicyNumber() +
						" for investment: " + saveaddinvestmentPM.getPolicyCode());
			} catch (Exception e) {
				System.err.println("Warning: MIS Policy auto-creation failed for investment " +
						saveaddinvestmentPM.getPolicyCode() + ": " + e.getMessage());
				// Do NOT roll back the investment — it's saved. Log and continue.
			}
		}
		// ── END MIS auto-creation
		if (isNew) {
			return ApiResponse.success(HttpStatus.CREATED,
					"Saved successfully. Customer Name: " + saveaddinvestmentPM.getCustomerName(), saveaddinvestmentPM);
		} else {
			return ApiResponse.success(HttpStatus.OK,
					"Updated successfully. Customer Name: " + saveaddinvestmentPM.getCustomerName(),
					saveaddinvestmentPM);
		}
	}

	public boolean existByMemberSelection(String customerCode) {
		// TODO Auto-generated method stub
		return addinvestmentrepo.existsByMemberSelection(customerCode);
	}

	public List<FullMaturity> fetchFullMaturityByPolicyCode(String policyCode) {
		if (policyCode == null || policyCode.trim().isEmpty()) {
			return Collections.emptyList(); // returns an immutable empty list
		}
		return fullMaturityRepo.findByPolicyCodeIgnoreCase(policyCode.trim());
	}

	public boolean deletePolicyDataById(Long id) {
		// TODO Auto-generated method stub
		if (addinvestmentrepo.existsById(id)) {
			addinvestmentrepo.deleteById(id);
			return true;
		} else {
			return false;
		}
	}

	public List<FullMaturity> getAllApprovedRDPolicies(String policyCode) {
		List<FullMaturity> result = new ArrayList<>();

		// 1. Get approved RD investments from addinvestmentrepo
		List<AddnewinvestmentPM> approvedRds = addinvestmentrepo.findApprovedRDPolicies();
		if (policyCode != null && !policyCode.trim().isEmpty()) {
			approvedRds = approvedRds.stream()
					.filter(a -> a.getPolicyCode() != null && a.getPolicyCode().trim().equalsIgnoreCase(policyCode.trim()))
					.collect(Collectors.toList());
		}

		for (AddnewinvestmentPM inv : approvedRds) {
			String pCode = inv.getPolicyCode() != null ? inv.getPolicyCode().trim() : "";

			// Always include the initial investment payment receipt
			FullMaturity initialFm = new FullMaturity();
			initialFm.setPolicyCode(pCode);
			initialFm.setCustomerName(inv.getCustomerName());
			initialFm.setPaymentDate(inv.getPolicyStartDate());
			initialFm.setPolicyAmount(inv.getPolicyAmount());
			initialFm.setPlanCode(inv.getSchemeCode());
			initialFm.setMaturityDate(inv.getMaturityDate());
			initialFm.setMaturityAmount(inv.getMaturityAmount());
			initialFm.setDuration(inv.getSchemeTerm());
			initialFm.setBranchName(inv.getBranchName());
			initialFm.setModeofPayment(inv.getPaymentBy() != null && !inv.getPaymentBy().trim().isEmpty() ? inv.getPaymentBy() : inv.getModeOfPayment());
			initialFm.setApproveStatus(true);
			result.add(initialFm);

			// Check renewals in flexibleRenewalRepo
			List<FlexibleRenewal> flexRenewals = flexibleRenewalRepo.findByPolicyCode(pCode);
			if (flexRenewals != null && !flexRenewals.isEmpty()) {
				for (FlexibleRenewal f : flexRenewals) {
					FullMaturity fm = new FullMaturity();
					fm.setPolicyCode(pCode);
					fm.setCustomerName(f.getClientName() != null && !f.getClientName().trim().isEmpty() ? f.getClientName() : inv.getCustomerName());
					fm.setPaymentDate(f.getRenewalDate() != null && !f.getRenewalDate().trim().isEmpty() ? f.getRenewalDate() : f.getPolicyDate());
					fm.setPolicyAmount(f.getPolicyAmount() != null ? String.valueOf(f.getPolicyAmount()) : inv.getPolicyAmount());
					fm.setPlanCode(inv.getSchemeCode());
					fm.setMaturityDate(f.getMaturityDate() != null && !f.getMaturityDate().trim().isEmpty() ? f.getMaturityDate() : inv.getMaturityDate());
					fm.setMaturityAmount(f.getMaturityAmount() != null ? String.valueOf(f.getMaturityAmount()) : inv.getMaturityAmount());
					fm.setDuration(f.getPolicyTerm() != null && !f.getPolicyTerm().trim().isEmpty() ? f.getPolicyTerm() : inv.getSchemeTerm());
					fm.setBranchName(f.getBranchname() != null && !f.getBranchname().trim().isEmpty() ? f.getBranchname() : inv.getBranchName());
					fm.setModeofPayment(f.getModeOfPayment() != null && !f.getModeOfPayment().trim().isEmpty() ? f.getModeOfPayment() : inv.getPaymentBy());
					fm.setApproveStatus(true);
					result.add(fm);
				}
			}

			// Also check policyRenewalRepo if any
			List<PolicyRenewal> pRenewals = policyRenewalRepo.findByPolicyCode(pCode);
			if (pRenewals != null && !pRenewals.isEmpty()) {
				for (PolicyRenewal pr : pRenewals) {
					FullMaturity fm = new FullMaturity();
					fm.setPolicyCode(pCode);
					fm.setCustomerName(pr.getClientName() != null && !pr.getClientName().trim().isEmpty() ? pr.getClientName() : inv.getCustomerName());
					fm.setPaymentDate(pr.getRenewalDate() != null && !pr.getRenewalDate().trim().isEmpty() ? pr.getRenewalDate() : pr.getPolicyDate());
					fm.setPolicyAmount(pr.getPolicyAmount() != null ? String.valueOf(pr.getPolicyAmount()) : inv.getPolicyAmount());
					fm.setPlanCode(inv.getSchemeCode());
					fm.setMaturityDate(pr.getMaturityDate() != null && !pr.getMaturityDate().trim().isEmpty() ? pr.getMaturityDate() : inv.getMaturityDate());
					fm.setMaturityAmount(pr.getMaturityAmount() != null ? String.valueOf(pr.getMaturityAmount()) : inv.getMaturityAmount());
					fm.setDuration(pr.getPolicyTerm() != null && !pr.getPolicyTerm().trim().isEmpty() ? pr.getPolicyTerm() : inv.getSchemeTerm());
					fm.setBranchName(pr.getBranchname() != null && !pr.getBranchname().trim().isEmpty() ? pr.getBranchname() : inv.getBranchName());
					fm.setModeofPayment(pr.getModeOfPayment() != null && !pr.getModeOfPayment().trim().isEmpty() ? pr.getModeOfPayment() : inv.getPaymentBy());
					fm.setApproveStatus(true);
					result.add(fm);
				}
			}
		}

		// Also include any approved records from fullMaturityRepo (if any exist)
		List<FullMaturity> existing = fullMaturityRepo.findByApproveStatusTrue();
		if (existing != null && !existing.isEmpty()) {
			for (FullMaturity efm : existing) {
				if (policyCode == null || policyCode.trim().isEmpty() || (efm.getPolicyCode() != null && efm.getPolicyCode().trim().equalsIgnoreCase(policyCode.trim()))) {
					result.add(efm);
				}
			}
		}

		return result;
	}

	public List<FullMaturity> getAllApprovedRDPolicies() {
		return getAllApprovedRDPolicies(null);
	}

	public boolean planNameExists(String planName) {
		return dailyDepositPMRepo.existsByPlanNameDD(planName);
	}
}
