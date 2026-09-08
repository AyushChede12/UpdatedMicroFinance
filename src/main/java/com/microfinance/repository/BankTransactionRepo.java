package com.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.microfinance.model.BankTransaction;

@Repository
public interface BankTransactionRepo extends JpaRepository<BankTransaction, Long> {

	// Period ke transactions
	@Query(value = "SELECT * FROM bank_transaction " + "WHERE account_number = :accountNumber "
			+ "AND STR_TO_DATE(date, '%Y-%m-%d') " + "BETWEEN STR_TO_DATE(:startDate, '%Y-%m-%d') "
			+ "AND STR_TO_DATE(:endDate, '%Y-%m-%d') "
			+ "ORDER BY STR_TO_DATE(date, '%Y-%m-%d') ASC, id ASC", nativeQuery = true)
	List<BankTransaction> findBankStatement(@Param("accountNumber") String accountNumber,
			@Param("startDate") String startDate, @Param("endDate") String endDate);

	// Start date se pehle ka latest transaction
	@Query(value = "SELECT * FROM bank_transaction " + "WHERE account_number = :accountNumber "
			+ "AND STR_TO_DATE(date, '%Y-%m-%d') < STR_TO_DATE(:startDate, '%Y-%m-%d') "
			+ "ORDER BY STR_TO_DATE(date, '%Y-%m-%d') DESC, id DESC " + "LIMIT 1", nativeQuery = true)
	BankTransaction findLastTransactionBeforeStartDate(@Param("accountNumber") String accountNumber,
			@Param("startDate") String startDate);
}