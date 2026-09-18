package com.microfinance.report;

import java.awt.Color;
import java.io.FileOutputStream;

import com.lowagie.text.Chunk;
import com.lowagie.text.Document;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.Rectangle;
import com.lowagie.text.pdf.BaseFont;
import com.lowagie.text.pdf.PdfContentByte;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfPageEventHelper;
import com.lowagie.text.pdf.PdfTemplate;
import com.lowagie.text.pdf.PdfWriter;

public class WorkSummaryReportGenerator {

    // Palette matching the reference image
    private static final Color COLOR_TITLE = new Color(24, 49, 102);         // Deep corporate blue
    private static final Color COLOR_BANNER_BG = new Color(27, 54, 93);      // Navy banner header
    private static final Color COLOR_BANNER_TEXT = Color.WHITE;
    private static final Color COLOR_SUBHEADER = new Color(26, 75, 140);     // Medium blue for A., B., C.
    private static final Color COLOR_TH_BG = new Color(30, 64, 130);         // Table header blue
    private static final Color COLOR_FLOW_BG = new Color(37, 78, 148);       // Process flow box blue
    private static final Color COLOR_FLOW_TEXT = Color.WHITE;
    private static final Color COLOR_BODY = new Color(51, 51, 51);           // #333333 Dark gray
    private static final Color COLOR_MUTED = new Color(102, 102, 102);       // #666666
    private static final Color COLOR_BORDER = new Color(218, 224, 233);      // Clean soft border
    private static final Color COLOR_ROW_ALT = new Color(248, 250, 253);     // Subtle alternating row
    private static final Color COLOR_WHITE = Color.WHITE;

    // Fonts
    private static Font FONT_DOC_TITLE;
    private static Font FONT_DOC_SUBTITLE;
    private static Font FONT_BANNER;
    private static Font FONT_SUBSECTION_HEADING;
    private static Font FONT_BODY;
    private static Font FONT_BODY_BOLD;
    private static Font FONT_CONTRIBUTION_LABEL;
    private static Font FONT_TABLE_HEADER;
    private static Font FONT_TABLE_BODY;
    private static Font FONT_TABLE_BODY_BOLD;
    private static Font FONT_FLOW_BOX;
    private static Font FONT_FOOTER;

    static {
        FONT_DOC_TITLE = new Font(Font.HELVETICA, 20, Font.BOLD, COLOR_TITLE);
        FONT_DOC_SUBTITLE = new Font(Font.HELVETICA, 10.5f, Font.NORMAL, COLOR_MUTED);
        FONT_BANNER = new Font(Font.HELVETICA, 11, Font.BOLD, COLOR_BANNER_TEXT);
        FONT_SUBSECTION_HEADING = new Font(Font.HELVETICA, 11, Font.BOLD, COLOR_SUBHEADER);
        FONT_BODY = new Font(Font.HELVETICA, 9.2f, Font.NORMAL, COLOR_BODY);
        FONT_BODY_BOLD = new Font(Font.HELVETICA, 9.2f, Font.BOLD, COLOR_BODY);
        FONT_CONTRIBUTION_LABEL = new Font(Font.HELVETICA, 9.2f, Font.BOLD, COLOR_BODY);
        FONT_TABLE_HEADER = new Font(Font.HELVETICA, 8.5f, Font.BOLD, COLOR_WHITE);
        FONT_TABLE_BODY = new Font(Font.HELVETICA, 8.2f, Font.NORMAL, COLOR_BODY);
        FONT_TABLE_BODY_BOLD = new Font(Font.HELVETICA, 8.2f, Font.BOLD, COLOR_BODY);
        FONT_FLOW_BOX = new Font(Font.HELVETICA, 7.8f, Font.BOLD, COLOR_FLOW_TEXT);
        FONT_FOOTER = new Font(Font.HELVETICA, 8f, Font.NORMAL, COLOR_MUTED);
    }

    public static void main(String[] args) {
        String outputPath = "F:\\Samitha Urban\\UpdatedMicroFinance\\Work_Summary_Customer_to_Loan_Module.pdf";
        if (args.length > 0) {
            outputPath = args[0];
        }

        try {
            generatePdf(outputPath);
            System.out.println("WORK_SUMMARY_GENERATED_SUCCESS: " + outputPath);
        } catch (Exception e) {
            System.err.println("ERROR: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void generatePdf(String outputPath) throws Exception {
        // Page setup: Standard A4 with comfortable 40pt margins
        Document document = new Document(PageSize.A4, 40, 40, 45, 45);
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(outputPath));

        PageNumberFooter footerEvent = new PageNumberFooter();
        writer.setPageEvent(footerEvent);

        document.open();

        // 1. Header Title & Subtitle
        Paragraph pTitle = new Paragraph("Work Summary Report", FONT_DOC_TITLE);
        pTitle.setSpacingAfter(3);
        document.add(pTitle);

        Paragraph pSub = new Paragraph("Customer Management to Loan Module — Microfinance Application (Samitha Urban Enterprise Project)", FONT_DOC_SUBTITLE);
        pSub.setSpacingAfter(12);
        document.add(pSub);

        // Thin divider line
        addHorizontalDivider(document);

        // Intro paragraph
        Paragraph pIntro = new Paragraph(
            "This document summarises the work completed across the core banking modules from Customer Management through the Loan Module of the microfinance application. It is organised in two parts: first, the business functionality worked on and how it fits into the overall system; second, the technical techniques used to build it. Wherever a feature already existed in the codebase, contributions are described as enhancements rather than as new work.",
            FONT_BODY
        );
        pIntro.setLeading(13.5f);
        pIntro.setSpacingAfter(14);
        document.add(pIntro);

        // ==========================================
        // PART 1 — BUSINESS FUNCTIONALITY
        // ==========================================
        addPartBanner(document, "Part 1 — Business Functionality");

        // A. Customer & Member Onboarding
        addSubsectionHeading(document, "A. Customer & Member Onboarding Lifecycle");
        Paragraph pA = new Paragraph(
            "When a new individual joins the institution, the system registers their personal, demographic, contact, and nominee information, generates a unique Member Code, collects KYC identity records, and establishes their foundational account in the core banking database.",
            FONT_BODY
        );
        pA.setLeading(13f);
        pA.setSpacingAfter(6);
        document.add(pA);

        Paragraph pACont = new Paragraph();
        pACont.setLeading(13f);
        pACont.setSpacingAfter(12);
        pACont.add(new Phrase("My contribution: ", FONT_CONTRIBUTION_LABEL));
        pACont.add(new Phrase("I worked on the end-to-end registration flow — implementing multi-document KYC verification (Aadhaar, PAN, Voter ID, Ration Card), photo and signature upload handling with live image previews, automatic default Savings Account provisioning with zero opening friction upon member creation, Aadhaar visibility toggle, and standardized uppercase normalization across stored customer records.", FONT_BODY));
        document.add(pACont);

        // B. Share Capital & Holdings
        addSubsectionHeading(document, "B. Share Capital & Distinctive Share Management");
        Paragraph pB = new Paragraph(
            "As a cooperative/Nidhi financial structure, every member must hold capital shares. The shareholding module manages share allocation, tracks unallotted equity inventory, records share transfers between members, and issues legal share certificates.",
            FONT_BODY
        );
        pB.setLeading(13f);
        pB.setSpacingAfter(6);
        document.add(pB);

        Paragraph pBCont = new Paragraph();
        pBCont.setLeading(13f);
        pBCont.setSpacingAfter(12);
        pBCont.add(new Phrase("My contribution: ", FONT_CONTRIBUTION_LABEL));
        pBCont.add(new Phrase("I implemented the share transfer transaction logic ensuring share ledger balance consistency between transferor and transferee, engineered the Distinctive Number Order (DNO) allocation and automated regeneration engine, and developed the formal share certificate generation layout with distinct certificate numbering.", FONT_BODY));
        document.add(pBCont);

        // C. General Ledger & Double-Entry Accounting
        addSubsectionHeading(document, "C. General Ledger & Double-Entry Accounting Integration");
        Paragraph pC = new Paragraph(
            "The accounting backbone provides institutional double-entry bookkeeping across all branch operations — capturing cash/bank receipt and payment vouchers, contra transfers, cheque clearance lifecycles, and real-time statutory financial statements.",
            FONT_BODY
        );
        pC.setLeading(13f);
        pC.setSpacingAfter(6);
        document.add(pC);

        Paragraph pCCont = new Paragraph();
        pCCont.setLeading(13f);
        pCCont.setSpacingAfter(12);
        pCCont.add(new Phrase("My contribution: ", FONT_CONTRIBUTION_LABEL));
        pCCont.add(new Phrase("I connected cash desk and teller operations directly to the double-entry ledger so that every deposit, withdrawal, loan disbursement, and EMI repayment automatically posts balanced debit and credit entries. I also verified the automated financial reporting logic for the Daybook, Cashbook, Trial Balance, Profit & Loss Statement, and Balance Sheet.", FONT_BODY));
        document.add(pCCont);

        // D. Customer Savings & Deposit Operations
        addSubsectionHeading(document, "D. Customer Savings & Deposit Operations");
        Paragraph pD = new Paragraph(
            "This module serves as the primary transaction hub for customer liquidity — offering savings accounts, cash desk deposits and withdrawals, account-to-account internal fund transfers, passbook record generation, and automated interest crediting.",
            FONT_BODY
        );
        pD.setLeading(13f);
        pD.setSpacingAfter(6);
        document.add(pD);

        Paragraph pDCont = new Paragraph();
        pDCont.setLeading(13f);
        pDCont.setSpacingAfter(10);
        pDCont.add(new Phrase("My contribution: ", FONT_CONTRIBUTION_LABEL));
        pDCont.add(new Phrase("I built the cash teller deposit/withdrawal validation, eliminated duplicate alert popups on passbook transactions, engineered the automated quarterly interest computation engine with a single-click batch transfer button, and developed the customer savings statement view featuring date-range filters, summary metric cards, and instant PDF download/print capabilities.", FONT_BODY));
        document.add(pDCont);

        // Core Financial Products Comparison Table
        Paragraph pTableIntro = new Paragraph("Comparison of Core Financial Products across the Pipeline", FONT_SUBSECTION_HEADING);
        pTableIntro.setSpacingAfter(5);
        document.add(pTableIntro);

        PdfPTable tableProducts = createComparisonTable();
        document.add(tableProducts);
        document.add(new Paragraph(" "));

        // E. Scheme & Policy Management (Investments / Deposits)
        addSubsectionHeading(document, "E. Scheme & Policy Management (RD, FD, DRD, MIS)");
        Paragraph pE = new Paragraph(
            "The investment module enables long-term deposits across Recurring Deposits (RD), Fixed Deposits (FD), Daily Recurring Deposits (DRD), and Monthly Income Schemes (MIS) — tracking policy booking, installment schedules, renewal payments, and maturity payouts.",
            FONT_BODY
        );
        pE.setLeading(13f);
        pE.setSpacingAfter(6);
        document.add(pE);

        Paragraph pECont = new Paragraph();
        pECont.setLeading(13f);
        pECont.setSpacingAfter(12);
        pECont.add(new Phrase("My contribution: ", FONT_CONTRIBUTION_LABEL));
        pECont.add(new Phrase("I worked on plan interest and maturity calculations across all four deposit types, connected policy creation to savings account balance checks, built the rapid daily renewal collection screens for field collectors, and added installment record book tracking with automated late-fee/penalty calculations.", FONT_BODY));
        document.add(pECont);

        // F. Credit & Loan Management Lifecycle
        addSubsectionHeading(document, "F. Credit & Loan Management Lifecycle (Core Asset Engine)");
        Paragraph pF = new Paragraph(
            "This constitutes the primary asset management engine of the institution: from initial loan eligibility assessment and dynamic EMI calculation to application appraisal, multi-tier sanctioning, deduction schedule execution, disbursement, monthly installment collections, legal documentation, and loan foreclosure.",
            FONT_BODY
        );
        pF.setLeading(13f);
        pF.setSpacingAfter(8);
        document.add(pF);

        // Process Flow Diagram (6 sequential boxes)
        PdfPTable flowTable = createProcessFlowDiagram();
        flowTable.setSpacingAfter(8);
        document.add(flowTable);

        Paragraph pFCont = new Paragraph();
        pFCont.setLeading(13f);
        pFCont.setSpacingAfter(12);
        pFCont.add(new Phrase("My contribution: ", FONT_CONTRIBUTION_LABEL));
        pFCont.add(new Phrase("I built the dynamic loan deduction engine (automatically computing processing fees, insurance premiums, legal fees, and GST dynamically per loan product at disbursement), integrated the automated notification service for SMS/email alerts on sanction and disbursement, developed the regular loan statement ledger, and implemented OpenPDF document printing for statutory loan agreements, promissory notes, and NOC clearance certificates.", FONT_BODY));
        document.add(pFCont);

        // G. Extended Lending (Gold Loans & Joint Liability Loans)
        addSubsectionHeading(document, "G. Extended Lending (Secured Gold & Joint Liability Loans)");
        Paragraph pG = new Paragraph(
            "To support diverse borrower segments, the loan ecosystem extends into Secured Jewellery / Gold Loans (with ornament appraisal, purity karat valuation, and LTV enforcement) and Joint Liability Group (JLG) loans (group formation and peer-guaranteed lending).",
            FONT_BODY
        );
        pG.setLeading(13f);
        pG.setSpacingAfter(6);
        document.add(pG);

        Paragraph pGCont = new Paragraph();
        pGCont.setLeading(13f);
        pGCont.setSpacingAfter(14);
        pGCont.add(new Phrase("My contribution: ", FONT_CONTRIBUTION_LABEL));
        pGCont.add(new Phrase("I connected gold ornament appraisal logic to maximum permissible sanction limits, implemented gold loan closure with collateral packet release tracking, and wired lending group directories with peer-guarantee verification.", FONT_BODY));
        document.add(pGCont);

        // How These Pieces Fit Together
        addSubsectionHeading(document, "How These Pieces Fit Together");
        Paragraph pFit = new Paragraph(
            "At the architectural center of the application sits the Customer/Member record. Every share certificate, savings account, deposit policy (RD/FD/DRD/MIS), and loan account is tied to this central Member ID. When a member applies for a loan or policy, the system verifies their KYC and linked Savings Account. Loan disbursements can credit their savings account directly, and EMI repayments or policy renewals can automatically deduct from their available balance. Simultaneously, every financial event posts balanced vouchers into the General Ledger, ensuring real-time reconciliation between branch tellers, portfolio ledgers, and financial balance sheets.",
            FONT_BODY
        );
        pFit.setLeading(13.5f);
        pFit.setSpacingAfter(16);
        document.add(pFit);

        // ==========================================
        // PART 2 — TECHNICAL IMPLEMENTATION
        // ==========================================
        addPartBanner(document, "Part 2 — Technical Implementation");

        Paragraph pPart2Intro = new Paragraph(
            "The table below lists the primary software engineering techniques, architectural patterns, and libraries utilised across these modules, following the structured pattern: \"I used X to achieve Y in the Z business flow.\"",
            FONT_BODY
        );
        pPart2Intro.setLeading(13f);
        pPart2Intro.setSpacingAfter(8);
        document.add(pPart2Intro);

        PdfPTable tableTechniques = createTechniqueTable();
        document.add(tableTechniques);
        document.add(new Paragraph(" "));

        // Smaller Updates Section
        Paragraph pSmallHeading = new Paragraph("Smaller Updates & Polish Across These Modules", FONT_SUBSECTION_HEADING);
        pSmallHeading.setSpacingBefore(4);
        pSmallHeading.setSpacingAfter(6);
        document.add(pSmallHeading);

        addBulletItem(document, "Added new customer form fields (occupation, education, monthly income, member fees, building fund, admin charges).");
        addBulletItem(document, "Standardised all personal customer text fields to a consistent upper-case format upon database persistence.");
        addBulletItem(document, "Resolved account number binding bug in Customer Summary and Savings Record Book views.");
        addBulletItem(document, "Implemented Aadhaar visibility toggle and enhanced document preview for KYC verification.");
        addBulletItem(document, "Eliminated duplicate alert popups on passbook transaction button clicks.");
        addBulletItem(document, "Integrated dynamic loan deduction details (processing fees, insurance, legal charges, GST) calculated at disbursement.");
        addBulletItem(document, "Added automated loan notification service hooks dispatching SMS/email on status changes.");
        addBulletItem(document, "Applied unified Samitha Urban corporate branding, color schemes, and responsive UI styling.");

        // Concluding Summary
        document.add(new Paragraph(" "));
        Paragraph pSummaryHeading = new Paragraph("Summary", FONT_SUBSECTION_HEADING);
        pSummaryHeading.setSpacingAfter(4);
        document.add(pSummaryHeading);

        Paragraph pSummary = new Paragraph(
            "The core pipeline from Customer Management to Loan Management represents the complete foundational banking cycle of the Samitha Urban Microfinance system. Major deliverables include verified member onboarding with instant savings account provisioning, distinctive shareholding management, double-entry general ledger integration, multi-scheme deposit lifecycles with batch interest crediting, and a full-featured loan management system complete with dynamic deduction schedules, EMI amortization, OpenPDF legal document printing, and foreclosure settlement. The implementation adheres to enterprise Java/Spring Boot standards, ensuring robust transactional consistency, clean modular separation, and readiness for client demonstration and production operations.",
            FONT_BODY
        );
        pSummary.setLeading(13.5f);
        document.add(pSummary);

        document.close();
    }

    // ==========================================
    // UI HELPER METHODS & WIDGETS
    // ==========================================

    private static void addPartBanner(Document document, String text) throws Exception {
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);
        table.setSpacingBefore(6);
        table.setSpacingAfter(10);

        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(COLOR_BANNER_BG);
        cell.setPaddingTop(6);
        cell.setPaddingBottom(6);
        cell.setPaddingLeft(10);
        cell.setPaddingRight(10);
        cell.setBorder(Rectangle.NO_BORDER);

        Paragraph p = new Paragraph(text, FONT_BANNER);
        cell.addElement(p);

        table.addCell(cell);
        document.add(table);
    }

    private static void addSubsectionHeading(Document document, String text) throws Exception {
        Paragraph p = new Paragraph(text, FONT_SUBSECTION_HEADING);
        p.setSpacingBefore(6);
        p.setSpacingAfter(3);
        document.add(p);
    }

    private static void addHorizontalDivider(Document document) throws Exception {
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);
        table.setSpacingAfter(10);

        PdfPCell cell = new PdfPCell();
        cell.setBorder(Rectangle.BOTTOM);
        cell.setBorderWidthBottom(1f);
        cell.setBorderColorBottom(COLOR_BORDER);
        cell.setPadding(0);
        table.addCell(cell);

        document.add(table);
    }

    private static void addBulletItem(Document document, String text) throws Exception {
        Paragraph p = new Paragraph();
        p.setLeading(13f);
        p.setSpacingAfter(3);
        p.setIndentationLeft(14);
        p.add(new Phrase("•  ", FONT_BODY_BOLD));
        p.add(new Phrase(text, FONT_BODY));
        document.add(p);
    }

    // Comparison Table
    private static PdfPTable createComparisonTable() throws Exception {
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{22f, 24f, 26f, 28f});
        table.setHeaderRows(1);
        table.setSpacingBefore(4);
        table.setSpacingAfter(8);

        addTableHeader(table, "Scheme / Product");
        addTableHeader(table, "How Money is Deposited / Borrowed");
        addTableHeader(table, "How Interest is Worked Out");
        addTableHeader(table, "What the Customer Receives / Pays");

        addTableRow(table, "Savings Account", "Anytime flexible deposits and cash teller withdrawals", "Quarterly interest credited to savings balance based on daily balance", "Liquidity on demand, quarterly interest yield, passbook records", false);
        addTableRow(table, "RD (Recurring Deposit)", "Fixed monthly installments over chosen term", "Compounded monthly or quarterly over term", "Total saved sum plus accumulated interest paid at maturity", true);
        addTableRow(table, "FD (Fixed Deposit)", "Single one-time lump sum deposit", "Calculated quarterly/yearly depending on chosen scheme", "Lump sum principal plus compounded interest at maturity", false);
        addTableRow(table, "MIS (Monthly Income)", "Single lump sum deposit kept locked in", "Fixed monthly interest calculated on principal", "Monthly interest payout to Savings Account; principal returned at maturity", true);
        addTableRow(table, "DRD (Daily Deposit)", "Small daily cash collections via field collectors", "Calculated daily/monthly over specified number of days", "Total saved capital plus interest returned at maturity", false);
        addTableRow(table, "Regular / Term Loans", "Disbursed lump sum net of processing & statutory deductions", "Reducing balance or flat rate EMI schedule", "Repays monthly EMIs; receives NOC upon full clearance", true);

        return table;
    }

    // Process Flow 6-Box Diagram
    private static PdfPTable createProcessFlowDiagram() throws Exception {
        PdfPTable table = new PdfPTable(6);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{16.6f, 16.6f, 16.6f, 16.6f, 16.6f, 16.6f});

        addFlowBox(table, "1. Loan Applied", "Eligibility & appraisal");
        addFlowBox(table, "2. Verification", "Co-applicant & guarantor");
        addFlowBox(table, "3. Sanctioned", "Authority approval");
        addFlowBox(table, "4. Disbursed", "Fee deductions & net payout");
        addFlowBox(table, "5. EMI Repayment", "Monthly installment collections");
        addFlowBox(table, "6. Closed / NOC", "Full clearance & certificate");

        return table;
    }

    private static void addFlowBox(PdfPTable table, String step, String sub) {
        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(COLOR_FLOW_BG);
        cell.setBorderColor(COLOR_WHITE);
        cell.setBorderWidth(1.5f);
        cell.setPadding(6);
        cell.setHorizontalAlignment(Element.ALIGN_CENTER);

        Paragraph pStep = new Paragraph(step, FONT_FLOW_BOX);
        pStep.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(pStep);

        Paragraph pSub = new Paragraph(sub, new Font(Font.HELVETICA, 6.8f, Font.NORMAL, new Color(224, 231, 255)));
        pSub.setAlignment(Element.ALIGN_CENTER);
        cell.addElement(pSub);

        table.addCell(cell);
    }

    // Technique Table
    private static PdfPTable createTechniqueTable() throws Exception {
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{30f, 70f});
        table.setHeaderRows(1);
        table.setSpacingBefore(4);
        table.setSpacingAfter(8);

        addTableHeader(table, "Technique");
        addTableHeader(table, "How I used it, and why");

        addTechRow(table, "@Transactional", "I used this to make sure that money-related operations (creating a policy, deducting or crediting a Savings Account, running quarterly interest batches, and disbursing loans) either complete fully or not at all — so a failure partway through never leaves a balance or ledger in an inconsistent state.", false);
        addTechRow(table, "@Scheduled / Batch Processing", "I used this to automate recurring calculations — the system checks and processes quarterly savings interest crediting and scheduled policy updates without requiring manual row-by-row intervention.", true);
        addTechRow(table, "Dynamic Fee Deduction Engine", "I used this to dynamically compute processing charges, insurance premiums, legal fees, and GST on loan disbursement, so deductions are auto-calculated from scheme rules rather than hardcoded.", false);
        addTechRow(table, "Custom Business Exceptions & Validations", "I used these to enforce business rules cleanly — for example, blocking savings withdrawals below minimum balance, preventing duplicate passbook alerts, and validating guarantor eligibility.", true);
        addTechRow(table, "DTOs (Data Transfer Objects)", "I used these to validate and structure the data coming in from customer registration, loan origination, and policy forms before saving, catching missing or malformed inputs early.", false);
        addTechRow(table, "PDF Generation (OpenPDF & Flying Saucer)", "I built the downloadable document generation features using these libraries — staff can now download formatted Customer Statements, Share Certificates, Loan Agreements, and NOCs on demand.", true);
        addTechRow(table, "Spreadsheet Integration (Apache POI)", "I used this to generate downloadable Excel reports for member registers and financial audits with proper column typing and date formatting.", false);
        addTechRow(table, "HandlerInterceptor & Activity Logging", "I used this to log staff actions across request routes, recording timestamps and mutation details into the ActivityLog table to maintain an audit trail for compliance.", true);
        addTechRow(table, "AJAX & Dynamic DOM Rendering", "I used this across customer search, loan statement filtering, and passbook views to fetch ledger entries asynchronously and update summary cards without reloading the full page.", false);

        return table;
    }

    private static void addTableHeader(PdfPTable table, String text) {
        PdfPCell cell = new PdfPCell(new Phrase(text, FONT_TABLE_HEADER));
        cell.setBackgroundColor(COLOR_TH_BG);
        cell.setBorderColor(COLOR_TH_BG);
        cell.setPadding(6);
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        table.addCell(cell);
    }

    private static void addTableRow(PdfPTable table, String c1, String c2, String c3, String c4, boolean alt) {
        Color bg = alt ? COLOR_ROW_ALT : COLOR_WHITE;

        PdfPCell cell1 = new PdfPCell(new Phrase(c1, FONT_TABLE_BODY_BOLD));
        cell1.setBackgroundColor(bg);
        cell1.setBorderColor(COLOR_BORDER);
        cell1.setPadding(5);
        table.addCell(cell1);

        PdfPCell cell2 = new PdfPCell(new Phrase(c2, FONT_TABLE_BODY));
        cell2.setBackgroundColor(bg);
        cell2.setBorderColor(COLOR_BORDER);
        cell2.setPadding(5);
        table.addCell(cell2);

        PdfPCell cell3 = new PdfPCell(new Phrase(c3, FONT_TABLE_BODY));
        cell3.setBackgroundColor(bg);
        cell3.setBorderColor(COLOR_BORDER);
        cell3.setPadding(5);
        table.addCell(cell3);

        PdfPCell cell4 = new PdfPCell(new Phrase(c4, FONT_TABLE_BODY));
        cell4.setBackgroundColor(bg);
        cell4.setBorderColor(COLOR_BORDER);
        cell4.setPadding(5);
        table.addCell(cell4);
    }

    private static void addTechRow(PdfPTable table, String tech, String desc, boolean alt) {
        Color bg = alt ? COLOR_ROW_ALT : COLOR_WHITE;

        PdfPCell cell1 = new PdfPCell(new Phrase(tech, FONT_TABLE_BODY_BOLD));
        cell1.setBackgroundColor(bg);
        cell1.setBorderColor(COLOR_BORDER);
        cell1.setPadding(6);
        table.addCell(cell1);

        PdfPCell cell2 = new PdfPCell(new Phrase(desc, FONT_BODY));
        cell2.setBackgroundColor(bg);
        cell2.setBorderColor(COLOR_BORDER);
        cell2.setPadding(6);
        table.addCell(cell2);
    }

    // Page Number Footer (matches clean style: "Page X of Y" or subtle running footer)
    static class PageNumberFooter extends PdfPageEventHelper {
        private PdfTemplate totalPagesTemplate;
        private BaseFont baseFont;

        @Override
        public void onOpenDocument(PdfWriter writer, Document document) {
            try {
                baseFont = BaseFont.createFont(BaseFont.HELVETICA, BaseFont.WINANSI, BaseFont.NOT_EMBEDDED);
                totalPagesTemplate = writer.getDirectContent().createTemplate(30, 16);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        @Override
        public void onEndPage(PdfWriter writer, Document document) {
            PdfContentByte cb = writer.getDirectContent();
            int pageNumber = writer.getPageNumber();

            // Subtle line above footer
            cb.saveState();
            cb.setColorStroke(COLOR_BORDER);
            cb.setLineWidth(0.5f);
            cb.moveTo(document.left(), document.bottom() - 10);
            cb.lineTo(document.right(), document.bottom() - 10);
            cb.stroke();

            // Left: Document title
            cb.beginText();
            cb.setFontAndSize(baseFont, 7.5f);
            cb.setColorFill(COLOR_MUTED);
            cb.setTextMatrix(document.left(), document.bottom() - 22);
            cb.showText("Samitha Urban Microfinance Enterprise Solution — Work Summary Report");
            cb.endText();

            // Right: Page X of Y
            String pageText = "Page " + pageNumber + " of ";
            float textSize = baseFont.getWidthPoint(pageText, 7.5f);
            float textBase = document.bottom() - 22;
            float textRight = document.right() - 25;

            cb.beginText();
            cb.setFontAndSize(baseFont, 7.5f);
            cb.setColorFill(COLOR_MUTED);
            cb.setTextMatrix(textRight - textSize, textBase);
            cb.showText(pageText);
            cb.endText();

            cb.addTemplate(totalPagesTemplate, textRight, textBase);
            cb.restoreState();
        }

        @Override
        public void onCloseDocument(PdfWriter writer, Document document) {
            totalPagesTemplate.beginText();
            totalPagesTemplate.setFontAndSize(baseFont, 7.5f);
            totalPagesTemplate.setColorFill(COLOR_MUTED);
            totalPagesTemplate.setTextMatrix(0, 0);
            totalPagesTemplate.showText(String.valueOf(writer.getPageNumber() - 1));
            totalPagesTemplate.endText();
        }
    }
}
