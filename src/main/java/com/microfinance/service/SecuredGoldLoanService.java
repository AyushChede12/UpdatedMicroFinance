package com.microfinance.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestParam;

import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.ApplyForGoldRequestDto;
import com.microfinance.dto.GoldItemDto;
import com.microfinance.model.ApplyForGold;
import com.microfinance.model.ApplyForGoldItem;
import com.microfinance.model.CreateSavingsAccount;
import com.microfinance.model.EmiInstallmentPaymentGold;
import com.microfinance.model.GoldDirectory;
import com.microfinance.model.GoldLoanClose;
import com.microfinance.model.GoldLoanPayment;
import com.microfinance.model.SecuredGoldPlan;
import com.microfinance.model.addCustomer;
import com.microfinance.repository.AddCustomerRepo;
import com.microfinance.repository.ApplyForGoldRepo;
import com.microfinance.repository.CreateSavingAccountRepo;
import com.microfinance.repository.EMIInstallmentRepo;
import com.microfinance.repository.GoldCloseRepo;
import com.microfinance.repository.GoldDirectoryRepo;
import com.microfinance.repository.GoldLoanApprovalRepo;
import com.microfinance.repository.GoldPaymentRepo;
import com.microfinance.repository.GoldSecurePlanRepo;

@Service
public class SecuredGoldLoanService {

	@Autowired
	GoldSecurePlanRepo goldSecurePlanRepo;

	@Autowired
	GoldDirectoryRepo goldDirectoryRepo;

	@Autowired
	ApplyForGoldRepo applyForGoldRepo;

	@Autowired
	AddCustomerRepo addCustomerRepo;

	@Autowired
	GoldLoanApprovalRepo goldApprovalRepo;

	@Autowired
	CreateSavingAccountRepo createSavingRepo;

	@Autowired
	GoldCloseRepo goldCloseRepo;

	@Autowired
	GoldPaymentRepo goldPaymentRepo;

	@Autowired
	EMIInstallmentRepo emiRepo;

	public SecuredGoldPlan saveLoanManagmentData(SecuredGoldPlan goldLoan) {
		if (goldLoan.getId() != null && goldSecurePlanRepo.existsById(goldLoan.getId())) {
			// Perform update
			SecuredGoldPlan existingGoldLoan = goldSecurePlanRepo.findById(goldLoan.getId()).get();

			// Gold Loan Details
			existingGoldLoan.setLoanPlanName(goldLoan.getLoanPlanName());
			existingGoldLoan.setTypeOfLoan(goldLoan.getTypeOfLoan());
			existingGoldLoan.setLoanMode(goldLoan.getLoanMode());
			existingGoldLoan.setInterestType(goldLoan.getInterestType());
			existingGoldLoan.setEmiType(goldLoan.getEmiType());
			existingGoldLoan.setMinAge(goldLoan.getMinAge());
			existingGoldLoan.setMaxAge(goldLoan.getMaxAge());
			existingGoldLoan.setLoanAmt(goldLoan.getLoanAmt());
			existingGoldLoan.setLoanTerm(goldLoan.getLoanTerm());
			existingGoldLoan.setRateInterestType(goldLoan.getRateInterestType());
			existingGoldLoan.setSecurityType(goldLoan.getSecurityType());
			existingGoldLoan.setPlanStatus(goldLoan.getPlanStatus());

			// Deduction Details
			existingGoldLoan.setProcFee(goldLoan.getProcFee());
			existingGoldLoan.setLegalCharge(goldLoan.getLegalCharge());
			existingGoldLoan.setGst(goldLoan.getGst());
			existingGoldLoan.setInsuFee(goldLoan.getInsuFee());
			existingGoldLoan.setValuFee(goldLoan.getValuFee());

			// Late Fine Details
			existingGoldLoan.setLateAllowanceDay(goldLoan.getLateAllowanceDay());
			existingGoldLoan.setPenaltyMode(goldLoan.getPenaltyMode());
			existingGoldLoan.setMonthlyPenalty(goldLoan.getMonthlyPenalty());

			return goldSecurePlanRepo.save(existingGoldLoan);
		} else {
			// Save new record
			return goldSecurePlanRepo.save(goldLoan);
		}

	}

	public List<SecuredGoldPlan> allDataFetchGoldSecurePlan() {
		// TODO Auto-generated method stub
		return goldSecurePlanRepo.findAll();

	}

	public SecuredGoldPlan getGoldLoanById(Long id) {
		// TODO Auto-generated method stub
		return goldSecurePlanRepo.findById(id).orElse(null);
	}

	public boolean deleteGoldLoanLoanById(Long id) {
		// TODO Auto-generated method stub
		if (goldSecurePlanRepo.existsById(id)) {
			goldSecurePlanRepo.deleteById(id);
			return true;
		}
		return false;
	}

	/*
	 * public GoldDirectory saveGoldDirectory(String karat, String silverRate,
	 * String goldRate, String itemMasterType, String itemName, String
	 * lockerLocation, String lockerAddress, String purityName, String purity,
	 * String itemPurityType) {
	 * 
	 * GoldDirectory goldDirectory = new GoldDirectory();
	 * 
	 * // Today's Rate goldDirectory.setKarat(karat);
	 * goldDirectory.setSilverRate(silverRate); goldDirectory.setGoldRate(goldRate);
	 * 
	 * // Item Master goldDirectory.setItemMasterType(itemMasterType);
	 * goldDirectory.setItemName(itemName);
	 * 
	 * // Locker Master goldDirectory.setLockerLocation(lockerLocation);
	 * goldDirectory.setLockerAddress(lockerAddress);
	 * 
	 * // Purity Master goldDirectory.setPurityName(purityName);
	 * goldDirectory.setPurity(purity);
	 * goldDirectory.setItemPurityType(itemPurityType);
	 * 
	 * return goldDirectoryRepo.save(goldDirectory); }
	 */

	public List<GoldDirectory> getAllGoldDirectories() {
		// TODO Auto-generated method stub
		return goldDirectoryRepo.findAll();
	}

	public List<addCustomer> getgoldApplicationById(String memberCode) {
		// TODO Auto-generated method stub
		return addCustomerRepo.findByMemberCode(memberCode);
	}

	public List<addCustomer> getAllCustomers() {
		// TODO Auto-generated method stub
		return addCustomerRepo.findAll();
	}

	public List<GoldDirectory> getLoanPlanNameApplyForGoldByLoanPlan(String loanPlanName) {
		// TODO Auto-generated method stub
		return goldDirectoryRepo.findByloanPlanName(loanPlanName);
	}

	public GoldDirectory saveGoldDirectory(GoldDirectory goldDirectory) {
		// TODO Auto-generated method stub
		return goldDirectoryRepo.save(goldDirectory);
	}

	public List<GoldDirectory> getByMemberCodeApplyForGoldByLoanPlan(String customerCode) {
		// TODO Auto-generated method stub
		return goldDirectoryRepo.findBycustomerCode(customerCode);
	}

	public boolean saveApplyForGoldData(ApplyForGold applyForGold) {
		// TODO Auto-generated method stub
		try {
			applyForGoldRepo.save(applyForGold);
			return true;
		} catch (Exception e) {
			e.printStackTrace();
			return false;
		}
	}

	@Transactional(rollbackFor = Exception.class)
	public ApplyForGold createGoldLoanApplication(ApplyForGoldRequestDto dto) {
		if (dto == null) {
			throw new IllegalArgumentException("Gold loan request data cannot be null");
		}

		// Validation 1: Mandatory Photo and Signature
		if (dto.getPhoto() == null || dto.getPhoto().trim().isEmpty() || dto.getPhoto().contains("default-placeholder")) {
			throw new IllegalArgumentException("Upload Photo is mandatory before saving.");
		}
		if (dto.getSignature() == null || dto.getSignature().trim().isEmpty() || dto.getSignature().contains("default-placeholder")) {
			throw new IllegalArgumentException("Upload Signature is mandatory before saving.");
		}

		// Validation 2: Items presence
		List<GoldItemDto> itemDtos = dto.getItems();
		if (itemDtos == null || itemDtos.isEmpty()) {
			throw new IllegalArgumentException("At least one gold item must be provided.");
		}

		ApplyForGold applyForGold = new ApplyForGold();
		applyForGold.setLoanDate(dto.getLoanDate());
		applyForGold.setMemberCode(dto.getMemberCode());
		applyForGold.setCustomerName(dto.getCustomerName());
		applyForGold.setDateOfBirth(dto.getDateOfBirth());
		applyForGold.setAge(dto.getAge());
		applyForGold.setContactNo(dto.getContactNo());
		applyForGold.setAddress(dto.getAddress());
		applyForGold.setPinCode(dto.getPinCode());
		applyForGold.setBranchName(dto.getBranchName());
		applyForGold.setLoanPlanName(dto.getLoanPlanName());
		applyForGold.setTypeOfLoan(dto.getTypeOfLoan());
		applyForGold.setLoanMode(dto.getLoanMode());
		applyForGold.setLoanTerm(dto.getLoanTerm());
		applyForGold.setRateOfInterest(dto.getRateOfInterest());
		applyForGold.setInterestType(dto.getInterestType());
		applyForGold.setPurposeOfLoan(dto.getPurposeOfLoan());
		applyForGold.setSmsSend(dto.getSmsSend());
		applyForGold.setPhoto(dto.getPhoto());
		applyForGold.setSignature(dto.getSignature());
		applyForGold.setOrnamentPhoto(dto.getOrnamentPhoto());
		applyForGold.setOrnamentPhoto2(dto.getOrnamentPhoto2());

		// Process repeatable items
		BigDecimal totalGrossWt = BigDecimal.ZERO;
		BigDecimal totalNetWt = BigDecimal.ZERO;
		BigDecimal totalStoneWt = BigDecimal.ZERO;
		BigDecimal totalValuation = BigDecimal.ZERO;
		BigDecimal totalEligibleLoan = BigDecimal.ZERO;
		int totalQty = 0;

		List<Integer> allowedKarats = Arrays.asList(18, 20, 22, 24);

		for (int i = 0; i < itemDtos.size(); i++) {
			GoldItemDto itemDto = itemDtos.get(i);
			int itemIndex = i + 1;

			// Validate Karat
			if (itemDto.getKarat() == null || !allowedKarats.contains(itemDto.getKarat())) {
				throw new IllegalArgumentException("Item " + itemIndex + ": Karat must be one of 18, 20, 22, or 24.");
			}

			// Validate Weights
			BigDecimal itemWt = itemDto.getItemWt() != null ? itemDto.getItemWt() : BigDecimal.ZERO;
			BigDecimal stoneWt = itemDto.getStoneWt() != null ? itemDto.getStoneWt() : BigDecimal.ZERO;
			int qty = itemDto.getItemQty() != null && itemDto.getItemQty() > 0 ? itemDto.getItemQty() : 1;

			if (itemWt.compareTo(BigDecimal.ZERO) <= 0) {
				throw new IllegalArgumentException("Item " + itemIndex + ": Item Weight must be greater than zero.");
			}
			if (itemWt.compareTo(stoneWt) <= 0) {
				throw new IllegalArgumentException("Item " + itemIndex + ": Item Weight (" + itemWt + "g) must be strictly greater than Stone Weight (" + stoneWt + "g).");
			}

			BigDecimal grossWt = itemWt.multiply(new BigDecimal(qty)).setScale(3, RoundingMode.HALF_UP);
			if (grossWt.compareTo(stoneWt) <= 0) {
				throw new IllegalArgumentException("Item " + itemIndex + ": Gross Weight (" + grossWt + "g) must be strictly greater than Stone Weight (" + stoneWt + "g).");
			}

			BigDecimal netWt = grossWt.subtract(stoneWt).setScale(3, RoundingMode.HALF_UP);

			// Purity: karat / 24
			BigDecimal purity = new BigDecimal(itemDto.getKarat())
					.divide(new BigDecimal("24"), 6, RoundingMode.HALF_UP);

			// Rate
			BigDecimal custRate = itemDto.getCustgoldRate();
			if (custRate == null || custRate.compareTo(BigDecimal.ZERO) <= 0) {
				throw new IllegalArgumentException("Item " + itemIndex + ": Customer Karat Rate must be greater than 0.");
			}

			// Market Valuation = Net Weight * (Karat / 24) * Customer Karat Rate
			BigDecimal marketValuation = netWt.multiply(purity).multiply(custRate).setScale(2, RoundingMode.HALF_UP);

			// Eligible Loan using RBI Tiered Slab (85% <= 2.5L, 80% <= 5L, 75% above)
			BigDecimal ltvRate;
			if (marketValuation.compareTo(new BigDecimal("250000.00")) <= 0) {
				ltvRate = new BigDecimal("0.85");
			} else if (marketValuation.compareTo(new BigDecimal("500000.00")) <= 0) {
				ltvRate = new BigDecimal("0.80");
			} else {
				ltvRate = new BigDecimal("0.75");
			}
			BigDecimal eligibleLoan = marketValuation.multiply(ltvRate).setScale(2, RoundingMode.HALF_UP);

			ApplyForGoldItem itemEntity = new ApplyForGoldItem();
			itemEntity.setItemName(itemDto.getItemName());
			itemEntity.setItemType(itemDto.getItemType());
			itemEntity.setKarat(itemDto.getKarat());
			itemEntity.setCustgoldRate(custRate);
			itemEntity.setLockerBranch(itemDto.getLockerBranch());
			itemEntity.setPurity(purity);
			itemEntity.setItemQty(qty);
			itemEntity.setItemWt(itemWt);
			itemEntity.setGrossWt(grossWt);
			itemEntity.setStoneWt(stoneWt);
			itemEntity.setNetWt(netWt);
			itemEntity.setMarketValuation(marketValuation);
			itemEntity.setEligibleLoan(eligibleLoan);

			String itemPhoto = itemDto.getItemPhoto();
			if ((itemPhoto == null || itemPhoto.trim().isEmpty()) && i == 0) {
				itemPhoto = dto.getOrnamentPhoto();
			}
			itemEntity.setItemPhoto(itemPhoto);

			applyForGold.addItem(itemEntity);

			totalGrossWt = totalGrossWt.add(grossWt);
			totalNetWt = totalNetWt.add(netWt);
			totalStoneWt = totalStoneWt.add(stoneWt);
			totalValuation = totalValuation.add(marketValuation);
			totalEligibleLoan = totalEligibleLoan.add(eligibleLoan);
			totalQty += qty;
		}

		// Set primary aggregate fields on ApplyForGold for backward compatibility
		ApplyForGoldItem firstItem = applyForGold.getItems().get(0);
		applyForGold.setKarat(String.valueOf(firstItem.getKarat()));
		applyForGold.setItemType(firstItem.getItemType());
		applyForGold.setCustgoldRate(firstItem.getCustgoldRate().toString());
		applyForGold.setItemName(firstItem.getItemName());
		applyForGold.setLockerBranch(firstItem.getLockerBranch());
		applyForGold.setPurity(firstItem.getPurity().toString());
		applyForGold.setItemQty(String.valueOf(totalQty));
		applyForGold.setItemWt(firstItem.getItemWt().toString());
		applyForGold.setGrossWt(totalGrossWt.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setStoneWt(totalStoneWt.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setNetWt(totalNetWt.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setMarketValuation(totalValuation.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setEligibleLoan(totalEligibleLoan.setScale(2, RoundingMode.HALF_UP).toString());

		// Validate Loan Amount cannot exceed Eligible Loan
		BigDecimal loanAmount = dto.getLoanAmount();
		if (loanAmount == null || loanAmount.compareTo(BigDecimal.ZERO) <= 0) {
			throw new IllegalArgumentException("Amount of loan must be greater than zero.");
		}
		if (loanAmount.compareTo(totalEligibleLoan) > 0) {
			throw new IllegalArgumentException("Amount of Loan (₹" + loanAmount.setScale(2, RoundingMode.HALF_UP)
					+ ") cannot exceed Eligible Loan (₹" + totalEligibleLoan.setScale(2, RoundingMode.HALF_UP) + ").");
		}
		applyForGold.setLoanAmount(loanAmount.setScale(2, RoundingMode.HALF_UP).toString());

		// EMI calculation
		if ("Bullet".equalsIgnoreCase(dto.getLoanMode())) {
			applyForGold.setEmiPayment("0");
		} else {
			BigDecimal calculatedEmi = calculateEmi(loanAmount, dto.getRateOfInterest(), dto.getLoanTerm(), dto.getInterestType());
			applyForGold.setEmiPayment(calculatedEmi.setScale(2, RoundingMode.HALF_UP).toString());
		}

		// Guarantor Details
		applyForGold.setGuarantorcustomerCode(dto.getGuarantorcustomerCode());
		applyForGold.setGuarantorIdentity(dto.getGuarantorIdentity());
		applyForGold.setGuarantorAddress(dto.getGuarantorAddress());
		applyForGold.setGuarantorPinCode(dto.getGuarantorPinCode());
		applyForGold.setGuarantorContactNo(dto.getGuarantorContactNo());
		applyForGold.setGuarantorSecurityType(dto.getGuarantorSecurityType());

		// Co-Applicant Details
		applyForGold.setCoApplicantMemberId(dto.getCoApplicantMemberId());
		applyForGold.setCoApplicantIdentity(dto.getCoApplicantIdentity());
		applyForGold.setCoApplicantAddress(dto.getCoApplicantAddress());
		applyForGold.setCoAge(dto.getCoAge());
		applyForGold.setCoApplicantContactNo(dto.getCoApplicantContactNo());
		applyForGold.setSecurityDetails(dto.getSecurityDetails());

		// Deduction Details calculation
		BigDecimal processingFee = dto.getProcessingFee() != null ? dto.getProcessingFee() : BigDecimal.ZERO;
		if (dto.getLoanPlanName() != null && !dto.getLoanPlanName().trim().isEmpty()) {
			Optional<SecuredGoldPlan> planOpt = goldSecurePlanRepo.findByLoanPlanName(dto.getLoanPlanName().trim());
			if (planOpt.isPresent() && planOpt.get().getProcFee() != null) {
				try {
					String procStr = planOpt.get().getProcFee().replace("%", "").trim();
					BigDecimal procPercent = new BigDecimal(procStr);
					processingFee = loanAmount.multiply(procPercent).divide(new BigDecimal("100"), 2, RoundingMode.HALF_UP);
				} catch (Exception ignored) {}
			}
		}

		BigDecimal valuationFees = dto.getValuationFees() != null ? dto.getValuationFees() : BigDecimal.ZERO;
		BigDecimal legalCharges = dto.getLegalCharges() != null ? dto.getLegalCharges() : BigDecimal.ZERO;
		BigDecimal stampDuty = dto.getStampDuty() != null ? dto.getStampDuty() : BigDecimal.ZERO;
		BigDecimal smsCharges = dto.getSmsCharges() != null ? dto.getSmsCharges() : BigDecimal.ZERO;
		BigDecimal mainCharges = dto.getMainCharges() != null ? dto.getMainCharges() : BigDecimal.ZERO;
		BigDecimal stationaryFee = dto.getStationaryFee() != null ? dto.getStationaryFee() : BigDecimal.ZERO;
		BigDecimal insuFee = dto.getInsuFee() != null ? dto.getInsuFee() : BigDecimal.ZERO;
		BigDecimal penaltyCharge = dto.getPenaltyCharge() != null ? dto.getPenaltyCharge() : BigDecimal.ZERO;
		BigDecimal overCharge = dto.getOverCharge() != null ? dto.getOverCharge() : BigDecimal.ZERO;
		BigDecimal collectionCharge = dto.getCollectionCharge() != null ? dto.getCollectionCharge() : BigDecimal.ZERO;

		// GST = 18% of (Processing Fee + Valuation Fees + Legal Charges)
		BigDecimal gstBase = processingFee.add(valuationFees).add(legalCharges);
		BigDecimal gst = gstBase.multiply(new BigDecimal("0.18")).setScale(2, RoundingMode.HALF_UP);

		BigDecimal totalDeductions = processingFee.add(legalCharges).add(stampDuty).add(smsCharges)
				.add(mainCharges).add(stationaryFee).add(gst).add(insuFee).add(penaltyCharge)
				.add(valuationFees).add(overCharge).add(collectionCharge);

		BigDecimal netDisbursement = loanAmount.subtract(totalDeductions).setScale(2, RoundingMode.HALF_UP);

		applyForGold.setProcessingFee(processingFee.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setValuationFees(valuationFees.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setLegalCharges(legalCharges.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setStampDuty(stampDuty.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setSmsCharges(smsCharges.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setMainCharges(mainCharges.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setStationaryFee(stationaryFee.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setGst(gst.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setInsuFee(insuFee.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setPenaltyCharge(penaltyCharge.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setOverCharge(overCharge.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setCollectionCharge(collectionCharge.setScale(2, RoundingMode.HALF_UP).toString());
		applyForGold.setFinancialConsultantId(dto.getFinancialConsultantId());
		applyForGold.setFinancialConsultantName(dto.getFinancialConsultantName());

		applyForGold.setNetDisbursement(netDisbursement.toString());
		applyForGold.setSanctionedAmount(netDisbursement.toString());

		// Generate unique loan_no and goldID
		Long maxId = applyForGoldRepo.getMaxId();
		String goldId = "GL" + String.format("%05d", (maxId != null ? maxId + 1 : 1));
		applyForGold.setGoldID(goldId);
		applyForGold.setLoanNo(goldId);

		// Status: PENDING_APPROVAL and approvalStatus false
		applyForGold.setApprovalStatus(false);
		applyForGold.setGoldLoanStatus("PENDING_APPROVAL");

		return applyForGoldRepo.save(applyForGold);
	}

	private BigDecimal calculateEmi(BigDecimal principal, String rateStr, String termStr, String interestType) {
		try {
			if (principal == null || principal.compareTo(BigDecimal.ZERO) <= 0) return BigDecimal.ZERO;
			double p = principal.doubleValue();
			double annualRate = (rateStr != null && !rateStr.trim().isEmpty()) ? Double.parseDouble(rateStr.trim()) : 0.0;
			int term = (termStr != null && !termStr.trim().isEmpty()) ? Integer.parseInt(termStr.trim()) : 12;
			if (term <= 0) term = 12;

			if ("REDUCING".equalsIgnoreCase(interestType)) {
				if (annualRate <= 0) {
					return BigDecimal.valueOf(p / term).setScale(2, RoundingMode.HALF_UP);
				}
				double monthlyRate = (annualRate / 12.0) / 100.0;
				double emi = (p * monthlyRate * Math.pow(1 + monthlyRate, term)) / (Math.pow(1 + monthlyRate, term) - 1);
				return BigDecimal.valueOf(emi).setScale(2, RoundingMode.HALF_UP);
			} else {
				// Flat interest
				double totalInterest = p * (annualRate / 100.0) * (term / 12.0);
				double totalPayable = p + totalInterest;
				double emi = totalPayable / term;
				return BigDecimal.valueOf(emi).setScale(2, RoundingMode.HALF_UP);
			}
		} catch (Exception e) {
			return BigDecimal.ZERO;
		}
	}

	public List<ApplyForGold> getAllGoldLoanCustomer() {
		// TODO Auto-generated method stub
		return applyForGoldRepo.findAll();
	}

	public List<ApplyForGold> getByGoldIDforApproval(String goldID) {
		// TODO Auto-generated method stub
		return applyForGoldRepo.findByGoldID(goldID);
	}

	public String approveGoldLoan(ApplyForGold approval) {
		ApplyForGold goldLoan = applyForGoldRepo.findSingleByGoldID(approval.getGoldID());

		if (goldLoan == null) {
			return "not_found";
		}

		if (goldLoan.isApprovalStatus()) {
			return "already_approved";
		}

		// Step 1: Calculate deductions
		double loanAmount = Double.parseDouble(goldLoan.getLoanAmount());
		double processingFee = goldLoan.getProcessingFee() != null ? Double.parseDouble(goldLoan.getProcessingFee())
				: 0;
		double legalCharge = goldLoan.getLegalCharges() != null ? Double.parseDouble(goldLoan.getLegalCharges()) : 0;
		double gst = goldLoan.getGst() != null ? Double.parseDouble(goldLoan.getGst()) : 0;
		double stampDuty = goldLoan.getStampDuty() != null ? Double.parseDouble(goldLoan.getStampDuty()) : 0;
		double smsCharges = goldLoan.getSmsCharges() != null ? Double.parseDouble(goldLoan.getSmsCharges()) : 0;
		double mainCharges = goldLoan.getMainCharges() != null ? Double.parseDouble(goldLoan.getMainCharges()) : 0;
		double stationaryFee = goldLoan.getStationaryFee() != null ? Double.parseDouble(goldLoan.getStationaryFee())
				: 0;
		double insuFee = goldLoan.getInsuFee() != null ? Double.parseDouble(goldLoan.getInsuFee()) : 0;
		double penaltyCharge = goldLoan.getPenaltyCharge() != null ? Double.parseDouble(goldLoan.getPenaltyCharge())
				: 0;
		double valuationFees = goldLoan.getValuationFees() != null ? Double.parseDouble(goldLoan.getValuationFees())
				: 0;
		double overCharge = goldLoan.getOverCharge() != null ? Double.parseDouble(goldLoan.getOverCharge()) : 0;
		double collectionCharge = goldLoan.getCollectionCharge() != null
				? Double.parseDouble(goldLoan.getCollectionCharge())
				: 0;

		double totalDeductions = processingFee + legalCharge + gst + stampDuty + smsCharges + mainCharges
				+ stationaryFee + insuFee + penaltyCharge + valuationFees + overCharge + collectionCharge;

		double sanctionedAmount = loanAmount - totalDeductions;

		// Step 2: Update linked savings account balance
		List<CreateSavingsAccount> accounts = createSavingRepo.findBySelectByCustomer(goldLoan.getMemberCode());
		if (accounts != null && !accounts.isEmpty()) {
			CreateSavingsAccount account = accounts.get(0); // assuming one account per member
			double existingBalance = Double.parseDouble(account.getBalance());
			double updatedBalance = existingBalance + sanctionedAmount;
			account.setBalance(String.valueOf(updatedBalance));
			createSavingRepo.save(account);
		}

		// Step 3: Update gold loan approval
		goldLoan.setApprovalStatus(true);
		goldLoan.setSanctionedAmount(String.valueOf(sanctionedAmount));
		goldLoan.setApprovalDate(LocalDate.now().toString());
		goldLoan.setGoldLoanStatus("ACTIVE");
		applyForGoldRepo.save(goldLoan);

		return "success";
	}

	public List<ApplyForGold> getApprovedGoldCustomer() {
		// TODO Auto-generated method stub
		return applyForGoldRepo.findByApprovalStatusTrue();
	}

	public GoldLoanClose closeGoldLoan(GoldLoanClose goldLoanCloseRequest) {
		// TODO Auto-generated method stub
		goldLoanCloseRequest.setGoldLoanStatus("CLOSED");
		GoldLoanClose savedCloseData = goldCloseRepo.save(goldLoanCloseRequest);

		// 2. UPDATE ApplyForGold Table Status = CLOSED
		ApplyForGold applyLoan = applyForGoldRepo.findSingleByGoldID(goldLoanCloseRequest.getGoldID());

		if (applyLoan != null) {
			applyLoan.setGoldLoanStatus("CLOSED");
			applyForGoldRepo.save(applyLoan);
		}

		return savedCloseData;
	}

	public List<GoldLoanClose> getAllGoldClosure() {
		return goldCloseRepo.findAll();
	}

	public List<GoldLoanClose> getGoldClosuresByGoldId(String goldID) {
		return goldCloseRepo.findByGoldID(goldID);
	}

	public GoldLoanPayment savePaymentForGold(GoldLoanPayment request) {
		return goldPaymentRepo.save(request);
	}

	public boolean processEmiPayment(GoldLoanPayment request, String string) {
		return false;
	}

	public boolean processGoldLoanEmi(GoldLoanPayment request, int noOfInst) {

		String goldID = request.getGoldID();

		// Step 1: Get Loan
		ApplyForGold goldApp = applyForGoldRepo.findSingleByGoldID(goldID);
		if (goldApp == null) {
			throw new RuntimeException("Gold Loan ID not found: " + goldID);
		}

		// Step 2: Check if member has savings account
		List<CreateSavingsAccount> accounts = createSavingRepo.findBySelectByCustomer(request.getCustomerCode());
		if (accounts.isEmpty()) {
			throw new RuntimeException("Saving account not found for Customer: " + request.getCustomerCode());
		}

		CreateSavingsAccount savingAcc = accounts.get(0);

		double accountBalance = Double.parseDouble(savingAcc.getBalance());
		double emiAmount = Double.parseDouble(request.getEmiPayment());

		// Check balance for all installments
		if (accountBalance < (emiAmount * noOfInst)) {
			throw new RuntimeException(
					"Insufficient balance! Available: " + accountBalance + ", Required: " + (emiAmount * noOfInst));
		}

		// Deduct balance
		accountBalance -= (emiAmount * noOfInst);
		savingAcc.setBalance(String.valueOf(accountBalance));
		createSavingRepo.save(savingAcc);

		// Step 3: Fetch previous payments
		List<GoldLoanPayment> allPayments = goldPaymentRepo.findByGoldID(goldID);

		double lastAmountDue;
		double remainingPrincipal = Double.parseDouble(goldApp.getLoanAmount());
		double roi = Double.parseDouble(goldApp.getRateOfInterest());
		double term = Double.parseDouble(goldApp.getLoanTerm());
		String interestType = goldApp.getInterestType();

		if (!allPayments.isEmpty()) {
			GoldLoanPayment lastPayment = allPayments.get(allPayments.size() - 1);
			lastAmountDue = Double.parseDouble(lastPayment.getAmountDue());
			if ("Reducing Interest".equalsIgnoreCase(interestType)) {
				remainingPrincipal = lastAmountDue;
			}
		} else {
			if ("Flat Interest".equalsIgnoreCase(interestType)) {
				lastAmountDue = remainingPrincipal + (remainingPrincipal * roi * term) / 100;
			} else {
				lastAmountDue = remainingPrincipal;
			}
		}

		boolean isLoanClosed = false;

		// Step 4: Process installments
		for (int i = 1; i <= noOfInst; i++) {
			if (lastAmountDue <= 0)
				break;

			double interestThisPeriod = 0;

			if ("Reducing Interest".equalsIgnoreCase(interestType)) {
				interestThisPeriod = (remainingPrincipal * roi) / 100;
				remainingPrincipal = remainingPrincipal - (emiAmount - interestThisPeriod);
				if (remainingPrincipal < 0)
					remainingPrincipal = 0;
				lastAmountDue = remainingPrincipal;
			} else {
				lastAmountDue -= emiAmount;
				if (lastAmountDue < 0)
					lastAmountDue = 0;
			}

			GoldLoanPayment payment = new GoldLoanPayment();

			// -------------------- Customer Details --------------------
			payment.setGoldID(request.getGoldID());
			payment.setCustomerCode(request.getCustomerCode());
			payment.setCustomerName(request.getCustomerName());
			payment.setDateOfBirth(goldApp.getDateOfBirth());
			payment.setAge(goldApp.getAge());
			payment.setContactNo(goldApp.getContactNo());
			payment.setAddress(goldApp.getAddress());
			payment.setPinCode(goldApp.getPinCode());
			payment.setBranchName(goldApp.getBranchName());

			// -------------------- Loan Details --------------------
			payment.setGoldLoanDate(goldApp.getLoanDate());
			payment.setLoanPlanName(goldApp.getLoanPlanName());
			payment.setTypeOfLoan(goldApp.getTypeOfLoan());
			payment.setLoanTerm(goldApp.getLoanTerm());
			payment.setLoanMode(goldApp.getLoanMode());
			payment.setRateOfInterest(goldApp.getRateOfInterest());
			payment.setLoanAmount(goldApp.getLoanAmount());
			payment.setInterestType(goldApp.getInterestType());
			payment.setEmiPayment(String.valueOf(emiAmount));
			payment.setPurposeOfLoan(goldApp.getPurposeOfLoan());

			// -------------------- Gold/Silver Details --------------------
			payment.setKarat(goldApp.getKarat());
			payment.setItemType(goldApp.getItemType());
			payment.setCustgoldRate(goldApp.getCustgoldRate());
			payment.setItemName(goldApp.getItemName());
			payment.setLockerBranch(goldApp.getLockerBranch());
			payment.setPurity(goldApp.getPurity());
			payment.setItemQty(goldApp.getItemQty());
			payment.setItemWt(goldApp.getItemWt());
			payment.setGrossWt(goldApp.getGrossWt());
			payment.setStoneWt(goldApp.getStoneWt());
			payment.setNetWt(goldApp.getNetWt());
			payment.setMarketValuation(goldApp.getMarketValuation());
			payment.setEligibleLoan(goldApp.getEligibleLoan());

			// -------------------- Guarantor Details --------------------
			payment.setGuarantorcustomerCode(goldApp.getGuarantorcustomerCode());
			payment.setGuarantorIdentity(goldApp.getGuarantorIdentity());
			payment.setGuarantorAddress(goldApp.getGuarantorAddress());
			payment.setGuarantorPinCode(goldApp.getGuarantorPinCode());
			payment.setGuarantorContactNo(goldApp.getGuarantorContactNo());
			payment.setGuarantorSecurityType(goldApp.getGuarantorSecurityType());

			// -------------------- Co-Applicant Details --------------------
			payment.setCoApplicantMemberId(goldApp.getCoApplicantMemberId());
			payment.setCoApplicantIdentity(goldApp.getCoApplicantIdentity());
			payment.setCoApplicantAddress(goldApp.getCoApplicantAddress());
			payment.setCoAge(goldApp.getCoAge());
			payment.setCoApplicantContactNo(goldApp.getCoApplicantContactNo());
			payment.setSecurityDetails(goldApp.getSecurityDetails());

			// -------------------- Deduction Details --------------------
			payment.setProcessingFee(request.getProcessingFee());
			payment.setLegalCharges(request.getLegalCharges());
			payment.setStampDuty(goldApp.getStampDuty());
			payment.setSmsCharges(goldApp.getSmsCharges());
			payment.setMainCharges(goldApp.getMainCharges());
			payment.setStationaryFee(request.getStationaryFee());
			payment.setGst(request.getGst());
			payment.setInsuFee(goldApp.getInsuFee());
			payment.setPenaltyCharge(goldApp.getPenaltyCharge());
			payment.setValuationFees(request.getValuationFees());
			payment.setOverdueInterestCharge(request.getOverdueInterestCharge());
			payment.setCollectionCharge(goldApp.getCollectionCharge());
			payment.setFinancialCode(request.getFinancialCode());
			payment.setFinancialName(request.getFinancialName());

			// -------------------- Payment Details --------------------
			payment.setPaymentDate(request.getPaymentDate());
			payment.setPaymentStatus("Paid");
			payment.setModeOfPayment(request.getModeOfPayment());
			payment.setChargeDeductCash("0"); // If any cash deduction needed
			payment.setRemarks("Installment " + (allPayments.size() + i));
			payment.setAmountDue(String.valueOf(lastAmountDue));

			goldPaymentRepo.save(payment);

			// Close loan if final installment
			if (lastAmountDue <= 0) {
				goldApp.setGoldLoanStatus("CLOSED");
				applyForGoldRepo.save(goldApp);
				isLoanClosed = true;
				break;
			}
		}

		return isLoanClosed;
	}

	public List<addCustomer> getLoanApplicationById(String memberCode) {
		// TODO Auto-generated method stub
		return addCustomerRepo.findByMemberCode(memberCode);
	}

	public List<ApplyForGold> getAllActiveGoldLoans() {
		// TODO Auto-generated method stub
		return applyForGoldRepo.findByGoldLoanStatus("ACTIVE");
	}

	public List<ApplyForGold> getNotApprovedGoldCustomer() {
		// TODO Auto-generated method stub
		return applyForGoldRepo.findByApprovalStatusFalse();
	}

	public List<GoldLoanPayment> getGoldPaymentByGoldId(String goldID) {
		// TODO Auto-generated method stub
		return goldPaymentRepo.findByGoldID(goldID);
	}

	public ApiResponse saveInstallmentAndUpdateSavings(EmiInstallmentPaymentGold emi) {

		// 1. Save EMI installment
		emiRepo.save(emi);

		// 2. Fetch Savings Account
		List<CreateSavingsAccount> optionalAcc = createSavingRepo.findBySelectByCustomer(emi.getCustomerCode());
		System.out.println(optionalAcc);
		if (optionalAcc == null || optionalAcc.isEmpty()) {
			return new ApiResponse(HttpStatus.INTERNAL_SERVER_ERROR, "FAILED", "Savings Account Not Found!");
		}

		// Extract actual entity
		CreateSavingsAccount acc = optionalAcc.get(0);

		double oldBalance = Double.parseDouble(acc.getBalance());
		double payAmount = Double.parseDouble(emi.getPaymentAmount());

		if (oldBalance < payAmount) {
			return new ApiResponse(HttpStatus.BAD_REQUEST, "FAILED", "Insufficient Balance in Savings Account!");
		}

		double newBalance = oldBalance - payAmount;
		acc.setBalance(String.valueOf(newBalance));

		createSavingRepo.save(acc);

		return new ApiResponse(HttpStatus.OK, "SUCCESS", "Installment Saved & Balance Updated");
	}

	public List<EmiInstallmentPaymentGold> getEMIInstallmentGoldByID(String goldID) {
		return emiRepo.findByGoldID(goldID);
	}

}
