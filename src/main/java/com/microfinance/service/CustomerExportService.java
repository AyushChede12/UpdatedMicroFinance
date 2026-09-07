package com.microfinance.service;

import java.awt.*;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.math.BigInteger;
import java.util.List;

import org.apache.poi.util.Units;
import org.apache.poi.xwpf.usermodel.*;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.lowagie.text.Document;
import com.lowagie.text.DocumentException;
import com.lowagie.text.Element;
import com.lowagie.text.Font;
import com.lowagie.text.Image;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;

import com.microfinance.model.CompanyAdministration;
import com.microfinance.model.CreateSavingsAccount;
import com.microfinance.model.addCustomer;

import com.microfinance.repository.CustomerRepo;
import com.microfinance.repository.CreateSavingAccountRepo;

@Service
public class CustomerExportService {

    @Autowired
    private CustomerRepo customerRepo;

    @Autowired
    private CreateSavingAccountRepo createSavingAccountRepo;

    // Fetch company details from preference service.
    @Autowired
    private PreferenceService preferenceService;

    @Value("${upload.directory}")
    private String uploadDirectory;


    // =========================================================
    // PDF
    // =========================================================

    public byte[] generatePdf(Long customerId) throws Exception {

        addCustomer customer = customerRepo.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        String accountNumber = getAccountNumber(customer);

        CompanyAdministration company = getCompanyDetails();

        ByteArrayOutputStream outputStream =
                new ByteArrayOutputStream();

        Document document =
                new Document(PageSize.A4, 30, 30, 30, 30);

        PdfWriter.getInstance(document, outputStream);

        document.open();


        // Fonts.
        Font companyFont =
                new Font(Font.HELVETICA, 18, Font.BOLD);

        Font titleFont =
                new Font(Font.HELVETICA, 12, Font.BOLD);

        Font sectionFont =
                new Font(Font.HELVETICA, 11, Font.BOLD);

        Font normalFont =
                new Font(Font.HELVETICA, 9, Font.NORMAL);

        Font boldFont =
                new Font(Font.HELVETICA, 9, Font.BOLD);


        // Company header.
        Paragraph companyName = new Paragraph(
                value(getCompanyName(company)),
                companyFont
        );

        companyName.setAlignment(Element.ALIGN_CENTER);
        document.add(companyName);


        Paragraph reportTitle = new Paragraph(
                "CUSTOMER COMPREHENSIVE PROFILE REPORT",
                titleFont
        );

        reportTitle.setAlignment(Element.ALIGN_CENTER);
        document.add(reportTitle);


        String address = buildCompanyAddress(company);

        if (!address.isEmpty()) {

            Paragraph addressParagraph =
                    new Paragraph(address, normalFont);

            addressParagraph.setAlignment(Element.ALIGN_CENTER);

            document.add(addressParagraph);
        }


        String contact = buildCompanyContact(company);

        if (!contact.isEmpty()) {

            Paragraph contactParagraph =
                    new Paragraph(contact, normalFont);

            contactParagraph.setAlignment(Element.ALIGN_CENTER);

            document.add(contactParagraph);
        }


        document.add(new Paragraph(" "));


        // Customer information.
        addPdfSection(
                document,
                "CUSTOMER INFORMATION",
                sectionFont
        );

        PdfPTable customerTable =
                createPdfDataTable();


        addPdfRow(
                customerTable,
                "CUSTOMER NAME",
                getFullName(customer)
        );

        addPdfRow(
                customerTable,
                "CUSTOMER CODE",
                customer.getMemberCode()
        );

        addPdfRow(
                customerTable,
                "ACCOUNT NUMBER",
                accountNumber
        );

        addPdfRow(
                customerTable,
                "JOINED ON",
                customer.getSignupDate()
        );

        addPdfRow(
                customerTable,
                "FIRST NAME",
                customer.getFirstName()
        );

        addPdfRow(
                customerTable,
                "MIDDLE NAME",
                customer.getMiddleName()
        );

        addPdfRow(
                customerTable,
                "LAST NAME",
                customer.getLastName()
        );

        addPdfRow(
                customerTable,
                "MEMBER TYPE",
                customer.getMemberType()
        );

        addPdfRow(
                customerTable,
                "GENDER",
                customer.getCustomerGender()
        );

        addPdfRow(
                customerTable,
                "DATE OF BIRTH",
                customer.getDob()
        );

        addPdfRow(
                customerTable,
                "AGE",
                customer.getCustomerAge()
        );

        addPdfRow(
                customerTable,
                "RELATIONSHIP STATUS",
                customer.getRelationshipStatus()
        );

        addPdfRow(
                customerTable,
                "RELATIVE / GUARDIAN NAME",
                customer.getGuardianName()
        );

        addPdfRow(
                customerTable,
                "GUARDIAN ACCOUNT NUMBER",
                customer.getGuardianAccountNo()
        );

        document.add(customerTable);


        // Contact information.
        addPdfSection(
                document,
                "CONTACT INFORMATION",
                sectionFont
        );

        PdfPTable contactTable =
                createPdfDataTable();

        addPdfRow(
                contactTable,
                "ADDRESS",
                customer.getCustomerAddress()
        );

        addPdfRow(
                contactTable,
                "PINCODE",
                customer.getPinCode()
        );

        addPdfRow(
                contactTable,
                "STATE",
                customer.getState()
        );

        addPdfRow(
                contactTable,
                "DISTRICT",
                customer.getDistrict()
        );

        addPdfRow(
                contactTable,
                "BRANCH",
                customer.getBranchName()
        );

        addPdfRow(
                contactTable,
                "CONTACT NUMBER",
                customer.getContactNo()
        );

        addPdfRow(
                contactTable,
                "EMAIL",
                customer.getEmailId()
        );

        document.add(contactTable);


        // KYC details.
        addPdfSection(
                document,
                "KYC DETAILS",
                sectionFont
        );

        PdfPTable kycTable =
                createPdfDataTable();

        addPdfRow(
                kycTable,
                "AADHAR NUMBER",
                customer.getAadharNo()
        );

        addPdfRow(
                kycTable,
                "PAN NUMBER",
                customer.getPanNo()
        );

        addPdfRow(
                kycTable,
                "VOTER NUMBER",
                customer.getVoterNo()
        );

        addPdfRow(
                kycTable,
                "DRIVING LICENCE NUMBER",
                customer.getDrivingLicenceNo()
        );

        document.add(kycTable);


        // Professional information.
        addPdfSection(
                document,
                "PROFESSIONAL INFORMATION",
                sectionFont
        );

        PdfPTable professionalTable =
                createPdfDataTable();

        addPdfRow(
                professionalTable,
                "PROFESSION",
                customer.getProfession()
        );

        addPdfRow(
                professionalTable,
                "OCCUPATION",
                customer.getOccupation()
        );

        addPdfRow(
                professionalTable,
                "EDUCATION",
                customer.getEducation()
        );

        addPdfRow(
                professionalTable,
                "MONTHLY INCOME",
                customer.getMonthlyIncome()
        );

        document.add(professionalTable);


        // Nominee details.
        addPdfSection(
                document,
                "NOMINEE DETAILS",
                sectionFont
        );

        PdfPTable nomineeTable =
                createPdfDataTable();

        addPdfRow(
                nomineeTable,
                "NOMINEE NAME",
                customer.getNomineeName()
        );

        addPdfRow(
                nomineeTable,
                "NOMINEE RELATION",
                customer.getNomineeRelationToApplicant()
        );

        addPdfRow(
                nomineeTable,
                "NOMINEE AGE",
                customer.getNomineeAge()
        );

        addPdfRow(
                nomineeTable,
                "NOMINEE DOB",
                customer.getNomineeDOB()
        );

        addPdfRow(
                nomineeTable,
                "NOMINEE ADDRESS",
                customer.getNomineeAddress()
        );

        addPdfRow(
                nomineeTable,
                "NOMINEE MOBILE",
                customer.getNomineeMobileNo()
        );

        addPdfRow(
                nomineeTable,
                "NOMINEE PAN",
                customer.getNomineePanNo()
        );

        addPdfRow(
                nomineeTable,
                "NOMINEE KYC NUMBER",
                customer.getNomineeKycNo()
        );

        addPdfRow(
                nomineeTable,
                "NOMINEE KYC TYPE",
                customer.getNomineeKycType()
        );

        document.add(nomineeTable);


        // Other customer details.
        addPdfSection(
                document,
                "OTHER CUSTOMER DETAILS",
                sectionFont
        );

        PdfPTable otherTable =
                createPdfDataTable();

        addPdfRow(otherTable, "CATEGORY",
                customer.getCategory());

        addPdfRow(otherTable, "CASTE",
                customer.getCaste());

        addPdfRow(otherTable, "REFERRAL CODE",
                customer.getReferralCode());

        addPdfRow(otherTable, "REFERRAL NAME",
                customer.getReferralName());

        addPdfRow(otherTable, "SHARE AMOUNT",
                customer.getShareAmount());

        addPdfRow(otherTable, "NUMBER OF SHARES",
                customer.getNoOfShare());

        addPdfRow(otherTable, "SHARE VALUE",
                customer.getShareValue());

        addPdfRow(otherTable, "LIGHT BILL",
                customer.getLightBill());

        addPdfRow(otherTable, "TAX BILL",
                customer.getTaxBill());

        addPdfRow(otherTable, "INTEREST PERCENT",
                customer.getInterestPercent());

        addPdfRow(otherTable, "MEMBER FEES",
                customer.getMemberFees());

        addPdfRow(otherTable, "BUILDING FUND",
                customer.getBuildingFund());

        addPdfRow(otherTable, "ADMIN CHARGE",
                customer.getAdminCharge());

        addPdfRow(otherTable, "DOCUMENT CHARGE",
                customer.getDocumentCharge());

        addPdfRow(otherTable, "OTHER CHARGE",
                customer.getOtherCharge());


        addPdfRow(otherTable, "PAYMENT BY",
                customer.getPaymentBy());

        addPdfRow(otherTable, "REMARKS",
                customer.getRemarks());

        document.add(otherTable);


        // =====================================================
        // CUSTOMER PHOTO + CUSTOMER SIGNATURE
        // SIDE BY SIDE
        // =====================================================

        document.add(new Paragraph(" "));

        PdfPTable mediaTable =
                new PdfPTable(2);

        mediaTable.setWidthPercentage(100);

        mediaTable.setWidths(
                new float[]{1f, 1f}
        );


        // -----------------------------------------------------
        // CUSTOMER PHOTO - LEFT
        // -----------------------------------------------------

        PdfPCell photoCell =
                new PdfPCell();

        photoCell.setBorder(PdfPCell.NO_BORDER);
        photoCell.setHorizontalAlignment(
                Element.ALIGN_LEFT
        );
        photoCell.setVerticalAlignment(
                Element.ALIGN_MIDDLE
        );

        Image photo =
                getImage(customer.getCustomerPhoto());

        if (photo != null) {

            photo.scaleToFit(100, 100);
            photo.setAlignment(Element.ALIGN_LEFT);

            photoCell.addElement(photo);

        } else {

            Paragraph noPhoto =
                    new Paragraph(
                            "PHOTO NOT AVAILABLE",
                            normalFont
                    );

            noPhoto.setAlignment(Element.ALIGN_LEFT);

            photoCell.addElement(noPhoto);
        }


        Paragraph photoLabel =
                new Paragraph(
                        "CUSTOMER PHOTO",
                        boldFont
                );

        photoLabel.setAlignment(
                Element.ALIGN_LEFT
        );

        photoCell.addElement(photoLabel);

        mediaTable.addCell(photoCell);


        // -----------------------------------------------------
        // CUSTOMER SIGNATURE - RIGHT
        // -----------------------------------------------------

        PdfPCell signatureCell =
                new PdfPCell();

        signatureCell.setBorder(PdfPCell.NO_BORDER);
        signatureCell.setHorizontalAlignment(
                Element.ALIGN_RIGHT
        );
        signatureCell.setVerticalAlignment(
                Element.ALIGN_MIDDLE
        );


        Image signature =
                getImage(customer.getCustomerSignature());

        if (signature != null) {

            signature.scaleToFit(120, 50);
            signature.setAlignment(Element.ALIGN_RIGHT);

            signatureCell.addElement(signature);

        } else {

            Paragraph noSignature =
                    new Paragraph(
                            "SIGNATURE NOT AVAILABLE",
                            normalFont
                    );

            noSignature.setAlignment(
                    Element.ALIGN_RIGHT
            );

            signatureCell.addElement(noSignature);
        }


        Paragraph signatureLabel =
                new Paragraph(
                        "CUSTOMER SIGNATURE",
                        boldFont
                );

        signatureLabel.setAlignment(
                Element.ALIGN_RIGHT
        );

        signatureCell.addElement(signatureLabel);

        mediaTable.addCell(signatureCell);


        document.add(mediaTable);


        document.close();

        return outputStream.toByteArray();
    }


    // =========================================================
    // WORD
    // =========================================================

    public byte[] generateWord(Long customerId) throws Exception {

        addCustomer customer = customerRepo.findById(customerId)
                .orElseThrow(() -> new RuntimeException("Customer not found"));

        String accountNumber =
                getAccountNumber(customer);

        CompanyAdministration company =
                getCompanyDetails();

        XWPFDocument document =
                new XWPFDocument();


        // Company header.
        XWPFParagraph companyParagraph =
                document.createParagraph();

        companyParagraph.setAlignment(
                ParagraphAlignment.CENTER
        );

        XWPFRun companyRun =
                companyParagraph.createRun();

        companyRun.setBold(true);
        companyRun.setFontSize(18);

        companyRun.setText(
                value(getCompanyName(company))
        );


        XWPFParagraph reportParagraph =
                document.createParagraph();

        reportParagraph.setAlignment(
                ParagraphAlignment.CENTER
        );

        XWPFRun reportRun =
                reportParagraph.createRun();

        reportRun.setBold(true);
        reportRun.setFontSize(12);

        reportRun.setText(
                "CUSTOMER COMPREHENSIVE PROFILE REPORT"
        );


        String address =
                buildCompanyAddress(company);

        if (!address.isEmpty()) {

            XWPFParagraph addressParagraph =
                    document.createParagraph();

            addressParagraph.setAlignment(
                    ParagraphAlignment.CENTER
            );

            XWPFRun addressRun =
                    addressParagraph.createRun();

            addressRun.setFontSize(9);
            addressRun.setText(address);
        }


        String contact =
                buildCompanyContact(company);

        if (!contact.isEmpty()) {

            XWPFParagraph contactParagraph =
                    document.createParagraph();

            contactParagraph.setAlignment(
                    ParagraphAlignment.CENTER
            );

            XWPFRun contactRun =
                    contactParagraph.createRun();

            contactRun.setFontSize(9);
            contactRun.setText(contact);
        }


        document.createParagraph();


        // Customer information.
        addWordSection(
                document,
                "CUSTOMER INFORMATION"
        );

        XWPFTable customerTable =
                document.createTable();


        addWordRow(
                customerTable,
                "CUSTOMER NAME",
                getFullName(customer)
        );

        addWordRow(
                customerTable,
                "CUSTOMER CODE",
                customer.getMemberCode()
        );

        addWordRow(
                customerTable,
                "ACCOUNT NUMBER",
                accountNumber
        );

        addWordRow(
                customerTable,
                "JOINED ON",
                customer.getSignupDate()
        );

        addWordRow(
                customerTable,
                "FIRST NAME",
                customer.getFirstName()
        );

        addWordRow(
                customerTable,
                "MIDDLE NAME",
                customer.getMiddleName()
        );

        addWordRow(
                customerTable,
                "LAST NAME",
                customer.getLastName()
        );

        addWordRow(
                customerTable,
                "MEMBER TYPE",
                customer.getMemberType()
        );

        addWordRow(
                customerTable,
                "GENDER",
                customer.getCustomerGender()
        );

        addWordRow(
                customerTable,
                "DATE OF BIRTH",
                customer.getDob()
        );

        addWordRow(
                customerTable,
                "AGE",
                customer.getCustomerAge()
        );

        addWordRow(
                customerTable,
                "RELATIONSHIP STATUS",
                customer.getRelationshipStatus()
        );

        addWordRow(
                customerTable,
                "RELATIVE / GUARDIAN NAME",
                customer.getGuardianName()
        );

        addWordRow(
                customerTable,
                "GUARDIAN ACCOUNT NUMBER",
                customer.getGuardianAccountNo()
        );


        // Contact.
        addWordSection(
                document,
                "CONTACT INFORMATION"
        );

        XWPFTable contactTable =
                document.createTable();

        addWordRow(
                contactTable,
                "ADDRESS",
                customer.getCustomerAddress()
        );

        addWordRow(
                contactTable,
                "PINCODE",
                customer.getPinCode()
        );

        addWordRow(
                contactTable,
                "STATE",
                customer.getState()
        );

        addWordRow(
                contactTable,
                "DISTRICT",
                customer.getDistrict()
        );

        addWordRow(
                contactTable,
                "BRANCH",
                customer.getBranchName()
        );

        addWordRow(
                contactTable,
                "CONTACT NUMBER",
                customer.getContactNo()
        );

        addWordRow(
                contactTable,
                "EMAIL",
                customer.getEmailId()
        );


        // KYC.
        addWordSection(
                document,
                "KYC DETAILS"
        );

        XWPFTable kycTable =
                document.createTable();

        addWordRow(
                kycTable,
                "AADHAR NUMBER",
                customer.getAadharNo()
        );

        addWordRow(
                kycTable,
                "PAN NUMBER",
                customer.getPanNo()
        );

        addWordRow(
                kycTable,
                "VOTER NUMBER",
                customer.getVoterNo()
        );

        addWordRow(
                kycTable,
                "DRIVING LICENCE NUMBER",
                customer.getDrivingLicenceNo()
        );


        // Professional.
        addWordSection(
                document,
                "PROFESSIONAL INFORMATION"
        );

        XWPFTable professionalTable =
                document.createTable();

        addWordRow(
                professionalTable,
                "PROFESSION",
                customer.getProfession()
        );

        addWordRow(
                professionalTable,
                "OCCUPATION",
                customer.getOccupation()
        );

        addWordRow(
                professionalTable,
                "EDUCATION",
                customer.getEducation()
        );

        addWordRow(
                professionalTable,
                "MONTHLY INCOME",
                customer.getMonthlyIncome()
        );


        // Nominee.
        addWordSection(
                document,
                "NOMINEE DETAILS"
        );

        XWPFTable nomineeTable =
                document.createTable();

        addWordRow(
                nomineeTable,
                "NOMINEE NAME",
                customer.getNomineeName()
        );

        addWordRow(
                nomineeTable,
                "NOMINEE RELATION",
                customer.getNomineeRelationToApplicant()
        );

        addWordRow(
                nomineeTable,
                "NOMINEE AGE",
                customer.getNomineeAge()
        );

        addWordRow(
                nomineeTable,
                "NOMINEE DOB",
                customer.getNomineeDOB()
        );

        addWordRow(
                nomineeTable,
                "NOMINEE ADDRESS",
                customer.getNomineeAddress()
        );

        addWordRow(
                nomineeTable,
                "NOMINEE MOBILE",
                customer.getNomineeMobileNo()
        );

        addWordRow(
                nomineeTable,
                "NOMINEE PAN",
                customer.getNomineePanNo()
        );

        addWordRow(
                nomineeTable,
                "NOMINEE KYC NUMBER",
                customer.getNomineeKycNo()
        );

        addWordRow(
                nomineeTable,
                "NOMINEE KYC TYPE",
                customer.getNomineeKycType()
        );


        // Other.
        addWordSection(
                document,
                "OTHER CUSTOMER DETAILS"
        );

        XWPFTable otherTable =
                document.createTable();

        addWordRow(otherTable, "CATEGORY",
                customer.getCategory());

        addWordRow(otherTable, "CASTE",
                customer.getCaste());

        addWordRow(otherTable, "REFERRAL CODE",
                customer.getReferralCode());

        addWordRow(otherTable, "REFERRAL NAME",
                customer.getReferralName());

        addWordRow(otherTable, "SHARE AMOUNT",
                customer.getShareAmount());

        addWordRow(otherTable, "NUMBER OF SHARES",
                customer.getNoOfShare());

        addWordRow(otherTable, "SHARE VALUE",
                customer.getShareValue());

        addWordRow(otherTable, "LIGHT BILL",
                customer.getLightBill());

        addWordRow(otherTable, "TAX BILL",
                customer.getTaxBill());

        addWordRow(otherTable, "INTEREST PERCENT",
                customer.getInterestPercent());

        addWordRow(otherTable, "MEMBER FEES",
                customer.getMemberFees());

        addWordRow(otherTable, "BUILDING FUND",
                customer.getBuildingFund());

        addWordRow(otherTable, "ADMIN CHARGE",
                customer.getAdminCharge());

        addWordRow(otherTable, "DOCUMENT CHARGE",
                customer.getDocumentCharge());

        addWordRow(otherTable, "OTHER CHARGE",
                customer.getOtherCharge());


        addWordRow(otherTable, "PAYMENT BY",
                customer.getPaymentBy());

        addWordRow(otherTable, "REMARKS",
                customer.getRemarks());


        // =====================================================
        // CUSTOMER PHOTO + CUSTOMER SIGNATURE
        // SIDE BY SIDE
        // =====================================================

        XWPFTable mediaTable =
                document.createTable(1, 2);


        // -----------------------------------------------------
        // CUSTOMER PHOTO - LEFT
        // -----------------------------------------------------

        XWPFTableCell photoCell =
                mediaTable.getRow(0).getCell(0);

        photoCell.setVerticalAlignment(
                XWPFTableCell.XWPFVertAlign.CENTER
        );

        XWPFParagraph photoParagraph =
                photoCell.getParagraphs().get(0);

        photoParagraph.setAlignment(
                ParagraphAlignment.LEFT
        );

        File photoFile =
                getImageFile(customer.getCustomerPhoto());

        if (photoFile != null &&
                photoFile.exists()) {

            try {

                XWPFRun photoRun =
                        photoParagraph.createRun();

                String fileName =
                        photoFile.getName().toLowerCase();

                int pictureType =
                        XWPFDocument.PICTURE_TYPE_JPEG;

                if (fileName.endsWith(".png")) {
                    pictureType =
                            XWPFDocument.PICTURE_TYPE_PNG;
                } else if (fileName.endsWith(".gif")) {
                    pictureType =
                            XWPFDocument.PICTURE_TYPE_GIF;
                }

                FileInputStream inputStream =
                        new FileInputStream(photoFile);

                photoRun.addPicture(
                        inputStream,
                        pictureType,
                        photoFile.getName(),
                        Units.toEMU(100),
                        Units.toEMU(100)
                );

                inputStream.close();

            } catch (Exception e) {

                photoParagraph.createRun()
                        .setText("PHOTO NOT AVAILABLE");
            }

        } else {

            photoParagraph.createRun()
                    .setText("PHOTO NOT AVAILABLE");
        }


        // Photo label below image.
        XWPFParagraph photoLabel =
                photoCell.addParagraph();

        photoLabel.setAlignment(
                ParagraphAlignment.LEFT
        );

        XWPFRun photoLabelRun =
                photoLabel.createRun();

        photoLabelRun.setBold(true);
        photoLabelRun.setFontSize(9);
        photoLabelRun.setText("CUSTOMER PHOTO");


        // -----------------------------------------------------
        // CUSTOMER SIGNATURE - RIGHT
        // -----------------------------------------------------

        XWPFTableCell signatureCell =
                mediaTable.getRow(0).getCell(1);

        signatureCell.setVerticalAlignment(
                XWPFTableCell.XWPFVertAlign.CENTER
        );

        XWPFParagraph signatureParagraph =
                signatureCell.getParagraphs().get(0);

        signatureParagraph.setAlignment(
                ParagraphAlignment.RIGHT
        );

        File signatureFile =
                getImageFile(customer.getCustomerSignature());

        if (signatureFile != null &&
                signatureFile.exists()) {

            try {

                XWPFRun imageRun =
                        signatureParagraph.createRun();

                String fileName =
                        signatureFile.getName().toLowerCase();

                int pictureType =
                        XWPFDocument.PICTURE_TYPE_JPEG;

                if (fileName.endsWith(".png")) {
                    pictureType =
                            XWPFDocument.PICTURE_TYPE_PNG;
                } else if (fileName.endsWith(".gif")) {
                    pictureType =
                            XWPFDocument.PICTURE_TYPE_GIF;
                }

                FileInputStream inputStream =
                        new FileInputStream(signatureFile);

                imageRun.addPicture(
                        inputStream,
                        pictureType,
                        signatureFile.getName(),
                        Units.toEMU(120),
                        Units.toEMU(50)
                );

                inputStream.close();

            } catch (Exception e) {

                signatureParagraph.createRun()
                        .setText("SIGNATURE NOT AVAILABLE");
            }

        } else {

            signatureParagraph.createRun()
                    .setText("SIGNATURE NOT AVAILABLE");
        }


        // Signature label below image.
        XWPFParagraph signatureLabel =
                signatureCell.addParagraph();

        signatureLabel.setAlignment(
                ParagraphAlignment.RIGHT
        );

        XWPFRun signatureLabelRun =
                signatureLabel.createRun();

        signatureLabelRun.setBold(true);
        signatureLabelRun.setFontSize(9);
        signatureLabelRun.setText("CUSTOMER SIGNATURE");


        // Write Word.
        ByteArrayOutputStream outputStream =
                new ByteArrayOutputStream();

        document.write(outputStream);
        document.close();

        return outputStream.toByteArray();
    }


    // =========================================================
    // COMPANY DETAILS
    // =========================================================

    private CompanyAdministration getCompanyDetails() {

        List<CompanyAdministration> list =
                preferenceService.fetchAllCompanyAdministration();

        if (list != null && !list.isEmpty()) {
            return list.get(0);
        }

        return null;
    }


    private String getCompanyName(
            CompanyAdministration company) {

        if (company == null) {
            return "SAMITHA URBAN NIDHI LIMITED";
        }

        return value(company.getCompanyName());
    }


    private String buildCompanyAddress(
            CompanyAdministration company) {

        if (company == null) {
            return "";
        }

        StringBuilder address =
                new StringBuilder();

        append(address, company.getAddress());
        append(address, company.getCity());
        append(address, company.getState());

        String pin =
                value(company.getPinCode());

        if (!"N/A".equals(pin)) {
            append(address, "- " + pin);
        }

        String result =
                address.toString().trim();

        if (result.equals("- N/A")) {
            return "";
        }

        return result;
    }


    private String buildCompanyContact(
            CompanyAdministration company) {

        if (company == null) {
            return "";
        }

        StringBuilder contact =
                new StringBuilder();

        String email =
                value(company.getEmailId());

        String helpline =
                value(company.getHelplineNo());

        String cin =
                value(company.getCinNo());

        if (!"N/A".equals(email)) {
            contact.append("Email: ")
                    .append(email);
        }

        if (!"N/A".equals(helpline)) {

            if (contact.length() > 0) {
                contact.append(" | ");
            }

            contact.append("Helpline: ")
                    .append(helpline);
        }

        if (!"N/A".equals(cin)) {

            if (contact.length() > 0) {
                contact.append(" | ");
            }

            contact.append("CIN: ")
                    .append(cin);
        }

        return contact.toString();
    }


    private void append(
            StringBuilder builder,
            String value) {

        if (value != null &&
                !value.trim().isEmpty() &&
                !"N/A".equalsIgnoreCase(value.trim())) {

            if (builder.length() > 0) {
                builder.append(", ");
            }

            builder.append(value.trim());
        }
    }


    // =========================================================
    // CUSTOMER HELPERS
    // =========================================================

    private String getFullName(
            addCustomer customer) {

        StringBuilder name =
                new StringBuilder();

        // Use spaces between name parts.
        if (customer.getFirstName() != null &&
                !customer.getFirstName().trim().isEmpty()) {

            name.append(customer.getFirstName().trim());
        }

        if (customer.getMiddleName() != null &&
                !customer.getMiddleName().trim().isEmpty()) {

            if (name.length() > 0) {
                name.append(" ");
            }

            name.append(customer.getMiddleName().trim());
        }

        if (customer.getLastName() != null &&
                !customer.getLastName().trim().isEmpty()) {

            if (name.length() > 0) {
                name.append(" ");
            }

            name.append(customer.getLastName().trim());
        }

        if (name.length() == 0) {
            return value(customer.getCustomerName());
        }

        return name.toString();
    }


    private String getAccountNumber(
            addCustomer customer) {

        if (customer.getMemberCode() == null) {
            return "N/A";
        }

        List<CreateSavingsAccount> accounts =
                createSavingAccountRepo
                        .findBySelectByCustomer(
                                customer.getMemberCode()
                        );

        if (accounts != null) {

            for (CreateSavingsAccount account :
                    accounts) {

                if (account.isApproved()
                        && account.getAccountNumber() != null
                        && !account.getAccountNumber()
                        .trim().isEmpty()) {

                    return account.getAccountNumber();
                }
            }

            for (CreateSavingsAccount account :
                    accounts) {

                if (account.getAccountNumber() != null
                        && !account.getAccountNumber()
                        .trim().isEmpty()) {

                    return account.getAccountNumber();
                }
            }
        }

        return "N/A";
    }


    // =========================================================
    // PDF HELPERS
    // =========================================================

    private PdfPTable createPdfDataTable() {

        PdfPTable table =
                new PdfPTable(2);

        table.setWidthPercentage(100);

        table.setWidths(
                new float[]{2.5f, 5f}
        );

        table.setSpacingAfter(6);

        return table;
    }


    private void addPdfSection(
            Document document,
            String title,
            Font font)
            throws DocumentException {

        Paragraph section =
                new Paragraph(title, font);

        section.setSpacingBefore(8);
        section.setSpacingAfter(5);

        section.setIndentationLeft(4);

        document.add(section);
    }


    private void addPdfRow(
            PdfPTable table,
            String label,
            String value) {

        Font labelFont =
                new Font(
                        Font.HELVETICA,
                        9,
                        Font.BOLD
                );

        Font valueFont =
                new Font(
                        Font.HELVETICA,
                        9,
                        Font.NORMAL
                );

        PdfPCell labelCell =
                new PdfPCell(
                        new Phrase(
                                label,
                                labelFont
                        )
                );

        PdfPCell valueCell =
                new PdfPCell(
                        new Phrase(
                                value(value),
                                valueFont
                        )
                );

        labelCell.setPadding(5);
        valueCell.setPadding(5);

        labelCell.setBackgroundColor(
                new Color(241, 244, 249)
        );

        labelCell.setBorderColor(
                new Color(206, 212, 218)
        );

        valueCell.setBorderColor(
                new Color(206, 212, 218)
        );

        table.addCell(labelCell);
        table.addCell(valueCell);
    }


    private Image getImage(
            String fileName) {

        File file =
                getImageFile(fileName);

        if (file == null ||
                !file.exists()) {

            return null;
        }

        try {

            return Image.getInstance(
                    file.getAbsolutePath()
            );

        } catch (Exception e) {

            return null;
        }
    }


    // =========================================================
    // WORD HELPERS
    // =========================================================

    private void addWordSection(
            XWPFDocument document,
            String title) {

        XWPFParagraph paragraph =
                document.createParagraph();

        paragraph.setSpacingBefore(100);
        paragraph.setSpacingAfter(60);

        XWPFRun run =
                paragraph.createRun();

        run.setBold(true);
        run.setFontSize(12);
        run.setText(title);
    }


    private void addWordRow(
            XWPFTable table,
            String label,
            String value) {

        XWPFTableRow row;

        if (table.getNumberOfRows() == 1
                && table.getRow(0)
                .getCell(0)
                .getText()
                .trim()
                .isEmpty()) {

            row = table.getRow(0);

        } else {

            row = table.createRow();
        }


        while (row.getTableCells().size() < 2) {
            row.createCell();
        }


        XWPFTableCell labelCell =
                row.getCell(0);

        XWPFTableCell valueCell =
                row.getCell(1);


        labelCell.setText(label);
        valueCell.setText(value(value));


        // Style label cell.
        XWPFParagraph labelParagraph =
                labelCell.getParagraphs().get(0);

        for (XWPFRun run : labelParagraph.getRuns()) {
            run.setBold(true);
            run.setFontSize(9);
        }


        // Style value cell.
        XWPFParagraph valueParagraph =
                valueCell.getParagraphs().get(0);

        for (XWPFRun run : valueParagraph.getRuns()) {
            run.setFontSize(9);
        }


        // Add cell shading.
        setCellShading(
                labelCell,
                "F1F4F9"
        );


        // Add cell borders.
        setCellBorders(labelCell);
        setCellBorders(valueCell);
    }


    private void addWordImage(
            XWPFTableCell cell,
            String title,
            File file,
            int width) {

        XWPFParagraph paragraph =
                cell.getParagraphs().get(0);

        paragraph.setAlignment(
                ParagraphAlignment.CENTER
        );

        XWPFRun titleRun =
                paragraph.createRun();

        titleRun.setBold(true);
        titleRun.setFontSize(9);
        titleRun.setText(title);


        if (file == null ||
                !file.exists()) {

            XWPFRun run =
                    paragraph.createRun();

            run.addBreak();

            run.setText(
                    "IMAGE NOT AVAILABLE"
            );

            return;
        }


        try {

            XWPFRun imageRun =
                    paragraph.createRun();

            imageRun.addBreak();

            String fileName =
                    file.getName().toLowerCase();

            int pictureType =
                    XWPFDocument.PICTURE_TYPE_JPEG;


            if (fileName.endsWith(".png")) {

                pictureType =
                        XWPFDocument.PICTURE_TYPE_PNG;

            } else if (fileName.endsWith(".gif")) {

                pictureType =
                        XWPFDocument.PICTURE_TYPE_GIF;
            }


            FileInputStream inputStream =
                    new FileInputStream(file);


            imageRun.addPicture(
                    inputStream,
                    pictureType,
                    file.getName(),
                    Units.toEMU(width),
                    Units.toEMU(width)
            );


            inputStream.close();

        } catch (Exception e) {

            XWPFRun errorRun =
                    paragraph.createRun();

            errorRun.addBreak();

            errorRun.setText(
                    "IMAGE NOT AVAILABLE"
            );
        }
    }


    private void setCellShading(
            XWPFTableCell cell,
            String color) {

        org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcPr tcPr =
                cell.getCTTc().isSetTcPr()
                        ? cell.getCTTc().getTcPr()
                        : cell.getCTTc().addNewTcPr();

        org.openxmlformats.schemas.wordprocessingml.x2006.main.CTShd shd =
                tcPr.isSetShd()
                        ? tcPr.getShd()
                        : tcPr.addNewShd();

        shd.setFill(color);
    }


    private void setCellBorders(
            XWPFTableCell cell) {

        org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcPr tcPr =
                cell.getCTTc().isSetTcPr()
                        ? cell.getCTTc().getTcPr()
                        : cell.getCTTc().addNewTcPr();

        org.openxmlformats.schemas.wordprocessingml.x2006.main.CTTcBorders borders =
                tcPr.isSetTcBorders()
                        ? tcPr.getTcBorders()
                        : tcPr.addNewTcBorders();

        org.openxmlformats.schemas.wordprocessingml.x2006.main.CTBorder top =
                borders.isSetTop()
                        ? borders.getTop()
                        : borders.addNewTop();

        org.openxmlformats.schemas.wordprocessingml.x2006.main.CTBorder bottom =
                borders.isSetBottom()
                        ? borders.getBottom()
                        : borders.addNewBottom();

        org.openxmlformats.schemas.wordprocessingml.x2006.main.CTBorder left =
                borders.isSetLeft()
                        ? borders.getLeft()
                        : borders.addNewLeft();

        org.openxmlformats.schemas.wordprocessingml.x2006.main.CTBorder right =
                borders.isSetRight()
                        ? borders.getRight()
                        : borders.addNewRight();

        top.setVal(
                org.openxmlformats.schemas.wordprocessingml.x2006.main.STBorder.SINGLE
        );

        bottom.setVal(
                org.openxmlformats.schemas.wordprocessingml.x2006.main.STBorder.SINGLE
        );

        left.setVal(
                org.openxmlformats.schemas.wordprocessingml.x2006.main.STBorder.SINGLE
        );

        right.setVal(
                org.openxmlformats.schemas.wordprocessingml.x2006.main.STBorder.SINGLE
        );

        top.setSz(BigInteger.valueOf(4));
        bottom.setSz(BigInteger.valueOf(4));
        left.setSz(BigInteger.valueOf(4));
        right.setSz(BigInteger.valueOf(4));

        top.setColor("CED4DA");
        bottom.setColor("CED4DA");
        left.setColor("CED4DA");
        right.setColor("CED4DA");
    }


    // =========================================================
    // FILE / VALUE HELPERS
    // =========================================================

    private File getImageFile(
            String fileName) {

        if (fileName == null ||
                fileName.trim().isEmpty()) {

            return null;
        }

        File file =
                new File(
                        uploadDirectory,
                        fileName
                );

        if (file.exists()) {
            return file;
        }

        return null;
    }


    private String value(
            String value) {

        if (value == null ||
                value.trim().isEmpty()) {

            return "N/A";
        }

        return value;
    }
}