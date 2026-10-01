package com.microfinance.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Entity
@Table(name = "group_loan_application")
public class GroupLoanApplication {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "application_no", nullable = false, unique = true, length = 30)
    private String applicationNo;

    @Column(name = "group_code", nullable = false, length = 50)
    private String groupCode;

    @Column(name = "opening_date", nullable = false)
    private LocalDate openingDate;

    @Column(name = "purpose_of_loan", nullable = false)
    private String purposeOfLoan;

    @Column(name = "loan_amount", nullable = false, precision = 15, scale = 2)
    private BigDecimal loanAmount;

    @Column(name = "term", nullable = false)
    private Integer term;

    @Column(name = "rate_of_interest", nullable = false, precision = 6, scale = 2)
    private BigDecimal rateOfInterest;

    @Column(name = "interest_type", nullable = false, length = 20)
    private String interestType;

    @Column(name = "emi_frequency", nullable = false, length = 20)
    private String emiFrequency;

    @Column(name = "emi_mode", nullable = false, length = 20)
    private String emiMode;

    @Column(name = "emi_amount", nullable = false, precision = 15, scale = 2)
    private BigDecimal emiAmount;

    @Column(name = "interest_on_loan", precision = 15, scale = 2)
    private BigDecimal interestOnLoan;

    @Column(name = "total_amount_to_pay", precision = 15, scale = 2)
    private BigDecimal totalAmountToPay;

    @Column(name = "first_emi_date", nullable = false)
    private LocalDate firstEmiDate;

    @Column(name = "processing_fee_percent", precision = 6, scale = 2)
    private BigDecimal processingFeePercent;

    @Column(name = "legal_charges_percent", precision = 6, scale = 2)
    private BigDecimal legalChargesPercent;

    @Column(name = "insurance_fee_percent", precision = 6, scale = 2)
    private BigDecimal insuranceFeePercent;

    @Column(name = "valuation_fee_percent", precision = 6, scale = 2)
    private BigDecimal valuationFeePercent;

    @Column(name = "gst_percent", precision = 6, scale = 2)
    private BigDecimal gstPercent;

    @Column(name = "total_deduction", nullable = false, precision = 15, scale = 2)
    private BigDecimal totalDeduction;

    @Column(name = "net_disbursement", nullable = false, precision = 15, scale = 2)
    private BigDecimal netDisbursement;

    @Column(name = "penalty_mode", length = 20)
    private String penaltyMode;

    @Column(name = "monthly_penalty", precision = 10, scale = 2)
    private BigDecimal monthlyPenalty;

    @Column(name = "status", nullable = false, length = 20)
    private String status = "PENDING";

    @Column(name = "approval_date")
    private LocalDate approvalDate;

    @Column(name = "approval_remarks", length = 500)
    private String approvalRemarks;

    @Column(name = "approved_by", length = 100)
    private String approvedBy;

    @Column(name = "created_at", nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @OneToMany(mappedBy = "groupLoanApplication", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<GroupLoanMember> members = new ArrayList<>();

    public void addMember(GroupLoanMember member) {
        members.add(member);
        member.setGroupLoanApplication(this);
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getApplicationNo() { return applicationNo; }
    public void setApplicationNo(String applicationNo) { this.applicationNo = applicationNo; }
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
    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }
    public LocalDate getApprovalDate() { return approvalDate; }
    public void setApprovalDate(LocalDate approvalDate) { this.approvalDate = approvalDate; }
    public String getApprovalRemarks() { return approvalRemarks; }
    public void setApprovalRemarks(String approvalRemarks) { this.approvalRemarks = approvalRemarks; }
    public String getApprovedBy() { return approvedBy; }
    public void setApprovedBy(String approvedBy) { this.approvedBy = approvedBy; }
    public LocalDateTime getCreatedAt() { return createdAt; }
    public void setCreatedAt(LocalDateTime createdAt) { this.createdAt = createdAt; }
    public List<GroupLoanMember> getMembers() { return members; }
    public void setMembers(List<GroupLoanMember> members) { this.members = members; }
}
