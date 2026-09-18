package com.microfinance.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Locale;
import java.util.concurrent.CompletableFuture;

import javax.mail.internet.MimeMessage;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.microfinance.model.CreateSavingsAccount;
import com.microfinance.model.LoanApplication;
import com.microfinance.model.LoanDeductionDetails;
import com.microfinance.model.LoanPayment;
import com.microfinance.model.addCustomer;
import com.microfinance.repository.AddCustomerRepo;
import com.microfinance.repository.CreateSavingAccountRepo;
import com.microfinance.repository.LoanDeductionDetailsRepo;

@Service
public class LoanNotificationService {

	private static final Logger logger = LoggerFactory.getLogger(LoanNotificationService.class);

	@Autowired(required = false)
	private JavaMailSender mailSender;

	@Autowired
	private AddCustomerRepo addCustomerRepo;

	@Autowired
	private CreateSavingAccountRepo createSavingRepo;

	@Autowired(required = false)
	private LoanDeductionDetailsRepo loanDeductionDetailsRepo;

	@Value("${spring.mail.username:infosaisoftwarecompany@gmail.com}")
	private String fromEmail;

	@Value("${sms.api.key:4668E481546B25}")
	private String smsApiKey;

	@Value("${sms.sender.id:SMSSPT}")
	private String smsSenderId;

	// ==========================================
	// 1. NEW LOAN APPLICATION NOTIFICATION
	// ==========================================
	public void sendLoanApplicationNotification(LoanApplication loanApp) {
		if (loanApp == null) return;

		CustomerContact contact = resolveCustomerContact(loanApp.getMemberId(), loanApp.getContactNo(), loanApp.getMemberName());

		String loanId = loanApp.getLoanId() != null ? loanApp.getLoanId() : "N/A";
		String loanAmount = loanApp.getLoanAmount() != null ? loanApp.getLoanAmount() : "0.00";
		String loanPlan = loanApp.getLoanPlanName() != null ? loanApp.getLoanPlanName() : "Standard Loan";

		// SMS message
		String smsText = "Dear " + contact.name + ", your loan application (" + loanId + ") for Rs." 
				+ loanAmount + " under " + loanPlan + " has been submitted successfully. - Samitha Urban";
		sendSms(contact.mobile, smsText);

		// Email message
		String emailSubject = "Loan Application Submitted - " + loanId + " | Samitha Urban Nidhi Limited";
		String emailBody = "Dear " + contact.name + ",\n\n"
				+ "Greetings from Samitha Urban Nidhi Limited!\n\n"
				+ "We have successfully received your loan application. Details are as follows:\n"
				+ "--------------------------------------------------\n"
				+ "Loan Application ID : " + loanId + "\n"
				+ "Customer Member Code: " + (loanApp.getMemberId() != null ? loanApp.getMemberId() : "N/A") + "\n"
				+ "Loan Plan Name      : " + loanPlan + "\n"
				+ "Loan Amount Applied : Rs. " + loanAmount + "\n"
				+ "Loan Mode           : " + (loanApp.getLoanMode() != null ? loanApp.getLoanMode() : "N/A") + "\n"
				+ "Loan Term           : " + (loanApp.getLoanTerm() != null ? loanApp.getLoanTerm() : "N/A") + "\n"
				+ "Interest Type       : " + (loanApp.getInterestType() != null ? loanApp.getInterestType() : "N/A") + "\n"
				+ "Rate of Interest    : " + (loanApp.getRateOfInterest() != null ? loanApp.getRateOfInterest() + "% P.A." : "N/A") + "\n"
				+ "Estimated EMI       : Rs. " + (loanApp.getEmiPayment() != null ? loanApp.getEmiPayment() : "N/A") + "\n"
				+ "Application Date    : " + (loanApp.getLoanDate() != null ? loanApp.getLoanDate() : "N/A") + "\n"
				+ "--------------------------------------------------\n\n"
				+ "Your application is currently under verification. We will notify you once your application is reviewed and approved.\n\n"
				+ "Thank you for choosing Samitha Urban Nidhi Limited.\n\n"
				+ "Warm regards,\n"
				+ "Loan Management Team\n"
				+ "Samitha Urban Nidhi Limited";
		sendEmail(contact.email, emailSubject, emailBody);
	}

	// ==========================================
	// 2. LOAN APPROVAL NOTIFICATION
	// ==========================================
	public void sendLoanApprovalNotification(LoanApplication loanApp) {
		if (loanApp == null) return;

		CustomerContact contact = resolveCustomerContact(loanApp.getMemberId(), loanApp.getContactNo(), loanApp.getMemberName());

		String loanId = loanApp.getLoanId() != null ? loanApp.getLoanId() : "N/A";
		String approvedAmount = loanApp.getSanctionedAmount() != null && !loanApp.getSanctionedAmount().trim().isEmpty()
				? loanApp.getSanctionedAmount()
				: (loanApp.getLoanAmount() != null ? loanApp.getLoanAmount() : "0.00");

		// SMS message
		String smsText = "Dear " + contact.name + ", congratulations! Your loan (" + loanId + ") of Rs." 
				+ approvedAmount + " has been approved successfully. - Samitha Urban";
		sendSms(contact.mobile, smsText);

		// Email message
		String emailSubject = "Loan Application Approved - " + loanId + " | Samitha Urban Nidhi Limited";
		String emailBody = "Dear " + contact.name + ",\n\n"
				+ "Congratulations! We are delighted to inform you that your loan application has been APPROVED.\n\n"
				+ "--------------------------------------------------\n"
				+ "Loan ID             : " + loanId + "\n"
				+ "Customer Member Code: " + (loanApp.getMemberId() != null ? loanApp.getMemberId() : "N/A") + "\n"
				+ "Sanctioned Amount   : Rs. " + approvedAmount + "\n"
				+ "Loan Plan Name      : " + (loanApp.getLoanPlanName() != null ? loanApp.getLoanPlanName() : "N/A") + "\n"
				+ "Approval Date       : " + (loanApp.getApprovalDate() != null ? loanApp.getApprovalDate() : "N/A") + "\n"
				+ "Repayment Mode      : " + (loanApp.getLoanMode() != null ? loanApp.getLoanMode() : "N/A") + "\n"
				+ "Interest Type       : " + (loanApp.getInterestType() != null ? loanApp.getInterestType() : "N/A") + "\n"
				+ "Installment (EMI)   : Rs. " + (loanApp.getEmiPayment() != null ? loanApp.getEmiPayment() : "N/A") + "\n"
				+ "--------------------------------------------------\n\n"
				+ "Your loan is now ready for disbursement. You can visit your branch to complete the disbursement process.\n\n"
				+ "Warm regards,\n"
				+ "Credit Approval Team\n"
				+ "Samitha Urban Nidhi Limited";
		sendEmail(contact.email, emailSubject, emailBody);
	}

	// ==========================================
	// 3. LOAN DISBURSEMENT NOTIFICATION (WITH DEDUCTIONS & EMI CHART)
	// ==========================================
	public void sendLoanDisbursementNotification(LoanApplication loanApp, LoanPayment payment) {
		if (loanApp == null && payment == null) return;

		String memberId = payment != null && payment.getMemberId() != null ? payment.getMemberId()
				: (loanApp != null ? loanApp.getMemberId() : null);
		String fallbackContact = loanApp != null ? loanApp.getContactNo() : null;
		String fallbackName = payment != null && payment.getMemberName() != null ? payment.getMemberName()
				: (loanApp != null ? loanApp.getMemberName() : "Customer");

		CustomerContact contact = resolveCustomerContact(memberId, fallbackContact, fallbackName);

		String loanId = payment != null && payment.getLoanId() != null ? payment.getLoanId()
				: (loanApp != null ? loanApp.getLoanId() : "N/A");
		String grossLoanAmountStr = loanApp != null && loanApp.getLoanAmount() != null ? loanApp.getLoanAmount()
				: (payment != null && payment.getLoanAmount() != null ? payment.getLoanAmount() : "0.00");
		String mode = payment != null && payment.getPaymentMode() != null ? payment.getPaymentMode() : "Cash";
		String accountNo = payment != null && payment.getAccountNo() != null ? payment.getAccountNo() : "N/A";
		String disburseDateStr = payment != null && payment.getPaymentDate() != null ? payment.getPaymentDate()
				: (loanApp != null && loanApp.getLoanDate() != null ? loanApp.getLoanDate() : LocalDate.now().toString());

		boolean isSavingTransfer = "Saving Account".equalsIgnoreCase(mode) || "Savings Account".equalsIgnoreCase(mode);

		// Parse numerical values for EMI Amortization Schedule
		double grossPrincipal = parseDoubleSafely(grossLoanAmountStr);

		double annualRoi = 0.0;
		String roiStr = loanApp != null ? loanApp.getRateOfInterest() : (payment != null ? payment.getRateOfInterest() : "0");
		annualRoi = parseDoubleSafely(roiStr);

		int tenure = 0;
		String termStr = loanApp != null ? loanApp.getLoanTerm() : (payment != null ? payment.getLoanTerm() : "0");
		try {
			if (termStr != null) tenure = Integer.parseInt(termStr.trim());
		} catch (Exception e) {
			tenure = 0;
		}

		String loanMode = loanApp != null && loanApp.getLoanMode() != null ? loanApp.getLoanMode()
				: (payment != null && payment.getLoanMode() != null ? payment.getLoanMode() : "Monthly");
		String interestType = loanApp != null && loanApp.getInterestType() != null ? loanApp.getInterestType()
				: (payment != null && payment.getInterestType() != null ? payment.getInterestType() : "Reducing Interest");

		double emiAmount = 0.0;
		String emiStr = payment != null && payment.getEmiPayment() != null ? payment.getEmiPayment()
				: (loanApp != null ? loanApp.getEmiPayment() : "0");
		emiAmount = parseDoubleSafely(emiStr);

		LocalDate disburseDate = parseDateSafely(disburseDateStr);

		// ----------------------------------------------------
		// Extract Deduction Details
		// ----------------------------------------------------
		double processingFee = 0.0;
		double legalCharges = 0.0;
		double gst = 0.0;
		double insuranceFee = 0.0;
		double valuationFees = 0.0;
		double stationaryFee = 0.0;
		double totalDeductions = 0.0;
		double netDisbursementAmount = 0.0;

		LoanDeductionDetails deduction = null;
		if (loanApp != null) {
			if (loanApp.getDeductionDetails() != null) {
				deduction = loanApp.getDeductionDetails();
			} else if (loanApp.getId() > 0 && loanDeductionDetailsRepo != null) {
				try {
					deduction = loanDeductionDetailsRepo.findByLoanApplicationId(loanApp.getId()).orElse(null);
				} catch (Exception e) {
					logger.warn("Could not query loan deduction details for loan id {}: {}", loanApp.getId(), e.getMessage());
				}
			}
		}

		if (deduction != null) {
			if (deduction.getProcessingFee() != null) processingFee = deduction.getProcessingFee().doubleValue();
			if (deduction.getLegalCharges() != null) legalCharges = deduction.getLegalCharges().doubleValue();
			if (deduction.getGst() != null) gst = deduction.getGst().doubleValue();
			if (deduction.getInsuranceFee() != null) insuranceFee = deduction.getInsuranceFee().doubleValue();
			if (deduction.getValuationFees() != null) valuationFees = deduction.getValuationFees().doubleValue();
			if (deduction.getStationaryChargesFee() != null) stationaryFee = deduction.getStationaryChargesFee().doubleValue();
			if (deduction.getTotalDeductions() != null) totalDeductions = deduction.getTotalDeductions().doubleValue();
			if (deduction.getNetDisbursementAmount() != null) netDisbursementAmount = deduction.getNetDisbursementAmount().doubleValue();
		} else {
			// Fallback to loanApp or payment fields
			if (loanApp != null) {
				processingFee = parseDoubleSafely(loanApp.getProcessingFee());
				legalCharges = parseDoubleSafely(loanApp.getLegalCharges());
				gst = parseDoubleSafely(loanApp.getGst());
				insuranceFee = parseDoubleSafely(loanApp.getInsuranceFee());
				valuationFees = parseDoubleSafely(loanApp.getValuationFees());
				stationaryFee = parseDoubleSafely(loanApp.getStationaryFee());
				netDisbursementAmount = parseDoubleSafely(loanApp.getNetDisbursementAmount());
			}
			if (processingFee == 0.0 && payment != null) {
				processingFee = parseDoubleSafely(payment.getProcessingFee());
				legalCharges = parseDoubleSafely(payment.getLegalCharges());
				insuranceFee = parseDoubleSafely(payment.getInsuranceFee());
			}
		}

		if (totalDeductions <= 0) {
			totalDeductions = processingFee + legalCharges + gst + insuranceFee + valuationFees + stationaryFee;
		}
		if (netDisbursementAmount <= 0) {
			netDisbursementAmount = Math.max(0.0, grossPrincipal - totalDeductions);
		}

		// SMS message
		String smsText;
		if (isSavingTransfer) {
			smsText = String.format(Locale.US,
					"Dear %s, your loan (%s) of Gross Rs.%.2f has been disbursed. Total Deductions: Rs.%.2f. Net credited: Rs.%.2f to Savings A/c %s. - Samitha Urban",
					contact.name, loanId, grossPrincipal, totalDeductions, netDisbursementAmount, accountNo);
		} else {
			smsText = String.format(Locale.US,
					"Dear %s, your loan (%s) of Gross Rs.%.2f has been disbursed in Cash. Total Deductions: Rs.%.2f. Net Disbursed: Rs.%.2f. - Samitha Urban",
					contact.name, loanId, grossPrincipal, totalDeductions, netDisbursementAmount);
		}
		sendSms(contact.mobile, smsText);

		// Generate the EMI Amortization Schedule Rows
		List<EmiScheduleRow> schedule = generateEmiAmortizationSchedule(grossPrincipal, annualRoi, tenure, loanMode, interestType, disburseDate, emiAmount);

		// Build HTML and Plain Text Bodies
		String emailSubject = "Loan Disbursed Successfully & EMI Schedule - " + loanId + " | Samitha Urban Nidhi Limited";
		String htmlBody = buildDisbursementHtmlEmail(contact.name, memberId, loanId, grossPrincipal, totalDeductions, netDisbursementAmount,
				processingFee, legalCharges, gst, insuranceFee, valuationFees, stationaryFee,
				mode, accountNo, disburseDateStr, interestType, annualRoi, tenure, loanMode, emiAmount, schedule);
		String textBody = buildDisbursementTextEmail(contact.name, memberId, loanId, grossPrincipal, totalDeductions, netDisbursementAmount,
				processingFee, legalCharges, gst, insuranceFee, valuationFees, stationaryFee,
				mode, accountNo, disburseDateStr, interestType, annualRoi, tenure, loanMode, emiAmount, schedule);

		sendHtmlEmail(contact.email, emailSubject, htmlBody, textBody);
	}

	private double parseDoubleSafely(String val) {
		if (val == null || val.trim().isEmpty()) return 0.0;
		try {
			return Double.parseDouble(val.trim());
		} catch (Exception e) {
			return 0.0;
		}
	}

	// ==========================================
	// EMI AMORTIZATION SCHEDULE MODEL & GENERATOR
	// ==========================================
	public static class EmiScheduleRow {
		public int emiNo;
		public String dueDate;
		public double emi;
		public double principle;
		public double interest;
		public double currentBalance;
	}

	public List<EmiScheduleRow> generateEmiAmortizationSchedule(double principalAmount, double annualRoi, int tenure,
			String loanMode, String interestType, LocalDate disburseDate, double suggestedEmi) {
		List<EmiScheduleRow> rows = new ArrayList<>();
		if (principalAmount <= 0 || tenure <= 0) {
			return rows;
		}

		int periodsPerYear = getPeriodsPerYear(loanMode);
		DateTimeFormatter dtf = DateTimeFormatter.ofPattern("dd-MM-yyyy");

		boolean isFlat = interestType != null && interestType.toLowerCase().contains("flat");
		boolean isRule78 = interestType != null && (interestType.toLowerCase().contains("78") || interestType.toLowerCase().contains("rule"));

		if (isFlat) {
			double years = (double) tenure / periodsPerYear;
			double totalInterest = principalAmount * (annualRoi / 100.0) * years;
			double totalRepayable = principalAmount + totalInterest;
			double emi = (suggestedEmi > 0) ? suggestedEmi : (totalRepayable / tenure);
			double interestComponent = totalInterest / tenure;
			double principalComponent = emi - interestComponent;
			double currentPrincipal = principalAmount;

			for (int m = 1; m <= tenure; m++) {
				LocalDate dueDate = getInstallmentDueDate(disburseDate, loanMode, m);
				double closingPrincipal = currentPrincipal - principalComponent;
				if (m == tenure || closingPrincipal < 0.02) {
					closingPrincipal = 0.00;
				}

				EmiScheduleRow row = new EmiScheduleRow();
				row.emiNo = m;
				row.dueDate = dueDate.format(dtf);
				row.emi = emi;
				row.principle = principalComponent;
				row.interest = interestComponent;
				row.currentBalance = Math.max(0.0, closingPrincipal);
				rows.add(row);

				currentPrincipal = closingPrincipal;
			}
		} else if (isRule78) {
			double periodicRate = (annualRoi / periodsPerYear) / 100.0;
			double totalInterest = principalAmount * periodicRate * tenure;
			double sumOfDigits = ((double) tenure * (tenure + 1)) / 2.0;
			double emi = (suggestedEmi > 0) ? suggestedEmi : ((principalAmount + totalInterest) / tenure);
			double principalComponent = principalAmount / tenure;
			double currentPrincipal = principalAmount;

			for (int m = 1; m <= tenure; m++) {
				LocalDate dueDate = getInstallmentDueDate(disburseDate, loanMode, m);
				double interestComponent = ((double) (tenure - m + 1) / sumOfDigits) * totalInterest;
				double installment = principalComponent + interestComponent;
				double closingPrincipal = currentPrincipal - principalComponent;
				if (m == tenure || closingPrincipal < 0.02) {
					closingPrincipal = 0.00;
				}

				EmiScheduleRow row = new EmiScheduleRow();
				row.emiNo = m;
				row.dueDate = dueDate.format(dtf);
				row.emi = installment;
				row.principle = principalComponent;
				row.interest = interestComponent;
				row.currentBalance = Math.max(0.0, closingPrincipal);
				rows.add(row);

				currentPrincipal = closingPrincipal;
			}
		} else {
			// Reducing Interest (Amortization Schedule)
			double r = (annualRoi / periodsPerYear) / 100.0;
			double emi;
			if (suggestedEmi > 0) {
				emi = suggestedEmi;
			} else if (r == 0) {
				emi = principalAmount / tenure;
			} else {
				double factor = Math.pow(1 + r, tenure);
				emi = (principalAmount * r * factor) / (factor - 1);
			}

			double currentPrincipal = principalAmount;

			for (int m = 1; m <= tenure; m++) {
				LocalDate dueDate = getInstallmentDueDate(disburseDate, loanMode, m);
				double interestComponent = currentPrincipal * r;
				double principalComponent = emi - interestComponent;
				double closingPrincipal = currentPrincipal - principalComponent;

				if (m == tenure || Math.abs(closingPrincipal) < 0.05) {
					principalComponent = currentPrincipal;
					closingPrincipal = 0.00;
				}

				EmiScheduleRow row = new EmiScheduleRow();
				row.emiNo = m;
				row.dueDate = dueDate.format(dtf);
				row.emi = emi;
				row.principle = principalComponent;
				row.interest = interestComponent;
				row.currentBalance = Math.max(0.0, closingPrincipal);
				rows.add(row);

				currentPrincipal = closingPrincipal;
			}
		}

		return rows;
	}

	private int getPeriodsPerYear(String loanMode) {
		if (loanMode == null) return 12;
		String m = loanMode.trim().toLowerCase().replaceAll("[- _]", "");
		if (m.contains("daily")) return 365;
		if (m.contains("weekly")) return 52;
		if (m.contains("fortnight")) return 26;
		if (m.contains("quarter")) return 4;
		if (m.contains("half")) return 2;
		if (m.contains("year")) return 1;
		return 12;
	}

	private LocalDate parseDateSafely(String dateStr) {
		if (dateStr == null || dateStr.trim().isEmpty()) {
			return LocalDate.now();
		}
		String s = dateStr.trim();
		try {
			if (s.matches("^\\d{4}-\\d{2}-\\d{2}$")) {
				return LocalDate.parse(s, DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			} else if (s.matches("^\\d{2}-\\d{2}-\\d{4}$")) {
				return LocalDate.parse(s, DateTimeFormatter.ofPattern("dd-MM-yyyy"));
			} else if (s.matches("^\\d{2}/\\d{2}/\\d{4}$")) {
				return LocalDate.parse(s, DateTimeFormatter.ofPattern("dd/MM/yyyy"));
			}
		} catch (Exception e) {
			logger.warn("Could not parse date string '{}', using today", s);
		}
		return LocalDate.now();
	}

	private LocalDate getInstallmentDueDate(LocalDate startDate, String loanMode, int periodIndex) {
		if (loanMode == null) {
			return startDate.plusMonths(periodIndex);
		}
		String m = loanMode.trim().toLowerCase().replaceAll("[- _]", "");
		if (m.contains("daily")) {
			return startDate.plusDays(periodIndex);
		} else if (m.contains("weekly")) {
			return startDate.plusWeeks(periodIndex);
		} else if (m.contains("fortnight")) {
			return startDate.plusWeeks(2L * periodIndex);
		} else if (m.contains("quarter")) {
			return startDate.plusMonths(3L * periodIndex);
		} else if (m.contains("half")) {
			return startDate.plusMonths(6L * periodIndex);
		} else if (m.contains("year")) {
			return startDate.plusYears(periodIndex);
		} else {
			return startDate.plusMonths(periodIndex);
		}
	}

	// ==========================================
	// BUILD HTML EMAIL WITH DEDUCTIONS & EMI SCHEDULE
	// ==========================================
	private String buildDisbursementHtmlEmail(String customerName, String memberId, String loanId,
			double grossPrincipal, double totalDeductions, double netDisbursementAmount,
			double processingFee, double legalCharges, double gst, double insuranceFee,
			double valuationFees, double stationaryFee,
			String mode, String accountNo, String disburseDate, String interestType, double annualRoi, int tenure,
			String loanMode, double emiAmount, List<EmiScheduleRow> schedule) {

		boolean isSavingTransfer = "Saving Account".equalsIgnoreCase(mode) || "Savings Account".equalsIgnoreCase(mode);

		StringBuilder rowsHtml = new StringBuilder();
		double totalEmi = 0.0;
		double totalPrinciple = 0.0;
		double totalInterest = 0.0;

		for (int i = 0; i < schedule.size(); i++) {
			EmiScheduleRow r = schedule.get(i);
			totalEmi += r.emi;
			totalPrinciple += r.principle;
			totalInterest += r.interest;

			String bg = (i % 2 == 0) ? "#ffffff" : "#f8fafc";
			rowsHtml.append(String.format(Locale.US,
					"<tr style=\"background-color: %s;\">"
					+ "<td style=\"padding: 7px 10px; text-align: center; border: 1px solid #e2e8f0; color: #334155;\">%d</td>"
					+ "<td style=\"padding: 7px 10px; text-align: center; border: 1px solid #e2e8f0; color: #334155; font-weight: 500;\">%s</td>"
					+ "<td style=\"padding: 7px 10px; text-align: right; border: 1px solid #e2e8f0; color: #0f172a; font-weight: 600;\">₹%.2f</td>"
					+ "<td style=\"padding: 7px 10px; text-align: right; border: 1px solid #e2e8f0; color: #2563eb;\">₹%.2f</td>"
					+ "<td style=\"padding: 7px 10px; text-align: right; border: 1px solid #e2e8f0; color: #d97706;\">₹%.2f</td>"
					+ "<td style=\"padding: 7px 10px; text-align: right; border: 1px solid #e2e8f0; color: #16a34a; font-weight: 600;\">₹%.2f</td>"
					+ "</tr>",
					bg, r.emiNo, r.dueDate, r.emi, r.principle, r.interest, r.currentBalance));
		}

		return "<!DOCTYPE html>"
				+ "<html>"
				+ "<head>"
				+ "<meta charset=\"UTF-8\">"
				+ "<title>Loan Disbursement Advice & EMI Schedule</title>"
				+ "</head>"
				+ "<body style=\"margin: 0; padding: 20px; background-color: #f1f5f9; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; color: #334155;\">"
				+ "<div style=\"max-width: 800px; margin: 0 auto; background-color: #ffffff; border-radius: 10px; overflow: hidden; box-shadow: 0 4px 12px rgba(0,0,0,0.08); border: 1px solid #e2e8f0;\">"
				
				// Header
				+ "<div style=\"background: linear-gradient(135deg, #0f172a 0%, #1e3a8a 100%); color: #ffffff; padding: 25px 30px; text-align: center;\">"
				+ "<h1 style=\"margin: 0; font-size: 22px; letter-spacing: 0.5px;\">SAMITHA URBAN NIDHI LIMITED</h1>"
				+ "<p style=\"margin: 6px 0 0 0; font-size: 13px; opacity: 0.85; text-transform: uppercase; letter-spacing: 1px;\">Loan Disbursement Advice & Repayment Schedule</p>"
				+ "</div>"

				// Customer greeting
				+ "<div style=\"padding: 24px 30px;\">"
				+ "<p style=\"font-size: 15px; margin: 0 0 14px 0;\">Dear <strong>" + customerName + "</strong>,</p>"
				+ "<p style=\"font-size: 14px; line-height: 1.5; margin: 0 0 20px 0; color: #475569;\">We are pleased to inform you that your loan has been successfully <strong>DISBURSED</strong>. Please find the complete details of your loan, charges deducted, net credited amount, and your EMI Repayment Schedule below.</p>"

				// Key Loan Summary Card
				+ "<div style=\"background-color: #f8fafc; border: 1px solid #cbd5e1; border-radius: 8px; padding: 18px 20px; margin-bottom: 22px;\">"
				+ "<h3 style=\"margin: 0 0 12px 0; font-size: 14px; color: #0f172a; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 2px solid #e2e8f0; padding-bottom: 6px;\">Disbursement Summary</h3>"
				+ "<table style=\"width: 100%; border-collapse: collapse; font-size: 13px;\">"
				+ "<tr>"
				+ "<td style=\"padding: 6px 0; width: 25%; color: #64748b;\">Loan ID:</td>"
				+ "<td style=\"padding: 6px 0; width: 25%; font-weight: 600; color: #0f172a;\">" + loanId + "</td>"
				+ "<td style=\"padding: 6px 0; width: 25%; color: #64748b;\">Customer ID:</td>"
				+ "<td style=\"padding: 6px 0; width: 25%; font-weight: 600; color: #0f172a;\">" + (memberId != null ? memberId : "N/A") + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">Gross Loan Amount:</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 700; color: #0f172a; font-size: 14px;\">" + String.format(Locale.US, "₹%.2f", grossPrincipal) + "</td>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">Disbursement Date:</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 600; color: #0f172a;\">" + disburseDate + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">Total Deductions:</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 600; color: #dc2626;\">" + String.format(Locale.US, "- ₹%.2f", totalDeductions) + "</td>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">Net Disbursed Amount:</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 700; color: #16a34a; font-size: 15px;\">" + String.format(Locale.US, "₹%.2f", netDisbursementAmount) + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">Mode of Transfer:</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 600; color: #0f172a;\">" + (isSavingTransfer ? "Savings Account Credit" : "Cash") + "</td>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">" + (isSavingTransfer ? "Savings Account No:" : "Frequency:") + "</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 600; color: #0f172a;\">" + (isSavingTransfer ? accountNo : loanMode) + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">Interest Type:</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 600; color: #0f172a;\">" + interestType + "</td>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">Rate of Interest:</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 600; color: #0f172a;\">" + String.format(Locale.US, "%.2f%% P.A.", annualRoi) + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">Loan Tenure:</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 600; color: #0f172a;\">" + tenure + " " + loanMode + "</td>"
				+ "<td style=\"padding: 6px 0; color: #64748b;\">Installment (EMI):</td>"
				+ "<td style=\"padding: 6px 0; font-weight: 700; color: #0f172a; font-size: 14px;\">" + String.format(Locale.US, "₹%.2f", emiAmount) + "</td>"
				+ "</tr>"
				+ "</table>"
				+ "</div>"

				// ----------------------------------------------------
				// Deduction & Charges Itemized Table
				// ----------------------------------------------------
				+ "<div style=\"background-color: #ffffff; border: 1px solid #e2e8f0; border-radius: 8px; padding: 16px 20px; margin-bottom: 25px; box-shadow: 0 1px 3px rgba(0,0,0,0.04);\">"
				+ "<h3 style=\"margin: 0 0 10px 0; font-size: 14px; color: #0f172a; text-transform: uppercase; letter-spacing: 0.5px; border-bottom: 2px solid #e2e8f0; padding-bottom: 6px;\">Charges & Deduction Breakdown</h3>"
				+ "<table style=\"width: 100%; border-collapse: collapse; font-size: 13px;\">"
				+ "<thead>"
				+ "<tr style=\"background-color: #f1f5f9; color: #334155;\">"
				+ "<th style=\"padding: 8px 10px; text-align: left; border: 1px solid #e2e8f0;\">Fee / Charge Component</th>"
				+ "<th style=\"padding: 8px 10px; text-align: right; border: 1px solid #e2e8f0;\">Amount</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 10px; border: 1px solid #e2e8f0; color: #475569;\">Gross Loan Amount</td>"
				+ "<td style=\"padding: 6px 10px; text-align: right; border: 1px solid #e2e8f0; font-weight: 600; color: #0f172a;\">" + String.format(Locale.US, "₹%.2f", grossPrincipal) + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 10px; border: 1px solid #e2e8f0; color: #475569;\">Processing Fee</td>"
				+ "<td style=\"padding: 6px 10px; text-align: right; border: 1px solid #e2e8f0; color: #dc2626;\">" + String.format(Locale.US, "- ₹%.2f", processingFee) + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 10px; border: 1px solid #e2e8f0; color: #475569;\">Legal Charges</td>"
				+ "<td style=\"padding: 6px 10px; text-align: right; border: 1px solid #e2e8f0; color: #dc2626;\">" + String.format(Locale.US, "- ₹%.2f", legalCharges) + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 10px; border: 1px solid #e2e8f0; color: #475569;\">GST (18%)</td>"
				+ "<td style=\"padding: 6px 10px; text-align: right; border: 1px solid #e2e8f0; color: #dc2626;\">" + String.format(Locale.US, "- ₹%.2f", gst) + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 10px; border: 1px solid #e2e8f0; color: #475569;\">Insurance Fee</td>"
				+ "<td style=\"padding: 6px 10px; text-align: right; border: 1px solid #e2e8f0; color: #dc2626;\">" + String.format(Locale.US, "- ₹%.2f", insuranceFee) + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 10px; border: 1px solid #e2e8f0; color: #475569;\">Valuation Fees</td>"
				+ "<td style=\"padding: 6px 10px; text-align: right; border: 1px solid #e2e8f0; color: #dc2626;\">" + String.format(Locale.US, "- ₹%.2f", valuationFees) + "</td>"
				+ "</tr>"
				+ "<tr>"
				+ "<td style=\"padding: 6px 10px; border: 1px solid #e2e8f0; color: #475569;\">Stationary Charges Fee</td>"
				+ "<td style=\"padding: 6px 10px; text-align: right; border: 1px solid #e2e8f0; color: #dc2626;\">" + String.format(Locale.US, "- ₹%.2f", stationaryFee) + "</td>"
				+ "</tr>"
				+ "</tbody>"
				+ "<tfoot>"
				+ "<tr style=\"background-color: #f8fafc; font-weight: 600;\">"
				+ "<td style=\"padding: 8px 10px; border: 1px solid #e2e8f0; color: #0f172a;\">Total Deductions</td>"
				+ "<td style=\"padding: 8px 10px; text-align: right; border: 1px solid #e2e8f0; color: #dc2626; font-size: 13px;\">" + String.format(Locale.US, "- ₹%.2f", totalDeductions) + "</td>"
				+ "</tr>"
				+ "<tr style=\"background-color: #ecfdf5; font-weight: 700;\">"
				+ "<td style=\"padding: 10px 10px; border: 1px solid #a7f3d0; color: #065f46; font-size: 14px;\">Net Disbursed Amount (Credited)</td>"
				+ "<td style=\"padding: 10px 10px; text-align: right; border: 1px solid #a7f3d0; color: #16a34a; font-size: 15px;\">" + String.format(Locale.US, "₹%.2f", netDisbursementAmount) + "</td>"
				+ "</tr>"
				+ "</tfoot>"
				+ "</table>"
				+ "</div>"

				// Table Header Section
				+ "<div style=\"margin-bottom: 10px;\">"
				+ "<h3 style=\"margin: 0; font-size: 15px; color: #0f172a; letter-spacing: 0.5px;\">LOAN CALCULATOR | <span style=\"color: #64748b; font-weight: normal;\">REPAYMENT SCHEDULE</span></h3>"
				+ "<p style=\"font-size: 12px; color: #64748b; margin: 4px 0 12px 0;\">Detailed breakdown of principal, interest, and remaining balance per installment:</p>"
				+ "</div>"

				// Amortization Table
				+ "<div style=\"overflow-x: auto; margin-bottom: 25px;\">"
				+ "<table style=\"width: 100%; border-collapse: collapse; font-size: 12px;\">"
				+ "<thead>"
				+ "<tr style=\"background-color: #1e293b; color: #ffffff;\">"
				+ "<th style=\"padding: 9px 8px; text-align: center; border: 1px solid #334155; font-size: 11px;\">EMI NO.</th>"
				+ "<th style=\"padding: 9px 8px; text-align: center; border: 1px solid #334155; font-size: 11px;\">DUE DATE</th>"
				+ "<th style=\"padding: 9px 8px; text-align: right; border: 1px solid #334155; font-size: 11px;\">EMI</th>"
				+ "<th style=\"padding: 9px 8px; text-align: right; border: 1px solid #334155; font-size: 11px;\">PRINCIPLE</th>"
				+ "<th style=\"padding: 9px 8px; text-align: right; border: 1px solid #334155; font-size: 11px;\">INTEREST</th>"
				+ "<th style=\"padding: 9px 8px; text-align: right; border: 1px solid #334155; font-size: 11px;\">CURRENT BALANCE</th>"
				+ "</tr>"
				+ "</thead>"
				+ "<tbody>"
				+ rowsHtml.toString()
				+ "</tbody>"
				+ "<tfoot>"
				+ "<tr style=\"background-color: #f1f5f9; font-weight: bold; border-top: 2px solid #cbd5e1;\">"
				+ "<td colspan=\"2\" style=\"padding: 8px 10px; text-align: center; border: 1px solid #cbd5e1; color: #0f172a;\">TOTAL</td>"
				+ "<td style=\"padding: 8px 10px; text-align: right; border: 1px solid #cbd5e1; color: #0f172a;\">₹" + String.format(Locale.US, "%.2f", totalEmi) + "</td>"
				+ "<td style=\"padding: 8px 10px; text-align: right; border: 1px solid #cbd5e1; color: #2563eb;\">₹" + String.format(Locale.US, "%.2f", totalPrinciple) + "</td>"
				+ "<td style=\"padding: 8px 10px; text-align: right; border: 1px solid #cbd5e1; color: #d97706;\">₹" + String.format(Locale.US, "%.2f", totalInterest) + "</td>"
				+ "<td style=\"padding: 8px 10px; text-align: right; border: 1px solid #cbd5e1; color: #16a34a;\">₹0.00</td>"
				+ "</tr>"
				+ "</tfoot>"
				+ "</table>"
				+ "</div>"

				// Footer notes
				+ "<div style=\"border-top: 1px solid #e2e8f0; padding-top: 16px; font-size: 12px; color: #64748b; line-height: 1.5;\">"
				+ "<p style=\"margin: 0 0 6px 0;\"><strong>Important Note:</strong> Please ensure timely deposits on or before each scheduled due date to avoid late payment charges.</p>"
				+ "<p style=\"margin: 0 0 16px 0;\">For any assistance regarding your loan, please reach out to your home branch or email us at support.</p>"
				+ "<p style=\"margin: 0; color: #334155;\">Warm regards,<br><strong>Disbursement & Operations Team</strong><br>Samitha Urban Nidhi Limited</p>"
				+ "</div>"

				+ "</div>"
				+ "</div>"
				+ "</body>"
				+ "</html>";
	}

	// ==========================================
	// BUILD PLAIN TEXT EMAIL FALLBACK
	// ==========================================
	private String buildDisbursementTextEmail(String customerName, String memberId, String loanId,
			double grossPrincipal, double totalDeductions, double netDisbursementAmount,
			double processingFee, double legalCharges, double gst, double insuranceFee,
			double valuationFees, double stationaryFee,
			String mode, String accountNo, String disburseDate, String interestType, double annualRoi, int tenure,
			String loanMode, double emiAmount, List<EmiScheduleRow> schedule) {

		StringBuilder sb = new StringBuilder();
		sb.append("Dear ").append(customerName).append(",\n\n");
		sb.append("We are pleased to inform you that your loan has been successfully DISBURSED.\n\n");
		sb.append("--------------------------------------------------------------------------------\n");
		sb.append("LOAN DISBURSEMENT SUMMARY\n");
		sb.append("--------------------------------------------------------------------------------\n");
		sb.append("Loan ID                 : ").append(loanId).append("\n");
		sb.append("Customer Member Code    : ").append(memberId != null ? memberId : "N/A").append("\n");
		sb.append(String.format(Locale.US, "Gross Loan Amount       : Rs. %.2f\n", grossPrincipal));
		sb.append(String.format(Locale.US, "Total Deductions        : - Rs. %.2f\n", totalDeductions));
		sb.append(String.format(Locale.US, "Net Disbursed Amount    : Rs. %.2f\n", netDisbursementAmount));
		sb.append("Mode of Transfer        : ").append("Saving Account".equalsIgnoreCase(mode) ? "Transfer to Savings Account (" + accountNo + ")" : "Cash").append("\n");
		sb.append("Disbursement Date       : ").append(disburseDate).append("\n");
		sb.append("Interest Type           : ").append(interestType).append("\n");
		sb.append(String.format(Locale.US, "Rate of Interest        : %.2f%% P.A.\n", annualRoi));
		sb.append("Loan Tenure             : ").append(tenure).append(" ").append(loanMode).append("\n");
		sb.append(String.format(Locale.US, "Installment (EMI)       : Rs. %.2f\n", emiAmount));
		sb.append("--------------------------------------------------------------------------------\n\n");

		sb.append("DEDUCTIONS & CHARGES BREAKDOWN:\n");
		sb.append(String.format(Locale.US, " - Processing Fee       : Rs. %.2f\n", processingFee));
		sb.append(String.format(Locale.US, " - Legal Charges        : Rs. %.2f\n", legalCharges));
		sb.append(String.format(Locale.US, " - GST (18%%)           : Rs. %.2f\n", gst));
		sb.append(String.format(Locale.US, " - Insurance Fee        : Rs. %.2f\n", insuranceFee));
		sb.append(String.format(Locale.US, " - Valuation Fees       : Rs. %.2f\n", valuationFees));
		sb.append(String.format(Locale.US, " - Stationary Charges   : Rs. %.2f\n", stationaryFee));
		sb.append(String.format(Locale.US, "Total Charges Deducted  : Rs. %.2f\n", totalDeductions));
		sb.append(String.format(Locale.US, "Net Amount Credited     : Rs. %.2f\n", netDisbursementAmount));
		sb.append("--------------------------------------------------------------------------------\n\n");

		sb.append("REPAYMENT SCHEDULE (LOAN CALCULATOR):\n");
		sb.append(String.format("%-8s | %-12s | %-12s | %-12s | %-12s | %-15s\n",
				"EMI NO.", "DUE DATE", "EMI (Rs.)", "PRINCIPLE", "INTEREST", "CURRENT BALANCE"));
		sb.append("--------------------------------------------------------------------------------\n");

		for (EmiScheduleRow r : schedule) {
			sb.append(String.format(Locale.US, "%-8d | %-12s | %-12.2f | %-12.2f | %-12.2f | %-15.2f\n",
					r.emiNo, r.dueDate, r.emi, r.principle, r.interest, r.currentBalance));
		}

		sb.append("--------------------------------------------------------------------------------\n\n");
		sb.append("Please maintain sufficient balance or timely deposits for regular installment payments.\n\n");
		sb.append("Warm regards,\n");
		sb.append("Disbursement & Operations Team\n");
		sb.append("Samitha Urban Nidhi Limited\n");

		return sb.toString();
	}

	// ==========================================
	// RESOLVE CUSTOMER CONTACT (MOBILE + EMAIL)
	// ==========================================
	private CustomerContact resolveCustomerContact(String memberId, String fallbackContact, String fallbackName) {
		CustomerContact contact = new CustomerContact();
		contact.name = fallbackName != null && !fallbackName.trim().isEmpty() ? fallbackName.trim() : "Customer";
		contact.mobile = fallbackContact;

		if (memberId != null && !memberId.trim().isEmpty()) {
			try {
				List<addCustomer> customers = addCustomerRepo.findByMemberCode(memberId.trim());
				if (customers != null && !customers.isEmpty()) {
					addCustomer c = customers.get(0);
					if (c.getEmailId() != null && !c.getEmailId().trim().isEmpty()) {
						contact.email = c.getEmailId().trim();
					}
					if (c.getContactNo() != null && !c.getContactNo().trim().isEmpty()) {
						contact.mobile = c.getContactNo().trim();
					}
					String fullName = ((c.getFirstName() != null ? c.getFirstName() : "") + " "
							+ (c.getLastName() != null ? c.getLastName() : "")).trim();
					if (!fullName.isEmpty()) {
						contact.name = fullName;
					}
				}
			} catch (Exception e) {
				logger.warn("Could not query addCustomerRepo for memberCode: {}", memberId, e);
			}

			// If email still missing, try CreateSavingsAccount
			if (contact.email == null || contact.email.isEmpty()) {
				try {
					List<CreateSavingsAccount> savingAccounts = createSavingRepo.findBySelectByCustomer(memberId.trim());
					if (savingAccounts != null && !savingAccounts.isEmpty()) {
						CreateSavingsAccount sa = savingAccounts.get(0);
						if (sa.getEmailId() != null && !sa.getEmailId().trim().isEmpty()) {
							contact.email = sa.getEmailId().trim();
						}
						if ((contact.mobile == null || contact.mobile.isEmpty()) && sa.getContactNumber() != null) {
							contact.mobile = sa.getContactNumber().trim();
						}
					}
				} catch (Exception e) {
					logger.warn("Could not query createSavingRepo for memberCode: {}", memberId, e);
				}
			}
		}

		return contact;
	}

	// ==========================================
	// SEND SMS (ASYNC HTTP GET)
	// ==========================================
	private void sendSms(String mobileNumber, String messageText) {
		if (mobileNumber == null || mobileNumber.trim().isEmpty()) {
			logger.info("Skipping SMS: No contact number provided.");
			return;
		}

		String cleanMobile = mobileNumber.replaceAll("[^0-9]", "");
		if (cleanMobile.length() > 10) {
			cleanMobile = cleanMobile.substring(cleanMobile.length() - 10);
		}

		if (cleanMobile.length() != 10) {
			logger.warn("Skipping SMS: Invalid 10-digit mobile number: {}", mobileNumber);
			return;
		}

		final String targetMobile = cleanMobile;
		final String msg = messageText;

		CompletableFuture.runAsync(() -> {
			try {
				String encodedMsg = URLEncoder.encode(msg, StandardCharsets.UTF_8.toString());
				String requestUrl = "https://sms.autobysms.com/app/smsapi/index.php?key=" + smsApiKey
						+ "&campaign=0&routeid=9&type=text&contacts=" + targetMobile
						+ "&senderid=" + smsSenderId + "&msg=" + encodedMsg;

				URL url = new URL(requestUrl);
				HttpURLConnection conn = (HttpURLConnection) url.openConnection();
				conn.setRequestMethod("GET");
				conn.setConnectTimeout(8000);
				conn.setReadTimeout(8000);

				int responseCode = conn.getResponseCode();
				BufferedReader in = new BufferedReader(new InputStreamReader(
						(responseCode >= 200 && responseCode < 300) ? conn.getInputStream() : conn.getErrorStream()));
				StringBuilder response = new StringBuilder();
				String inputLine;
				while ((inputLine = in.readLine()) != null) {
					response.append(inputLine);
				}
				in.close();

				logger.info("✅ SMS sent to {} (HTTP {}): {}", targetMobile, responseCode, response);
			} catch (Exception e) {
				logger.error("❌ Failed to send SMS to {}: {}", targetMobile, e.getMessage());
			}
		});
	}

	// ==========================================
	// SEND PLAIN TEXT EMAIL
	// ==========================================
	private void sendEmail(String emailId, String subject, String bodyText) {
		if (emailId == null || emailId.trim().isEmpty()) {
			logger.info("Skipping Email: No email address registered for customer.");
			return;
		}

		final String targetEmail = emailId.trim();
		CompletableFuture.runAsync(() -> {
			try {
				if (mailSender == null) {
					logger.warn("JavaMailSender not available, skipping email to {}", targetEmail);
					return;
				}
				SimpleMailMessage message = new SimpleMailMessage();
				message.setFrom(fromEmail);
				message.setTo(targetEmail);
				message.setSubject(subject);
				message.setText(bodyText);
				mailSender.send(message);
				logger.info("✅ Plain text email sent successfully to {}", targetEmail);
			} catch (Exception e) {
				logger.error("❌ Failed to send email to {}: {}", targetEmail, e.getMessage());
			}
		});
	}

	// ==========================================
	// SEND HTML EMAIL (WITH FALLBACK)
	// ==========================================
	private void sendHtmlEmail(String emailId, String subject, String htmlBody, String fallbackText) {
		if (emailId == null || emailId.trim().isEmpty()) {
			logger.info("Skipping Email: No email address registered for customer.");
			return;
		}

		final String targetEmail = emailId.trim();
		CompletableFuture.runAsync(() -> {
			try {
				if (mailSender == null) {
					logger.warn("JavaMailSender not available, skipping email to {}", targetEmail);
					return;
				}
				MimeMessage mimeMessage = mailSender.createMimeMessage();
				MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
				helper.setFrom(fromEmail);
				helper.setTo(targetEmail);
				helper.setSubject(subject);
				helper.setText(fallbackText != null ? fallbackText : htmlBody, htmlBody);
				mailSender.send(mimeMessage);
				logger.info("✅ Loan Disbursement HTML email with deductions & EMI chart sent successfully to {}", targetEmail);
			} catch (Exception e) {
				logger.error("❌ Failed to send HTML email to {}: {}", targetEmail, e.getMessage(), e);
				// Fallback to simple mail message
				try {
					SimpleMailMessage message = new SimpleMailMessage();
					message.setFrom(fromEmail);
					message.setTo(targetEmail);
					message.setSubject(subject);
					message.setText(fallbackText != null ? fallbackText : htmlBody);
					mailSender.send(message);
					logger.info("✅ Fallback plain text email sent successfully to {}", targetEmail);
				} catch (Exception ex) {
					logger.error("❌ Fallback email also failed to {}: {}", targetEmail, ex.getMessage());
				}
			}
		});
	}

	private static class CustomerContact {
		String mobile;
		String email;
		String name;
	}
}
