package com.microfinance.dto;

import javax.validation.Valid;
import javax.validation.constraints.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

public class GroupLoanApplicationDto {

    @NotBlank(message = "Group Code is required")
    private String groupCode;

    @NotNull(message = "Opening Date is required")
    private LocalDate openingDate;

    @NotBlank(message = "Purpose of Loan is required")
    private String purposeOfLoan;

    @NotNull(message = "Loan Amount is required")
    @DecimalMin(value = "0.01", message = "Loan Amount must be greater than 0")
    private BigDecimal loanAmount;

    @NotNull(message = "Term is required")
    @Min(value = 1, message = "Term must be at least 1")
    private Integer term;

    @NotNull(message = "Rate of Interest is required")
    @DecimalMin(value = "0.00", message = "Rate of Interest must be at least 0")
    @DecimalMax(value = "100.00", message = "Rate of Interest cannot exceed 100%")
    private BigDecimal rateOfInterest;

    @NotBlank(message = "Interest Type is required")
    @Pattern(regexp = "^(FLAT|REDUCING)$", message = "Interest Type must be FLAT or REDUCING")
    private String interestType;

    @NotBlank(message = "EMI Frequency is required")
    @Pattern(regexp = "^(WEEKLY|MONTHLY)$", message = "EMI Frequency must be WEEKLY or MONTHLY")
    private String emiFrequency;

    @NotBlank(message = "EMI Mode is required")
    private String emiMode;

    private BigDecimal emiAmount;

    private BigDecimal interestOnLoan;

    private BigDecimal totalAmountToPay;

    private LocalDate firstEmiDate;

    @DecimalMin(value = "0.00", message = "Processing Fee % must be between 0 and 100")
    @DecimalMax(value = "100.00", message = "Processing Fee % must be between 0 and 100")
    private BigDecimal processingFeePercent;

    @DecimalMin(value = "0.00", message = "Legal Charges % must be between 0 and 100")
    @DecimalMax(value = "100.00", message = "Legal Charges % must be between 0 and 100")
    private BigDecimal legalChargesPercent;

    @DecimalMin(value = "0.00", message = "Insurance Fee % must be between 0 and 100")
    @DecimalMax(value = "100.00", message = "Insurance Fee % must be between 0 and 100")
    private BigDecimal insuranceFeePercent;

    @DecimalMin(value = "0.00", message = "Valuation Fee % must be between 0 and 100")
    @DecimalMax(value = "100.00", message = "Valuation Fee % must be between 0 and 100")
    private BigDecimal valuationFeePercent;

    @DecimalMin(value = "0.00", message = "GST % must be between 0 and 100")
    @DecimalMax(value = "100.00", message = "GST % must be between 0 and 100")
    private BigDecimal gstPercent;

    private BigDecimal totalDeduction;

    private BigDecimal netDisbursement;

    private String penaltyMode;

    @DecimalMin(value = "0.00", message = "Monthly Penalty must be at least 0")
    private BigDecimal monthlyPenalty;

    @NotEmpty(message = "Group must have member loan allocations")
    @Valid
    private List<GroupLoanMemberDto> members;

    public GroupLoanApplicationDto() {}

    public String getGroupCode() { return groupCode; }
    public void setGroupCode(String groupCode) { this.groupCode = groupCode; }

    public LocalDate getOpeningDate() { return openingDate; }
    public void setOpeningDate(LocalDate openingDate) { this.openingDate = openingDate; }

    public String getPurposeOfLoan() { return purposeOfLoan; }
    public void setPurposeOfLoan(String purposeOfLoan) { this.purposeOfLoan = purposeOfLoan; }

    public BigDecimal getLoanAmount() { return loanAmount; }
    public void setLoanAmount(BigDecimal loanAmount) { this.loanAmount = loanAmount; }

    public Integer getTerm() { return term; }
    public void setTerm(Integer term) { this.term = term; }

    public BigDecimal getRateOfInterest() { return rateOfInterest; }
    public void setRateOfInterest(BigDecimal rateOfInterest) { this.rateOfInterest = rateOfInterest; }

    public String getInterestType() { return interestType; }
    public void setInterestType(String interestType) { this.interestType = interestType; }

    public String getEmiFrequency() { return emiFrequency; }
    public void setEmiFrequency(String emiFrequency) { this.emiFrequency = emiFrequency; }

    public String getEmiMode() { return emiMode; }
    public void setEmiMode(String emiMode) { this.emiMode = emiMode; }

    public BigDecimal getEmiAmount() { return emiAmount; }
    public void setEmiAmount(BigDecimal emiAmount) { this.emiAmount = emiAmount; }

    public BigDecimal getInterestOnLoan() { return interestOnLoan; }
    public void setInterestOnLoan(BigDecimal interestOnLoan) { this.interestOnLoan = interestOnLoan; }

    public BigDecimal getTotalAmountToPay() { return totalAmountToPay; }
    public void setTotalAmountToPay(BigDecimal totalAmountToPay) { this.totalAmountToPay = totalAmountToPay; }

    public LocalDate getFirstEmiDate() { return firstEmiDate; }
    public void setFirstEmiDate(LocalDate firstEmiDate) { this.firstEmiDate = firstEmiDate; }

    public BigDecimal getProcessingFeePercent() { return processingFeePercent; }
    public void setProcessingFeePercent(BigDecimal processingFeePercent) { this.processingFeePercent = processingFeePercent; }

    public BigDecimal getLegalChargesPercent() { return legalChargesPercent; }
    public void setLegalChargesPercent(BigDecimal legalChargesPercent) { this.legalChargesPercent = legalChargesPercent; }

    public BigDecimal getInsuranceFeePercent() { return insuranceFeePercent; }
    public void setInsuranceFeePercent(BigDecimal insuranceFeePercent) { this.insuranceFeePercent = insuranceFeePercent; }

    public BigDecimal getValuationFeePercent() { return valuationFeePercent; }
    public void setValuationFeePercent(BigDecimal valuationFeePercent) { this.valuationFeePercent = valuationFeePercent; }

    public BigDecimal getGstPercent() { return gstPercent; }
    public void setGstPercent(BigDecimal gstPercent) { this.gstPercent = gstPercent; }

    public BigDecimal getTotalDeduction() { return totalDeduction; }
    public void setTotalDeduction(BigDecimal totalDeduction) { this.totalDeduction = totalDeduction; }

    public BigDecimal getNetDisbursement() { return netDisbursement; }
    public void setNetDisbursement(BigDecimal netDisbursement) { this.netDisbursement = netDisbursement; }

    public String getPenaltyMode() { return penaltyMode; }
    public void setPenaltyMode(String penaltyMode) { this.penaltyMode = penaltyMode; }

    public BigDecimal getMonthlyPenalty() { return monthlyPenalty; }
    public void setMonthlyPenalty(BigDecimal monthlyPenalty) { this.monthlyPenalty = monthlyPenalty; }

    public List<GroupLoanMemberDto> getMembers() { return members; }
    public void setMembers(List<GroupLoanMemberDto> members) { this.members = members; }
}
