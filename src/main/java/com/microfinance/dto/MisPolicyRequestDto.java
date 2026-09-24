package com.microfinance.dto;

import java.math.BigDecimal;

/**
 * Request DTO for creating a new MIS policy directly via REST.
 * (Also used internally from PolicyManagementService when schemeType=MIS)
 */
public class MisPolicyRequestDto {

    private String policyNumber;
    private String customerId;
    private String customerName;
    private Long planId;
    private String planName;
    private BigDecimal principalAmount;
    private BigDecimal interestRate;
    private Integer tenureMonths;
    private String startDate;   // yyyy-MM-dd
    private Integer payoutDay;
    private Integer lockInMonths;
    private String linkedAccountId;
    private String nomineeName;
    private String nomineeRelation;
    private Long addInvestmentId;

    // Getters & Setters

    public String getPolicyNumber() { return policyNumber; }
    public void setPolicyNumber(String policyNumber) { this.policyNumber = policyNumber; }

    public String getCustomerId() { return customerId; }
    public void setCustomerId(String customerId) { this.customerId = customerId; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public Long getPlanId() { return planId; }
    public void setPlanId(Long planId) { this.planId = planId; }

    public String getPlanName() { return planName; }
    public void setPlanName(String planName) { this.planName = planName; }

    public BigDecimal getPrincipalAmount() { return principalAmount; }
    public void setPrincipalAmount(BigDecimal principalAmount) { this.principalAmount = principalAmount; }

    public BigDecimal getInterestRate() { return interestRate; }
    public void setInterestRate(BigDecimal interestRate) { this.interestRate = interestRate; }

    public Integer getTenureMonths() { return tenureMonths; }
    public void setTenureMonths(Integer tenureMonths) { this.tenureMonths = tenureMonths; }

    public String getStartDate() { return startDate; }
    public void setStartDate(String startDate) { this.startDate = startDate; }

    public Integer getPayoutDay() { return payoutDay; }
    public void setPayoutDay(Integer payoutDay) { this.payoutDay = payoutDay; }

    public Integer getLockInMonths() { return lockInMonths; }
    public void setLockInMonths(Integer lockInMonths) { this.lockInMonths = lockInMonths; }

    public String getLinkedAccountId() { return linkedAccountId; }
    public void setLinkedAccountId(String linkedAccountId) { this.linkedAccountId = linkedAccountId; }

    public String getNomineeName() { return nomineeName; }
    public void setNomineeName(String nomineeName) { this.nomineeName = nomineeName; }

    public String getNomineeRelation() { return nomineeRelation; }
    public void setNomineeRelation(String nomineeRelation) { this.nomineeRelation = nomineeRelation; }

    public Long getAddInvestmentId() { return addInvestmentId; }
    public void setAddInvestmentId(Long addInvestmentId) { this.addInvestmentId = addInvestmentId; }
}
