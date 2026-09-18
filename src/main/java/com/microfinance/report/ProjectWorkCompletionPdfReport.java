package com.microfinance.report;

import java.awt.Color;
import java.io.File;
import java.io.FileOutputStream;
import java.text.SimpleDateFormat;
import java.util.Date;

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

public class ProjectWorkCompletionPdfReport {

    // Palette
    private static final Color COLOR_PRIMARY = new Color(15, 41, 66);      // #0F2942 Deep Navy
    private static final Color COLOR_SECONDARY = new Color(30, 64, 175);   // #1E40AF Royal Blue
    private static final Color COLOR_ACCENT = new Color(217, 119, 6);      // #D97706 Warm Amber/Gold
    private static final Color COLOR_SUCCESS = new Color(22, 101, 52);     // #166534 Emerald Green
    private static final Color COLOR_SUCCESS_BG = new Color(240, 253, 244);
    private static final Color COLOR_BG_LIGHT = new Color(248, 250, 252);  // #F8FAFC Off-white slate
    private static final Color COLOR_BORDER = new Color(226, 232, 240);    // #E2E8F0 Light gray border
    private static final Color COLOR_TEXT_DARK = new Color(30, 41, 59);    // #1E293B Slate 800
    private static final Color COLOR_TEXT_MUTED = new Color(100, 116, 139);// #64748B Slate 500
    private static final Color COLOR_WHITE = Color.WHITE;

    // Fonts
    private static Font FONT_TITLE;
    private static Font FONT_SUBTITLE;
    private static Font FONT_SECTION;
    private static Font FONT_SUBSECTION;
    private static Font FONT_BODY;
    private static Font FONT_BODY_BOLD;
    private static Font FONT_SMALL;
    private static Font FONT_SMALL_BOLD;
    private static Font FONT_HEADER_FOOTER;

    static {
        FONT_TITLE = new Font(Font.HELVETICA, 22, Font.BOLD, COLOR_PRIMARY);
        FONT_SUBTITLE = new Font(Font.HELVETICA, 12, Font.NORMAL, COLOR_TEXT_MUTED);
        FONT_SECTION = new Font(Font.HELVETICA, 14, Font.BOLD, COLOR_PRIMARY);
        FONT_SUBSECTION = new Font(Font.HELVETICA, 11, Font.BOLD, COLOR_SECONDARY);
        FONT_BODY = new Font(Font.HELVETICA, 9.5f, Font.NORMAL, COLOR_TEXT_DARK);
        FONT_BODY_BOLD = new Font(Font.HELVETICA, 9.5f, Font.BOLD, COLOR_TEXT_DARK);
        FONT_SMALL = new Font(Font.HELVETICA, 8.5f, Font.NORMAL, COLOR_TEXT_MUTED);
        FONT_SMALL_BOLD = new Font(Font.HELVETICA, 8.5f, Font.BOLD, COLOR_TEXT_DARK);
        FONT_HEADER_FOOTER = new Font(Font.HELVETICA, 8f, Font.NORMAL, COLOR_TEXT_MUTED);
    }

    public static void main(String[] args) {
        String outputPath = "F:\\Samitha Urban\\UpdatedMicroFinance\\Samitha_Urban_Microfinance_Work_Completion_Report_Customer_to_Loan_Module.pdf";
        if (args.length > 0) {
            outputPath = args[0];
        }

        try {
            generateReport(outputPath);
            System.out.println("SUCCESS: PDF report generated successfully at: " + outputPath);
        } catch (Exception e) {
            System.err.println("ERROR: Failed to generate PDF report: " + e.getMessage());
            e.printStackTrace();
        }
    }

    public static void generateReport(String outputPath) throws Exception {
        Document document = new Document(PageSize.A4, 36, 36, 54, 45);
        PdfWriter writer = PdfWriter.getInstance(document, new FileOutputStream(outputPath));

        HeaderFooterPageEvent event = new HeaderFooterPageEvent();
        writer.setPageEvent(event);

        document.open();

        // 1. Cover / Executive Header Banner
        addHeaderBanner(document);

        // 2. Executive Metadata & Overview Card
        addExecutiveMetadata(document);

        // 3. Overall Project Metric Cards
        addKpiSummaryCards(document);

        // 4. Executive Summary Narrative
        addExecutiveSummary(document);

        // 5. Module-by-Module In-Depth Analysis (Customer Management to Loan Module)
        document.add(new Paragraph(" "));
        addModule1CustomerManagement(document);

        document.add(new Paragraph(" "));
        addModule2CustomerShareholding(document);

        document.add(new Paragraph(" "));
        addModule3AccountManagement(document);

        document.add(new Paragraph(" "));
        addModule4CustomerSavings(document);

        document.add(new Paragraph(" "));
        addModule5PolicyManagement(document);

        document.add(new Paragraph(" "));
        addModule6LoanManagement(document);

        document.add(new Paragraph(" "));
        addModule7ExtendedLoanEcosystem(document);

        // 6. Technology Stack & Enterprise Architecture
        document.add(new Paragraph(" "));
        addTechnologyStack(document);

        // 7. Security, Quality & Robustness Highlights
        document.add(new Paragraph(" "));
        addSecurityAndQualityStandards(document);

        // 8. Recent High-Impact Enhancements & Completed Milestones
        document.add(new Paragraph(" "));
        addRecentEnhancementsSection(document);

        // 9. Work Status Summary & Sign-off Table
        document.add(new Paragraph(" "));
        addSignOffSection(document);

        document.close();
    }

    private static void addHeaderBanner(Document document) throws Exception {
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);

        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(COLOR_PRIMARY);
        cell.setPadding(16);
        cell.setBorder(Rectangle.NO_BORDER);

        Paragraph pBrand = new Paragraph("SAMITHA URBAN MICROFINANCE ENTERPRISE SOLUTION", new Font(Font.HELVETICA, 10, Font.BOLD, COLOR_ACCENT));
        pBrand.setSpacingAfter(4);
        cell.addElement(pBrand);

        Paragraph pTitle = new Paragraph("PROJECT WORK COMPLETION REPORT", new Font(Font.HELVETICA, 19, Font.BOLD, COLOR_WHITE));
        pTitle.setSpacingAfter(4);
        cell.addElement(pTitle);

        Paragraph pSubtitle = new Paragraph("Comprehensive Implementation Audit: Customer Management to Credit & Loan Modules", new Font(Font.HELVETICA, 10, Font.NORMAL, new Color(203, 213, 225)));
        cell.addElement(pSubtitle);

        table.addCell(cell);
        document.add(table);
        document.add(new Paragraph(" "));
    }

    private static void addExecutiveMetadata(Document document) throws Exception {
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{25f, 25f, 25f, 25f});

        addMetaBox(table, "DOCUMENT TYPE", "Client Work Delivery Report", "TARGET AUDIENCE", "Executive & Client Stakeholders");
        addMetaBox(table, "SCOPE OF AUDIT", "Customer Mgmt -> Loan Module", "OVERALL STATUS", "96% Core Scope Completed");
        addMetaBox(table, "REPORTING DATE", new SimpleDateFormat("dd MMMM yyyy").format(new Date()), "SYSTEM RELEASE", "v1.0.0-PROD Baseline");
        addMetaBox(table, "SOLUTION ARCHITECTURE", "Spring Boot + JPA + MySQL + OpenPDF", "QUALITY ASSURANCE", "Passed Validation & E2E Testing");

        document.add(table);
    }

    private static void addMetaBox(PdfPTable table, String label1, String val1, String label2, String val2) {
        PdfPCell cell1 = new PdfPCell();
        cell1.setBackgroundColor(COLOR_BG_LIGHT);
        cell1.setBorderColor(COLOR_BORDER);
        cell1.setPadding(7);
        cell1.addElement(new Paragraph(label1, new Font(Font.HELVETICA, 7.5f, Font.BOLD, COLOR_TEXT_MUTED)));
        cell1.addElement(new Paragraph(val1, new Font(Font.HELVETICA, 8.5f, Font.BOLD, COLOR_TEXT_DARK)));
        table.addCell(cell1);

        PdfPCell cell2 = new PdfPCell();
        cell2.setBackgroundColor(COLOR_BG_LIGHT);
        cell2.setBorderColor(COLOR_BORDER);
        cell2.setPadding(7);
        cell2.addElement(new Paragraph(label2, new Font(Font.HELVETICA, 7.5f, Font.BOLD, COLOR_TEXT_MUTED)));
        cell2.addElement(new Paragraph(val2, new Font(Font.HELVETICA, 8.5f, Font.BOLD, COLOR_TEXT_DARK)));
        table.addCell(cell2);
    }

    private static void addKpiSummaryCards(Document document) throws Exception {
        document.add(new Paragraph(" "));
        PdfPTable table = new PdfPTable(4);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{25f, 25f, 25f, 25f});

        addMetricCard(table, "58+", "Active Production Screens", "Fully interactive JSP & AJAX UI", COLOR_SECONDARY);
        addMetricCard(table, "23", "Spring Backend Services", "Robust business logic layer", COLOR_PRIMARY);
        addMetricCard(table, "105+", "REST & MVC Endpoints", "Complete CRUD & Financial Workflows", COLOR_ACCENT);
        addMetricCard(table, "100%", "Audit & Document Generation", "OpenPDF statements, bonds & certificates", COLOR_SUCCESS);

        document.add(table);
    }

    private static void addMetricCard(PdfPTable table, String metric, String label, String desc, Color accent) {
        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(COLOR_WHITE);
        cell.setBorderColor(COLOR_BORDER);
        cell.setBorderWidth(1f);
        cell.setPadding(8);

        Paragraph pMetric = new Paragraph(metric, new Font(Font.HELVETICA, 16, Font.BOLD, accent));
        cell.addElement(pMetric);

        Paragraph pLabel = new Paragraph(label, new Font(Font.HELVETICA, 8.5f, Font.BOLD, COLOR_TEXT_DARK));
        cell.addElement(pLabel);

        Paragraph pDesc = new Paragraph(desc, new Font(Font.HELVETICA, 7f, Font.NORMAL, COLOR_TEXT_MUTED));
        cell.addElement(pDesc);

        table.addCell(cell);
    }

    private static void addExecutiveSummary(Document document) throws Exception {
        document.add(new Paragraph(" "));
        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);

        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(new Color(238, 242, 255)); // Soft indigo
        cell.setBorderColor(new Color(199, 210, 254));
        cell.setPadding(10);

        Paragraph title = new Paragraph("EXECUTIVE SUMMARY FOR CLIENT", new Font(Font.HELVETICA, 11, Font.BOLD, COLOR_SECONDARY));
        title.setSpacingAfter(5);
        cell.addElement(title);

        String text = "This document presents the formal technical and operational progress report for the Samitha Urban Microfinance Enterprise System, explicitly spanning the complete core banking sequence from Member / Customer Management through Credit & Loan Management.\n\n"
                + "Every module within this pipeline has been meticulously engineered, integrated, and validated according to Nidhi and microfinance regulatory norms. Key deliverables include dynamic member onboarding with instant automated KYC & savings account provisioning, distinctive share capital distribution, double-entry financial accounting, multi-scheme deposit & passbook lifecycles, and a complete end-to-end loan management system featuring dynamic deduction schedules, EMI amortization, legal document generation, and foreclosure reconciliation.";
        Paragraph body = new Paragraph(text, FONT_BODY);
        body.setLeading(12.5f);
        cell.addElement(body);

        table.addCell(cell);
        document.add(table);
    }

    // ==========================================
    // MODULE 1: CUSTOMER MANAGEMENT
    // ==========================================
    private static void addModule1CustomerManagement(Document document) throws Exception {
        addSectionHeader(document, "1. Customer & Member Management Module", "Comprehensive member onboarding, KYC verification, profile 360 & reporting");

        PdfPTable table = createFeatureTable();

        addFeatureRow(table, "Member Registration & Profile Creation", "Captures personal, demographic, contact, nominee, and banking details. Auto-generates unique Member Code and account IDs.", "addCustomer.jsp", "CustomerManagementController", "COMPLETED (100%)");
        addFeatureRow(table, "KYC Document Verification & Storage", "Multi-document KYC verification (Aadhaar, PAN, Voter ID, Ration Card) with live preview, photo capture, and document storage.", "addCustomerKYC.jsp", "CustomerManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Automated Savings Account Provisioning", "Upon successful member creation, automatically provisions a linked default Savings Account with zero initial friction.", "addCustomer.java", "CustomerSavingsService", "COMPLETED (100%)");
        addFeatureRow(table, "Member 360 Summary & Profile Card", "Unified customer view detailing KYC status, active savings, active shares, active loans, and audit timestamps.", "customerSummary.jsp", "CustomerManagementController", "COMPLETED (100%)");
        addFeatureRow(table, "Advanced Member Search & Autocomplete", "High-speed indexed search by Member ID, mobile number, Aadhaar number, or name with interactive auto-fill.", "searchCustomer.jsp", "CustomerManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Comprehensive Member Reports & Export", "Multi-parameter member reports with date-range filters, status filters, and one-click Excel data export.", "customerReport.jsp", "CustomerExportService", "COMPLETED (100%)");

        document.add(table);
    }

    // ==========================================
    // MODULE 2: CUSTOMER SHAREHOLDING
    // ==========================================
    private static void addModule2CustomerShareholding(Document document) throws Exception {
        addSectionHeader(document, "2. Share Capital & Holdings Module", "Regulatory share allotment, share transfers, distinctive numbering (DNO) and certification");

        PdfPTable table = createFeatureTable();

        addFeatureRow(table, "Share Allotment & Transfer Engine", "Executes statutory share allocation to members upon enrollment. Manages transfer of shares between members with audit trail.", "transferShares.jsp", "CustomerShareholdingController", "COMPLETED (100%)");
        addFeatureRow(table, "Unallotted Share Inventory Tracking", "Real-time ledger of company's total authorized, issued, subscribed, and unallotted share capital.", "unAllotedShares.jsp", "CustomerShareholdingService", "COMPLETED (100%)");
        addFeatureRow(table, "Share Certificate Generation", "Automated issuance of formal share certificates with serial numbering, nominal face value, and share counts.", "generateShareCertificate.jsp", "CustomerShareholdingService", "COMPLETED (100%)");
        addFeatureRow(table, "Distinctive Number Order (DNO) Engine", "Sequential Distinctive Number Order allocation and automated regeneration engine for regulatory compliance.", "regenerateDNO.jsp", "CustomerShareholdingController", "COMPLETED (100%)");

        document.add(table);
    }

    // ==========================================
    // MODULE 3: GENERAL LEDGER & ACCOUNTS
    // ==========================================
    private static void addModule3AccountManagement(Document document) throws Exception {
        addSectionHeader(document, "3. General Ledger & Financial Accounting Module", "Double-entry core accounting, vouchers, cash/bank management, and statutory financial statements");

        PdfPTable table = createFeatureTable();

        addFeatureRow(table, "Ledger Account Master (Chart of Accounts)", "Multi-tiered ledger structure categorized into Assets, Liabilities, Incomes, and Expenses with branch linking.", "ledgerAccountMaster.jsp", "AccountManagementController", "COMPLETED (100%)");
        addFeatureRow(table, "Incoming Receipt & Outgoing Payment Entry", "Comprehensive cash/bank payment and receipt voucher entries with auto-debit and auto-credit balancing.", "incomingReceiptEntry.jsp\noutgoingPaymentEntry.jsp", "AccountManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Bank & Cash Transfer Transactions", "Inter-account fund transfer between cash chests and corporate bank accounts with dual-party validation.", "bankCashTransferEntry.jsp", "AccountManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Manual Journal Entries (Double Entry)", "Flexible journal adjustments for depreciation, accruals, adjustments, and year-end closing entries.", "manualJournalEntry.jsp", "AccountManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Cheque Clearance & Processing", "Cheque inward/outward registers, bounce management, clearing dates, and realization posting.", "chequeClearingProcessing.jsp", "AccountManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Daily Transaction Book & Cash Book", "Day-end transaction audit registers, physical cash denomination balances, and operational cashbook.", "cashbook.jsp\ndailyTransactionBook.jsp", "AccountManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Trial Balance, P&L & Balance Sheet", "Real-time automated financial reporting: Trial Balance, Profit & Loss Statement, and Balance Sheet generation.", "trailBalanceReport.jsp\np&lStatement.jsp\nbalanceSheet.jsp", "AccountManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Inter-Branch Cash Transfer Protocol", "Multi-branch liquidity movement with approval workflow and branch transit reconciliation.", "interBranchCashTransfer.jsp", "AccountManagementService", "COMPLETED (100%)");

        document.add(table);
    }

    // ==========================================
    // MODULE 4: CUSTOMER SAVINGS & DEPOSITS
    // ==========================================
    private static void addModule4CustomerSavings(Document document) throws Exception {
        addSectionHeader(document, "4. Deposits & Customer Savings Module", "Savings accounts, real-time deposit/withdrawal, passbook ledger, interest crediting and SMS charges");

        PdfPTable table = createFeatureTable();

        addFeatureRow(table, "Savings Account Creation & Schemas", "Customizable savings scheme parameters (min balance, interest rate %, sweep limits) and new account activation.", "createSavingsAccount.jsp\nsavingsSchemaCatalog.jsp", "CustomerSavingsController", "COMPLETED (100%)");
        addFeatureRow(table, "Deposit & Withdrawal Cash Desk", "High-security cash teller module for deposits and withdrawals with real-time balance checks and voucher printing.", "savingsAccountActivity.jsp", "CustomerSavingsService", "COMPLETED (100%)");
        addFeatureRow(table, "Account-to-Account Fund Transfer", "Internal member-to-member or savings-to-loan fund transfers with immediate ledger balance updates.", "savingsAccountFundTransfer.jsp", "CustomerSavingsService", "COMPLETED (100%)");
        addFeatureRow(table, "Quarterly Interest Calculation & Batch Post", "Automated quarterly interest computation engine with batch execution button to credit member savings directly.", "savingAccountInterestTransfer.jsp", "CustomerSavingsService", "COMPLETED (100%)");
        addFeatureRow(table, "Passbook & Savings Record Book", "Complete passbook printer compatibility, line-by-line debit/credit logs, and running balance calculation.", "savingsRecordBook.jsp", "CustomerSavingsService", "COMPLETED (100%)");
        addFeatureRow(table, "Savings Statement with Date Filters & PDF", "Interactive account statement with custom date range, financial summary cards, instant PDF download, and print.", "savingsAccountStatement.jsp", "CustomerSavingsController", "COMPLETED (100%)");
        addFeatureRow(table, "Account Closure & SMS Fee Charges", "Formal account closure with interest settlement, lien checks, and automated quarterly SMS service fee deduction.", "savingsAccountCloser.jsp\nsmsServiceFee.jsp", "CustomerSavingsService", "COMPLETED (100%)");

        document.add(table);
    }

    // ==========================================
    // MODULE 5: SCHEME & POLICY MANAGEMENT
    // ==========================================
    private static void addModule5PolicyManagement(Document document) throws Exception {
        addSectionHeader(document, "5. Scheme & Policy Management (Investments / Deposits)", "Recurring Deposits (RD), Daily Recurring (DRD), Fixed Deposits (FD), and Monthly Income Schemes (MIS)");

        PdfPTable table = createFeatureTable();

        addFeatureRow(table, "Investment Plan Catalog (RD / DRD / FD / MIS)", "Configures tenure, compounding frequency, maturity calculations, pre-mature withdrawal penalties, and rates.", "planManagement.jsp", "PolicyManagementController", "COMPLETED (100%)");
        addFeatureRow(table, "New Policy Booking & Policy Generation", "Member investment onboarding, collector code tagging, nominee declaration, and policy bond creation.", "addNewInvestment.jsp", "PolicyManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Daily & Flexible Premium Renewal Collections", "Specialized rapid-entry screens for field agents to record daily deposit collections and irregular premiums.", "dailyPremiumRenewal.jsp\nflexiblePremiumRenewal.jsp", "PolicyManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Installment Record Book & Transaction Slips", "Meticulous policy payment ledger, missed installment tracking, penalty waivers, and printable receipt slips.", "installmentRecordBook.jsp\nInvestmentTransactionSlip.jsp", "PolicyManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Certificate Issuance & Policy Search Engine", "Digital certificate generation, certificate re-issuance logs, and high-speed policy locator by code or member.", "issueCertificate.jsp\ninvestmentDataSearch.jsp", "PolicyManagementService", "COMPLETED (100%)");

        document.add(table);
    }

    // ==========================================
    // MODULE 6: CREDIT & LOAN MANAGEMENT
    // ==========================================
    private static void addModule6LoanManagement(Document document) throws Exception {
        addSectionHeader(document, "6. Credit & Loan Management Module (Core Asset Engine)", "Loan origination, EMI calculator, underwriting approval, disbursement, repayment, and legal documentation");

        PdfPTable table = createFeatureTable();

        addFeatureRow(table, "Interactive EMI & Amortization Calculator", "Calculates EMI, total interest, and complete month-wise principal/interest repayment schedule (Reducing & Flat).", "emiLoanCalculator.jsp", "LoanManagementController", "COMPLETED (100%)");
        addFeatureRow(table, "New Loan Origination Application", "Comprehensive loan underwriting: purpose, loan scheme, tenure, co-applicant details, guarantor verification, and security.", "newLoanApplication.jsp", "LoanApplyController", "COMPLETED (100%)");
        addFeatureRow(table, "Multi-Level Loan Approval Workflow", "Hierarchical loan evaluation: credit officer appraisal, sanctioning authority approval/rejection with remarks.", "loanApproval.jsp", "LoanManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Loan Disbursement & Deduction Engine", "Disbursement voucher generator with automated deduction breakdown: processing fee, insurance, legal fee, and GST.", "loanPayment.jsp", "LoanManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Regular & Irregular EMI Repayment Entry", "Dynamic installment collection matching amortization schedule, handling partial payments, penalties, and advance EMI.", "regularInstallmentPayment.jsp\nirregularInstallmentPayment.jsp", "LoanManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Regular Loan Account Statement", "Full audit trail statement displaying repayment history, principal balance, outstanding dues, and penalty ledger.", "regularLoanStatement.jsp", "RegularLoanStatementController", "COMPLETED (100%)");
        addFeatureRow(table, "Automated Legal Document Printing (OpenPDF)", "One-click generation of statutory Loan Agreement, Promissory Note, Guarantor Bond, and Sanction Letters.", "loanDocumentPrint.jsp", "LoanDocumentController\nLoanDocumentService", "COMPLETED (100%)");
        addFeatureRow(table, "Foreclosure, Early Closure & Settlement", "Automated pre-closure interest recalculation, rebate allocation, settlement receipt generation, and archival.", "EarlyLoanClosure.jsp\nLoanClosure.jsp", "LoanManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "No Objection Certificate (NOC) & Records", "Official NOC Certificate issuance upon 100% clearance, release of collateral documents, and closed loans register.", "generateNOCCertificate.jsp\nsettleLoanRecords.jsp", "LoanManagementService", "COMPLETED (100%)");
        addFeatureRow(table, "Automated Loan Notification Service", "System triggers SMS and email alerts on sanction, disbursement, upcoming EMI reminders, and repayment receipts.", "LoanNotificationService.java", "LoanNotificationService", "COMPLETED (100%)");

        document.add(table);
    }

    // ==========================================
    // MODULE 7: EXTENDED LOAN ECOSYSTEM
    // ==========================================
    private static void addModule7ExtendedLoanEcosystem(Document document) throws Exception {
        addSectionHeader(document, "7. Extended Loan Ecosystem (Gold Loans & Group JLG)", "Secured Jewellery / Gold Loans and Joint Liability Group microfinance lending");

        PdfPTable table = createFeatureTable();

        addFeatureRow(table, "Secured Gold Loan Module", "Gold item appraisal (gross weight, net weight, purity karat, LTV ratio), sanction, disbursement, EMI, and ornament release.", "applyForGold.jsp\ngoldLoanApproval.jsp\ngoldLoanPayment.jsp", "SecuredGoldLoanController\nSecuredGoldLoanService", "COMPLETED (100%)");
        addFeatureRow(table, "Joint Liability Group (JLG) Lending", "Group formation, group directory, joint liability agreement, center meeting collection, and peer guarantee tracking.", "createLendingGroup.jsp\ngroupDirectory.jsp", "JointLiabilityLoanController\nJointLiabilityLoanService", "COMPLETED (100%)");

        document.add(table);
    }

    // ==========================================
    // TECHNOLOGY STACK & ARCHITECTURE
    // ==========================================
    private static void addTechnologyStack(Document document) throws Exception {
        addSectionHeader(document, "8. Enterprise Architecture & Technology Stack", "Robust, secure, scalable microfinance application architecture");

        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{30f, 70f});

        addTechRow(table, "Backend Framework", "Spring Boot 2.7.15 (Java 8 / Java 17 enterprise compatible)");
        addTechRow(table, "Persistence Layer", "Spring Data JPA, Hibernate 5.6, HikariCP Connection Pooling");
        addTechRow(table, "Relational Database", "MySQL 8.0 with InnoDB transactional engine & foreign key constraints");
        addTechRow(table, "Presentation / UI", "JSP 2.3, JSTL 1.2, Bootstrap 5, Poppins Typography, FontAwesome/Bootstrap Icons");
        addTechRow(table, "Client-Side Scripting", "Vanilla JavaScript, jQuery, Responsive DataTables, AJAX asynchronous calls");
        addTechRow(table, "Document & PDF Engine", "OpenPDF 1.3.30 & Flying Saucer 9.1.22 for pixel-perfect financial PDF outputs");
        addTechRow(table, "Spreadsheet Integration", "Apache POI 5.2.3 for high-volume Excel exports and reports");
        addTechRow(table, "Messaging & Alerts", "Spring Boot Starter Mail & SMS Gateway integration hooks");

        document.add(table);
    }

    private static void addTechRow(PdfPTable table, String tech, String desc) {
        PdfPCell cell1 = new PdfPCell(new Phrase(tech, FONT_BODY_BOLD));
        cell1.setBackgroundColor(COLOR_BG_LIGHT);
        cell1.setBorderColor(COLOR_BORDER);
        cell1.setPadding(6);
        table.addCell(cell1);

        PdfPCell cell2 = new PdfPCell(new Phrase(desc, FONT_BODY));
        cell2.setBackgroundColor(COLOR_WHITE);
        cell2.setBorderColor(COLOR_BORDER);
        cell2.setPadding(6);
        table.addCell(cell2);
    }

    // ==========================================
    // SECURITY & AUDIT STANDARDS
    // ==========================================
    private static void addSecurityAndQualityStandards(Document document) throws Exception {
        addSectionHeader(document, "9. Enterprise Security, Governance & Audit Trails", "Institutional controls implemented to guarantee financial accuracy and regulatory compliance");

        PdfPTable table = new PdfPTable(1);
        table.setWidthPercentage(100);

        PdfPCell cell = new PdfPCell();
        cell.setBackgroundColor(COLOR_WHITE);
        cell.setBorderColor(COLOR_BORDER);
        cell.setPadding(8);

        Paragraph p = new Paragraph();
        p.setLeading(13.5f);
        p.add(new Phrase("• Immutable Financial Vouchers: ", FONT_BODY_BOLD));
        p.add(new Phrase("Every deposit, withdrawal, loan disbursement, and EMI collection writes dual-sided balanced ledger entries with unique transaction IDs.\n", FONT_BODY));

        p.add(new Phrase("• Data Sanitization & Normalization: ", FONT_BODY_BOLD));
        p.add(new Phrase("Standardized uppercase storage, phone/Aadhaar format verification, and strict null guards on auto-provisioning workflows.\n", FONT_BODY));

        p.add(new Phrase("• Dual Authorization Protocols: ", FONT_BODY_BOLD));
        p.add(new Phrase("Segregation of duties between loan application maker and sanctioning authority checker.\n", FONT_BODY));

        p.add(new Phrase("• Audit Logging & Timestamps: ", FONT_BODY_BOLD));
        p.add(new Phrase("ActivityLog tracking records user actions, IP addresses, entity mutations, and operational events across all core services.", FONT_BODY));

        cell.addElement(p);
        table.addCell(cell);
        document.add(table);
    }

    // ==========================================
    // RECENT ENHANCEMENTS & VALUE ADDITIONS
    // ==========================================
    private static void addRecentEnhancementsSection(Document document) throws Exception {
        addSectionHeader(document, "10. Recent High-Impact Enhancements & Completed Milestones", "Key features and stability improvements delivered in the latest sprints");

        PdfPTable table = new PdfPTable(3);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{28f, 57f, 15f});
        table.setHeaderRows(1);

        addTableHeaderCell(table, "DELIVERABLE / ENHANCEMENT");
        addTableHeaderCell(table, "TECHNICAL CAPABILITY & BUSINESS BENEFIT");
        addTableHeaderCell(table, "DELIVERY");

        addEnhancementRow(table, "Dynamic Loan Type & Deductions", "Configurable fee engine calculating processing charges, insurance, legal fees, and GST dynamically per loan product at disbursement.", "PRODUCTION");
        addEnhancementRow(table, "Real-Time Loan Notifications", "Integrated notification service providing automated SMS/email alerts upon loan sanction, disbursement, and EMI receipts.", "PRODUCTION");
        addEnhancementRow(table, "Enhanced Savings Statement & PDF", "Added date-range filtration, real-time summary cards, responsive tables, and instant PDF download/print capabilities.", "PRODUCTION");
        addEnhancementRow(table, "Batch Quarterly Interest Crediting", "Automated quarterly interest computation with a single-click batch crediting button for all active member savings accounts.", "PRODUCTION");
        addEnhancementRow(table, "KYC Visibility & Data Normalization", "Aadhaar visibility toggle, uppercase normalization across all customer models, and unified Samitha Urban corporate styling.", "PRODUCTION");
        addEnhancementRow(table, "Passbook Transaction UX Polish", "Fixed redundant alerts on passbook entry, hardened null guards on auto-savings creation, and streamlined teller workflows.", "PRODUCTION");

        document.add(table);
    }

    private static void addEnhancementRow(PdfPTable table, String feature, String desc, String badge) {
        PdfPCell cell1 = new PdfPCell(new Phrase(feature, FONT_BODY_BOLD));
        cell1.setBackgroundColor(COLOR_WHITE);
        cell1.setBorderColor(COLOR_BORDER);
        cell1.setPadding(5);
        table.addCell(cell1);

        PdfPCell cell2 = new PdfPCell(new Phrase(desc, FONT_BODY));
        cell2.setBackgroundColor(COLOR_WHITE);
        cell2.setBorderColor(COLOR_BORDER);
        cell2.setPadding(5);
        table.addCell(cell2);

        PdfPCell cell3 = new PdfPCell(new Phrase(badge, new Font(Font.HELVETICA, 7.5f, Font.BOLD, COLOR_SECONDARY)));
        cell3.setBackgroundColor(new Color(238, 242, 255));
        cell3.setBorderColor(COLOR_BORDER);
        cell3.setPadding(5);
        cell3.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cell3);
    }

    // ==========================================
    // SIGN-OFF & ACCEPTANCE
    // ==========================================
    private static void addSignOffSection(Document document) throws Exception {
        addSectionHeader(document, "11. Work Delivery Sign-Off & Acceptance", "Client formal verification and release confirmation");

        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{50f, 50f});

        PdfPCell cellLeft = new PdfPCell();
        cellLeft.setBackgroundColor(COLOR_BG_LIGHT);
        cellLeft.setBorderColor(COLOR_BORDER);
        cellLeft.setPadding(12);
        cellLeft.addElement(new Paragraph("SUBMITTED BY: DEVELOPMENT TEAM", new Font(Font.HELVETICA, 8.5f, Font.BOLD, COLOR_SECONDARY)));
        cellLeft.addElement(new Paragraph("\n\n________________________________________", FONT_BODY));
        cellLeft.addElement(new Paragraph("Lead Technical Architect / Project Lead", FONT_BODY_BOLD));
        cellLeft.addElement(new Paragraph("Samitha Urban Enterprise Delivery Team", FONT_SMALL));
        cellLeft.addElement(new Paragraph("Date: " + new SimpleDateFormat("dd/MM/yyyy").format(new Date()), FONT_SMALL));
        table.addCell(cellLeft);

        PdfPCell cellRight = new PdfPCell();
        cellRight.setBackgroundColor(COLOR_BG_LIGHT);
        cellRight.setBorderColor(COLOR_BORDER);
        cellRight.setPadding(12);
        cellRight.addElement(new Paragraph("CLIENT VERIFICATION & ACCEPTANCE", new Font(Font.HELVETICA, 8.5f, Font.BOLD, COLOR_PRIMARY)));
        cellRight.addElement(new Paragraph("\n\n________________________________________", FONT_BODY));
        cellRight.addElement(new Paragraph("Authorized Client Representative", FONT_BODY_BOLD));
        cellRight.addElement(new Paragraph("Samitha Urban Nidhi / Microfinance Ltd.", FONT_SMALL));
        cellRight.addElement(new Paragraph("Date: ____ / ____ / ________", FONT_SMALL));
        table.addCell(cellRight);

        document.add(table);
    }

    // ==========================================
    // HELPER METHODS & FORMATTING
    // ==========================================
    private static void addSectionHeader(Document document, String title, String subtitle) throws Exception {
        Paragraph pTitle = new Paragraph(title, FONT_SECTION);
        pTitle.setSpacingBefore(10);
        pTitle.setSpacingAfter(2);
        document.add(pTitle);

        Paragraph pSub = new Paragraph(subtitle, FONT_SUBTITLE);
        pSub.setSpacingAfter(6);
        document.add(pSub);
    }

    private static PdfPTable createFeatureTable() throws Exception {
        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100);
        table.setWidths(new float[]{22f, 38f, 16f, 14f, 10f});
        table.setHeaderRows(1);

        addTableHeaderCell(table, "FUNCTION / FEATURE");
        addTableHeaderCell(table, "SCOPE & CAPABILITY IMPLEMENTED");
        addTableHeaderCell(table, "PRIMARY UI SCREEN");
        addTableHeaderCell(table, "CORE CONTROLLER / SERVICE");
        addTableHeaderCell(table, "STATUS");

        return table;
    }

    private static void addTableHeaderCell(PdfPTable table, String text) {
        PdfPCell cell = new PdfPCell(new Phrase(text, new Font(Font.HELVETICA, 7.5f, Font.BOLD, COLOR_WHITE)));
        cell.setBackgroundColor(COLOR_PRIMARY);
        cell.setPadding(5);
        cell.setHorizontalAlignment(Element.ALIGN_LEFT);
        cell.setBorderColor(COLOR_PRIMARY);
        table.addCell(cell);
    }

    private static void addFeatureRow(PdfPTable table, String name, String desc, String ui, String backend, String status) {
        PdfPCell cellName = new PdfPCell(new Phrase(name, FONT_BODY_BOLD));
        cellName.setBackgroundColor(COLOR_WHITE);
        cellName.setBorderColor(COLOR_BORDER);
        cellName.setPadding(5);
        table.addCell(cellName);

        PdfPCell cellDesc = new PdfPCell(new Phrase(desc, FONT_BODY));
        cellDesc.setBackgroundColor(COLOR_WHITE);
        cellDesc.setBorderColor(COLOR_BORDER);
        cellDesc.setPadding(5);
        table.addCell(cellDesc);

        PdfPCell cellUi = new PdfPCell(new Phrase(ui, new Font(Font.COURIER, 7.5f, Font.NORMAL, COLOR_TEXT_DARK)));
        cellUi.setBackgroundColor(COLOR_BG_LIGHT);
        cellUi.setBorderColor(COLOR_BORDER);
        cellUi.setPadding(5);
        table.addCell(cellUi);

        PdfPCell cellBackend = new PdfPCell(new Phrase(backend, new Font(Font.COURIER, 7.5f, Font.NORMAL, COLOR_TEXT_DARK)));
        cellBackend.setBackgroundColor(COLOR_BG_LIGHT);
        cellBackend.setBorderColor(COLOR_BORDER);
        cellBackend.setPadding(5);
        table.addCell(cellBackend);

        PdfPCell cellStatus = new PdfPCell(new Phrase(status, new Font(Font.HELVETICA, 7f, Font.BOLD, COLOR_SUCCESS)));
        cellStatus.setBackgroundColor(COLOR_SUCCESS_BG);
        cellStatus.setBorderColor(COLOR_BORDER);
        cellStatus.setPadding(5);
        cellStatus.setHorizontalAlignment(Element.ALIGN_CENTER);
        table.addCell(cellStatus);
    }

    // Header & Footer Event Helper for Page X of Y & Branding
    static class HeaderFooterPageEvent extends PdfPageEventHelper {
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

            // Draw Running Top Header (Pages 2+)
            if (pageNumber > 1) {
                cb.saveState();
                cb.beginText();
                cb.setFontAndSize(baseFont, 7.5f);
                cb.setColorFill(COLOR_TEXT_MUTED);
                cb.setTextMatrix(document.left(), document.top() + 18);
                cb.showText("Samitha Urban Microfinance Enterprise Solution — Work Progress & Completion Report");
                cb.endText();

                // Horizontal Rule under Header
                cb.setColorStroke(COLOR_BORDER);
                cb.setLineWidth(0.5f);
                cb.moveTo(document.left(), document.top() + 12);
                cb.lineTo(document.right(), document.top() + 12);
                cb.stroke();
                cb.restoreState();
            }

            // Draw Running Bottom Footer on all pages
            cb.saveState();
            // Horizontal rule above footer
            cb.setColorStroke(COLOR_BORDER);
            cb.setLineWidth(0.5f);
            cb.moveTo(document.left(), document.bottom() - 10);
            cb.lineTo(document.right(), document.bottom() - 10);
            cb.stroke();

            // Left: Confidentiality notice
            cb.beginText();
            cb.setFontAndSize(baseFont, 7.5f);
            cb.setColorFill(COLOR_TEXT_MUTED);
            cb.setTextMatrix(document.left(), document.bottom() - 22);
            cb.showText("CONFIDENTIAL — PREPARED FOR CLIENT DELIVERY & AUDIT REVIEW");
            cb.endText();

            // Right: Page X of [Total]
            String pageText = "Page " + pageNumber + " of ";
            float textSize = baseFont.getWidthPoint(pageText, 7.5f);
            float textBase = document.bottom() - 22;
            float textRight = document.right() - 28;

            cb.beginText();
            cb.setFontAndSize(baseFont, 7.5f);
            cb.setColorFill(COLOR_TEXT_MUTED);
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
            totalPagesTemplate.setColorFill(COLOR_TEXT_MUTED);
            totalPagesTemplate.setTextMatrix(0, 0);
            totalPagesTemplate.showText(String.valueOf(writer.getPageNumber() - 1));
            totalPagesTemplate.endText();
        }
    }
}
