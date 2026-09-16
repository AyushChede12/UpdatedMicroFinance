package com.microfinance.model;

import javax.persistence.*;
import java.math.BigDecimal;
import java.time.LocalDate;

/**
 * MisClosureAudit — records premature closure or maturity closure details for an MIS policy.
 */
@Entity
@Table(name = "mis_closure_audit")
public class MisClosureAudit {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "policy_id", nullable = false)
    private Long policyId;

    @Column(name = "closure_type", length = 50)
    private String closureType; // PREMATURE | MATURITY

    @Column(name = "closure_date")
    private LocalDate closureDate;

    @Column(name = "penalty_applied", precision = 15, scale = 2)
    private BigDecimal penaltyApplied;

    @Column(name = "refund_amount", precision = 15, scale = 2)
    private BigDecimal refundAmount;

    @Column(name = "reason", length = 500)
    private String reason;

    @Column(name = "created_at", updatable = false, insertable = false)
    private java.time.LocalDateTime createdAt;

    // ── Getters & Setters ──────────────────────────────────────────────────

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public Long getPolicyId() { return policyId; }
    public void setPolicyId(Long policyId) { this.policyId = policyId; }

    public String getClosureType() { return closureType; }
    public void setClosureType(String closureType) { this.closureType = closureType; }

    public LocalDate getClosureDate() { return closureDate; }
    public void setClosureDate(LocalDate closureDate) { this.closureDate = closureDate; }

    public BigDecimal getPenaltyApplied() { return penaltyApplied; }
    public void setPenaltyApplied(BigDecimal penaltyApplied) { this.penaltyApplied = penaltyApplied; }

    public BigDecimal getRefundAmount() { return refundAmount; }
    public void setRefundAmount(BigDecimal refundAmount) { this.refundAmount = refundAmount; }

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }

    public java.time.LocalDateTime getCreatedAt() { return createdAt; }
}
