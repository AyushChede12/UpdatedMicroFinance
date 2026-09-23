package com.microfinance.repository;

import java.util.List;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;
import com.microfinance.model.ApplyForGoldItem;

@Repository
public interface ApplyForGoldItemRepo extends JpaRepository<ApplyForGoldItem, Long> {

	List<ApplyForGoldItem> findByApplyForGoldId(Long goldLoanId);
}
