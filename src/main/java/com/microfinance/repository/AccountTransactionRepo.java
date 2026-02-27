package com.microfinance.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.microfinance.model.AccountTransaction;

public interface AccountTransactionRepo extends JpaRepository<AccountTransaction, Long> {

}
