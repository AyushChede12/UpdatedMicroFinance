package com.microfinance.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class GroupLoanApprovalDetailsDto {

    private String applicationNo;
    private String groupCode;
    private String communityName;
    private String communityAddress;
    private String leaderAddress;
    private String communityLeader;
    private String leaderContactNumber;
    private String branch;
    private String allocatedStaff;
    private String scheduledCollectionDay;
    private LocalDate openingDate;
    private String purposeOfLoan;

    // Terms
    private BigDecimal loanAmount;
    private Integer term;
    private BigDecimal rateOfInterest;
    private String interestType;
    private String emiFrequency;
    private String emiMode;
    private BigDecimal emiAmount;
    private BigDecimal interestOnLoan;
    private BigDecimal totalAmountToPay;
    private LocalDate firstEmiDate;

    // Deductions
    private BigDecimal processingFeePercent;
    private BigDecimal legalChargesPercent;
    private BigDecimal insuranceFeePercent;
    private BigDecimal valuationFeePercent;
    private BigDecimal gstPercent;
    private BigDecimal totalDeduction;
    private BigDecimal netDisbursement;
    private String penaltyMode;
    private BigDecimal monthlyPenalty;

    // Approval info
    private String status;
    private LocalDate approvalDate;
    private String approvalRemarks;
    private String approvedBy;

    // Member Allocations
    private List<GroupLoanMemberDto> members = new ArrayList<>();

    public GroupLoanApprovalDetailsDto() {}

    public String getApplicationNo() { return applicationNo; }
    public void setApplicationNo(String applicationNo) { this.applicationNo = applicationNo; }

    public String getGroupCode() { return groupCode; }
    public void setGroupCode(String groupCode) { this.groupCode = groupCode; }

    public String getCommunityName() { return communityName; }
    public void setCommunityName(String communityName) { this.communityName = communityName; }

    public String getCommunityAddress() { return communityAddress; }
    public void setCommunityAddress(String communityAddress) { this.communityAddress = communityAddress; }

    public String getLeaderAddress() { return leaderAddress; }
    public void setLeaderAddress(String leaderAddress) { this.leaderAddress = leaderAddress; }

    public String getCommunityLeader() { return communityLeader; }
    public void setCommunityLeader(String communityLeader) { this.communityLeader = communityLeader; }

    public String getLeaderContactNumber() { return leaderContactNumber; }
    public void setLeaderContactNumber(String leaderContactNumber) { this.leaderContactNumber = leaderContactNumber; }

    public String getBranch() { return branch; }
    public void setBranch(String branch) { this.branch = branch; }

    public String getAllocatedStaff() { return allocatedStaff; }
    public void setAllocatedStaff(String allocatedStaff) { this.allocatedStaff = allocatedStaff; }

    public String getScheduledCollectionDay() { return scheduledCollectionDay; }
    public void setScheduledCollectionDay(String scheduledCollectionDay) { this.scheduledCollectionDay = scheduledCollectionDay; }

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

    public List<GroupLoanMemberDto> getMembers() { return members; }
    public void setMembers(List<GroupLoanMemberDto> members) { this.members = members; }
}
