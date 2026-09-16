package com.microfinance.repository;

import com.microfinance.model.MisPayoutLedger;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.List;

@Repository
public interface MisPayoutLedgerRepo extends JpaRepository<MisPayoutLedger, Long> {

    List<MisPayoutLedger> findByPolicyIdOrderByPayoutDateDesc(Long policyId);

    /** Prevent duplicate payouts: check if a payout already exists for this policy on this exact date */
    boolean existsByPolicyIdAndPayoutDate(Long policyId, LocalDate payoutDate);

    /** Sum of all interest paid for a policy (for TDS annual threshold check) */
    @Query("SELECT COALESCE(SUM(l.interestAmount), 0) FROM MisPayoutLedger l WHERE l.policyId = :policyId")
    BigDecimal sumInterestByPolicyId(Long policyId);

    /** Sum of all TDS deducted for a policy */
    @Query("SELECT COALESCE(SUM(l.tdsDeducted), 0) FROM MisPayoutLedger l WHERE l.policyId = :policyId")
    BigDecimal sumTdsByPolicyId(Long policyId);

    /** Sum of all net paid for a policy */
    @Query("SELECT COALESCE(SUM(l.netPaid), 0) FROM MisPayoutLedger l WHERE l.policyId = :policyId")
    BigDecimal sumNetPaidByPolicyId(Long policyId);
}
