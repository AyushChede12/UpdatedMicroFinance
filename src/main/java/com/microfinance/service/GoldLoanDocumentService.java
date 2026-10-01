package com.microfinance.service;

import java.math.BigDecimal;
import java.time.LocalDate;
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
import org.springframework.transaction.annotation.Transactional;
import org.thymeleaf.context.Context;
import org.thymeleaf.spring5.SpringTemplateEngine;

import com.microfinance.dto.AvailableDocumentDto;
import com.microfinance.dto.GoldItemDto;
import com.microfinance.dto.GoldLoanDocumentDetailDto;
import com.microfinance.dto.GoldLoanDropdownDto;
import com.microfinance.model.ApplyForGold;
import com.microfinance.model.ApplyForGoldItem;
import com.microfinance.model.DocumentGenerationLog;
import com.microfinance.model.GoldLoanClose;
import com.microfinance.model.GoldLoanPayment;
import com.microfinance.model.addCustomer;
import com.microfinance.repository.AddCustomerRepo;
import com.microfinance.repository.ApplyForGoldRepo;
import com.microfinance.repository.GoldCloseRepo;
import com.microfinance.repository.GoldPaymentRepo;

@Service
public class GoldLoanDocumentService {

    private static final Logger logger = LoggerFactory.getLogger(GoldLoanDocumentService.class);

    @Autowired
    private ApplyForGoldRepo applyForGoldRepo;

    @Autowired
    private AddCustomerRepo addCustomerRepo;

    @Autowired
    private GoldCloseRepo goldCloseRepo;

    @Autowired
    private GoldPaymentRepo goldPaymentRepo;

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

    /**
     * Returns distinct Gold Loan items (with Loan ID and Client/Customer Name) for document selection.
     */
    public List<GoldLoanDropdownDto> getPrintableGoldLoans() {
        Map<String, GoldLoanDropdownDto> distinctMap = new java.util.LinkedHashMap<>();

        try {
            List<GoldLoanDropdownDto> list = applyForGoldRepo.findAllGoldLoanDropdown();
            if (list != null && !list.isEmpty()) {
                for (GoldLoanDropdownDto dto : list) {
                    if (dto.getGoldID() != null && !dto.getGoldID().trim().isEmpty()) {
                        String gid = dto.getGoldID().trim();
                        if (!distinctMap.containsKey(gid)) {
                            // If customerName is empty, attempt memberCode lookup
                            if ((dto.getCustomerName() == null || dto.getCustomerName().trim().isEmpty())
                                    && dto.getMemberCode() != null && !dto.getMemberCode().trim().isEmpty()) {
                                try {
                                    List<addCustomer> custs = addCustomerRepo.findByMemberCode(dto.getMemberCode().trim());
                                    if (custs != null && !custs.isEmpty() && custs.get(0).getCustomerName() != null) {
                                        dto.setCustomerName(custs.get(0).getCustomerName().trim().toUpperCase());
                                    }
                                } catch (Exception ex) {
                                    logger.debug("Failed customer lookup for memberCode: {}", dto.getMemberCode());
                                }
                            }
                            distinctMap.put(gid, dto);
                        }
                    }
                }
                return new ArrayList<>(distinctMap.values());
            }
        } catch (Exception ex) {
            logger.warn("Query findAllGoldLoanDropdown failed, falling back to findAll: {}", ex.getMessage());
        }

        for (ApplyForGold g : applyForGoldRepo.findAll()) {
            if (g.getGoldID() != null && !g.getGoldID().trim().isEmpty()) {
                String gid = g.getGoldID().trim();
                if (!distinctMap.containsKey(gid)) {
                    String custName = g.getCustomerName();
                    if ((custName == null || custName.trim().isEmpty()) && g.getMemberCode() != null && !g.getMemberCode().trim().isEmpty()) {
                        try {
                            List<addCustomer> custs = addCustomerRepo.findByMemberCode(g.getMemberCode().trim());
                            if (custs != null && !custs.isEmpty() && custs.get(0).getCustomerName() != null) {
                                custName = custs.get(0).getCustomerName();
                            }
                        } catch (Exception ex) {
                            logger.debug("Failed customer lookup for memberCode: {}", g.getMemberCode());
                        }
                    }
                    GoldLoanDropdownDto dto = new GoldLoanDropdownDto(
                            gid,
                            custName != null ? custName.trim().toUpperCase() : "",
                            g.getMemberCode(),
                            g.getGoldLoanStatus(),
                            g.isApprovalStatus(),
                            g.getPaymentStatus(),
                            g.getLoanDate(),
                            g.getLoanAmount()
                    );
                    distinctMap.put(gid, dto);
                }
            }
        }
        return new ArrayList<>(distinctMap.values());
    }

    /**
     * Returns distinct Gold Loan IDs suitable for document printing.
     */
    public List<String> getPrintableGoldLoanIds() {
        try {
            List<String> ids = applyForGoldRepo.findPrintableGoldLoanIds();
            if (ids != null && !ids.isEmpty()) {
                return ids;
            }
        } catch (Exception ex) {
            logger.warn("Query findPrintableGoldLoanIds failed, falling back to findAll: {}", ex.getMessage());
        }

        return applyForGoldRepo.findAll().stream()
                .map(ApplyForGold::getGoldID)
                .filter(Objects::nonNull)
                .map(String::trim)
                .filter(s -> !s.isEmpty())
                .distinct()
                .sorted()
                .collect(Collectors.toList());
    }

    /**
     * Fetches client name associated with the given gold loan ID.
     */
    public String getClientNameByGoldId(String goldId) {
        if (goldId == null || goldId.trim().isEmpty()) {
            return "";
        }
        goldId = goldId.trim();
        ApplyForGold goldLoan = applyForGoldRepo.findSingleByGoldID(goldId);
        if (goldLoan == null) {
            List<ApplyForGold> list = applyForGoldRepo.findByGoldID(goldId);
            if (list != null && !list.isEmpty()) {
                goldLoan = list.get(0);
            }
        }
        if (goldLoan != null) {
            String name = goldLoan.getCustomerName();
            if ((name == null || name.trim().isEmpty()) && goldLoan.getMemberCode() != null && !goldLoan.getMemberCode().trim().isEmpty()) {
                try {
                    List<addCustomer> custs = addCustomerRepo.findByMemberCode(goldLoan.getMemberCode().trim());
                    if (custs != null && !custs.isEmpty() && custs.get(0).getCustomerName() != null) {
                        name = custs.get(0).getCustomerName();
                    }
                } catch (Exception ex) {
                    logger.debug("Customer lookup error: {}", ex.getMessage());
                }
            }
            return name != null ? name.trim().toUpperCase() : "";
        }
        return "";
    }

    /**
     * Assembles all gold loan details, ornaments inventory, borrower, guarantor, deductions, and closure.
     */
    @Transactional(readOnly = true)
    public GoldLoanDocumentDetailDto getGoldLoanDetails(String goldId) {
        if (goldId == null || goldId.trim().isEmpty()) {
            throw new IllegalArgumentException("Gold Loan ID cannot be empty");
        }
        goldId = goldId.trim();

        ApplyForGold goldLoan = applyForGoldRepo.findSingleByGoldID(goldId);
        if (goldLoan == null) {
            List<ApplyForGold> list = applyForGoldRepo.findByGoldID(goldId);
            if (list != null && !list.isEmpty()) {
                goldLoan = list.get(0);
            }
        }

        if (goldLoan == null) {
            throw new RuntimeException("Gold Loan not found for ID: " + goldId);
        }

        GoldLoanDocumentDetailDto dto = new GoldLoanDocumentDetailDto();
        dto.setGoldId(goldLoan.getGoldID());
        dto.setLoanNo(goldLoan.getLoanNo());
        dto.setLoanDate(goldLoan.getLoanDate());
        dto.setLoanPlanName(goldLoan.getLoanPlanName());
        dto.setTypeOfLoan(goldLoan.getTypeOfLoan() != null ? goldLoan.getTypeOfLoan() : "Secured Gold Loan");
        dto.setLoanMode(goldLoan.getLoanMode());
        dto.setLoanTerm(goldLoan.getLoanTerm());
        dto.setRateOfInterest(goldLoan.getRateOfInterest());
        dto.setLoanAmount(goldLoan.getLoanAmount());
        dto.setSanctionedAmount(goldLoan.getSanctionedAmount() != null ? goldLoan.getSanctionedAmount() : goldLoan.getLoanAmount());
        dto.setInterestType(goldLoan.getInterestType());
        dto.setEmiPayment(goldLoan.getEmiPayment());
        dto.setPurposeOfLoan(goldLoan.getPurposeOfLoan());
        dto.setApprovalStatus(goldLoan.isApprovalStatus());
        dto.setApprovalDate(goldLoan.getApprovalDate());

        String status = goldLoan.getGoldLoanStatus() != null ? goldLoan.getGoldLoanStatus().toUpperCase() : "PENDING";
        if (goldLoan.isApprovalStatus() && "PENDING".equalsIgnoreCase(status)) {
            status = "APPROVED";
        }
        dto.setLoanStatus(status);

        // Member / Borrower details
        dto.setMemberCode(goldLoan.getMemberCode());
        String clientName = goldLoan.getCustomerName();
        if ((clientName == null || clientName.trim().isEmpty()) && goldLoan.getMemberCode() != null && !goldLoan.getMemberCode().trim().isEmpty()) {
            try {
                List<addCustomer> custs = addCustomerRepo.findByMemberCode(goldLoan.getMemberCode().trim());
                if (custs != null && !custs.isEmpty() && custs.get(0).getCustomerName() != null) {
                    clientName = custs.get(0).getCustomerName();
                }
            } catch (Exception ex) {
                logger.warn("Could not lookup customer by memberCode: {}", goldLoan.getMemberCode(), ex);
            }
        }
        dto.setCustomerName(clientName != null ? clientName.trim().toUpperCase() : "");
        dto.setDateOfBirth(goldLoan.getDateOfBirth());
        dto.setAge(goldLoan.getAge());
        dto.setContactNo(goldLoan.getContactNo());
        dto.setAddress(goldLoan.getAddress());
        dto.setPinCode(goldLoan.getPinCode());
        dto.setBranchName(goldLoan.getBranchName() != null ? goldLoan.getBranchName() : "Main Branch");

        // Summary Gold values
        dto.setItemName(goldLoan.getItemName());
        dto.setItemType(goldLoan.getItemType());
        dto.setKarat(goldLoan.getKarat());
        dto.setPurity(goldLoan.getPurity());
        dto.setCustgoldRate(goldLoan.getCustgoldRate());
        dto.setItemQty(goldLoan.getItemQty());
        dto.setItemWt(goldLoan.getItemWt());
        dto.setGrossWt(goldLoan.getGrossWt());
        dto.setStoneWt(goldLoan.getStoneWt());
        dto.setNetWt(goldLoan.getNetWt());
        dto.setMarketValuation(goldLoan.getMarketValuation());
        dto.setEligibleLoan(goldLoan.getEligibleLoan());
        dto.setLockerBranch(goldLoan.getLockerBranch() != null ? goldLoan.getLockerBranch() : "Main Branch Locker");

        // Pledged Ornaments list
        List<GoldItemDto> itemDtos = new ArrayList<>();
        double totalGross = 0.0;
        double totalNet = 0.0;
        double totalValuation = 0.0;
        int totalItems = 0;

        if (goldLoan.getItems() != null && !goldLoan.getItems().isEmpty()) {
            for (ApplyForGoldItem item : goldLoan.getItems()) {
                GoldItemDto idto = new GoldItemDto();
                idto.setItemName(item.getItemName());
                idto.setItemType(item.getItemType());
                idto.setKarat(item.getKarat());
                idto.setCustgoldRate(item.getCustgoldRate());
                idto.setLockerBranch(item.getLockerBranch());
                idto.setPurity(item.getPurity());
                idto.setItemQty(item.getItemQty() != null ? item.getItemQty() : 1);
                idto.setItemWt(item.getItemWt());
                idto.setGrossWt(item.getGrossWt());
                idto.setStoneWt(item.getStoneWt() != null ? item.getStoneWt() : BigDecimal.ZERO);
                idto.setNetWt(item.getNetWt());
                idto.setMarketValuation(item.getMarketValuation());
                idto.setEligibleLoan(item.getEligibleLoan());
                itemDtos.add(idto);

                if (item.getGrossWt() != null) totalGross += item.getGrossWt().doubleValue();
                if (item.getNetWt() != null) totalNet += item.getNetWt().doubleValue();
                if (item.getMarketValuation() != null) totalValuation += item.getMarketValuation().doubleValue();
                totalItems += (item.getItemQty() != null ? item.getItemQty() : 1);
            }
        } else {
            // Single item fallback from master entity fields
            GoldItemDto idto = new GoldItemDto();
            idto.setItemName(goldLoan.getItemName() != null ? goldLoan.getItemName() : "Gold Ornaments");
            idto.setItemType(goldLoan.getItemType() != null ? goldLoan.getItemType() : "Ornament");
            try {
                idto.setKarat(goldLoan.getKarat() != null ? Integer.parseInt(goldLoan.getKarat().replaceAll("[^0-9]", "")) : 22);
            } catch (Exception e) {
                idto.setKarat(22);
            }
            idto.setCustgoldRate(BigDecimal.valueOf(commonDocumentService.parseDouble(goldLoan.getCustgoldRate())));
            idto.setLockerBranch(goldLoan.getLockerBranch());
            idto.setPurity(BigDecimal.valueOf(commonDocumentService.parseDouble(goldLoan.getPurity())));
            idto.setItemQty(1);
            idto.setGrossWt(BigDecimal.valueOf(commonDocumentService.parseDouble(goldLoan.getGrossWt())));
            idto.setStoneWt(BigDecimal.valueOf(commonDocumentService.parseDouble(goldLoan.getStoneWt())));
            idto.setNetWt(BigDecimal.valueOf(commonDocumentService.parseDouble(goldLoan.getNetWt())));
            idto.setMarketValuation(BigDecimal.valueOf(commonDocumentService.parseDouble(goldLoan.getMarketValuation())));
            idto.setEligibleLoan(BigDecimal.valueOf(commonDocumentService.parseDouble(goldLoan.getEligibleLoan())));
            itemDtos.add(idto);

            totalGross = commonDocumentService.parseDouble(goldLoan.getGrossWt());
            totalNet = commonDocumentService.parseDouble(goldLoan.getNetWt());
            totalValuation = commonDocumentService.parseDouble(goldLoan.getMarketValuation());
            totalItems = 1;
        }

        dto.setItems(itemDtos);
        dto.setTotalGrossWt(String.format("%.3f", totalGross));
        dto.setTotalNetWt(String.format("%.3f", totalNet));
        dto.setTotalItemsCount(totalItems > 0 ? totalItems : 1);
        dto.setTotalMarketValuation(String.format(java.util.Locale.US, "%,.2f", totalValuation));

        // Guarantor
        dto.setGuarantorCustomerCode(goldLoan.getGuarantorcustomerCode());
        dto.setGuarantorIdentity(goldLoan.getGuarantorIdentity());
        dto.setGuarantorAddress(goldLoan.getGuarantorAddress());
        dto.setGuarantorPinCode(goldLoan.getGuarantorPinCode());
        dto.setGuarantorContactNo(goldLoan.getGuarantorContactNo());
        dto.setGuarantorSecurityType(goldLoan.getGuarantorSecurityType());

        // Co-Applicant
        dto.setCoApplicantMemberId(goldLoan.getCoApplicantMemberId());
        dto.setCoApplicantIdentity(goldLoan.getCoApplicantIdentity());
        dto.setCoApplicantAddress(goldLoan.getCoApplicantAddress());
        dto.setCoAge(goldLoan.getCoAge());
        dto.setCoApplicantContactNo(goldLoan.getCoApplicantContactNo());
        dto.setSecurityDetails(goldLoan.getSecurityDetails());

        // Deductions & Disbursement
        double pFee = commonDocumentService.parseDouble(goldLoan.getProcessingFee());
        double lCharges = commonDocumentService.parseDouble(goldLoan.getLegalCharges());
        double gst = commonDocumentService.parseDouble(goldLoan.getGst());
        double insFee = commonDocumentService.parseDouble(goldLoan.getInsuFee());
        double valFee = commonDocumentService.parseDouble(goldLoan.getValuationFees());
        double statFee = commonDocumentService.parseDouble(goldLoan.getStationaryFee());
        double stampDuty = commonDocumentService.parseDouble(goldLoan.getStampDuty());
        double smsCharges = commonDocumentService.parseDouble(goldLoan.getSmsCharges());
        double mainCharges = commonDocumentService.parseDouble(goldLoan.getMainCharges());
        double totalDeductions = pFee + lCharges + gst + insFee + valFee + statFee + stampDuty + smsCharges + mainCharges;

        double loanAmt = commonDocumentService.parseDouble(goldLoan.getLoanAmount());
        double netDisbursed = commonDocumentService.parseDouble(goldLoan.getNetDisbursement());
        if (netDisbursed <= 0 && loanAmt > 0) {
            netDisbursed = Math.max(0, loanAmt - totalDeductions);
        }

        dto.setProcessingFee(String.format("%.2f", pFee));
        dto.setLegalCharges(String.format("%.2f", lCharges));
        dto.setGst(String.format("%.2f", gst));
        dto.setInsuFee(String.format("%.2f", insFee));
        dto.setValuationFees(String.format("%.2f", valFee));
        dto.setStationaryFee(String.format("%.2f", statFee));
        dto.setStampDuty(String.format("%.2f", stampDuty));
        dto.setSmsCharges(String.format("%.2f", smsCharges));
        dto.setMainCharges(String.format("%.2f", mainCharges));
        dto.setTotalDeductions(String.format(java.util.Locale.US, "%,.2f", totalDeductions));
        dto.setNetDisbursementAmount(String.format(java.util.Locale.US, "%,.2f", netDisbursed));

        // Format and calculate Total Interest & Total Payable Amount on full Applied Principal
        double totalInterestVal = 0.0;
        double totalPayableVal = loanAmt;
        if (goldLoan.getTotalInterest() != null && !goldLoan.getTotalInterest().trim().isEmpty() 
                && !"0.00".equals(goldLoan.getTotalInterest().trim()) && !"0".equals(goldLoan.getTotalInterest().trim())) {
            totalInterestVal = commonDocumentService.parseDouble(goldLoan.getTotalInterest());
            totalPayableVal = commonDocumentService.parseDouble(goldLoan.getTotalPayableAmount());
            if (totalPayableVal <= 0) {
                totalPayableVal = loanAmt + totalInterestVal;
            }
        } else if (loanAmt > 0) {
            double rate = commonDocumentService.parseDouble(goldLoan.getRateOfInterest());
            int term = 12;
            try {
                if (goldLoan.getLoanTerm() != null) term = Integer.parseInt(goldLoan.getLoanTerm().replaceAll("[^0-9]", ""));
            } catch (Exception ignored) {}
            if (term <= 0) term = 12;

            if ("REDUCING".equalsIgnoreCase(goldLoan.getInterestType())) {
                if (rate > 0) {
                    double r = (rate / 12.0) / 100.0;
                    double emi = (loanAmt * r * Math.pow(1 + r, term)) / (Math.pow(1 + r, term) - 1);
                    totalPayableVal = emi * term;
                    totalInterestVal = Math.max(0, totalPayableVal - loanAmt);
                } else {
                    totalPayableVal = loanAmt;
                    totalInterestVal = 0.0;
                }
            } else {
                totalInterestVal = loanAmt * (rate / 100.0) * (term / 12.0);
                totalPayableVal = loanAmt + totalInterestVal;
            }
        }

        dto.setLoanAmount(String.format(java.util.Locale.US, "%,.2f", loanAmt));
        dto.setSanctionedAmount(String.format(java.util.Locale.US, "%,.2f", loanAmt));
        dto.setTotalInterest(String.format(java.util.Locale.US, "%,.2f", totalInterestVal));
        dto.setTotalPayableAmount(String.format(java.util.Locale.US, "%,.2f", totalPayableVal));

        double emiVal = commonDocumentService.parseDouble(goldLoan.getEmiPayment());
        if (emiVal > 0) {
            dto.setEmiPayment(String.format(java.util.Locale.US, "%,.2f", emiVal));
        } else if ("Bullet".equalsIgnoreCase(goldLoan.getLoanMode())) {
            dto.setEmiPayment("0.00 (Bullet)");
        } else {
            dto.setEmiPayment("0.00");
        }

        // Payment / Disbursement info
        dto.setPaymentStatus(goldLoan.getPaymentStatus());
        List<GoldLoanPayment> payments = goldPaymentRepo.findByGoldID(goldId);
        if (payments != null && !payments.isEmpty()) {
            GoldLoanPayment gp = payments.get(0);
            dto.setPaymentDate(gp.getGoldLoanDate() != null ? gp.getGoldLoanDate() : goldLoan.getLoanDate());
            dto.setPaymentMode(gp.getLoanMode() != null ? gp.getLoanMode() : "Cash");
        } else {
            dto.setPaymentDate(goldLoan.getLoanDate());
            dto.setPaymentMode("Cash");
        }

        // Closure info if any
        List<GoldLoanClose> closures = goldCloseRepo.findByGoldID(goldId);
        if (closures != null && !closures.isEmpty()) {
            GoldLoanClose gc = closures.get(closures.size() - 1);
            dto.setClosureDate(gc.getPaymentDate());
            dto.setClosureRemarks(gc.getRemarks());
            dto.setClosureReceiptNo(gc.getId() != null ? "GL-CLOSE-" + gc.getId() : "GL-CLOSE");
            dto.setLoanStatus("CLOSED");
        }

        // Financial Consultant
        dto.setFinancialConsultantId(goldLoan.getFinancialConsultantId());
        dto.setFinancialConsultantName(goldLoan.getFinancialConsultantName());

        return dto;
    }

    /**
     * Determines which documents are available to preview/generate based on lifecycle state.
     */
    public List<AvailableDocumentDto> getAvailableDocuments(String goldId) {
        GoldLoanDocumentDetailDto details = getGoldLoanDetails(goldId);
        String status = details.getLoanStatus() != null ? details.getLoanStatus().toUpperCase() : "PENDING";

        boolean isApproved = details.isApprovalStatus() || "APPROVED".equalsIgnoreCase(status)
                || "DISBURSED".equalsIgnoreCase(status) || "ACTIVE".equalsIgnoreCase(status)
                || "CLOSED".equalsIgnoreCase(status);

        boolean isDisbursed = "DISBURSED".equalsIgnoreCase(status) || "ACTIVE".equalsIgnoreCase(status)
                || "CLOSED".equalsIgnoreCase(status) || "PAID".equalsIgnoreCase(details.getPaymentStatus());

        boolean isClosed = "CLOSED".equalsIgnoreCase(status);

        boolean hasGuarantor = (details.getGuarantorIdentity() != null && !details.getGuarantorIdentity().trim().isEmpty())
                || (details.getGuarantorCustomerCode() != null && !details.getGuarantorCustomerCode().trim().isEmpty())
                || (details.getCoApplicantIdentity() != null && !details.getCoApplicantIdentity().trim().isEmpty())
                || (details.getCoApplicantMemberId() != null && !details.getCoApplicantMemberId().trim().isEmpty());

        List<AvailableDocumentDto> list = new ArrayList<>();

        // 1. Application & Appraisal Form (Always Available)
        list.add(new AvailableDocumentDto(
                "APPLICATION_FORM",
                "Gold Loan Application & Appraisal Form",
                true,
                "Available"
        ));

        // 2. Sanction Letter
        list.add(new AvailableDocumentDto(
                "SANCTION_LETTER",
                "Gold Loan Sanction Letter",
                isApproved,
                isApproved ? "Available" : "Requires gold loan status to be APPROVED"
        ));

        // 3. Loan Agreement & Pledge Deed
        list.add(new AvailableDocumentDto(
                "LOAN_AGREEMENT",
                "Gold Loan Agreement & Pledge Deed",
                isApproved,
                isApproved ? "Available" : "Requires gold loan status to be APPROVED"
        ));

        // 4. EMI Repayment Schedule
        list.add(new AvailableDocumentDto(
                "REPAYMENT_SCHEDULE",
                "EMI Repayment Schedule",
                isApproved || isDisbursed,
                (isApproved || isDisbursed) ? "Available" : "Requires gold loan to be APPROVED or DISBURSED"
        ));

        // 5. Guarantor & Co-Applicant Declaration
        list.add(new AvailableDocumentDto(
                "GUARANTOR_DECLARATION",
                "Guarantor & Co-Applicant Declaration",
                hasGuarantor,
                hasGuarantor ? "Available" : "Available only if a Guarantor or Co-Applicant is linked"
        ));

        // 6. Disbursement Receipt
        list.add(new AvailableDocumentDto(
                "DISBURSEMENT_RECEIPT",
                "Gold Loan Disbursement Receipt",
                isDisbursed,
                isDisbursed ? "Available" : "Available only after the loan has been disbursed"
        ));

        // 7. NOC & Pledge Release
        list.add(new AvailableDocumentDto(
                "NOC",
                "No Objection & Ornament Release Certificate (NOC)",
                isClosed,
                isClosed ? "Available" : "Available only after loan is fully closed and status is CLOSED"
        ));

        return list;
    }

    /**
     * Renders document HTML using Thymeleaf documentTemplateEngine.
     */
    public String renderDocumentHtml(String goldId, String docType) {
        if (docType == null || docType.trim().isEmpty()) {
            throw new IllegalArgumentException("Document type cannot be empty");
        }
        docType = docType.trim().toUpperCase();

        GoldLoanDocumentDetailDto details = getGoldLoanDetails(goldId);

        // Verify gating
        List<AvailableDocumentDto> availableDocs = getAvailableDocuments(goldId);
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
            case "APPLICATION_FORM":
            case "APPLICANTFORM":
                templateName = "gold_applicant_form";
                break;

            case "SANCTION_LETTER":
            case "SANCTIONLETTER":
                templateName = "gold_sanction_letter";
                context.setVariable("sanctionRefNo", "GL/SL/" + details.getGoldId() + "/" + LocalDate.now().getYear());
                LocalDate startDate;
                try {
                    startDate = LocalDate.parse(details.getLoanDate().substring(0, 10));
                    context.setVariable("firstRepaymentDate", startDate.plusMonths(1).toString());
                } catch (Exception e) {
                    context.setVariable("firstRepaymentDate", LocalDate.now().plusMonths(1).toString());
                }
                break;

            case "LOAN_AGREEMENT":
            case "LOANAGREEMENT":
                templateName = "gold_loan_agreement";
                break;

            case "REPAYMENT_SCHEDULE":
            case "REPAYMENTSCHEDULE":
                templateName = "gold_repayment_schedule";
                buildRepaymentScheduleContext(details, context);
                break;

            case "GUARANTOR_DECLARATION":
            case "GUARANTORDECLARATION":
                templateName = "gold_guarantor_declaration";
                break;

            case "DISBURSEMENT_RECEIPT":
            case "DISBURSEMENTRECEIPT":
                templateName = "gold_disbursement_receipt";
                context.setVariable("receiptVoucherNo", "GL-DISB/" + details.getGoldId() + "/REC");
                double netAmt = commonDocumentService.parseDouble(details.getNetDisbursementAmount());
                context.setVariable("netDisbursedInWords", commonDocumentService.convertNumberToWords((long) netAmt) + " Rupees Only");
                break;

            case "NOC":
                templateName = "gold_noc";
                context.setVariable("nocRefNo", "GL-NOC/" + details.getGoldId() + "/" + LocalDate.now().getYear());
                break;

            default:
                throw new IllegalArgumentException("Unsupported gold loan document type: " + docType);
        }

        return getTemplateEngine().process(templateName, context);
    }

    /**
     * Generates PDF bytes and logs generation audit.
     */
    public byte[] generateDocumentPdf(String goldId, String docType, String username) throws Exception {
        String htmlContent = renderDocumentHtml(goldId, docType);
        byte[] pdfBytes = commonDocumentService.generatePdf(htmlContent);

        String filename = docType.toUpperCase() + "_" + goldId + ".pdf";
        String docName = getDocumentReadableName(docType);

        commonDocumentService.recordDocumentLog(goldId, docType.toUpperCase(), docName, username, filename, pdfBytes.length);

        logger.info("Generated Gold Loan PDF: goldId={}, docType={}, size={} bytes, user={}", 
                goldId, docType, pdfBytes.length, username);

        return pdfBytes;
    }

    /**
     * Retrieves audit generation logs for a gold loan.
     */
    public List<DocumentGenerationLog> getDocumentLogs(String goldId) {
        return commonDocumentService.getDocumentLogs(goldId);
    }

    private void buildRepaymentScheduleContext(GoldLoanDocumentDetailDto details, Context context) {
        try {
            double loanAmount = commonDocumentService.parseDouble(details.getLoanAmount());
            double rate = commonDocumentService.parseDouble(details.getRateOfInterest());
            int term = 12;
            try {
                term = Integer.parseInt(details.getLoanTerm().replaceAll("[^0-9]", ""));
            } catch (Exception e) {}
            if (term <= 0) term = 12;

            String interestType = (details.getInterestType() != null) ? details.getInterestType().trim().toUpperCase() : "FLAT";
            LocalDate baseDate = LocalDate.now();
            try {
                if (details.getLoanDate() != null && details.getLoanDate().length() >= 10) {
                    baseDate = LocalDate.parse(details.getLoanDate().substring(0, 10));
                }
            } catch (Exception e) {}

            List<Map<String, Object>> rows = new ArrayList<>();
            double totalEmi = 0.0;
            double totalPrin = 0.0;
            double totalInt = 0.0;

            if (interestType.contains("REDUCING")) {
                double monthlyRate = (rate / 100.0) / 12.0;
                double emi = 0.0;
                if (monthlyRate > 0) {
                    emi = loanAmount * monthlyRate * Math.pow(1 + monthlyRate, term) / (Math.pow(1 + monthlyRate, term) - 1);
                } else {
                    emi = loanAmount / term;
                }

                double curBal = loanAmount;
                for (int i = 1; i <= term; i++) {
                    double intComp = curBal * monthlyRate;
                    double prinComp = emi - intComp;
                    double closeBal = Math.max(0, curBal - prinComp);

                    Map<String, Object> r = new HashMap<>();
                    r.put("installmentNumber", i);
                    r.put("dueDate", baseDate.plusMonths(i).toString());
                    r.put("openingBalance", curBal);
                    r.put("emiAmount", emi);
                    r.put("principalComponent", prinComp);
                    r.put("interestComponent", intComp);
                    r.put("closingBalance", closeBal);
                    rows.add(r);

                    totalEmi += emi;
                    totalPrin += prinComp;
                    totalInt += intComp;
                    curBal = closeBal;
                }
            } else {
                // Flat Interest method
                double totalInterestCalc = (loanAmount * rate * term) / (100.0 * 12.0);
                double monthlyInterest = totalInterestCalc / term;
                double monthlyPrincipal = loanAmount / term;
                double emi = monthlyPrincipal + monthlyInterest;

                double curBal = loanAmount;
                for (int i = 1; i <= term; i++) {
                    double closeBal = Math.max(0, curBal - monthlyPrincipal);

                    Map<String, Object> r = new HashMap<>();
                    r.put("installmentNumber", i);
                    r.put("dueDate", baseDate.plusMonths(i).toString());
                    r.put("openingBalance", curBal);
                    r.put("emiAmount", emi);
                    r.put("principalComponent", monthlyPrincipal);
                    r.put("interestComponent", monthlyInterest);
                    r.put("closingBalance", closeBal);
                    rows.add(r);

                    totalEmi += emi;
                    totalPrin += monthlyPrincipal;
                    totalInt += monthlyInterest;
                    curBal = closeBal;
                }
            }

            context.setVariable("scheduleRows", rows);
            context.setVariable("totalEmiSum", totalEmi);
            context.setVariable("totalPrincipalSum", totalPrin);
            context.setVariable("totalInterestSum", totalInt);
            context.setVariable("totalRepayment", String.format(java.util.Locale.US, "%,.2f", totalEmi));
        } catch (Exception ex) {
            logger.warn("Could not compute schedule for gold loan {}: {}", details.getGoldId(), ex.getMessage());
            context.setVariable("scheduleRows", new ArrayList<>());
            context.setVariable("totalEmiSum", 0.0);
            context.setVariable("totalPrincipalSum", 0.0);
            context.setVariable("totalInterestSum", 0.0);
            context.setVariable("totalRepayment", "0.00");
        }
    }

    private String getDocumentReadableName(String docType) {
        switch (docType.toUpperCase()) {
            case "APPLICATION_FORM":
            case "APPLICANTFORM":
                return "Gold Loan Application & Appraisal Form";
            case "SANCTION_LETTER":
            case "SANCTIONLETTER":
                return "Gold Loan Sanction Letter";
            case "LOAN_AGREEMENT":
            case "LOANAGREEMENT":
                return "Gold Loan Agreement & Pledge Deed";
            case "REPAYMENT_SCHEDULE":
            case "REPAYMENTSCHEDULE":
                return "EMI Repayment Schedule";
            case "GUARANTOR_DECLARATION":
            case "GUARANTORDECLARATION":
                return "Guarantor & Co-Applicant Declaration";
            case "DISBURSEMENT_RECEIPT":
            case "DISBURSEMENTRECEIPT":
                return "Gold Loan Disbursement Receipt";
            case "NOC":
                return "No Objection & Gold Release Certificate (NOC)";
            default:
                return docType;
        }
    }
}
