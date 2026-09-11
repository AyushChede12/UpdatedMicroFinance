package com.microfinance.service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.util.List;
import java.util.concurrent.CompletableFuture;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;

import com.microfinance.model.CreateSavingsAccount;
import com.microfinance.model.LoanApplication;
import com.microfinance.model.LoanPayment;
import com.microfinance.model.addCustomer;
import com.microfinance.repository.AddCustomerRepo;
import com.microfinance.repository.CreateSavingAccountRepo;

@Service
public class LoanNotificationService {

	private static final Logger logger = LoggerFactory.getLogger(LoanNotificationService.class);

	@Autowired(required = false)
	private JavaMailSender mailSender;

	@Autowired
	private AddCustomerRepo addCustomerRepo;

	@Autowired
	private CreateSavingAccountRepo createSavingRepo;

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
				+ "Rate of Interest    : " + (loanApp.getRateOfInterest() != null ? loanApp.getRateOfInterest() + "% P.A." : "N/A") + "\n"
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
				+ "Installment (EMI)   : Rs. " + (loanApp.getEmiPayment() != null ? loanApp.getEmiPayment() : "N/A") + "\n"
				+ "--------------------------------------------------\n\n"
				+ "Your loan is now ready for disbursement. You can visit your branch to complete the disbursement process.\n\n"
				+ "Warm regards,\n"
				+ "Credit Approval Team\n"
				+ "Samitha Urban Nidhi Limited";
		sendEmail(contact.email, emailSubject, emailBody);
	}

	// ==========================================
	// 3. LOAN DISBURSEMENT NOTIFICATION
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
		String disbursedAmount = loanApp != null && loanApp.getLoanAmount() != null ? loanApp.getLoanAmount()
				: (payment != null && payment.getLoanAmount() != null ? payment.getLoanAmount() : "0.00");
		String mode = payment != null && payment.getPaymentMode() != null ? payment.getPaymentMode() : "Cash";
		String accountNo = payment != null && payment.getAccountNo() != null ? payment.getAccountNo() : "N/A";
		String disburseDate = payment != null && payment.getPaymentDate() != null ? payment.getPaymentDate() : "N/A";

		boolean isSavingTransfer = "Saving Account".equalsIgnoreCase(mode) || "Savings Account".equalsIgnoreCase(mode);

		// SMS message
		String smsText;
		if (isSavingTransfer) {
			smsText = "Dear " + contact.name + ", your loan (" + loanId + ") of Rs." + disbursedAmount
					+ " has been disbursed and credited to your Savings A/c " + accountNo + ". - Samitha Urban";
		} else {
			smsText = "Dear " + contact.name + ", your loan (" + loanId + ") of Rs." + disbursedAmount
					+ " has been disbursed in Cash successfully. - Samitha Urban";
		}
		sendSms(contact.mobile, smsText);

		// Email message
		String emailSubject = "Loan Disbursed Successfully - " + loanId + " | Samitha Urban Nidhi Limited";
		String emailBody = "Dear " + contact.name + ",\n\n"
				+ "We are pleased to inform you that your loan has been successfully DISBURSED.\n\n"
				+ "--------------------------------------------------\n"
				+ "Loan ID             : " + loanId + "\n"
				+ "Customer Member Code: " + (memberId != null ? memberId : "N/A") + "\n"
				+ "Disbursed Amount    : Rs. " + disbursedAmount + "\n"
				+ "Mode of Disbursement: " + (isSavingTransfer ? "Transfer to Savings Account" : "Cash") + "\n"
				+ (isSavingTransfer ? ("Savings Account No. : " + accountNo + "\n") : "")
				+ "Disbursement Date   : " + disburseDate + "\n"
				+ "EMI Installment     : Rs. " + (payment != null && payment.getEmiPayment() != null ? payment.getEmiPayment() : "N/A") + "\n"
				+ "--------------------------------------------------\n\n"
				+ "Please maintain sufficient balance or timely deposits for regular installment payments.\n\n"
				+ "Thank you for partnering with Samitha Urban Nidhi Limited.\n\n"
				+ "Warm regards,\n"
				+ "Disbursement & Operations Team\n"
				+ "Samitha Urban Nidhi Limited";
		sendEmail(contact.email, emailSubject, emailBody);
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
	// SEND EMAIL (ASYNC JAVAMAILSENDER)
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
				logger.info("✅ Email sent successfully to {}", targetEmail);
			} catch (Exception e) {
				logger.error("❌ Failed to send email to {}: {}", targetEmail, e.getMessage());
			}
		});
	}

	private static class CustomerContact {
		String mobile;
		String email;
		String name;
	}
}
