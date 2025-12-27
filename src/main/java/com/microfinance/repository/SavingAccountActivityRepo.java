package com.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.microfinance.model.SavingAccountActivity;
@Repository
public interface SavingAccountActivityRepo extends JpaRepository<SavingAccountActivity, Long>{


	List<SavingAccountActivity> findAllByAccountNumber(String accountNumber);
	List<SavingAccountActivity> findByIsApprovedTrue();
	List<SavingAccountActivity> findByPayBy(String string);



}
