package com.microfinance;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import com.microfinance.controller.RegularLoanStatementController;
import com.microfinance.dto.ErrorResponseDto;
import com.microfinance.dto.RegularLoanStatementResponse;

@SpringBootTest
public class RegularLoanStatementTest {

    @Autowired
    private RegularLoanStatementController regularLoanStatementController;

    @Test
    public void testValidLoanCodeReturns200WithCorrectTotals() {
        String validLoanCode = "LP00001";

        ResponseEntity<?> responseEntity = regularLoanStatementController.getRegularLoanStatement(validLoanCode);

        assertNotNull(responseEntity, "Response entity should not be null");
        assertEquals(HttpStatus.OK, responseEntity.getStatusCode(), "Status should be 200 OK for valid loan code");
        assertTrue(responseEntity.getBody() instanceof RegularLoanStatementResponse, "Body should be RegularLoanStatementResponse");

        RegularLoanStatementResponse statement = (RegularLoanStatementResponse) responseEntity.getBody();

        // Validate Loan Summary
        assertNotNull(statement.getLoanSummary(), "Loan summary should not be null");
        assertEquals(validLoanCode, statement.getLoanSummary().getLoanCode(), "Loan code should match");
        assertTrue(statement.getLoanSummary().getPrincipalAmount() > 0, "Principal should be greater than 0");
        assertTrue(statement.getLoanSummary().getTenureMonths() > 0, "Tenure should be positive");
        assertTrue(statement.getLoanSummary().getEmiAmount() > 0, "EMI amount should be positive");

        // Validate Statement Rows
        assertNotNull(statement.getStatementRows(), "Statement rows should not be null");
        assertEquals(statement.getLoanSummary().getTenureMonths(), statement.getStatementRows().size(),
                "Number of statement rows should equal tenure months");

        // Validate Totals
        assertNotNull(statement.getTotals(), "Totals should not be null");
        assertEquals(statement.getLoanSummary().getOutstandingPrincipal(), statement.getTotals().getCurrentOutstanding(),
                "Summary outstanding principal should equal totals current outstanding");
    }

    @Test
    public void testInvalidLoanCodeReturns404() {
        String invalidLoanCode = "NON_EXISTENT_LOAN_99999";

        ResponseEntity<?> responseEntity = regularLoanStatementController.getRegularLoanStatement(invalidLoanCode);

        assertNotNull(responseEntity, "Response entity should not be null");
        assertEquals(HttpStatus.NOT_FOUND, responseEntity.getStatusCode(), "Status should be 404 NOT_FOUND for invalid loan code");
        assertTrue(responseEntity.getBody() instanceof ErrorResponseDto, "Body should be ErrorResponseDto");

        ErrorResponseDto error = (ErrorResponseDto) responseEntity.getBody();
        assertEquals("LOAN_NOT_FOUND", error.getErrorCode(), "Error code should be LOAN_NOT_FOUND");
        assertTrue(error.getMessage().contains("No loan found for code " + invalidLoanCode),
                "Error message should clearly state loan not found");
    }
}
