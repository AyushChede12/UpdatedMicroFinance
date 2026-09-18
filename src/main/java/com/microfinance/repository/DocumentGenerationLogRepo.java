package com.microfinance.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.microfinance.model.DocumentGenerationLog;

@Repository
public interface DocumentGenerationLogRepo extends JpaRepository<DocumentGenerationLog, Long> {

    List<DocumentGenerationLog> findByLoanIdOrderByIdDesc(String loanId);

    List<DocumentGenerationLog> findByLoanIdOrderByGeneratedAtDesc(String loanId);
}
