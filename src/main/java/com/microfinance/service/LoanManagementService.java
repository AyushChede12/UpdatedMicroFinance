package com.microfinance.service;

import java.util.List;
import java.util.Objects;
import java.util.Optional;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

import com.microfinance.dto.ApiResponse;
import com.microfinance.model.BranchModule;
import com.microfinance.model.CreateSavingsAccount;
import com.microfinance.model.LoanApplication;
import com.microfinance.model.LoanClosure;
import com.microfinance.model.LoanPayment;
import com.microfinance.model.LoanSchemCatalog;
import com.microfinance.model.NewLoanApplication;
import com.microfinance.model.addCustomer;
import com.microfinance.repository.AddCustomerRepo;
import com.microfinance.repository.BranchModuleRepo;
import com.microfinance.repository.CreateSavingAccountRepo;

import com.microfinance.repository.LoanApplicationRepo;
import com.microfinance.repository.LoanClosureRepo;
import com.microfinance.repository.LoanMangmentSchemeRepo;
import com.microfinance.repository.LoanPaymentRepo;
import com.microfinance.repository.NewLoanAppicationRepo;

@Service
public class LoanManagementService {

	@Autowired

	private LoanMangmentSchemeRepo loanRepository;
	@Autowired
	private AddCustomerRepo addCustomerRepo;

	@Autowired
	LoanApplicationRepo loanApplicationRepo;

	@Autowired
	LoanPaymentRepo loanPaymentRepo;

	@Autowired
	CreateSavingAccountRepo createSavingRepo;

	@Autowired
	LoanClosureRepo loanClosurerepo;

	@org.springframework.beans.factory.annotation.Value("${loan.deduction.gst-rate:18.0}")
	private double gstRate;

	@Autowired
	private com.microfinance.repository.LoanDeductionDetailsRepo loanDeductionDetailsRepo;

	@Autowired
	private com.microfinance.repository.FinancialConsultantRepo financialConsultantRepo;

	@Autowired
	private LoanNotificationService loanNotificationService;

	// Service fo saving and updating the loan scheme data
	public LoanSchemCatalog saveLoanManagmentData(LoanSchemCatalog loan) {
		if (loan.getId() != null && loanRepository.existsById(loan.getId())) {
			// Perform update
			LoanSchemCatalog existingLoan = loanRepository.findById(loan.getId()).get();

			// Copy all fields from input to existing
			existingLoan.setLoanSchemeCode(loan.getLoanSchemeCode());
			existingLoan.setLoanPlaneName(loan.getLoanPlaneName());
			existingLoan.setTypeLoan(loan.getTypeLoan());
			existingLoan.setAge(loan.getAge());
			existingLoan.setLoanTerm(loan.getLoanTerm());
			existingLoan.setEmiType(loan.getEmiType());
			existingLoan.setLoanAmount(loan.getLoanAmount());
			existingLoan.setLoanMode(loan.getLoanMode());
			existingLoan.setRateIntrestType(loan.getRateIntrestType());
			existingLoan.setTypeIntrest(loan.getTypeIntrest());
			existingLoan.setTypesecurity(loan.getTypesecurity());
			existingLoan.setPlanStatus(loan.getPlanStatus());

			// Deductions
			existingLoan.setFeeProcessing(loan.getFeeProcessing());
			existingLoan.setChargesLegal(loan.getChargesLegal());
			existingLoan.setGst(loan.getGst());
			existingLoan.setFeeInsurence(loan.getFeeInsurence());
			existingLoan.setFeeValuation(loan.getFeeValuation());

			// Late fee
			existingLoan.setLateAllowanceday(loan.getLateAllowanceday());
			existingLoan.setModePanalty(loan.getModePanalty());
			existingLoan.setPennaltyMonthly(loan.getPennaltyMonthly());

			return loanRepository.save(existingLoan);
		} else {
			// Save new record
			return loanRepository.save(loan);
		}
	}

	// Fetch data On Table

	public List<LoanSchemCatalog> allDataFetchLoanSchemCatelog() {
		// TODO Auto-generated method stub
		return loanRepository.findAll();
	}

// Append the data on Text Field
	public LoanSchemCatalog getLoanById(Long id) {
		// TODO Auto-generated method stub
		return loanRepository.findById(id).orElse(null);
	}

// Delete By ID
	public boolean deleteLoanLoanById(Long id) {
		// TODO Auto-generated method stub
		if (loanRepository.existsById(id)) {
			loanRepository.deleteById(id);
			return true;
		}
		return false;
	}

	public List<addCustomer> getAllLoanApplication() {
		// TODO Auto-generated method stub
		return addCustomerRepo.findAll();
	}

	// Loan schem Code Name Dropdrawn

	public List<LoanSchemCatalog> getLoanSchemCode() {
		// TODO Auto-generated method stub
		return loanRepository.findAll();
	}

	// fetching in new loan application by schem loan Code

	public LoanSchemCatalog getLoanByCode(String code) {
		return loanRepository.findByLoanSchemeCode(code)
				.orElseThrow(() -> new RuntimeException("Loan Scheme not found for code: " + code));
	}

	public List<LoanSchemCatalog> getLoanPlanName(String loanPlanName) {
		// Example: find by plan name (case-insensitive match)
		return loanRepository.findByLoanPlaneNameContainingIgnoreCase(loanPlanName);
	}

	public List<LoanSchemCatalog> getSchemeCatalog() {

		return loanRepository.findAll();
	}

	public com.microfinance.model.LoanDeductionDetails validateAndCalculateDeductions(
			java.math.BigDecimal loanAmount, com.microfinance.model.LoanDeductionDetails details) {

		if (details == null) {
			details = new com.microfinance.model.LoanDeductionDetails();
		}

		if (loanAmount == null || loanAmount.compareTo(java.math.BigDecimal.ZERO) <= 0) {
			throw new IllegalArgumentException("Loan Amount must be greater than 0 before calculating deductions.");
		}

		java.math.BigDecimal processingFee = details.getProcessingFee() != null
				? details.getProcessingFee().setScale(2, java.math.RoundingMode.HALF_UP)
				: java.math.BigDecimal.ZERO.setScale(2, java.math.RoundingMode.HALF_UP);
		java.math.BigDecimal legalCharges = details.getLegalCharges() != null
				? details.getLegalCharges().setScale(2, java.math.RoundingMode.HALF_UP)
				: java.math.BigDecimal.ZERO.setScale(2, java.math.RoundingMode.HALF_UP);
		java.math.BigDecimal insuranceFee = details.getInsuranceFee() != null
				? details.getInsuranceFee().setScale(2, java.math.RoundingMode.HALF_UP)
				: java.math.BigDecimal.ZERO.setScale(2, java.math.RoundingMode.HALF_UP);
		java.math.BigDecimal valuationFees = details.getValuationFees() != null
				? details.getValuationFees().setScale(2, java.math.RoundingMode.HALF_UP)
				: java.math.BigDecimal.ZERO.setScale(2, java.math.RoundingMode.HALF_UP);
		java.math.BigDecimal stationaryFee = details.getStationaryChargesFee() != null
				? details.getStationaryChargesFee().setScale(2, java.math.RoundingMode.HALF_UP)
				: java.math.BigDecimal.ZERO.setScale(2, java.math.RoundingMode.HALF_UP);

		// a. All fee fields must be >= 0
		if (processingFee.compareTo(java.math.BigDecimal.ZERO) < 0
				|| legalCharges.compareTo(java.math.BigDecimal.ZERO) < 0
				|| insuranceFee.compareTo(java.math.BigDecimal.ZERO) < 0
				|| valuationFees.compareTo(java.math.BigDecimal.ZERO) < 0
				|| stationaryFee.compareTo(java.math.BigDecimal.ZERO) < 0) {
			throw new IllegalArgumentException("Deduction fee values cannot be negative.");
		}

		// c. GST calculated server-side as configurable rate of processing fee if not manually supplied > 0
		java.math.BigDecimal gst = details.getGst();
		if (gst == null || gst.compareTo(java.math.BigDecimal.ZERO) <= 0) {
			gst = processingFee.multiply(java.math.BigDecimal.valueOf(gstRate))
					.divide(java.math.BigDecimal.valueOf(100), 2, java.math.RoundingMode.HALF_UP);
		} else {
			gst = gst.setScale(2, java.math.RoundingMode.HALF_UP);
		}

		if (gst.compareTo(java.math.BigDecimal.ZERO) < 0) {
			throw new IllegalArgumentException("GST amount cannot be negative.");
		}

		// Sum of all deductions
		java.math.BigDecimal totalDeductions = processingFee.add(legalCharges).add(gst).add(insuranceFee)
				.add(valuationFees).add(stationaryFee).setScale(2, java.math.RoundingMode.HALF_UP);

		// b. Sum of all deductions must NOT exceed Loan Amount
		if (totalDeductions.compareTo(loanAmount) > 0) {
			throw new IllegalArgumentException(
					"Total deductions (" + totalDeductions + ") must not exceed the Loan Amount (" + loanAmount + ").");
		}

		// d. Net Disbursement Amount = Loan Amount - Total Deductions
		java.math.BigDecimal netDisbursement = loanAmount.subtract(totalDeductions).setScale(2, java.math.RoundingMode.HALF_UP);

		// Employee validation
		if (details.getEmployeeId() != null && !details.getEmployeeId().trim().isEmpty()) {
			List<com.microfinance.model.addFinancialConsultant> staffList = financialConsultantRepo
					.findByFinancialCode(details.getEmployeeId().trim());
			if (staffList != null && !staffList.isEmpty()) {
				com.microfinance.model.addFinancialConsultant staff = staffList.get(0);
				if (details.getEmployeeName() == null || details.getEmployeeName().trim().isEmpty()) {
					details.setEmployeeName(staff.getFinancialName());
				}
			}
		}

		details.setProcessingFee(processingFee);
		details.setLegalCharges(legalCharges);
		details.setGst(gst);
		details.setInsuranceFee(insuranceFee);
		details.setValuationFees(valuationFees);
		details.setStationaryChargesFee(stationaryFee);
		details.setTotalDeductions(totalDeductions);
		details.setNetDisbursementAmount(netDisbursement);

		return details;
	}

	public boolean saveLoanApplicationData(LoanApplication loanApplication) {
		try {
			if (loanApplication.getLoanId() == null || loanApplication.getLoanId().trim().isEmpty()) {
				long nextId = loanApplicationRepo.getMaxId() + 1;
				loanApplication.setLoanId("LA" + String.format("%05d", nextId));
			}
			loanApplication.syncDynamicFields();
			checkLoanModeRangeOverride(loanApplication);

			// Parse loan amount and deduction details
			java.math.BigDecimal loanAmt = java.math.BigDecimal.ZERO;
			try {
				if (loanApplication.getLoanAmount() != null) {
					loanAmt = new java.math.BigDecimal(loanApplication.getLoanAmount().trim());
				}
			} catch (Exception ignored) {}

			if (loanAmt.compareTo(java.math.BigDecimal.ZERO) > 0) {
				com.microfinance.model.LoanDeductionDetails deduction = loanApplication.getDeductionDetails();
				if (deduction == null) {
					deduction = new com.microfinance.model.LoanDeductionDetails();
				}
				if (deduction.getProcessingFee() == null || deduction.getProcessingFee().compareTo(java.math.BigDecimal.ZERO) == 0) {
					try { if (loanApplication.getProcessingFee() != null) deduction.setProcessingFee(new java.math.BigDecimal(loanApplication.getProcessingFee().trim())); } catch (Exception ignored) {}
				}
				if (deduction.getLegalCharges() == null || deduction.getLegalCharges().compareTo(java.math.BigDecimal.ZERO) == 0) {
					try { if (loanApplication.getLegalCharges() != null) deduction.setLegalCharges(new java.math.BigDecimal(loanApplication.getLegalCharges().trim())); } catch (Exception ignored) {}
				}
				if (deduction.getGst() == null || deduction.getGst().compareTo(java.math.BigDecimal.ZERO) == 0) {
					try { if (loanApplication.getGst() != null) deduction.setGst(new java.math.BigDecimal(loanApplication.getGst().trim())); } catch (Exception ignored) {}
				}
				if (deduction.getInsuranceFee() == null || deduction.getInsuranceFee().compareTo(java.math.BigDecimal.ZERO) == 0) {
					try { if (loanApplication.getInsuranceFee() != null) deduction.setInsuranceFee(new java.math.BigDecimal(loanApplication.getInsuranceFee().trim())); } catch (Exception ignored) {}
				}
				if (deduction.getValuationFees() == null || deduction.getValuationFees().compareTo(java.math.BigDecimal.ZERO) == 0) {
					try { if (loanApplication.getValuationFees() != null) deduction.setValuationFees(new java.math.BigDecimal(loanApplication.getValuationFees().trim())); } catch (Exception ignored) {}
				}
				if (deduction.getStationaryChargesFee() == null || deduction.getStationaryChargesFee().compareTo(java.math.BigDecimal.ZERO) == 0) {
					try { if (loanApplication.getStationaryFee() != null) deduction.setStationaryChargesFee(new java.math.BigDecimal(loanApplication.getStationaryFee().trim())); } catch (Exception ignored) {}
				}
				if (deduction.getEmployeeId() == null || deduction.getEmployeeId().trim().isEmpty()) {
					deduction.setEmployeeId(loanApplication.getFinancialConsultantId());
				}
				if (deduction.getEmployeeName() == null || deduction.getEmployeeName().trim().isEmpty()) {
					deduction.setEmployeeName(loanApplication.getFinancialConsultantName());
				}

				validateAndCalculateDeductions(loanAmt, deduction);

				loanApplication.setProcessingFee(deduction.getProcessingFee().toPlainString());
				loanApplication.setLegalCharges(deduction.getLegalCharges().toPlainString());
				loanApplication.setGst(deduction.getGst().toPlainString());
				loanApplication.setInsuranceFee(deduction.getInsuranceFee().toPlainString());
				loanApplication.setValuationFees(deduction.getValuationFees().toPlainString());
				loanApplication.setStationaryFee(deduction.getStationaryChargesFee().toPlainString());
				loanApplication.setNetDisbursementAmount(deduction.getNetDisbursementAmount().toPlainString());
				loanApplication.setDeductionDetails(deduction);
			}

			if (loanApplication.getPaymentStatus() == null || loanApplication.getPaymentStatus().trim().isEmpty()) {
				loanApplication.setPaymentStatus("UNPAID");
			}

			LoanApplication savedApp = loanApplicationRepo.save(loanApplication);
			if (savedApp.getDeductionDetails() != null) {
				savedApp.getDeductionDetails().setLoanApplication(savedApp);
				loanDeductionDetailsRepo.save(savedApp.getDeductionDetails());
			}
			loanNotificationService.sendLoanApplicationNotification(savedApp);
			return true; // Saved successfully
		} catch (Exception e) {
			e.printStackTrace();
			if (e instanceof IllegalArgumentException) {
				throw (IllegalArgumentException) e;
			}
			return false; // Something went wrong
		}
	}

	public LoanApplication saveLoanApplication(LoanApplication loanApplication) {
		if (loanApplication.getLoanId() == null || loanApplication.getLoanId().trim().isEmpty()) {
			long nextId = loanApplicationRepo.getMaxId() + 1;
			loanApplication.setLoanId("LA" + String.format("%05d", nextId));
		}
		loanApplication.syncDynamicFields();
		checkLoanModeRangeOverride(loanApplication);
		LoanApplication saved = loanApplicationRepo.save(loanApplication);
		loanNotificationService.sendLoanApplicationNotification(saved);
		return saved;
	}

	private void checkLoanModeRangeOverride(LoanApplication loanApplication) {
		if (loanApplication == null || loanApplication.getLoanMode() == null) return;
		com.microfinance.enums.LoanModeConfig modeConfig = com.microfinance.enums.LoanModeConfig.fromMode(loanApplication.getLoanMode());
		if (modeConfig != null) {
			boolean termOverride = false;
			boolean rateOverride = false;
			int termVal = 0;
			double rateVal = 0.0;

			try {
				if (loanApplication.getLoanTerm() != null && !loanApplication.getLoanTerm().trim().isEmpty()) {
					termVal = Integer.parseInt(loanApplication.getLoanTerm().trim());
					if (!modeConfig.isTermInRange(termVal)) {
						termOverride = true;
					}
				}
			} catch (Exception ignored) {}

			try {
				if (loanApplication.getRateOfInterest() != null && !loanApplication.getRateOfInterest().trim().isEmpty()) {
					rateVal = Double.parseDouble(loanApplication.getRateOfInterest().trim());
					if (!modeConfig.isRateInRange(rateVal)) {
						rateOverride = true;
					}
				}
			} catch (Exception ignored) {}

			if (termOverride || rateOverride) {
				loanApplication.setIsRangeOverride(true);
				if (loanApplication.getRangeOverrideReason() == null || loanApplication.getRangeOverrideReason().trim().isEmpty()) {
					StringBuilder reason = new StringBuilder();
					if (termOverride) {
						reason.append("Term (").append(termVal).append(" ").append(modeConfig.getTermUnit())
							  .append(") outside typical range [").append(modeConfig.getMinTerm()).append("-").append(modeConfig.getMaxTerm()).append("]. ");
					}
					if (rateOverride) {
						reason.append("Rate (").append(rateVal).append("%) outside typical range [")
							  .append(modeConfig.getMinInterestRate()).append("%-").append(modeConfig.getMaxInterestRate()).append("%].");
					}
					loanApplication.setRangeOverrideReason(reason.toString().trim());
				}
			}
		}
	}

	public List<addCustomer> getLoanApplicationById(String memberCode) {
		return addCustomerRepo.findByMemberCode(memberCode);
	}

	// Service for fetching Active Loan Id's In the dropdown (Vaibhav)
	public List<String> fetchAllLoanIds() {
		return loanApplicationRepo.findAll().stream().filter(loan -> "ACTIVE".equalsIgnoreCase(loan.getLoanStatus()))
				.map(LoanApplication::getLoanId).filter(Objects::nonNull).collect(Collectors.toList());
	}

	// Service for fetching the data in the textfields (Vaibhav)
	public LoanApplication getLoanById(String loanId) {
		return loanApplicationRepo.findFirstByLoanIdOrderByIdDesc(loanId);
	}

	// Service for approving the loan application (Vaibhav)
	public String updateApproval(LoanApplication approval) {
		LoanApplication loan = loanApplicationRepo.findFirstByLoanIdOrderByIdDesc(approval.getLoanId());

		if (loan != null) {
			if (loan.isApprovalStatus()) {
				return "already_approved";
			}

			double loanAmount = 0.0;
			try {
				loanAmount = Double.parseDouble(loan.getLoanAmount());
			} catch (Exception ignored) {
			}
			double processingFee = 0.0;
			try {
				processingFee = Double.parseDouble(loan.getProcessingFee());
			} catch (Exception ignored) {
			}
			double gst = 0.0;
			try {
				gst = Double.parseDouble(loan.getGst());
			} catch (Exception ignored) {
			}
			double legalCharge = 0.0;
			try {
				legalCharge = Double.parseDouble(loan.getLegalCharges());
			} catch (Exception ignored) {
			}
			double extraCharges = processingFee + gst + legalCharge;
			double sanctionedAmount = loanAmount - extraCharges;

			loan.setSanctionedAmount(String.format(java.util.Locale.US, "%.2f", sanctionedAmount));
			loan.setApprovalStatus(approval.isApprovalStatus());
			loan.setApprovalDate(approval.getApprovalDate());
			LoanApplication savedLoan = loanApplicationRepo.save(loan);
			if (approval.isApprovalStatus()) {
				loanNotificationService.sendLoanApprovalNotification(savedLoan);
			}
			return "success";
		} else {
			return "not_found";
		}
	}

	// Service for getting Approved & Active loan Ids( Vaibhav)
	public List<String> getApprovedLoanIds() {
		List<LoanApplication> approvedActiveLoans = loanApplicationRepo.findByApprovalStatusTrueAndLoanStatus("ACTIVE");
		return approvedActiveLoans.stream().map(LoanApplication::getLoanId).collect(Collectors.toList());
	}

	// Service for paying the payment
	@Autowired
	private CreateSavingAccountRepo savingAccountRepo; // Add repo for savings account

	public boolean processEmiPayment(LoanPayment request, String noOfInst) {
		String loanId = request.getLoanId();

		LoanApplication loanApp = loanApplicationRepo.findFirstByLoanIdOrderByIdDesc(loanId);
		if (loanApp == null) {
			throw new RuntimeException("Loan ID not found");
		}

		String mode = request.getPaymentMode() != null ? request.getPaymentMode().trim() : "Cash";

		// ✅ Mode of disbursement: Cash or Saving Account
		// If Saving Account -> Transfer loan amount to customer savings account
		if ("Saving Account".equalsIgnoreCase(mode) || "Savings Account".equalsIgnoreCase(mode)) {
			List<CreateSavingsAccount> accounts = createSavingRepo.findBySelectByCustomer(request.getMemberId());
			if (accounts == null || accounts.isEmpty()) {
				accounts = createSavingRepo.findBySelectByCustomerIgnoreCase(request.getMemberId());
			}

			if (accounts == null || accounts.isEmpty()) {
				throw new RuntimeException("Saving account not found for Member ID: " + request.getMemberId()
						+ ". Cannot transfer loan disbursement to Saving Account.");
			}

			CreateSavingsAccount savingAcc = accounts.get(0);

			double currentBalance = 0.0;
			try {
				currentBalance = Double.parseDouble(savingAcc.getBalance());
			} catch (Exception e) {
				currentBalance = 0.0;
			}

			double loanAmt = 0.0;
			try {
				loanAmt = Double.parseDouble(loanApp.getLoanAmount());
			} catch (Exception e) {
				loanAmt = 0.0;
			}

			double updatedBalance = currentBalance + loanAmt;
			savingAcc.setBalance(String.format(java.util.Locale.US, "%.2f", updatedBalance));
			savingAccountRepo.save(savingAcc);

			if (request.getAccountNo() == null || request.getAccountNo().trim().isEmpty()) {
				request.setAccountNo(savingAcc.getAccountNumber());
			}
		}

		// ✅ Continue existing loan payment / disbursement tracking logic
		String loanDate = loanApp.getLoanDate();
		double policyAmount = Double.parseDouble(loanApp.getLoanAmount()); // Principal
		double roi = Double.parseDouble(loanApp.getRateOfInterest()); // Annual ROI
		double term = Double.parseDouble(loanApp.getLoanTerm());
		String frequency = loanApp.getLoanMode();
		String interestType = loanApp.getInterestType(); // "Flat" or "Reducing"

		double emiAmount = 0.0;
		try {
			emiAmount = Double.parseDouble(loanApp.getEmiPayment());
		} catch (Exception e) {
			emiAmount = 0.0;
		}

		int numberOfInstallments = 1;
		try {
			if (noOfInst != null && !noOfInst.trim().isEmpty()) {
				numberOfInstallments = Integer.parseInt(noOfInst.trim());
			}
		} catch (Exception e) {
			numberOfInstallments = 1;
		}

		double periodDivisor;
		switch (frequency) {
		case "Daily":
			periodDivisor = 365;
			break;
		case "Weekly":
			periodDivisor = 52;
			break;
		case "Fortnightly":
			periodDivisor = 26;
			break;
		case "Monthly":
			periodDivisor = 12;
			break;
		case "Quarterly":
			periodDivisor = 4;
			break;
		default:
			throw new IllegalArgumentException("Invalid frequency: " + frequency);
		}

		List<LoanPayment> allPayments = loanPaymentRepo.findByLoanId(loanId);

		double lastAmountDue;
		double remainingPrincipal = policyAmount;

		if (!allPayments.isEmpty()) {
			LoanPayment lastPayment = allPayments.get(allPayments.size() - 1);
			lastAmountDue = Double.parseDouble(lastPayment.getAmountDue());
			if ("Reducing Interest".equalsIgnoreCase(interestType)) {
				remainingPrincipal = Double.parseDouble(lastPayment.getAmountDue());
			}
		} else {
			if ("Flat Interest".equalsIgnoreCase(interestType)) {
				double interest = (policyAmount * roi * term) / (100 * periodDivisor);
				lastAmountDue = policyAmount + interest;
			} else {
				lastAmountDue = policyAmount;
			}
		}

		boolean isLoanClosed = false;

		for (int i = 1; i <= numberOfInstallments; i++) {
			if (lastAmountDue <= 0)
				break;

			double interestThisPeriod = 0;

			if ("Reducing Interest".equalsIgnoreCase(interestType)) {
				interestThisPeriod = (remainingPrincipal * roi) / (100 * periodDivisor);
				remainingPrincipal = remainingPrincipal - (emiAmount - interestThisPeriod);
				if (remainingPrincipal < 0)
					remainingPrincipal = 0;

				lastAmountDue = remainingPrincipal;
			} else {
				lastAmountDue -= emiAmount;
				if (lastAmountDue < 0)
					lastAmountDue = 0;
			}

			LoanPayment payment = new LoanPayment();
			payment.setLoanId(request.getLoanId());
			payment.setLoanPlanName(request.getLoanPlanName());
			payment.setLoanMode(request.getLoanMode());
			payment.setLoanTerm(request.getLoanTerm());
			payment.setTypeOfLoan(request.getTypeOfLoan());
			payment.setRateOfInterest(request.getRateOfInterest());
			payment.setLoanAmount(request.getLoanAmount());
			payment.setInterestType(request.getInterestType());
			payment.setEmiPayment(String.valueOf(emiAmount));
			payment.setLoanDate(loanDate);
			payment.setMemberId(request.getMemberId());
			payment.setMemberName(request.getMemberName());

			// Deductions
			payment.setProcessingFee(request.getProcessingFee());
			payment.setLegalCharges(request.getLegalCharges());
			payment.setGst(request.getGst());
			payment.setInsuranceFee(request.getInsuranceFee());
			payment.setValuationFees(request.getValuationFees());
			payment.setStationaryFee(request.getStationaryFee());

			payment.setPaymentDate(request.getPaymentDate());
			payment.setPaymentMode(request.getPaymentMode());
			if (payment.getPaymentMode() == "Cheque") {
				payment.setPaymentStatus("PENDING");
			} else {
				payment.setPaymentStatus("PAID");
			}
			payment.setAccountNo(request.getAccountNo());
			payment.setRef_UpiId(request.getRef_UpiId());
			payment.setCharges(request.getCharges());
			payment.setRemarks("Installment " + (allPayments.size() + i));
			payment.setChequeDate(request.getChequeDate());
			payment.setChequeNo(request.getChequeNo());
			payment.setNoOfInst("1");
			payment.setAmountDue(String.valueOf(lastAmountDue));

			loanPaymentRepo.save(payment);
			loanApp.setPaymentStatus("PAID");
			loanApplicationRepo.save(loanApp);
			loanNotificationService.sendLoanDisbursementNotification(loanApp, payment);

			double instCount = allPayments.size() + i;

			if (term == instCount) {
				loanApp.setLoanStatus("CLOSED");
				loanApplicationRepo.save(loanApp);

				LoanClosure closure = new LoanClosure();
				closure.setLoanId(loanApp.getLoanId());
				closure.setLoanPlanName(loanApp.getLoanPlanName());
				closure.setLoanMode(loanApp.getLoanMode());
				closure.setLoanTerm(loanApp.getLoanTerm());
				closure.setRateOfInterest(loanApp.getRateOfInterest());
				closure.setLoanAmount(loanApp.getLoanAmount());
				closure.setInterestType(loanApp.getInterestType());
				closure.setLoanDate(loanApp.getLoanDate());
				closure.setLoanStatus("CLOSED");
				closure.setFinancialConsultantName(loanApp.getFinancialConsultantName());
				closure.setMemberId(loanApp.getMemberId());
				closure.setMemberName(loanApp.getMemberName());
				closure.setBranchName(loanApp.getBranchName());
				closure.setContactNo(loanApp.getContactNo());
				closure.setRelativeDetails(loanApp.getRelativeDetails());
				closure.setTypeOfLoan(loanApp.getTypeOfLoan());
				closure.setEmiPayment(loanApp.getEmiPayment());
				closure.setNoOfInst(payment.getNoOfInst());
				closure.setFinancialConsultantId(loanApp.getFinancialConsultantId());
				closure.setPaymentDate(loanApp.getPaymentDate());
				closure.setPaymentMode(loanApp.getPaymentMode());
				closure.setRemarks("Loan closed after final EMI");
				closure.setCharges(loanApp.getCharges());
				closure.setChequeNo(loanApp.getChequeNo());
				closure.setRef_UpiId(loanApp.getRef_UpiId());

				loanClosurerepo.save(closure);

				isLoanClosed = true;
				break;
			}
		}

		return isLoanClosed;
	}

	// Service for getting loan id's for loan payment statement(Vaibhav)
	public List<String> getStatementLoanId() {
		return loanApplicationRepo.findAll().stream().map(LoanApplication::getLoanId) // adjust class name if needed
				.filter(Objects::nonNull).collect(Collectors.toList());
	}

	// Service for fetching loan details from loan id(Vaibhav)
	public List<LoanPayment> fetchLoanStatement(String loanId) {
		return loanPaymentRepo.findByLoanId(loanId); // Make sure this method exists
	}

	public List<LoanPayment> fetchLoanPaymentsByLoanId(String loanId) {

		return loanPaymentRepo.findByLoanId(loanId);
	}

	public LoanPayment fetchLoanPaymentByLoanIdAndInst(String loanId, String remarks) {
		return loanPaymentRepo.findByLoanIdAndNoOfInst(loanId, remarks);
	}

	// Service for closing the loan (Vaibhav)
	public LoanClosure closeLoan(LoanClosure paymentDetails) {

		// Ensure loanId is present
		if (paymentDetails.getLoanId() == null) {
			throw new RuntimeException("Loan ID is required to update LoanApplication status");
		}

		// Retrieve the loan application from the database
		LoanApplication loan = loanApplicationRepo.findFirstByLoanIdOrderByIdDesc(paymentDetails.getLoanId());
		if (loan == null) {
			throw new RuntimeException("Loan not found for loanId: " + paymentDetails.getLoanId());
		}

		// Set memberName from the retrieved loan application
		paymentDetails.setMemberName(loan.getMemberName());
		paymentDetails.setLoanStatus("CLOSED");

		// Save the closure details in the LoanClosure table
		LoanClosure savedClosure = loanClosurerepo.save(paymentDetails);

		// Update the loan status in the LoanApplication table
		loan.setLoanStatus("CLOSED");
		loanApplicationRepo.save(loan);

		return savedClosure;
	}

	// Api for getting closed loan ids
	public List<String> getClosedLoanIds() {
		return loanClosurerepo.findAll().stream().map(LoanClosure::getLoanId).filter(Objects::nonNull).distinct()
				.collect(Collectors.toList());
	}

	//
	public List<LoanClosure> getLoanClosuresByLoanId(String loanId) {
		return loanClosurerepo.findByLoanId(loanId);
	}

	public List<LoanApplication> getNotApprovedLoanCustomer() {
		// TODO Auto-generated method stub
		return loanApplicationRepo.findByApprovalStatusFalse();
	}
}