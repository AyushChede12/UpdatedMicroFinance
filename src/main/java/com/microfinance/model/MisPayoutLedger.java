package com.microfinance.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * MisPayoutLedger — records each monthly payout event for an MIS policy.
 * Unique constraint on (policy_id, payout_date) prevents duplicate payouts.
 */
@Entity
@Table(name = "mis_payout_ledger",
       uniqueConstraints = @UniqueConstraint(columnNames = {"policy_id", "payout_date"}))
public class MisPayoutLedger {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "policy_id", nullable = false)
    private Long policyId;

    @Column(name = "payout_date", nullable = false)
    private LocalDate payoutDate;

    @Column(name = "interest_amount", precision = 15, scale = 2)
    private BigDecimal interestAmount;

    @Column(name = "tds_deducted", precision = 15, scale = 2)
    private BigDecimal tdsDeducted;

    @Column(name = "net_paid", precision = 15, scale = 2)
    private BigDecimal netPaid;

    @Column(name = "status", length = 50)
    private String status; // PAID

    @Column(name = "created_at", updatable = false, insertable = false)
    private java.time.LocalDateTime createdAt;

    // ── Getters & Setters ──────────────────────────────────────────────────

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getPolicyId() { return policyId; }
    public void setPolicyId(Long policyId) { this.policyId = policyId; }

    public LocalDate getPayoutDate() { return payoutDate; }
    public void setPayoutDate(LocalDate payoutDate) { this.payoutDate = payoutDate; }

    public BigDecimal getInterestAmount() { return interestAmount; }
    public void setInterestAmount(BigDecimal interestAmount) { this.interestAmount = interestAmount; }

    public BigDecimal getTdsDeducted() { return tdsDeducted; }
    public void setTdsDeducted(BigDecimal tdsDeducted) { this.tdsDeducted = tdsDeducted; }

    public BigDecimal getNetPaid() { return netPaid; }
    public void setNetPaid(BigDecimal netPaid) { this.netPaid = netPaid; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public java.time.LocalDateTime getCreatedAt() { return createdAt; }
}
