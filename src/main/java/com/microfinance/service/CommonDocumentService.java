package com.microfinance.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.microfinance.model.DocumentGenerationLog;
import com.microfinance.repository.DocumentGenerationLogRepo;
import com.microfinance.util.PdfDocumentGenerator;

@Service
public class CommonDocumentService {

    private static final Logger logger = LoggerFactory.getLogger(CommonDocumentService.class);

    @Autowired
    private DocumentGenerationLogRepo documentGenerationLogRepo;

    /**
     * Standard society/organization details for letterheads and document headers.
     */
    public Map<String, String> getSocietyDetails() {
        Map<String, String> society = new HashMap<>();
        society.put("name", "SAMITHA URBAN MULTI-STATE CREDIT CO-OPERATIVE SOCIETY LTD.");
        society.put("regInfo", "Registered Under MSCS Act 2002, Govt. of India | Reg. No: MSCS/CR/2014");
        society.put("address", "Head Office: Administrative Complex, City Center");
        society.put("phone", "+91 1800-123-4567");
        society.put("email", "contact@samithaurban.coop");
        society.put("website", "www.samithaurban.coop");
        return society;
    }

    /**
     * Generates PDF byte array from valid XHTML/HTML string using Flying Saucer OpenPDF engine.
     */
    public byte[] generatePdf(String htmlContent) throws Exception {
        if (htmlContent == null || htmlContent.trim().isEmpty()) {
            throw new IllegalArgumentException("HTML content for PDF generation cannot be empty");
        }
        return PdfDocumentGenerator.generatePdfFromHtml(htmlContent);
    }

    /**
     * Records document generation audit entry in database.
     */
    public DocumentGenerationLog recordDocumentLog(String loanId, String docType, String docName, 
                                                   String username, String filename, long sizeBytes) {
        DocumentGenerationLog log = new DocumentGenerationLog(
                loanId,
                docType,
                docName,
                (username != null && !username.trim().isEmpty()) ? username : "ADMIN",
                filename,
                sizeBytes
        );
        log.setGeneratedAt(LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss")));
        DocumentGenerationLog saved = documentGenerationLogRepo.save(log);
        logger.info("Recorded document log: id={}, loanId={}, docType={}, user={}", 
                saved.getId(), loanId, docType, username);
        return saved;
    }

    /**
     * Retrieves audit generation logs for a given loan ID (regular or gold loan).
     */
    public List<DocumentGenerationLog> getDocumentLogs(String loanId) {
        if (loanId == null || loanId.trim().isEmpty()) {
            return java.util.Collections.emptyList();
        }
        return documentGenerationLogRepo.findByLoanIdOrderByGeneratedAtDesc(loanId.trim());
    }

    /**
     * Converts a numeric value to Indian currency words representation (e.g. Fifty Thousand Rupees Only).
     */
    public String convertNumberToWords(long n) {
        if (n <= 0) return "Zero";
        String[] units = { "", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
                "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen" };
        String[] tens = { "", "", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety" };

        if (n >= 10000000) {
            return convertNumberToWords(n / 10000000) + " Crore " + convertNumberToWords(n % 10000000);
        }
        if (n >= 100000) {
            return convertNumberToWords(n / 100000) + " Lakh " + convertNumberToWords(n % 100000);
        }
        if (n >= 1000) {
            return convertNumberToWords(n / 1000) + " Thousand " + convertNumberToWords(n % 1000);
        }
        if (n >= 100) {
            return convertNumberToWords(n / 100) + " Hundred " + convertNumberToWords(n % 100);
        }
        if (n >= 20) {
            return tens[(int) (n / 10)] + " " + units[(int) (n % 10)];
        }
        return units[(int) n];
    }

    /**
     * Parses numeric strings safely, removing commas, spaces, currency symbols.
     */
    public double parseDouble(String str) {
        if (str == null) return 0.0;
        try {
            return Double.parseDouble(str.replaceAll("[^0-9.]", "").trim());
        } catch (Exception e) {
            return 0.0;
        }
    }
}
