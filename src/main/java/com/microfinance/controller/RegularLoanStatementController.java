package com.microfinance.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.microfinance.dto.ErrorResponseDto;
import com.microfinance.dto.RegularLoanStatementResponse;
import com.microfinance.service.LoanManagementService;

@RestController
@RequestMapping("/api/loans/statement")
public class RegularLoanStatementController {

    private static final Logger logger = LoggerFactory.getLogger(RegularLoanStatementController.class);

    @Autowired
    private LoanManagementService loanManagementService;

    @GetMapping("/regular")
    public ResponseEntity<?> getRegularLoanStatement(@RequestParam("loanCode") String loanCode) {
        logger.info("Received request for regular loan statement with loanCode: {}", loanCode);

        if (loanCode == null || loanCode.trim().isEmpty()) {
            logger.warn("Loan code is missing or empty in regular statement request");
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ErrorResponseDto("INVALID_ARGUMENT", "Loan code is required"));
        }

        try {
            RegularLoanStatementResponse response = loanManagementService.getRegularLoanStatement(loanCode.trim());
            return ResponseEntity.ok(response);
        } catch (RuntimeException ex) {
            String msg = ex.getMessage();
            if (msg != null && msg.contains("No loan found for code")) {
                logger.warn("Loan not found for regular statement: {}", loanCode);
                return ResponseEntity.status(HttpStatus.NOT_FOUND)
                        .body(new ErrorResponseDto("LOAN_NOT_FOUND", msg));
            }

            logger.error("Unexpected error occurred while generating regular loan statement for loanCode: {}", loanCode, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ErrorResponseDto("INTERNAL_SERVER_ERROR", msg != null ? msg : "An unexpected error occurred"));
        } catch (Exception ex) {
            logger.error("Unhandled exception generating regular loan statement for loanCode: {}", loanCode, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ErrorResponseDto("INTERNAL_SERVER_ERROR", ex.getMessage() != null ? ex.getMessage() : "Internal server error"));
        }
    }
}
