package com.microfinance.repository;

import com.microfinance.model.MisClosureAudit;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface MisClosureAuditRepo extends JpaRepository<MisClosureAudit, Long> {

    List<MisClosureAudit> findByPolicyId(Long policyId);
}
