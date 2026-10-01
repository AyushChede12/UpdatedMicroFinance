package com.microfinance.dto;

import java.util.ArrayList;
import java.util.List;

public class GoldLoanForeclosureSettlementDto {
    private String goldId;
    private String customerCode;
    private String customerName;
    private String contactNo;
    private String branchName;
    private String loanPlanName;
    private String typeOfLoan;
    private String loanMode;
    private String loanTerm;
    private String rateOfInterest;
    private String interestType;
    private String emiPayment;
    private String loanDate;
    private String lastPaymentDate;

    private int totalInstallments;
    private int paidInstallments;

    private double sanctionedPrincipal;
    private double totalPrincipalPaid;
    private double principalOutstanding;

    private long elapsedDaysSinceLastPayment;
    private double accruedInterestTillDate;
    private double overdueArrears;
    private double pendingPenalties;
    private double foreclosureFeePercent;
    private double foreclosureFeeAmount;
    private double unearnedInterestRebate;
    private double netPayoffAmount;

    private String totalInterest;
    private String totalPayableAmount;

    private String savingsAccountNumber;
    private double savingsAccountBalance;

    private String financialConsultantId;
    private String financialConsultantName;

    // Gold Collateral & Pledged Ornaments
    private String lockerBranch;
    private String totalGrossWt;
    private String totalNetWt;
    private String totalMarketValuation;
    private int totalItemsCount;
    private List<GoldItemDto> items = new ArrayList<>();

    private String guarantorName;
    private String coApplicantName;

    public GoldLoanForeclosureSettlementDto() {
    }

    public String getGoldId() {
        return goldId;
    }

    public void setGoldId(String goldId) {
        this.goldId = goldId;
    }

    public String getCustomerCode() {
        return customerCode;
    }

    public void setCustomerCode(String customerCode) {
        this.customerCode = customerCode;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getContactNo() {
        return contactNo;
    }

    public void setContactNo(String contactNo) {
        this.contactNo = contactNo;
    }

    public String getBranchName() {
        return branchName;
    }

    public void setBranchName(String branchName) {
        this.branchName = branchName;
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

    public String getLoanDate() {
        return loanDate;
    }

    public void setLoanDate(String loanDate) {
        this.loanDate = loanDate;
    }

    public String getLastPaymentDate() {
        return lastPaymentDate;
    }

    public void setLastPaymentDate(String lastPaymentDate) {
        this.lastPaymentDate = lastPaymentDate;
    }

    public int getTotalInstallments() {
        return totalInstallments;
    }

    public void setTotalInstallments(int totalInstallments) {
        this.totalInstallments = totalInstallments;
    }

    public int getPaidInstallments() {
        return paidInstallments;
    }

    public void setPaidInstallments(int paidInstallments) {
        this.paidInstallments = paidInstallments;
    }

    public double getSanctionedPrincipal() {
        return sanctionedPrincipal;
    }

    public void setSanctionedPrincipal(double sanctionedPrincipal) {
        this.sanctionedPrincipal = sanctionedPrincipal;
    }

    public double getTotalPrincipalPaid() {
        return totalPrincipalPaid;
    }

    public void setTotalPrincipalPaid(double totalPrincipalPaid) {
        this.totalPrincipalPaid = totalPrincipalPaid;
    }

    public double getPrincipalOutstanding() {
        return principalOutstanding;
    }

    public void setPrincipalOutstanding(double principalOutstanding) {
        this.principalOutstanding = principalOutstanding;
    }

    public long getElapsedDaysSinceLastPayment() {
        return elapsedDaysSinceLastPayment;
    }

    public void setElapsedDaysSinceLastPayment(long elapsedDaysSinceLastPayment) {
        this.elapsedDaysSinceLastPayment = elapsedDaysSinceLastPayment;
    }

    public double getAccruedInterestTillDate() {
        return accruedInterestTillDate;
    }

    public void setAccruedInterestTillDate(double accruedInterestTillDate) {
        this.accruedInterestTillDate = accruedInterestTillDate;
    }

    public double getOverdueArrears() {
        return overdueArrears;
    }

    public void setOverdueArrears(double overdueArrears) {
        this.overdueArrears = overdueArrears;
    }

    public double getPendingPenalties() {
        return pendingPenalties;
    }

    public void setPendingPenalties(double pendingPenalties) {
        this.pendingPenalties = pendingPenalties;
    }

    public double getForeclosureFeePercent() {
        return foreclosureFeePercent;
    }

    public void setForeclosureFeePercent(double foreclosureFeePercent) {
        this.foreclosureFeePercent = foreclosureFeePercent;
    }

    public double getForeclosureFeeAmount() {
        return foreclosureFeeAmount;
    }

    public void setForeclosureFeeAmount(double foreclosureFeeAmount) {
        this.foreclosureFeeAmount = foreclosureFeeAmount;
    }

    public double getUnearnedInterestRebate() {
        return unearnedInterestRebate;
    }

    public void setUnearnedInterestRebate(double unearnedInterestRebate) {
        this.unearnedInterestRebate = unearnedInterestRebate;
    }

    public double getNetPayoffAmount() {
        return netPayoffAmount;
    }

    public void setNetPayoffAmount(double netPayoffAmount) {
        this.netPayoffAmount = netPayoffAmount;
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

    public String getSavingsAccountNumber() {
        return savingsAccountNumber;
    }

    public void setSavingsAccountNumber(String savingsAccountNumber) {
        this.savingsAccountNumber = savingsAccountNumber;
    }

    public double getSavingsAccountBalance() {
        return savingsAccountBalance;
    }

    public void setSavingsAccountBalance(double savingsAccountBalance) {
        this.savingsAccountBalance = savingsAccountBalance;
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

    public String getTotalMarketValuation() {
        return totalMarketValuation;
    }

    public void setTotalMarketValuation(String totalMarketValuation) {
        this.totalMarketValuation = totalMarketValuation;
    }

    public int getTotalItemsCount() {
        return totalItemsCount;
    }

    public void setTotalItemsCount(int totalItemsCount) {
        this.totalItemsCount = totalItemsCount;
    }

    public List<GoldItemDto> getItems() {
        return items;
    }

    public void setItems(List<GoldItemDto> items) {
        this.items = items;
    }

    public String getGuarantorName() {
        return guarantorName;
    }

    public void setGuarantorName(String guarantorName) {
        this.guarantorName = guarantorName;
    }

    public String getCoApplicantName() {
        return coApplicantName;
    }

    public void setCoApplicantName(String coApplicantName) {
        this.coApplicantName = coApplicantName;
    }
}
