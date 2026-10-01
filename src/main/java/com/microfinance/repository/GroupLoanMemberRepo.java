package com.microfinance.repository;

import com.microfinance.model.GroupLoanMember;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GroupLoanMemberRepo extends JpaRepository<GroupLoanMember, Long> {
    List<GroupLoanMember> findByGroupLoanApplicationId(Long groupLoanApplicationId);
}
