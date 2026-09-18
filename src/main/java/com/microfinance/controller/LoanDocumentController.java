package com.microfinance.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.AvailableDocumentDto;
import com.microfinance.dto.ErrorResponseDto;
import com.microfinance.dto.LoanDocumentDetailDto;
import com.microfinance.model.DocumentGenerationLog;
import com.microfinance.service.LoanDocumentService;

@RestController
@RequestMapping("/api/loans")
public class LoanDocumentController {

    private static final Logger logger = LoggerFactory.getLogger(LoanDocumentController.class);

    @Autowired
    private LoanDocumentService loanDocumentService;

    @GetMapping("/printable-loan-ids")
    public ResponseEntity<ApiResponse<List<String>>> getPrintableLoanIds() {
        try {
            List<String> ids = loanDocumentService.getPrintableLoanIds();
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Printable loan IDs fetched", ids));
        } catch (Exception ex) {
            logger.error("Error fetching printable loan IDs", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to fetch loan IDs: " + ex.getMessage()));
        }
    }

    @GetMapping("/{loanId}/details")
    public ResponseEntity<?> getLoanDetails(@PathVariable("loanId") String loanId) {
        logger.info("Fetching document loan details for loanId: {}", loanId);
        try {
            LoanDocumentDetailDto details = loanDocumentService.getLoanDetails(loanId);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Loan details fetched successfully", details));
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ErrorResponseDto("INVALID_LOAN_ID", ex.getMessage()));
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ErrorResponseDto("LOAN_NOT_FOUND", ex.getMessage()));
        } catch (Exception ex) {
            logger.error("Unexpected error fetching details for loan: {}", loanId, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ErrorResponseDto("INTERNAL_SERVER_ERROR", ex.getMessage()));
        }
    }

    @GetMapping("/{loanId}/available-documents")
    public ResponseEntity<?> getAvailableDocuments(@PathVariable("loanId") String loanId) {
        logger.info("Fetching available documents for loanId: {}", loanId);
        try {
            List<AvailableDocumentDto> docs = loanDocumentService.getAvailableDocuments(loanId);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Available documents fetched", docs));
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ErrorResponseDto("LOAN_NOT_FOUND", ex.getMessage()));
        } catch (Exception ex) {
            logger.error("Error evaluating available documents for loan: {}", loanId, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ErrorResponseDto("INTERNAL_SERVER_ERROR", ex.getMessage()));
        }
    }

    @GetMapping(value = "/{loanId}/documents/{docType}/preview", produces = MediaType.TEXT_HTML_VALUE)
    public ResponseEntity<?> previewDocument(@PathVariable("loanId") String loanId,
                                            @PathVariable("docType") String docType) {
        logger.info("Previewing document docType: {} for loanId: {}", docType, loanId);
        try {
            String html = loanDocumentService.renderDocumentHtml(loanId, docType);
            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType("text/html;charset=UTF-8"))
                    .body(html);
        } catch (IllegalStateException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .contentType(MediaType.TEXT_PLAIN)
                    .body("Document Gated: " + ex.getMessage());
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .contentType(MediaType.TEXT_PLAIN)
                    .body("Error: " + ex.getMessage());
        } catch (Exception ex) {
            logger.error("Error previewing document {} for loan {}", docType, loanId, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .contentType(MediaType.TEXT_PLAIN)
                    .body("Internal error rendering preview: " + ex.getMessage());
        }
    }

    @PostMapping("/{loanId}/documents/{docType}/generate")
    public ResponseEntity<?> generateDocument(@PathVariable("loanId") String loanId,
                                             @PathVariable("docType") String docType,
                                             HttpSession session) {
        logger.info("Generating PDF document docType: {} for loanId: {}", docType, loanId);

        String username = null;
        if (session != null && session.getAttribute("username") != null) {
            username = session.getAttribute("username").toString();
        }

        try {
            byte[] pdfBytes = loanDocumentService.generateDocumentPdf(loanId, docType, username);

            String filename = docType.toUpperCase() + "_" + loanId + ".pdf";

            HttpHeaders headers = new HttpHeaders();
            headers.setContentType(MediaType.APPLICATION_PDF);
            headers.setContentDispositionFormData("attachment", filename);
            headers.setContentLength(pdfBytes.length);
            headers.setCacheControl("must-revalidate, post-check=0, pre-check=0");

            return new ResponseEntity<>(pdfBytes, headers, HttpStatus.OK);
        } catch (IllegalStateException ex) {
            return ResponseEntity.status(HttpStatus.FORBIDDEN)
                    .body(new ErrorResponseDto("DOCUMENT_GATED", ex.getMessage()));
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ErrorResponseDto("LOAN_NOT_FOUND", ex.getMessage()));
        } catch (Exception ex) {
            logger.error("Failed to generate PDF for loanId: {}, docType: {}", loanId, docType, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ErrorResponseDto("GENERATION_FAILED", "Failed to generate PDF: " + ex.getMessage()));
        }
    }

    @GetMapping("/{loanId}/document-logs")
    public ResponseEntity<ApiResponse<List<DocumentGenerationLog>>> getDocumentLogs(@PathVariable("loanId") String loanId) {
        try {
            List<DocumentGenerationLog> logs = loanDocumentService.getDocumentLogs(loanId);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Document logs fetched", logs));
        } catch (Exception ex) {
            logger.error("Error fetching document logs for loanId: {}", loanId, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to fetch logs: " + ex.getMessage()));
        }
    }
}
