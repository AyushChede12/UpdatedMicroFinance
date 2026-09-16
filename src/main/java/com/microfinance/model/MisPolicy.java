package com.microfinance.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * MisPolicy — represents an active MIS (Monthly Income Scheme) investment
 * created when a customer's Add New Investment record with schemeType=MIS is processed.
 */
@Entity
@Table(name = "mis_policy")
public class MisPolicy {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "policy_number", unique = true, nullable = false, length = 50)
    private String policyNumber;

    @Column(name = "customer_id", length = 100)
    private String customerId;

    @Column(name = "customer_name")
    private String customerName;

    @Column(name = "plan_id")
    private Long planId;

    @Column(name = "plan_name")
    private String planName;

    @Column(name = "principal_amount", nullable = false, precision = 15, scale = 2)
    private BigDecimal principalAmount;

    @Column(name = "interest_rate", nullable = false, precision = 5, scale = 2)
    private BigDecimal interestRate;

    @Column(name = "tenure_months", nullable = false)
    private Integer tenureMonths;

    @Column(name = "start_date", nullable = false)
    private LocalDate startDate;

    @Column(name = "maturity_date", nullable = false)
    private LocalDate maturityDate;

    @Column(name = "monthly_payout_amount", precision = 15, scale = 2)
    private BigDecimal monthlyPayoutAmount;

    @Column(name = "payout_day")
    private Integer payoutDay;

    @Column(name = "lock_in_months")
    private Integer lockInMonths;

    @Column(name = "status", length = 50)
    private String status; // ACTIVE | MATURED | RENEWED | CLOSED | PREMATURELY_CLOSED

    @Column(name = "linked_account_id", length = 100)
    private String linkedAccountId; // customer code to identify savings account

    @Column(name = "nominee_name")
    private String nomineeName;

    @Column(name = "nominee_relation", length = 100)
    private String nomineeRelation;

    @Column(name = "renewed_from_policy_id")
    private Long renewedFromPolicyId;

    @Column(name = "add_investment_id")
    private Long addInvestmentId;

    @Column(name = "created_at", updatable = false, insertable = false)
    private java.time.LocalDateTime createdAt;

    @Column(name = "updated_at", insertable = false)
    private java.time.LocalDateTime updatedAt;

    // ── Getters & Setters ──────────────────────────────────────────────────

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

    public LocalDate getStartDate() { return startDate; }
    public void setStartDate(LocalDate startDate) { this.startDate = startDate; }

    public LocalDate getMaturityDate() { return maturityDate; }
    public void setMaturityDate(LocalDate maturityDate) { this.maturityDate = maturityDate; }

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

    public Long getAddInvestmentId() { return addInvestmentId; }
    public void setAddInvestmentId(Long addInvestmentId) { this.addInvestmentId = addInvestmentId; }

    public java.time.LocalDateTime getCreatedAt() { return createdAt; }
    public java.time.LocalDateTime getUpdatedAt() { return updatedAt; }
}
