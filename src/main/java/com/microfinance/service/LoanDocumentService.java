package com.microfinance.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring5.SpringTemplateEngine;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.microfinance.dto.AvailableDocumentDto;
import com.microfinance.dto.LoanDocumentDetailDto;
import com.microfinance.dto.RegularLoanStatementResponse;
import com.microfinance.dto.StatementRowDto;
import com.microfinance.model.DocumentGenerationLog;
import com.microfinance.model.LoanApplication;
import com.microfinance.model.LoanClosure;
import com.microfinance.model.LoanDeductionDetails;
import com.microfinance.repository.DocumentGenerationLogRepo;
import com.microfinance.repository.LoanApplicationRepo;
import com.microfinance.repository.LoanClosureRepo;
import com.microfinance.repository.LoanDeductionDetailsRepo;
import com.microfinance.util.PdfDocumentGenerator;

@Service
public class LoanDocumentService {

    private static final Logger logger = LoggerFactory.getLogger(LoanDocumentService.class);
    private static final ObjectMapper objectMapper = new ObjectMapper();

    @Autowired
    private LoanApplicationRepo loanApplicationRepo;

    @Autowired
    private LoanClosureRepo loanClosureRepo;

    @Autowired(required = false)
    private LoanDeductionDetailsRepo loanDeductionDetailsRepo;

    @Autowired
    private DocumentGenerationLogRepo documentGenerationLogRepo;

    @Autowired
    private LoanManagementService loanManagementService;

    @Autowired
    private CommonDocumentService commonDocumentService;

    @Autowired(required = false)
    @Qualifier("documentTemplateEngine")
    private SpringTemplateEngine documentTemplateEngine;

    private SpringTemplateEngine getTemplateEngine() {
        if (documentTemplateEngine == null) {
            documentTemplateEngine = new com.microfinance.config.DocumentTemplateConfig().documentTemplateEngine();
        }
        return documentTemplateEngine;
    }

    public List<String> getPrintableLoanIds() {
        return loanApplicationRepo.findAll().stream()
                .map(LoanApplication::getLoanId)
                .filter(Objects::nonNull)
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .distinct()
                .collect(Collectors.toList());
    }

    public LoanDocumentDetailDto getLoanDetails(String loanId) {
        if (loanId == null || loanId.trim().isEmpty()) {
            throw new IllegalArgumentException("Loan ID cannot be empty");
        }
        loanId = loanId.trim();

        LoanApplication loanApp = loanApplicationRepo.findFirstByLoanIdOrderByIdDesc(loanId);
        if (loanApp == null) {
            throw new RuntimeException("Loan not found for ID: " + loanId);
        }

        LoanDocumentDetailDto dto = new LoanDocumentDetailDto();
        dto.setLoanId(loanApp.getLoanId());
        dto.setLoanDate(loanApp.getLoanDate());
        dto.setLoanPlanName(loanApp.getLoanPlanName());
        dto.setTypeOfLoan(loanApp.getTypeOfLoan());
        dto.setLoanMode(loanApp.getLoanMode());
        dto.setLoanTerm(loanApp.getLoanTerm());
        dto.setRateOfInterest(loanApp.getRateOfInterest());
        dto.setLoanAmount(loanApp.getLoanAmount());
        dto.setInterestType(loanApp.getInterestType());
        dto.setEmiPayment(loanApp.getEmiPayment());
        dto.setPurposeOfLoan(loanApp.getPurposeOfLoan());
        dto.setLoanStatus(loanApp.getLoanStatus() != null ? loanApp.getLoanStatus().toUpperCase() : "PENDING");
        dto.setApprovalStatus(loanApp.isApprovalStatus());
        dto.setApprovalDate(loanApp.getApprovalDate());
        dto.setTotalInterest(loanApp.getTotalInterest());
        dto.setTotalPayableAmount(loanApp.getTotalPayableAmount());

        // Member
        dto.setMemberId(loanApp.getMemberId());
        dto.setMemberName(loanApp.getMemberName());
        dto.setRelativeDetails(loanApp.getRelativeDetails());
        dto.setContactNo(loanApp.getContactNo());
        dto.setAddress(loanApp.getAddress());
        dto.setPinCode(loanApp.getPinCode());
        dto.setBranchName(loanApp.getBranchName() != null ? loanApp.getBranchName() : "Main Branch");

        // Guarantor
        dto.setGuarantorMemberId(loanApp.getGuarantorMemberId());
        dto.setGuarantorIdentity(loanApp.getGuarantorIdentity());
        dto.setGuarantorIdentityNo(loanApp.getGuarantorIdentityNo());
        dto.setGuarantorAadharNo(loanApp.getGuarantorAadharNo());
        dto.setGuarantorPanNo(loanApp.getGuarantorPanNo());
        dto.setGuarantorAddress(loanApp.getGuarantorAddress());
        dto.setGuarantorPinCode(loanApp.getGuarantorPinCode());
        dto.setGuarantorContactNo(loanApp.getGuarantorContactNo());
        dto.setGuarantorSecurityType(loanApp.getGuarantorSecurityType());

        // Co-Applicant
        dto.setCoApplicantMemberId(loanApp.getCoApplicantMemberId());
        dto.setCoApplicantIdentity(loanApp.getCoApplicantIdentity());
        dto.setCoApplicantIdentityNo(loanApp.getCoApplicantIdentityNo());
        dto.setCoApplicantAadharNo(loanApp.getCoApplicantAadharNo());
        dto.setCoApplicantPanNo(loanApp.getCoApplicantPanNo());
        dto.setCoApplicantAddress(loanApp.getCoApplicantAddress());
        dto.setCoApplicantPinCode(loanApp.getCoApplicantPinCode());
        dto.setCoApplicantContactNo(loanApp.getCoApplicantContactNo());

        // Deductions
        double pFee = parseDouble(loanApp.getProcessingFee());
        double lCharges = parseDouble(loanApp.getLegalCharges());
        double gst = parseDouble(loanApp.getGst());
        double insFee = parseDouble(loanApp.getInsuranceFee());
        double valFee = parseDouble(loanApp.getValuationFees());
        double statFee = parseDouble(loanApp.getStationaryFee());

        if (loanApp.getDeductionDetails() != null) {
            LoanDeductionDetails d = loanApp.getDeductionDetails();
            if (pFee == 0 && d.getProcessingFee() != null) pFee = d.getProcessingFee().doubleValue();
            if (lCharges == 0 && d.getLegalCharges() != null) lCharges = d.getLegalCharges().doubleValue();
            if (gst == 0 && d.getGst() != null) gst = d.getGst().doubleValue();
            if (insFee == 0 && d.getInsuranceFee() != null) insFee = d.getInsuranceFee().doubleValue();
            if (valFee == 0 && d.getValuationFees() != null) valFee = d.getValuationFees().doubleValue();
            if (statFee == 0 && d.getStationaryChargesFee() != null) statFee = d.getStationaryChargesFee().doubleValue();
        }

        double totalDeductions = pFee + lCharges + gst + insFee + valFee + statFee;
        double loanAmt = parseDouble(loanApp.getLoanAmount());
        double netDisbursed = parseDouble(loanApp.getNetDisbursementAmount());
        if (netDisbursed <= 0 && loanAmt > 0) {
            netDisbursed = Math.max(0, loanAmt - totalDeductions);
        }

        dto.setProcessingFee(String.format("%.2f", pFee));
        dto.setLegalCharges(String.format("%.2f", lCharges));
        dto.setGst(String.format("%.2f", gst));
        dto.setInsuranceFee(String.format("%.2f", insFee));
        dto.setValuationFees(String.format("%.2f", valFee));
        dto.setStationaryFee(String.format("%.2f", statFee));
        dto.setTotalDeductions(String.format("%.2f", totalDeductions));
        dto.setNetDisbursementAmount(String.format("%.2f", netDisbursed));

        // Payment / Disbursement details
        dto.setPaymentDate(loanApp.getPaymentDate());
        dto.setPaymentStatus(loanApp.getPaymentStatus());
        dto.setPaymentMode(loanApp.getPaymentMode());
        dto.setAccountNo(loanApp.getAccountNo());
        dto.setRef_UpiId(loanApp.getRef_UpiId());
        dto.setChequeNo(loanApp.getChequeNo());
        dto.setChequeDate(loanApp.getChequeDate());

        // Closure info if any
        List<LoanClosure> closures = loanClosureRepo.findByLoanId(loanId);
        if (closures != null && !closures.isEmpty()) {
            LoanClosure lc = closures.get(closures.size() - 1);
            dto.setClosureDate(lc.getPaymentDate());
            dto.setClosureRemarks(lc.getRemarks());
            dto.setClosureReceiptNo(lc.getRef_UpiId() != null ? lc.getRef_UpiId() : "CLOSURE-" + lc.getId());
        }

        // Dynamic details JSON
        if (loanApp.getLoanTypeSpecificDetails() != null && !loanApp.getLoanTypeSpecificDetails().trim().isEmpty()) {
            try {
                Map<String, Object> dynMap = objectMapper.readValue(
                        loanApp.getLoanTypeSpecificDetails(), new TypeReference<Map<String, Object>>() {});
                dto.setDynamicDetails(dynMap);
            } catch (Exception e) {
                logger.warn("Could not parse dynamic loan details JSON for loanId: {}", loanId);
            }
        }

        return dto;
    }

    public List<AvailableDocumentDto> getAvailableDocuments(String loanId) {
        LoanDocumentDetailDto details = getLoanDetails(loanId);
        String status = details.getLoanStatus() != null ? details.getLoanStatus().toUpperCase() : "PENDING";
        boolean isApproved = details.isApprovalStatus() || "APPROVED".equalsIgnoreCase(status)
                || "DISBURSED".equalsIgnoreCase(status) || "ACTIVE".equalsIgnoreCase(status)
                || "CLOSED".equalsIgnoreCase(status);

        boolean isDisbursed = "DISBURSED".equalsIgnoreCase(status) || "ACTIVE".equalsIgnoreCase(status)
                || "CLOSED".equalsIgnoreCase(status) || "PAID".equalsIgnoreCase(details.getPaymentStatus());

        boolean isClosed = "CLOSED".equalsIgnoreCase(status);

        boolean hasGuarantor = (details.getGuarantorMemberId() != null && !details.getGuarantorMemberId().trim().isEmpty())
                || (details.getGuarantorIdentityNo() != null && !details.getGuarantorIdentityNo().trim().isEmpty())
                || (details.getGuarantorIdentity() != null && !details.getGuarantorIdentity().trim().isEmpty())
                || (details.getCoApplicantMemberId() != null && !details.getCoApplicantMemberId().trim().isEmpty());

        List<AvailableDocumentDto> list = new ArrayList<>();

        // 1. Sanction Letter
        list.add(new AvailableDocumentDto(
                "SANCTION_LETTER",
                "Loan Sanction Letter",
                isApproved,
                isApproved ? "Available" : "Requires loan status to be APPROVED"
        ));

        // 2. Loan Agreement
        list.add(new AvailableDocumentDto(
                "LOAN_AGREEMENT",
                "Loan Agreement",
                isApproved,
                isApproved ? "Available" : "Requires loan status to be APPROVED"
        ));

        // 3. EMI Repayment Schedule
        list.add(new AvailableDocumentDto(
                "REPAYMENT_SCHEDULE",
                "EMI Repayment Schedule",
                isApproved || isDisbursed,
                (isApproved || isDisbursed) ? "Available" : "Requires loan to be APPROVED or DISBURSED"
        ));

        // 4. Guarantor Declaration
        list.add(new AvailableDocumentDto(
                "GUARANTOR_DECLARATION",
                "Guarantor/Co-applicant Declaration",
                hasGuarantor,
                hasGuarantor ? "Available" : "Available only if a Guarantor/Co-Applicant is linked to this loan"
        ));

        // 5. Loan Disbursement Receipt
        list.add(new AvailableDocumentDto(
                "DISBURSEMENT_RECEIPT",
                "Loan Disbursement Receipt",
                isDisbursed,
                isDisbursed ? "Available" : "Available only after the loan has been disbursed"
        ));

        // 6. NOC
        list.add(new AvailableDocumentDto(
                "NOC",
                "No Objection Certificate (NOC)",
                isClosed,
                isClosed ? "Available" : "Available only after loan is fully repaid and status is CLOSED"
        ));

        return list;
    }

    public String renderDocumentHtml(String loanId, String docType) {
        if (docType == null || docType.trim().isEmpty()) {
            throw new IllegalArgumentException("Document type cannot be empty");
        }
        docType = docType.trim().toUpperCase();

        LoanDocumentDetailDto details = getLoanDetails(loanId);

        // Verify gating
        List<AvailableDocumentDto> availableDocs = getAvailableDocuments(loanId);
        AvailableDocumentDto targetDoc = null;
        for (AvailableDocumentDto d : availableDocs) {
            if (d.getDocType().equalsIgnoreCase(docType)) {
                targetDoc = d;
                break;
            }
        }

        if (targetDoc != null && !targetDoc.isAvailable()) {
            throw new IllegalStateException("Document '" + targetDoc.getName() + "' is not available: " + targetDoc.getReason());
        }

        Context context = new Context();
        context.setVariable("loan", details);
        context.setVariable("society", commonDocumentService.getSocietyDetails());

        String todayStr = LocalDate.now().toString();
        context.setVariable("todayDate", todayStr);

        String templateName;
        switch (docType) {
            case "SANCTION_LETTER":
                templateName = "sanction_letter";
                context.setVariable("sanctionRefNo", "SL/" + details.getLoanId() + "/" + LocalDate.now().getYear());
                LocalDate startDate;
                try {
                    startDate = LocalDate.parse(details.getLoanDate().substring(0, 10));
                    context.setVariable("firstRepaymentDate", startDate.plusMonths(1).toString());
                } catch (Exception e) {
                    context.setVariable("firstRepaymentDate", LocalDate.now().plusMonths(1).toString());
                }
                break;

            case "LOAN_AGREEMENT":
                templateName = "loan_agreement";
                break;

            case "REPAYMENT_SCHEDULE":
                templateName = "repayment_schedule";
                buildRepaymentScheduleContext(details, context);
                break;

            case "GUARANTOR_DECLARATION":
                templateName = "guarantor_declaration";
                break;

            case "DISBURSEMENT_RECEIPT":
                templateName = "disbursement_receipt";
                context.setVariable("receiptVoucherNo", "DISB/" + details.getLoanId() + "/REC");
                double netAmt = parseDouble(details.getNetDisbursementAmount());
                double deductions = parseDouble(details.getTotalDeductions());
                context.setVariable("totalDeductionsFormatted", String.format(java.util.Locale.US, "%,.2f", deductions));
                context.setVariable("netDisbursedFormatted", String.format(java.util.Locale.US, "%,.2f", netAmt));
                context.setVariable("netDisbursedInWords", commonDocumentService.convertNumberToWords((long) netAmt) + " Rupees Only");
                break;

            case "NOC":
                templateName = "noc";
                context.setVariable("nocRefNo", "NOC/" + details.getLoanId() + "/" + LocalDate.now().getYear());
                break;

            default:
                throw new IllegalArgumentException("Unsupported document type: " + docType);
        }

        return getTemplateEngine().process(templateName, context);
    }

    public byte[] generateDocumentPdf(String loanId, String docType, String username) throws Exception {
        String htmlContent = renderDocumentHtml(loanId, docType);
        byte[] pdfBytes = commonDocumentService.generatePdf(htmlContent);

        // Record audit log via CommonDocumentService
        String filename = docType + "_" + loanId + ".pdf";
        String docName = getDocumentReadableName(docType);

        commonDocumentService.recordDocumentLog(
                loanId,
                docType,
                docName,
                username,
                filename,
                pdfBytes.length
        );

        logger.info("Generated PDF for loan: {}, docType: {}, size: {} bytes, user: {}",
                loanId, docType, pdfBytes.length, username);

        return pdfBytes;
    }

    public List<DocumentGenerationLog> getDocumentLogs(String loanId) {
        return commonDocumentService.getDocumentLogs(loanId);
    }

    private void buildRepaymentScheduleContext(LoanDocumentDetailDto details, Context context) {
        try {
            RegularLoanStatementResponse stmt = loanManagementService.getRegularLoanStatement(details.getLoanId());
            List<Map<String, Object>> rows = new ArrayList<>();
            double totalEmi = 0.0;
            double totalPrin = 0.0;
            double totalInt = 0.0;

            double currentBal = parseDouble(details.getLoanAmount());
            if (stmt != null && stmt.getStatementRows() != null) {
                for (StatementRowDto r : stmt.getStatementRows()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("installmentNumber", r.getInstallmentNumber());
                    map.put("dueDate", r.getDueDate());
                    map.put("openingBalance", currentBal);
                    map.put("emiAmount", r.getEmiAmount());
                    map.put("principalComponent", r.getPrincipalComponent());
                    map.put("interestComponent", r.getInterestComponent());
                    map.put("closingBalance", r.getRunningBalance());

                    totalEmi += r.getEmiAmount();
                    totalPrin += r.getPrincipalComponent();
                    totalInt += r.getInterestComponent();

                    currentBal = r.getRunningBalance();
                    rows.add(map);
                }
            }

            context.setVariable("scheduleRows", rows);
            context.setVariable("totalEmiSum", totalEmi);
            context.setVariable("totalPrincipalSum", totalPrin);
            context.setVariable("totalInterestSum", totalInt);
            context.setVariable("totalRepayment", String.format(java.util.Locale.US, "%,.2f", totalEmi));
        } catch (Exception ex) {
            logger.warn("Could not compute statement schedule for {}: {}", details.getLoanId(), ex.getMessage());
            context.setVariable("scheduleRows", new ArrayList<>());
            context.setVariable("totalEmiSum", 0.0);
            context.setVariable("totalPrincipalSum", 0.0);
            context.setVariable("totalInterestSum", 0.0);
            context.setVariable("totalRepayment", "0.00");
        }
    }

    private String getDocumentReadableName(String docType) {
        switch (docType) {
            case "SANCTION_LETTER": return "Loan Sanction Letter";
            case "LOAN_AGREEMENT": return "Loan Agreement";
            case "REPAYMENT_SCHEDULE": return "EMI Repayment Schedule";
            case "GUARANTOR_DECLARATION": return "Guarantor/Co-applicant Declaration";
            case "DISBURSEMENT_RECEIPT": return "Loan Disbursement Receipt";
            case "NOC": return "No Objection Certificate (NOC)";
            default: return docType;
        }
    }

    private double parseDouble(String str) {
        if (str == null) return 0.0;
        try {
            return Double.parseDouble(str.replaceAll("[^0-9.]", "").trim());
        } catch (Exception e) {
            return 0.0;
        }
    }

    private String convertNumberToWords(long n) {
        if (n <= 0) return "Zero";
        String[] units = { "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
                "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
        String[] tens = { "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };

        if (n >= 10000000) {
            return convertNumberToWords(n / 10000000) + " Crore " + convertNumberToWords(n % 10000000);
        }
        if (n >= 100000) {
            return convertNumberToWords(n / 100000) + " Lakh " + convertNumberToWords(n % 100000);
        }
        if (n >= 1000) {
            return convertNumberToWords(n / 1000) + " Thousand " + convertNumberToWords(n % 1000);
        }
        if (n >= 100) {
            return convertNumberToWords(n / 100) + " Hundred " + convertNumberToWords(n % 100);
        }
        if (n >= 20) {
            return tens[(int) (n / 10)] + " " + units[(int) (n % 10)];
        }
        return units[(int) n];
    }
}
