package com.microfinance.repository;

import com.microfinance.model.MisPolicy;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

@Repository
public interface MisPolicyRepo extends JpaRepository<MisPolicy, Long> {

    Optional<MisPolicy> findByPolicyNumber(String policyNumber);

    Optional<MisPolicy> findByPolicyNumberIgnoreCase(String policyNumber);

    Optional<MisPolicy> findByAddInvestmentId(Long addInvestmentId);

    List<MisPolicy> findByCustomerId(String customerId);

    List<MisPolicy> findByStatus(String status);

    /** Find all ACTIVE policies whose payout day matches today's day of month */
    @Query("SELECT p FROM MisPolicy p WHERE p.status = 'ACTIVE' AND p.payoutDay = :dayOfMonth")
    List<MisPolicy> findActiveByPayoutDay(int dayOfMonth);

    /** Find all ACTIVE policies that have reached or passed maturity */
    @Query("SELECT p FROM MisPolicy p WHERE p.status = 'ACTIVE' AND p.maturityDate <= :today")
    List<MisPolicy> findMaturedActivePolicies(LocalDate today);

    @Query("SELECT COALESCE(MAX(p.id), 0) FROM MisPolicy p")
    long getMaxId();
}
