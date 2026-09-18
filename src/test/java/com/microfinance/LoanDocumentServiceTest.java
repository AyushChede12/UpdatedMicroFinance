package com.microfinance;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertFalse;
import static org.junit.jupiter.api.Assertions.assertNotNull;
import static org.junit.jupiter.api.Assertions.assertTrue;

import java.util.List;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.microfinance.dto.AvailableDocumentDto;
import com.microfinance.dto.LoanDocumentDetailDto;
import com.microfinance.model.DocumentGenerationLog;
import com.microfinance.model.LoanApplication;
import com.microfinance.repository.LoanApplicationRepo;
import com.microfinance.service.LoanDocumentService;

@SpringBootTest
public class LoanDocumentServiceTest {

    @Autowired
    private LoanDocumentService loanDocumentService;

    @Autowired
    private LoanApplicationRepo loanApplicationRepo;

    @Test
    public void testLoanDetailsFetch() {
        String testLoanId = "LP00001";
        LoanDocumentDetailDto details = loanDocumentService.getLoanDetails(testLoanId);

        assertNotNull(details, "Loan details should not be null");
        assertEquals(testLoanId, details.getLoanId(), "Loan ID should match");
        assertNotNull(details.getMemberName(), "Member name should not be null");
        assertNotNull(details.getLoanAmount(), "Loan amount should not be null");
    }

    @Test
    public void testAvailableDocumentsGatingRules() {
        String testLoanId = "LP00001";
        List<AvailableDocumentDto> docs = loanDocumentService.getAvailableDocuments(testLoanId);

        assertNotNull(docs, "Available documents list should not be null");
        assertEquals(6, docs.size(), "Should evaluate exactly 6 document types");

        // Find individual documents
        AvailableDocumentDto sanction = docs.stream().filter(d -> "SANCTION_LETTER".equals(d.getDocType())).findFirst().orElse(null);
        AvailableDocumentDto agreement = docs.stream().filter(d -> "LOAN_AGREEMENT".equals(d.getDocType())).findFirst().orElse(null);
        AvailableDocumentDto schedule = docs.stream().filter(d -> "REPAYMENT_SCHEDULE".equals(d.getDocType())).findFirst().orElse(null);
        AvailableDocumentDto noc = docs.stream().filter(d -> "NOC".equals(d.getDocType())).findFirst().orElse(null);

        assertNotNull(sanction);
        assertNotNull(agreement);
        assertNotNull(schedule);
        assertNotNull(noc);

        // LP00001 is ACTIVE (approved and disbursed)
        assertTrue(sanction.isAvailable(), "Sanction letter should be available for active loan");
        assertTrue(agreement.isAvailable(), "Agreement should be available for active loan");
        assertTrue(schedule.isAvailable(), "Repayment schedule should be available for active loan");

        // Since LP00001 is ACTIVE (not CLOSED), NOC should be unavailable
        assertFalse(noc.isAvailable(), "NOC should NOT be available for active/non-closed loan");
        assertTrue(noc.getReason().contains("CLOSED"), "NOC reason should mention CLOSED status");
    }

    @Test
    public void testRenderHtmlAndGeneratePdfWithAudit() throws Exception {
        String testLoanId = "LP00001";

        // 1. Render HTML preview
        String html = loanDocumentService.renderDocumentHtml(testLoanId, "SANCTION_LETTER");
        assertNotNull(html, "Rendered HTML should not be null");
        assertTrue(html.contains("LOAN SANCTION LETTER"), "HTML should contain document title");
        assertTrue(html.contains("SAMITHA URBAN"), "HTML should contain society name");

        // 2. Generate PDF and verify audit log
        byte[] pdfBytes = loanDocumentService.generateDocumentPdf(testLoanId, "SANCTION_LETTER", "TEST_USER");
        assertNotNull(pdfBytes, "Generated PDF bytes should not be null");
        assertTrue(pdfBytes.length > 1000, "PDF should have substantial content size");

        // Check PDF header '%PDF'
        assertEquals('%', (char) pdfBytes[0]);
        assertEquals('P', (char) pdfBytes[1]);
        assertEquals('D', (char) pdfBytes[2]);
        assertEquals('F', (char) pdfBytes[3]);

        // 3. Verify audit log entry
        List<DocumentGenerationLog> logs = loanDocumentService.getDocumentLogs(testLoanId);
        assertNotNull(logs);
        assertFalse(logs.isEmpty(), "Audit log should contain at least one entry");
        DocumentGenerationLog latest = logs.get(0);
        assertEquals(testLoanId, latest.getLoanId());
        assertEquals("SANCTION_LETTER", latest.getDocumentType());
        assertEquals("TEST_USER", latest.getGeneratedByUserId());
    }
}
