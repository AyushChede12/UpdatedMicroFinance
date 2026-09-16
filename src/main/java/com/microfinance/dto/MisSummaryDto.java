package com.microfinance.dto;

import java.math.BigDecimal;

/**
 * Summary DTO for the MIS policy summary panel on the frontend.
 */
public class MisSummaryDto {

    private String policyNumber;
    private String customerName;
    private BigDecimal totalInvested;
    private BigDecimal totalInterestEarned;
    private BigDecimal totalTdsDeducted;
    private BigDecimal totalAmountPaid;
    private String nextPayoutDate;
    private long daysUntilMaturity;
    private String currentStatus;
    private BigDecimal monthlyPayoutAmount;
    private boolean lockInActive;
    private String lockInEndsOn;

    // Getters & Setters

    public String getPolicyNumber() { return policyNumber; }
    public void setPolicyNumber(String policyNumber) { this.policyNumber = policyNumber; }

    public String getCustomerName() { return customerName; }
    public void setCustomerName(String customerName) { this.customerName = customerName; }

    public BigDecimal getTotalInvested() { return totalInvested; }
    public void setTotalInvested(BigDecimal totalInvested) { this.totalInvested = totalInvested; }

    public BigDecimal getTotalInterestEarned() { return totalInterestEarned; }
    public void setTotalInterestEarned(BigDecimal totalInterestEarned) { this.totalInterestEarned = totalInterestEarned; }

    public BigDecimal getTotalTdsDeducted() { return totalTdsDeducted; }
    public void setTotalTdsDeducted(BigDecimal totalTdsDeducted) { this.totalTdsDeducted = totalTdsDeducted; }

    public BigDecimal getTotalAmountPaid() { return totalAmountPaid; }
    public void setTotalAmountPaid(BigDecimal totalAmountPaid) { this.totalAmountPaid = totalAmountPaid; }

    public String getNextPayoutDate() { return nextPayoutDate; }
    public void setNextPayoutDate(String nextPayoutDate) { this.nextPayoutDate = nextPayoutDate; }

    public long getDaysUntilMaturity() { return daysUntilMaturity; }
    public void setDaysUntilMaturity(long daysUntilMaturity) { this.daysUntilMaturity = daysUntilMaturity; }

    public String getCurrentStatus() { return currentStatus; }
    public void setCurrentStatus(String currentStatus) { this.currentStatus = currentStatus; }

    public BigDecimal getMonthlyPayoutAmount() { return monthlyPayoutAmount; }
    public void setMonthlyPayoutAmount(BigDecimal monthlyPayoutAmount) { this.monthlyPayoutAmount = monthlyPayoutAmount; }

    public boolean isLockInActive() { return lockInActive; }
    public void setLockInActive(boolean lockInActive) { this.lockInActive = lockInActive; }

    public String getLockInEndsOn() { return lockInEndsOn; }
    public void setLockInEndsOn(String lockInEndsOn) { this.lockInEndsOn = lockInEndsOn; }
}
