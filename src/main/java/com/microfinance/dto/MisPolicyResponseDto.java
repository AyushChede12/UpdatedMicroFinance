package com.microfinance.dto;

import java.math.BigDecimal;

/**
 * Response DTO for MIS policy data sent to the frontend.
 * Does not expose the entity directly.
 */
public class MisPolicyResponseDto {

    private Long id;
    private String policyNumber;
    private String customerId;
    private String customerName;
    private Long planId;
    private String planName;
    private BigDecimal principalAmount;
    private BigDecimal interestRate;
    private Integer tenureMonths;
    private String startDate;
    private String maturityDate;
    private BigDecimal monthlyPayoutAmount;
    private Integer payoutDay;
    private Integer lockInMonths;
    private String status;
    private String linkedAccountId;
    private String nomineeName;
    private String nomineeRelation;
    private Long renewedFromPolicyId;
    private String nextPayoutDate;
    private long daysUntilMaturity;

    // Getters & Setters

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

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

    public String getMaturityDate() { return maturityDate; }
    public void setMaturityDate(String maturityDate) { this.maturityDate = maturityDate; }

    public BigDecimal getMonthlyPayoutAmount() { return monthlyPayoutAmount; }
    public void setMonthlyPayoutAmount(BigDecimal monthlyPayoutAmount) { this.monthlyPayoutAmount = monthlyPayoutAmount; }

    public Integer getPayoutDay() { return payoutDay; }
    public void setPayoutDay(Integer payoutDay) { this.payoutDay = payoutDay; }

    public Integer getLockInMonths() { return lockInMonths; }
    public void setLockInMonths(Integer lockInMonths) { this.lockInMonths = lockInMonths; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getLinkedAccountId() { return linkedAccountId; }
    public void setLinkedAccountId(String linkedAccountId) { this.linkedAccountId = linkedAccountId; }

    public String getNomineeName() { return nomineeName; }
    public void setNomineeName(String nomineeName) { this.nomineeName = nomineeName; }

    public String getNomineeRelation() { return nomineeRelation; }
    public void setNomineeRelation(String nomineeRelation) { this.nomineeRelation = nomineeRelation; }

    public Long getRenewedFromPolicyId() { return renewedFromPolicyId; }
    public void setRenewedFromPolicyId(Long renewedFromPolicyId) { this.renewedFromPolicyId = renewedFromPolicyId; }

    public String getNextPayoutDate() { return nextPayoutDate; }
    public void setNextPayoutDate(String nextPayoutDate) { this.nextPayoutDate = nextPayoutDate; }

    public long getDaysUntilMaturity() { return daysUntilMaturity; }
    public void setDaysUntilMaturity(long daysUntilMaturity) { this.daysUntilMaturity = daysUntilMaturity; }
}
