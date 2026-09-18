package com.microfinance.util;

import java.io.ByteArrayOutputStream;
import java.io.OutputStream;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.xhtmlrenderer.pdf.ITextRenderer;

public class PdfDocumentGenerator {

    private static final Logger logger = LoggerFactory.getLogger(PdfDocumentGenerator.class);

    public static byte[] generatePdfFromHtml(String htmlContent) throws Exception {
        ByteArrayOutputStream outputStream = new ByteArrayOutputStream();
        generatePdfFromHtml(htmlContent, outputStream);
        return outputStream.toByteArray();
    }

    public static void generatePdfFromHtml(String htmlContent, OutputStream outputStream) throws Exception {
        if (htmlContent == null || htmlContent.trim().isEmpty()) {
            throw new IllegalArgumentException("HTML content cannot be empty for PDF generation");
        }

        try {
            ITextRenderer renderer = new ITextRenderer();
            renderer.setDocumentFromString(htmlContent);
            renderer.layout();
            renderer.createPDF(outputStream);
            outputStream.flush();
        } catch (Exception ex) {
            logger.error("Failed to render PDF from HTML content", ex);
            throw ex;
        }
    }
}
