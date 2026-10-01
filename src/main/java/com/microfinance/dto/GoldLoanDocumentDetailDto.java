package com.microfinance.dto;

import java.util.ArrayList;
import java.util.List;

public class GoldLoanDocumentDetailDto {

    // Identifiers & Basic Loan Information
    private String goldId;
    private String loanNo;
    private String loanDate;
    private String loanPlanName;
    private String typeOfLoan;
    private String loanMode;
    private String loanTerm;
    private String rateOfInterest;
    private String loanAmount;
    private String sanctionedAmount;
    private String interestType;
    private String emiPayment;
    private String purposeOfLoan;
    private String loanStatus;
    private boolean approvalStatus;
    private String approvalDate;
    private String totalInterest;
    private String totalPayableAmount;

    // Member / Borrower Information
    private String memberCode;
    private String customerName;
    private String dateOfBirth;
    private String age;
    private String contactNo;
    private String address;
    private String pinCode;
    private String branchName;

    // Pledged Gold Ornaments & Valuation
    private List<GoldItemDto> items = new ArrayList<>();
    private String itemName;
    private String itemType;
    private String karat;
    private String purity;
    private String custgoldRate;
    private String itemQty;
    private String itemWt;
    private String grossWt;
    private String stoneWt;
    private String netWt;
    private String marketValuation;
    private String eligibleLoan;
    private String lockerBranch;

    // Aggregated Gold Totals
    private String totalGrossWt;
    private String totalNetWt;
    private int totalItemsCount;
    private String totalMarketValuation;

    // Guarantor Details
    private String guarantorCustomerCode;
    private String guarantorIdentity;
    private String guarantorAddress;
    private String guarantorPinCode;
    private String guarantorContactNo;
    private String guarantorSecurityType;

    // Co-Applicant Details
    private String coApplicantMemberId;
    private String coApplicantIdentity;
    private String coApplicantAddress;
    private String coAge;
    private String coApplicantContactNo;
    private String securityDetails;

    // Deductions & Disbursement
    private String processingFee;
    private String legalCharges;
    private String stampDuty;
    private String smsCharges;
    private String mainCharges;
    private String stationaryFee;
    private String gst;
    private String insuFee;
    private String penaltyCharge;
    private String valuationFees;
    private String overCharge;
    private String collectionCharge;
    private String totalDeductions;
    private String netDisbursementAmount;

    // Payment / Disbursement Details
    private String paymentStatus;
    private String paymentDate;
    private String paymentMode;
    private String accountNo;

    // Closure Information
    private String closureDate;
    private String closureRemarks;
    private String closureReceiptNo;

    // Financial Consultant
    private String financialConsultantId;
    private String financialConsultantName;

    public GoldLoanDocumentDetailDto() {
    }

    // Getters and Setters
    public String getGoldId() {
        return goldId;
    }

    public void setGoldId(String goldId) {
        this.goldId = goldId;
    }

    public String getLoanNo() {
        return loanNo;
    }

    public void setLoanNo(String loanNo) {
        this.loanNo = loanNo;
    }

    public String getLoanDate() {
        return loanDate;
    }

    public void setLoanDate(String loanDate) {
        this.loanDate = loanDate;
    }

    public String getLoanPlanName() {
        return loanPlanName;
    }

    public void setLoanPlanName(String loanPlanName) {
        this.loanPlanName = loanPlanName;
    }

    public String getTypeOfLoan() {
        return typeOfLoan;
    }

    public void setTypeOfLoan(String typeOfLoan) {
        this.typeOfLoan = typeOfLoan;
    }

    public String getLoanMode() {
        return loanMode;
    }

    public void setLoanMode(String loanMode) {
        this.loanMode = loanMode;
    }

    public String getLoanTerm() {
        return loanTerm;
    }

    public void setLoanTerm(String loanTerm) {
        this.loanTerm = loanTerm;
    }

    public String getRateOfInterest() {
        return rateOfInterest;
    }

    public void setRateOfInterest(String rateOfInterest) {
        this.rateOfInterest = rateOfInterest;
    }

    public String getLoanAmount() {
        return loanAmount;
    }

    public void setLoanAmount(String loanAmount) {
        this.loanAmount = loanAmount;
    }

    public String getSanctionedAmount() {
        return sanctionedAmount;
    }

    public void setSanctionedAmount(String sanctionedAmount) {
        this.sanctionedAmount = sanctionedAmount;
    }

    public String getInterestType() {
        return interestType;
    }

    public void setInterestType(String interestType) {
        this.interestType = interestType;
    }

    public String getEmiPayment() {
        return emiPayment;
    }

    public void setEmiPayment(String emiPayment) {
        this.emiPayment = emiPayment;
    }

    public String getPurposeOfLoan() {
        return purposeOfLoan;
    }

    public void setPurposeOfLoan(String purposeOfLoan) {
        this.purposeOfLoan = purposeOfLoan;
    }

    public String getLoanStatus() {
        return loanStatus;
    }

    public void setLoanStatus(String loanStatus) {
        this.loanStatus = loanStatus;
    }

    public boolean isApprovalStatus() {
        return approvalStatus;
    }

    public void setApprovalStatus(boolean approvalStatus) {
        this.approvalStatus = approvalStatus;
    }

    public String getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(String approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getTotalInterest() {
        return totalInterest;
    }

    public void setTotalInterest(String totalInterest) {
        this.totalInterest = totalInterest;
    }

    public String getTotalPayableAmount() {
        return totalPayableAmount;
    }

    public void setTotalPayableAmount(String totalPayableAmount) {
        this.totalPayableAmount = totalPayableAmount;
    }

    public String getMemberCode() {
        return memberCode;
    }

    public void setMemberCode(String memberCode) {
        this.memberCode = memberCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getClientName() {
        return customerName;
    }

    public void setClientName(String clientName) {
        this.customerName = clientName;
    }

    public String getDateOfBirth() {
        return dateOfBirth;
    }

    public void setDateOfBirth(String dateOfBirth) {
        this.dateOfBirth = dateOfBirth;
    }

    public String getAge() {
        return age;
    }

    public void setAge(String age) {
        this.age = age;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPinCode() {
        return pinCode;
    }

    public void setPinCode(String pinCode) {
        this.pinCode = pinCode;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
    }

    public List<GoldItemDto> getItems() {
        return items;
    }

    public void setItems(List<GoldItemDto> items) {
        this.items = items;
    }

    public String getItemName() {
        return itemName;
    }

    public void setItemName(String itemName) {
        this.itemName = itemName;
    }

    public String getItemType() {
        return itemType;
    }

    public void setItemType(String itemType) {
        this.itemType = itemType;
    }

    public String getKarat() {
        return karat;
    }

    public void setKarat(String karat) {
        this.karat = karat;
    }

    public String getPurity() {
        return purity;
    }

    public void setPurity(String purity) {
        this.purity = purity;
    }

    public String getCustgoldRate() {
        return custgoldRate;
    }

    public void setCustgoldRate(String custgoldRate) {
        this.custgoldRate = custgoldRate;
    }

    public String getItemQty() {
        return itemQty;
    }

    public void setItemQty(String itemQty) {
        this.itemQty = itemQty;
    }

    public String getItemWt() {
        return itemWt;
    }

    public void setItemWt(String itemWt) {
        this.itemWt = itemWt;
    }

    public String getGrossWt() {
        return grossWt;
    }

    public void setGrossWt(String grossWt) {
        this.grossWt = grossWt;
    }

    public String getStoneWt() {
        return stoneWt;
    }

    public void setStoneWt(String stoneWt) {
        this.stoneWt = stoneWt;
    }

    public String getNetWt() {
        return netWt;
    }

    public void setNetWt(String netWt) {
        this.netWt = netWt;
    }

    public String getMarketValuation() {
        return marketValuation;
    }

    public void setMarketValuation(String marketValuation) {
        this.marketValuation = marketValuation;
    }

    public String getEligibleLoan() {
        return eligibleLoan;
    }

    public void setEligibleLoan(String eligibleLoan) {
        this.eligibleLoan = eligibleLoan;
    }

    public String getLockerBranch() {
        return lockerBranch;
    }

    public void setLockerBranch(String lockerBranch) {
        this.lockerBranch = lockerBranch;
    }

    public String getTotalGrossWt() {
        return totalGrossWt;
    }

    public void setTotalGrossWt(String totalGrossWt) {
        this.totalGrossWt = totalGrossWt;
    }

    public String getTotalNetWt() {
        return totalNetWt;
    }

    public void setTotalNetWt(String totalNetWt) {
        this.totalNetWt = totalNetWt;
    }

    public int getTotalItemsCount() {
        return totalItemsCount;
    }

    public void setTotalItemsCount(int totalItemsCount) {
        this.totalItemsCount = totalItemsCount;
    }

    public String getTotalMarketValuation() {
        return totalMarketValuation;
    }

    public void setTotalMarketValuation(String totalMarketValuation) {
        this.totalMarketValuation = totalMarketValuation;
    }

    public String getGuarantorCustomerCode() {
        return guarantorCustomerCode;
    }

    public void setGuarantorCustomerCode(String guarantorCustomerCode) {
        this.guarantorCustomerCode = guarantorCustomerCode;
    }

    public String getGuarantorIdentity() {
        return guarantorIdentity;
    }

    public void setGuarantorIdentity(String guarantorIdentity) {
        this.guarantorIdentity = guarantorIdentity;
    }

    public String getGuarantorAddress() {
        return guarantorAddress;
    }

    public void setGuarantorAddress(String guarantorAddress) {
        this.guarantorAddress = guarantorAddress;
    }

    public String getGuarantorPinCode() {
        return guarantorPinCode;
    }

    public void setGuarantorPinCode(String guarantorPinCode) {
        this.guarantorPinCode = guarantorPinCode;
    }

    public String getGuarantorContactNo() {
        return guarantorContactNo;
    }

    public void setGuarantorContactNo(String guarantorContactNo) {
        this.guarantorContactNo = guarantorContactNo;
    }

    public String getGuarantorSecurityType() {
        return guarantorSecurityType;
    }

    public void setGuarantorSecurityType(String guarantorSecurityType) {
        this.guarantorSecurityType = guarantorSecurityType;
    }

    public String getCoApplicantMemberId() {
        return coApplicantMemberId;
    }

    public void setCoApplicantMemberId(String coApplicantMemberId) {
        this.coApplicantMemberId = coApplicantMemberId;
    }

    public String getCoApplicantIdentity() {
        return coApplicantIdentity;
    }

    public void setCoApplicantIdentity(String coApplicantIdentity) {
        this.coApplicantIdentity = coApplicantIdentity;
    }

    public String getCoApplicantAddress() {
        return coApplicantAddress;
    }

    public void setCoApplicantAddress(String coApplicantAddress) {
        this.coApplicantAddress = coApplicantAddress;
    }

    public String getCoAge() {
        return coAge;
    }

    public void setCoAge(String coAge) {
        this.coAge = coAge;
    }

    public String getCoApplicantContactNo() {
        return coApplicantContactNo;
    }

    public void setCoApplicantContactNo(String coApplicantContactNo) {
        this.coApplicantContactNo = coApplicantContactNo;
    }

    public String getSecurityDetails() {
        return securityDetails;
    }

    public void setSecurityDetails(String securityDetails) {
        this.securityDetails = securityDetails;
    }

    public String getProcessingFee() {
        return processingFee;
    }

    public void setProcessingFee(String processingFee) {
        this.processingFee = processingFee;
    }

    public String getLegalCharges() {
        return legalCharges;
    }

    public void setLegalCharges(String legalCharges) {
        this.legalCharges = legalCharges;
    }

    public String getStampDuty() {
        return stampDuty;
    }

    public void setStampDuty(String stampDuty) {
        this.stampDuty = stampDuty;
    }

    public String getSmsCharges() {
        return smsCharges;
    }

    public void setSmsCharges(String smsCharges) {
        this.smsCharges = smsCharges;
    }

    public String getMainCharges() {
        return mainCharges;
    }

    public void setMainCharges(String mainCharges) {
        this.mainCharges = mainCharges;
    }

    public String getStationaryFee() {
        return stationaryFee;
    }

    public void setStationaryFee(String stationaryFee) {
        this.stationaryFee = stationaryFee;
    }

    public String getGst() {
        return gst;
    }

    public void setGst(String gst) {
        this.gst = gst;
    }

    public String getInsuFee() {
        return insuFee;
    }

    public void setInsuFee(String insuFee) {
        this.insuFee = insuFee;
    }

    public String getPenaltyCharge() {
        return penaltyCharge;
    }

    public void setPenaltyCharge(String penaltyCharge) {
        this.penaltyCharge = penaltyCharge;
    }

    public String getValuationFees() {
        return valuationFees;
    }

    public void setValuationFees(String valuationFees) {
        this.valuationFees = valuationFees;
    }

    public String getOverCharge() {
        return overCharge;
    }

    public void setOverCharge(String overCharge) {
        this.overCharge = overCharge;
    }

    public String getCollectionCharge() {
        return collectionCharge;
    }

    public void setCollectionCharge(String collectionCharge) {
        this.collectionCharge = collectionCharge;
    }

    public String getTotalDeductions() {
        return totalDeductions;
    }

    public void setTotalDeductions(String totalDeductions) {
        this.totalDeductions = totalDeductions;
    }

    public String getNetDisbursementAmount() {
        return netDisbursementAmount;
    }

    public void setNetDisbursementAmount(String netDisbursementAmount) {
        this.netDisbursementAmount = netDisbursementAmount;
    }

    public String getPaymentStatus() {
        return paymentStatus;
    }

    public void setPaymentStatus(String paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public String getPaymentDate() {
        return paymentDate;
    }

    public void setPaymentDate(String paymentDate) {
        this.paymentDate = paymentDate;
    }

    public String getPaymentMode() {
        return paymentMode;
    }

    public void setPaymentMode(String paymentMode) {
        this.paymentMode = paymentMode;
    }

    public String getAccountNo() {
        return accountNo;
    }

    public void setAccountNo(String accountNo) {
        this.accountNo = accountNo;
    }

    public String getClosureDate() {
        return closureDate;
    }

    public void setClosureDate(String closureDate) {
        this.closureDate = closureDate;
    }

    public String getClosureRemarks() {
        return closureRemarks;
    }

    public void setClosureRemarks(String closureRemarks) {
        this.closureRemarks = closureRemarks;
    }

    public String getClosureReceiptNo() {
        return closureReceiptNo;
    }

    public void setClosureReceiptNo(String closureReceiptNo) {
        this.closureReceiptNo = closureReceiptNo;
    }

    public String getFinancialConsultantId() {
        return financialConsultantId;
    }

    public void setFinancialConsultantId(String financialConsultantId) {
        this.financialConsultantId = financialConsultantId;
    }

    public String getFinancialConsultantName() {
        return financialConsultantName;
    }

    public void setFinancialConsultantName(String financialConsultantName) {
        this.financialConsultantName = financialConsultantName;
    }
}
