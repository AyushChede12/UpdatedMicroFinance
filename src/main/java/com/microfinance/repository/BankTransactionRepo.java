package com.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.microfinance.model.BankTransaction;

@Repository
public interface BankTransactionRepo extends JpaRepository<BankTransaction, Long> {

	List<BankTransaction> findByAccountNumberAndDateBetween(String accountNumber, String startDate, String endDate);

}
