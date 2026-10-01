package com.microfinance.service;

import com.microfinance.dto.GroupLoanApplicationDto;
import com.microfinance.dto.GroupLoanApprovalDetailsDto;
import com.microfinance.dto.GroupLoanApprovalDto;
import com.microfinance.dto.GroupLoanDropdownDto;
import com.microfinance.dto.GroupLoanMemberDto;
import com.microfinance.dto.GroupProfileDto;
import com.microfinance.model.ApplyForGroupLoan;
import com.microfinance.model.GroupDirectory;
import com.microfinance.model.GroupLoanApplication;
import com.microfinance.model.GroupLoanMember;
import com.microfinance.model.addCustomer;
import com.microfinance.repository.CustomerRepo;
import com.microfinance.repository.GroupDirectoryRepo;
import com.microfinance.repository.GroupLoanApplicationRepo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.temporal.TemporalAdjusters;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class GroupLoanApplicationService {

    // Defined in code whether GST applies to total fees or processing fee only
    public static final boolean GST_APPLIES_TO_TOTAL_FEES = true;

    private static final List<String> ACTIVE_STATUSES = Arrays.asList("PENDING", "APPROVED", "ACTIVE", "DISBURSED");

    @Autowired
    private GroupLoanApplicationRepo groupLoanApplicationRepo;

    @Autowired
    private com.microfinance.repository.GroupLoanMemberRepo groupLoanMemberRepo;

    @Autowired
    private com.microfinance.repository.ApplyForGroupLoanRepo applyForGroupLoanRepo;

    @Autowired
    private com.microfinance.repository.GroupLoanPaymentRepo groupLoanPaymentRepo;

    @Autowired
    private GroupDirectoryRepo groupDirectoryRepo;

    @Autowired
    private CustomerRepo customerRepo;

    @Transactional
    public void deleteAllGroupLoans() {
        groupLoanMemberRepo.deleteAll();
        groupLoanApplicationRepo.deleteAll();
        applyForGroupLoanRepo.deleteAll();
        try {
            groupLoanPaymentRepo.deleteAll();
        } catch (Exception e) {
            // Ignore if already empty or table differences
        }
    }

    public List<GroupLoanDropdownDto> getGroupDropdownList() {
        List<GroupDirectory> directories = groupDirectoryRepo.findAll();
        Map<String, String> uniqueGroups = new LinkedHashMap<>();

        for (GroupDirectory gd : directories) {
            if (gd.getGroupID() != null && !gd.getGroupID().trim().isEmpty()) {
                String code = gd.getGroupID().trim();
                String name = gd.getCommunityName() != null ? gd.getCommunityName().trim() : "";
                if (!uniqueGroups.containsKey(code)) {
                    uniqueGroups.put(code, name.isEmpty() ? code : (code + " - " + name));
                }
            }
        }

        List<GroupLoanDropdownDto> dropdownList = new ArrayList<>();
        for (Map.Entry<String, String> entry : uniqueGroups.entrySet()) {
            dropdownList.add(new GroupLoanDropdownDto(entry.getKey(), entry.getValue()));
        }
        return dropdownList;
    }

    public GroupProfileDto getGroupProfile(String groupCode) {
        List<GroupDirectory> list = groupDirectoryRepo.findByGroupID(groupCode);
        if (list == null || list.isEmpty()) {
            throw new IllegalArgumentException("Group not found with code: " + groupCode);
        }

        GroupDirectory first = list.get(0);
        GroupProfileDto profile = new GroupProfileDto();
        profile.setGroupCode(groupCode);
        profile.setCommunityName(first.getCommunityName() != null ? first.getCommunityName() : "");
        profile.setOpeningDate(LocalDate.now().toString());
        profile.setCommunityAddress(first.getCommunityAddress() != null ? first.getCommunityAddress() : "");
        profile.setBranch(first.getBranchName() != null ? first.getBranchName() : "");
        
        String staff = first.getFinancialConsultantName();
        if (staff == null || staff.trim().isEmpty()) {
            staff = first.getFinancialCode() != null ? first.getFinancialCode() : "";
        }
        profile.setAllocatedStaff(staff);
        profile.setScheduledCollectionDay(first.getCollectionDay() != null ? first.getCollectionDay().toUpperCase() : "");

        // Process Leader: format as "M00001 - Name"
        String rawLeader = first.getCommunityLeader() != null ? first.getCommunityLeader().trim() : "";
        String leaderCode = rawLeader;
        String leaderName = "";

        if (rawLeader.contains("-")) {
            String[] parts = rawLeader.split("-", 2);
            leaderCode = parts[0].trim();
            leaderName = parts[1].trim();
        }

        Optional<addCustomer> leaderCustOpt = Optional.empty();
        if (!leaderCode.isEmpty()) {
            leaderCustOpt = customerRepo.findByMemberCode(leaderCode);
            if (!leaderCustOpt.isPresent()) {
                List<addCustomer> listByCode = customerRepo.findBymemberCode(leaderCode);
                if (listByCode != null && !listByCode.isEmpty()) {
                    leaderCustOpt = Optional.of(listByCode.get(0));
                }
            }
        }

        if (leaderCustOpt.isPresent()) {
            addCustomer cust = leaderCustOpt.get();
            if (leaderName.isEmpty() && cust.getCustomerName() != null) {
                leaderName = cust.getCustomerName();
            }
        }

        if (!leaderCode.isEmpty() && !leaderName.isEmpty()) {
            profile.setCommunityLeader(leaderCode + " - " + leaderName);
        } else if (!leaderCode.isEmpty()) {
            profile.setCommunityLeader(leaderCode);
        } else if (!leaderName.isEmpty()) {
            profile.setCommunityLeader(leaderName);
        } else {
            profile.setCommunityLeader("");
        }

        // Leader Contact Number
        String contactNumber = first.getContactNo() != null ? first.getContactNo().trim() : "";
        if (contactNumber.isEmpty() && leaderCustOpt.isPresent() && leaderCustOpt.get().getContactNo() != null) {
            contactNumber = leaderCustOpt.get().getContactNo().trim();
        }
        profile.setLeaderContactNumber(contactNumber);

        // Fetch Leader Address from addCustomer or GroupDirectory
        String leaderAddress = "";
        if (leaderCustOpt.isPresent()) {
            addCustomer cust = leaderCustOpt.get();
            StringBuilder sb = new StringBuilder();
            if (cust.getCustomerAddress() != null && !cust.getCustomerAddress().trim().isEmpty()) {
                sb.append(cust.getCustomerAddress().trim());
            }
            if (cust.getDistrict() != null && !cust.getDistrict().trim().isEmpty()) {
                if (sb.length() > 0) sb.append(", ");
                sb.append(cust.getDistrict().trim());
            }
            if (cust.getState() != null && !cust.getState().trim().isEmpty()) {
                if (sb.length() > 0) sb.append(", ");
                sb.append(cust.getState().trim());
            }
            if (cust.getPinCode() != null && !cust.getPinCode().trim().isEmpty()) {
                if (sb.length() > 0) sb.append(" - ");
                sb.append(cust.getPinCode().trim());
            }
            leaderAddress = sb.toString();
        }
        if (leaderAddress.isEmpty() && first.getCommunityAddress() != null) {
            leaderAddress = first.getCommunityAddress().trim();
        }
        profile.setLeaderAddress(leaderAddress);

        // Fetch Members
        Map<String, String> memberMap = new LinkedHashMap<>();
        for (GroupDirectory gd : list) {
            String membersStr = gd.getSelectedMember();
            String namesStr = gd.getCustomerName();

            if (membersStr != null && !membersStr.trim().isEmpty()) {
                String[] memberCodes = membersStr.split(",");
                String[] memberNames = (namesStr != null) ? namesStr.split(",") : new String[0];

                for (int i = 0; i < memberCodes.length; i++) {
                    String mCode = memberCodes[i].trim();
                    if (!mCode.isEmpty() && !memberMap.containsKey(mCode)) {
                        String mName = (i < memberNames.length) ? memberNames[i].trim() : "";
                        if (mName.isEmpty()) {
                            Optional<addCustomer> cust = customerRepo.findByMemberCode(mCode);
                            if (cust.isPresent() && cust.get().getCustomerName() != null) {
                                mName = cust.get().getCustomerName();
                            }
                        }
                        memberMap.put(mCode, mName);
                    }
                }
            }
        }

        List<GroupLoanMemberDto> memberDtoList = new ArrayList<>();
        for (Map.Entry<String, String> entry : memberMap.entrySet()) {
            memberDtoList.add(new GroupLoanMemberDto(entry.getKey(), entry.getValue(), BigDecimal.ZERO));
        }
        profile.setMembers(memberDtoList);

        return profile;
    }

    @Transactional
    public GroupLoanApplication saveGroupLoanApplication(GroupLoanApplicationDto dto) {
        // 1. Validate active group loan
        boolean hasActive = groupLoanApplicationRepo.hasActiveGroupLoan(dto.getGroupCode(), ACTIVE_STATUSES);
        if (hasActive) {
            throw new IllegalStateException("The group '" + dto.getGroupCode() + "' already has an active or pending loan application.");
        }

        // 2. Validate member allocations
        if (dto.getMembers() == null || dto.getMembers().isEmpty()) {
            throw new IllegalArgumentException("At least one member loan allocation is required.");
        }

        BigDecimal memberSum = BigDecimal.ZERO;
        for (GroupLoanMemberDto memberDto : dto.getMembers()) {
            if (memberDto.getIndividualLoanAmount() == null || memberDto.getIndividualLoanAmount().compareTo(BigDecimal.ZERO) <= 0) {
                throw new IllegalArgumentException("Each member must have an individual loan amount greater than 0.");
            }
            memberSum = memberSum.add(memberDto.getIndividualLoanAmount());
        }

        if (memberSum.setScale(2, RoundingMode.HALF_UP).compareTo(dto.getLoanAmount().setScale(2, RoundingMode.HALF_UP)) != 0) {
            throw new IllegalArgumentException("Total member allocation (" + memberSum.setScale(2, RoundingMode.HALF_UP) 
                    + ") must exactly equal total Loan Amount (" + dto.getLoanAmount().setScale(2, RoundingMode.HALF_UP) + ").");
        }

        // 3. Server-side recalculation of Deductions
        BigDecimal loanAmount = dto.getLoanAmount();
        BigDecimal procFeePercent = dto.getProcessingFeePercent() != null ? dto.getProcessingFeePercent() : BigDecimal.ZERO;
        BigDecimal legalChargesPercent = dto.getLegalChargesPercent() != null ? dto.getLegalChargesPercent() : BigDecimal.ZERO;
        BigDecimal insuranceFeePercent = dto.getInsuranceFeePercent() != null ? dto.getInsuranceFeePercent() : BigDecimal.ZERO;
        BigDecimal valuationFeePercent = dto.getValuationFeePercent() != null ? dto.getValuationFeePercent() : BigDecimal.ZERO;
        BigDecimal gstPercent = dto.getGstPercent() != null ? dto.getGstPercent() : BigDecimal.ZERO;

        BigDecimal procFeeAmt = loanAmount.multiply(procFeePercent).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
        BigDecimal legalChargesAmt = loanAmount.multiply(legalChargesPercent).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
        BigDecimal insuranceFeeAmt = loanAmount.multiply(insuranceFeePercent).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
        BigDecimal valuationFeeAmt = loanAmount.multiply(valuationFeePercent).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);

        BigDecimal baseForGst;
        if (GST_APPLIES_TO_TOTAL_FEES) {
            baseForGst = procFeeAmt.add(legalChargesAmt).add(insuranceFeeAmt).add(valuationFeeAmt);
        } else {
            baseForGst = procFeeAmt;
        }

        BigDecimal gstAmt = baseForGst.multiply(gstPercent).divide(BigDecimal.valueOf(100), 2, RoundingMode.HALF_UP);
        BigDecimal totalDeduction = procFeeAmt.add(legalChargesAmt).add(insuranceFeeAmt).add(valuationFeeAmt).add(gstAmt);
        BigDecimal netDisbursement = loanAmount.subtract(totalDeduction);

        // 4. Server-side recalculation of EMI, Interest on Loan, and Total Amount to Pay
        BigDecimal[] emiAndInterest = calculateEmiAndInterest(loanAmount, dto.getRateOfInterest(), dto.getTerm(), 
                dto.getInterestType(), dto.getEmiFrequency());
        BigDecimal calculatedEmi = emiAndInterest[0];
        BigDecimal calculatedInterest = emiAndInterest[1];
        BigDecimal calculatedTotalToPay = emiAndInterest[2];

        // 5. First EMI Date calculation (next scheduled collection day)
        LocalDate openingDate = dto.getOpeningDate() != null ? dto.getOpeningDate() : LocalDate.now();
        LocalDate firstEmiDate = calculateFirstEmiDate(dto.getGroupCode(), openingDate);

        // 6. Generate Application Number: GLA-000001
        Long maxId = groupLoanApplicationRepo.getMaxId();
        long nextId = (maxId != null ? maxId : 0L) + 1L;
        String applicationNo = String.format("GLA-%06d", nextId);

        // 7. Populate Entity
        GroupLoanApplication app = new GroupLoanApplication();
        app.setApplicationNo(applicationNo);
        app.setGroupCode(dto.getGroupCode());
        app.setOpeningDate(openingDate);
        app.setPurposeOfLoan(dto.getPurposeOfLoan());
        app.setLoanAmount(loanAmount);
        app.setTerm(dto.getTerm());
        app.setRateOfInterest(dto.getRateOfInterest());
        app.setInterestType(dto.getInterestType().toUpperCase());
        app.setEmiFrequency(dto.getEmiFrequency().toUpperCase());
        app.setEmiMode(dto.getEmiMode().toUpperCase());
        app.setEmiAmount(calculatedEmi);
        app.setInterestOnLoan(calculatedInterest);
        app.setTotalAmountToPay(calculatedTotalToPay);
        app.setFirstEmiDate(firstEmiDate);

        app.setProcessingFeePercent(procFeePercent);
        app.setLegalChargesPercent(legalChargesPercent);
        app.setInsuranceFeePercent(insuranceFeePercent);
        app.setValuationFeePercent(valuationFeePercent);
        app.setGstPercent(gstPercent);
        app.setTotalDeduction(totalDeduction);
        app.setNetDisbursement(netDisbursement);

        app.setPenaltyMode(dto.getPenaltyMode() != null ? dto.getPenaltyMode().toUpperCase() : "FIXED");
        app.setMonthlyPenalty(dto.getMonthlyPenalty() != null ? dto.getMonthlyPenalty() : BigDecimal.ZERO);
        app.setStatus("PENDING");

        BigDecimal distributedNetSum = BigDecimal.ZERO;
        int memberCount = dto.getMembers().size();

        for (int i = 0; i < memberCount; i++) {
            GroupLoanMemberDto mDto = dto.getMembers().get(i);
            BigDecimal memberNetDisb;

            if (i == memberCount - 1) {
                memberNetDisb = netDisbursement.subtract(distributedNetSum);
            } else {
                memberNetDisb = mDto.getIndividualLoanAmount()
                        .multiply(netDisbursement)
                        .divide(loanAmount, 2, RoundingMode.HALF_UP);
                distributedNetSum = distributedNetSum.add(memberNetDisb);
            }

            GroupLoanMember member = new GroupLoanMember(
                    mDto.getMemberCode(),
                    mDto.getMemberName(),
                    mDto.getIndividualLoanAmount(),
                    memberNetDisb
            );
            app.addMember(member);
        }

        return groupLoanApplicationRepo.save(app);
    }

    public BigDecimal[] calculateEmiAndInterest(BigDecimal principal, BigDecimal ratePerAnnum, int term, String interestType, String emiFrequency) {
        if (principal == null || term <= 0) {
            return new BigDecimal[] { BigDecimal.ZERO, BigDecimal.ZERO, BigDecimal.ZERO };
        }

        int periodsPerYear = "WEEKLY".equalsIgnoreCase(emiFrequency) ? 52 : 12;
        double p = principal.doubleValue();
        double rAnnual = ratePerAnnum != null ? ratePerAnnum.doubleValue() : 0.0;

        double emi;
        double totalInterest;
        double totalAmountToPay;

        if ("FLAT".equalsIgnoreCase(interestType)) {
            totalInterest = p * (rAnnual / 100.0) * ((double) term / periodsPerYear);
            totalAmountToPay = p + totalInterest;
            emi = totalAmountToPay / term;
        } else {
            if (rAnnual == 0) {
                emi = p / term;
                totalAmountToPay = p;
                totalInterest = 0;
            } else {
                double r = (rAnnual / 100.0) / periodsPerYear;
                double factor = Math.pow(1 + r, term);
                emi = (p * r * factor) / (factor - 1);
                totalAmountToPay = emi * term;
                totalInterest = totalAmountToPay - p;
            }
        }

        return new BigDecimal[] {
            BigDecimal.valueOf(emi).setScale(2, RoundingMode.HALF_UP),
            BigDecimal.valueOf(totalInterest).setScale(2, RoundingMode.HALF_UP),
            BigDecimal.valueOf(totalAmountToPay).setScale(2, RoundingMode.HALF_UP)
        };
    }

    public BigDecimal calculateEmi(BigDecimal principal, BigDecimal ratePerAnnum, int term, String interestType, String emiFrequency) {
        return calculateEmiAndInterest(principal, ratePerAnnum, term, interestType, emiFrequency)[0];
    }

    public LocalDate calculateFirstEmiDate(String groupCode, LocalDate baseDate) {
        if (baseDate == null) baseDate = LocalDate.now();
        List<GroupDirectory> list = groupDirectoryRepo.findByGroupID(groupCode);
        if (list == null || list.isEmpty()) {
            return baseDate.plusWeeks(1);
        }

        String collectionDayStr = list.get(0).getCollectionDay();
        if (collectionDayStr == null || collectionDayStr.trim().isEmpty()) {
            return baseDate.plusWeeks(1);
        }

        try {
            DayOfWeek targetDay = DayOfWeek.valueOf(collectionDayStr.trim().toUpperCase());
            return baseDate.with(TemporalAdjusters.next(targetDay));
        } catch (Exception e) {
            return baseDate.plusWeeks(1);
        }
    }

    public List<GroupLoanApplication> getAllApplications() {
        return groupLoanApplicationRepo.findAllByOrderByCreatedAtDesc();
    }

    public List<Map<String, Object>> getApplicationsForApprovalDropdown() {
        List<GroupLoanApplication> list = groupLoanApplicationRepo.findAllByOrderByCreatedAtDesc();
        List<Map<String, Object>> result = new ArrayList<>();
        for (GroupLoanApplication app : list) {
            Map<String, Object> map = new HashMap<>();
            map.put("applicationNo", app.getApplicationNo());
            map.put("groupCode", app.getGroupCode());
            map.put("loanAmount", app.getLoanAmount());
            map.put("status", app.getStatus());
            map.put("openingDate", app.getOpeningDate());

            List<GroupDirectory> dirs = groupDirectoryRepo.findByGroupID(app.getGroupCode());
            String commName = (dirs != null && !dirs.isEmpty() && dirs.get(0).getCommunityName() != null)
                    ? dirs.get(0).getCommunityName() : "";
            map.put("communityName", commName);
            map.put("displayName", app.getApplicationNo() + " - " + app.getGroupCode() 
                    + (commName.isEmpty() ? "" : " (" + commName + ")") 
                    + " [₹" + app.getLoanAmount() + " - " + app.getStatus() + "]");
            result.add(map);
        }
        return result;
    }

    public GroupLoanApprovalDetailsDto getApplicationApprovalDetails(String identifier) {
        if (identifier == null || identifier.trim().isEmpty()) {
            throw new IllegalArgumentException("Application identifier is required.");
        }
        String idStr = identifier.trim();

        // 1. Try finding by Application No
        Optional<GroupLoanApplication> opt = groupLoanApplicationRepo.findByApplicationNo(idStr);
        GroupLoanApplication app = null;
        if (opt.isPresent()) {
            app = opt.get();
        } else {
            // 2. Try finding latest by Group Code
            List<GroupLoanApplication> byGroup = groupLoanApplicationRepo.findByGroupCodeOrderByCreatedAtDesc(idStr);
            if (byGroup != null && !byGroup.isEmpty()) {
                app = byGroup.get(0);
            }
        }

        if (app == null) {
            throw new IllegalArgumentException("Group loan application not found for: " + idStr);
        }

        GroupProfileDto profile = getGroupProfile(app.getGroupCode());

        GroupLoanApprovalDetailsDto dto = new GroupLoanApprovalDetailsDto();
        dto.setApplicationNo(app.getApplicationNo());
        dto.setGroupCode(app.getGroupCode());
        dto.setStatus(app.getStatus());
        dto.setOpeningDate(app.getOpeningDate());
        dto.setPurposeOfLoan(app.getPurposeOfLoan());

        dto.setCommunityName(profile.getCommunityName());
        dto.setCommunityAddress(profile.getCommunityAddress());
        dto.setLeaderAddress(profile.getLeaderAddress());
        dto.setCommunityLeader(profile.getCommunityLeader());
        dto.setLeaderContactNumber(profile.getLeaderContactNumber());
        dto.setBranch(profile.getBranch());
        dto.setAllocatedStaff(profile.getAllocatedStaff());
        dto.setScheduledCollectionDay(profile.getScheduledCollectionDay());

        dto.setLoanAmount(app.getLoanAmount());
        dto.setTerm(app.getTerm());
        dto.setRateOfInterest(app.getRateOfInterest());
        dto.setInterestType(app.getInterestType());
        dto.setEmiFrequency(app.getEmiFrequency());
        dto.setEmiMode(app.getEmiMode());
        dto.setEmiAmount(app.getEmiAmount());
        dto.setInterestOnLoan(app.getInterestOnLoan());
        dto.setTotalAmountToPay(app.getTotalAmountToPay());
        dto.setFirstEmiDate(app.getFirstEmiDate());

        dto.setProcessingFeePercent(app.getProcessingFeePercent());
        dto.setLegalChargesPercent(app.getLegalChargesPercent());
        dto.setInsuranceFeePercent(app.getInsuranceFeePercent());
        dto.setValuationFeePercent(app.getValuationFeePercent());
        dto.setGstPercent(app.getGstPercent());
        dto.setTotalDeduction(app.getTotalDeduction());
        dto.setNetDisbursement(app.getNetDisbursement());
        dto.setPenaltyMode(app.getPenaltyMode());
        dto.setMonthlyPenalty(app.getMonthlyPenalty());

        dto.setApprovalDate(app.getApprovalDate());
        dto.setApprovalRemarks(app.getApprovalRemarks());
        dto.setApprovedBy(app.getApprovedBy());

        List<GroupLoanMemberDto> memberDtos = new ArrayList<>();
        if (app.getMembers() != null) {
            for (GroupLoanMember m : app.getMembers()) {
                memberDtos.add(new GroupLoanMemberDto(
                        m.getMemberCode(),
                        m.getMemberName(),
                        m.getIndividualLoanAmount(),
                        m.getNetDisbursementAmount()
                ));
            }
        }
        dto.setMembers(memberDtos);

        return dto;
    }

    @Transactional
    public GroupLoanApprovalDetailsDto processLoanApproval(GroupLoanApprovalDto dto) {
        if (dto.getApplicationNo() == null && dto.getGroupCode() == null) {
            throw new IllegalArgumentException("Application Number or Group Code is required.");
        }

        GroupLoanApplication app = null;
        if (dto.getApplicationNo() != null && !dto.getApplicationNo().trim().isEmpty()) {
            app = groupLoanApplicationRepo.findByApplicationNo(dto.getApplicationNo().trim())
                    .orElse(null);
        }
        if (app == null && dto.getGroupCode() != null && !dto.getGroupCode().trim().isEmpty()) {
            List<GroupLoanApplication> list = groupLoanApplicationRepo.findByGroupCodeOrderByCreatedAtDesc(dto.getGroupCode().trim());
            if (list != null && !list.isEmpty()) {
                app = list.get(0);
            }
        }

        if (app == null) {
            throw new IllegalArgumentException("No group loan application found to process approval.");
        }

        String action = dto.getAction() != null ? dto.getAction().trim().toUpperCase() : "APPROVE";
        LocalDate approvalDate = dto.getApprovalDate() != null ? dto.getApprovalDate() : LocalDate.now();
        String remarks = dto.getRemarks() != null ? dto.getRemarks().trim() : "";
        String approvedBy = dto.getApprovedBy() != null ? dto.getApprovedBy().trim() : "ADMIN";

        if ("APPROVE".equals(action)) {
            if ("APPROVED".equalsIgnoreCase(app.getStatus())) {
                throw new IllegalStateException("This group loan application is already APPROVED.");
            }
            app.setStatus("APPROVED");
            app.setApprovalDate(approvalDate);
            app.setApprovalRemarks(remarks);
            app.setApprovedBy(approvedBy);

            // Sync with legacy ApplyForGroupLoan for downstream repayment/payment compatibility
            try {
                ApplyForGroupLoan legacy = applyForGroupLoanRepo.findSingleByGroupCode(app.getGroupCode());
                if (legacy == null) {
                    legacy = new ApplyForGroupLoan();
                    legacy.setGroupCode(app.getGroupCode());
                }
                GroupProfileDto prof = getGroupProfile(app.getGroupCode());
                legacy.setOpeningDate(app.getOpeningDate() != null ? app.getOpeningDate().toString() : LocalDate.now().toString());
                legacy.setCommunityName(prof.getCommunityName());
                legacy.setAllocatedStaff(prof.getAllocatedStaff());
                legacy.setBranchName(prof.getBranch());
                legacy.setCollectionDays(prof.getScheduledCollectionDay());
                legacy.setCommunityAddress(prof.getCommunityAddress());
                legacy.setCommunityLeader(prof.getCommunityLeader());
                legacy.setContactNumber(prof.getLeaderContactNumber());
                legacy.setLoanPurpose(app.getPurposeOfLoan());
                legacy.setTerm(String.valueOf(app.getTerm()));
                legacy.setRateOfInterest(String.valueOf(app.getRateOfInterest()));
                legacy.setInterestType(app.getInterestType());
                legacy.setEmiFrequency(app.getEmiFrequency());
                legacy.setEmiType(app.getEmiMode());
                legacy.setTotalAmount(String.valueOf(app.getLoanAmount()));
                legacy.setGroupLoanStatus("ACTIVE");
                legacy.setApprovalStatus(true);
                legacy.setApprovalDate(approvalDate.toString());
                legacy.setProcessingFee(app.getProcessingFeePercent() != null ? app.getProcessingFeePercent().toString() : "0");
                legacy.setLegalCharges(app.getLegalChargesPercent() != null ? app.getLegalChargesPercent().toString() : "0");
                legacy.setInsuranceFee(app.getInsuranceFeePercent() != null ? app.getInsuranceFeePercent().toString() : "0");
                legacy.setValuationFee(app.getValuationFeePercent() != null ? app.getValuationFeePercent().toString() : "0");
                legacy.setGstPercentage(app.getGstPercent() != null ? app.getGstPercent().toString() : "0");
                legacy.setPenaltyMode(app.getPenaltyMode());
                legacy.setMonthlyPenalty(app.getMonthlyPenalty() != null ? app.getMonthlyPenalty().toString() : "0");
                applyForGroupLoanRepo.save(legacy);
            } catch (Exception e) {
                System.err.println("Warning: could not sync ApplyForGroupLoan: " + e.getMessage());
            }

        } else if ("REJECT".equals(action)) {
            app.setStatus("REJECTED");
            app.setApprovalDate(approvalDate);
            app.setApprovalRemarks(remarks);
            app.setApprovedBy(approvedBy);

            try {
                ApplyForGroupLoan legacy = applyForGroupLoanRepo.findSingleByGroupCode(app.getGroupCode());
                if (legacy != null) {
                    legacy.setApprovalStatus(false);
                    legacy.setGroupLoanStatus("REJECTED");
                    applyForGroupLoanRepo.save(legacy);
                }
            } catch (Exception e) {
                // ignore
            }
        } else {
            throw new IllegalArgumentException("Invalid action: " + action + ". Must be APPROVE or REJECT.");
        }

        groupLoanApplicationRepo.save(app);

        return getApplicationApprovalDetails(app.getApplicationNo());
    }

    @Transactional
    public GroupLoanApprovalDetailsDto resetToPending(String identifier) {
        if (identifier == null || identifier.trim().isEmpty()) {
            throw new IllegalArgumentException("Identifier is required");
        }
        GroupLoanApplication app = groupLoanApplicationRepo.findByApplicationNo(identifier.trim()).orElse(null);
        if (app == null) {
            List<GroupLoanApplication> list = groupLoanApplicationRepo.findByGroupCodeOrderByCreatedAtDesc(identifier.trim());
            if (list != null && !list.isEmpty()) {
                app = list.get(0);
            }
        }
        if (app == null) {
            throw new IllegalArgumentException("Application not found: " + identifier);
        }

        app.setStatus("PENDING");
        app.setApprovalDate(null);
        app.setApprovalRemarks(null);
        app.setApprovedBy(null);
        groupLoanApplicationRepo.save(app);

        try {
            ApplyForGroupLoan legacy = applyForGroupLoanRepo.findSingleByGroupCode(app.getGroupCode());
            if (legacy != null) {
                applyForGroupLoanRepo.delete(legacy);
            }
        } catch (Exception e) {
            // ignore
        }

        return getApplicationApprovalDetails(app.getApplicationNo());
    }
}
