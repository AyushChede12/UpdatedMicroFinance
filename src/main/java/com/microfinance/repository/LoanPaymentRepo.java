package com.microfinance.repository;



import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.microfinance.model.LoanPayment;

@Repository
public interface LoanPaymentRepo extends JpaRepository<LoanPayment,Long> {
	List<LoanPayment> findByLoanId(String loanId);

	LoanPayment findByLoanIdAndNoOfInst(String loanId, String remarks);

	List<LoanPayment> findByPaymentMode(String string);
}
