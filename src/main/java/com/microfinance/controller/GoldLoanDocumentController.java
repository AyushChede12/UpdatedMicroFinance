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

import java.util.Map;
import java.util.HashMap;
import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.AvailableDocumentDto;
import com.microfinance.dto.ErrorResponseDto;
import com.microfinance.dto.GoldLoanDocumentDetailDto;
import com.microfinance.dto.GoldLoanDropdownDto;
import com.microfinance.model.DocumentGenerationLog;
import com.microfinance.service.GoldLoanDocumentService;

@RestController
@RequestMapping("/api/gold-loans")
public class GoldLoanDocumentController {

    private static final Logger logger = LoggerFactory.getLogger(GoldLoanDocumentController.class);

    @Autowired
    private GoldLoanDocumentService goldLoanDocumentService;

    @GetMapping({"/printable-loan-ids", "/printable-loans"})
    public ResponseEntity<ApiResponse<List<GoldLoanDropdownDto>>> getPrintableGoldLoanIds() {
        try {
            List<GoldLoanDropdownDto> loans = goldLoanDocumentService.getPrintableGoldLoans();
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Printable gold loans fetched successfully", loans));
        } catch (Exception ex) {
            logger.error("Error fetching printable gold loans", ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to fetch gold loans: " + ex.getMessage()));
        }
    }

    @GetMapping("/{goldId}/client-name")
    public ResponseEntity<ApiResponse<Map<String, String>>> getClientNameByGoldId(@PathVariable("goldId") String goldId) {
        try {
            String clientName = goldLoanDocumentService.getClientNameByGoldId(goldId);
            Map<String, String> data = new HashMap<>();
            data.put("goldId", goldId);
            data.put("clientName", clientName);
            data.put("customerName", clientName);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Client name fetched successfully", data));
        } catch (Exception ex) {
            logger.error("Error fetching client name for goldId: {}", goldId, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to fetch client name: " + ex.getMessage()));
        }
    }

    @GetMapping("/{goldId}/details")
    public ResponseEntity<?> getGoldLoanDetails(@PathVariable("goldId") String goldId) {
        logger.info("Fetching document details for goldId: {}", goldId);
        try {
            GoldLoanDocumentDetailDto details = goldLoanDocumentService.getGoldLoanDetails(goldId);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Gold loan details fetched successfully", details));
        } catch (IllegalArgumentException ex) {
            return ResponseEntity.status(HttpStatus.BAD_REQUEST)
                    .body(new ErrorResponseDto("INVALID_GOLD_ID", ex.getMessage()));
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ErrorResponseDto("GOLD_LOAN_NOT_FOUND", ex.getMessage()));
        } catch (Exception ex) {
            logger.error("Unexpected error fetching details for gold loan: {}", goldId, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ErrorResponseDto("INTERNAL_SERVER_ERROR", ex.getMessage()));
        }
    }

    @GetMapping("/{goldId}/available-documents")
    public ResponseEntity<?> getAvailableDocuments(@PathVariable("goldId") String goldId) {
        logger.info("Fetching available documents for goldId: {}", goldId);
        try {
            List<AvailableDocumentDto> docs = goldLoanDocumentService.getAvailableDocuments(goldId);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Available gold loan documents fetched", docs));
        } catch (RuntimeException ex) {
            return ResponseEntity.status(HttpStatus.NOT_FOUND)
                    .body(new ErrorResponseDto("GOLD_LOAN_NOT_FOUND", ex.getMessage()));
        } catch (Exception ex) {
            logger.error("Error evaluating available documents for goldId: {}", goldId, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ErrorResponseDto("INTERNAL_SERVER_ERROR", ex.getMessage()));
        }
    }

    @GetMapping(value = "/{goldId}/documents/{docType}/preview", produces = MediaType.TEXT_HTML_VALUE)
    public ResponseEntity<?> previewDocument(@PathVariable("goldId") String goldId,
                                            @PathVariable("docType") String docType) {
        logger.info("Previewing gold loan document docType: {} for goldId: {}", docType, goldId);
        try {
            String html = goldLoanDocumentService.renderDocumentHtml(goldId, docType);
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
            logger.error("Error previewing document {} for gold loan {}", docType, goldId, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .contentType(MediaType.TEXT_PLAIN)
                    .body("Internal error rendering preview: " + ex.getMessage());
        }
    }

    @PostMapping("/{goldId}/documents/{docType}/generate")
    public ResponseEntity<?> generateDocument(@PathVariable("goldId") String goldId,
                                             @PathVariable("docType") String docType,
                                             HttpSession session) {
        logger.info("Generating PDF document docType: {} for goldId: {}", docType, goldId);

        String username = null;
        if (session != null && session.getAttribute("username") != null) {
            username = session.getAttribute("username").toString();
        }

        try {
            byte[] pdfBytes = goldLoanDocumentService.generateDocumentPdf(goldId, docType, username);

            String filename = docType.toUpperCase() + "_" + goldId + ".pdf";

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
                    .body(new ErrorResponseDto("GOLD_LOAN_NOT_FOUND", ex.getMessage()));
        } catch (Exception ex) {
            logger.error("Failed to generate PDF for goldId: {}, docType: {}", goldId, docType, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(new ErrorResponseDto("GENERATION_FAILED", "Failed to generate PDF: " + ex.getMessage()));
        }
    }

    @GetMapping("/{goldId}/document-logs")
    public ResponseEntity<ApiResponse<List<DocumentGenerationLog>>> getDocumentLogs(@PathVariable("goldId") String goldId) {
        try {
            List<DocumentGenerationLog> logs = goldLoanDocumentService.getDocumentLogs(goldId);
            return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Document logs fetched", logs));
        } catch (Exception ex) {
            logger.error("Error fetching document logs for goldId: {}", goldId, ex);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error(HttpStatus.INTERNAL_SERVER_ERROR, "Failed to fetch logs: " + ex.getMessage()));
        }
    }
}
