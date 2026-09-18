package com.microfinance.model;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;

@Entity
@Table(name = "document_generation_log")
public class DocumentGenerationLog implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "loan_id", nullable = false)
    private String loanId;

    @Column(name = "document_type", nullable = false)
    private String documentType;

    @Column(name = "document_name")
    private String documentName;

    @Column(name = "generated_by_user_id")
    private String generatedByUserId;

    @Column(name = "generated_at")
    private String generatedAt;

    @Column(name = "file_reference", length = 500)
    private String fileReference;

    @Column(name = "file_size")
    private Long fileSize;

    public DocumentGenerationLog() {
    }

    public DocumentGenerationLog(String loanId, String documentType, String documentName,
                                 String generatedByUserId, String fileReference, Long fileSize) {
        this.loanId = loanId;
        this.documentType = documentType;
        this.documentName = documentName;
        this.generatedByUserId = generatedByUserId;
        this.fileReference = fileReference;
        this.fileSize = fileSize;
    }

    @PrePersist
    public void onPrePersist() {
        if (this.generatedAt == null) {
            this.generatedAt = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
        }
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getLoanId() {
        return loanId;
    }

    public void setLoanId(String loanId) {
        this.loanId = loanId;
    }

    public String getDocumentType() {
        return documentType;
    }

    public void setDocumentType(String documentType) {
        this.documentType = documentType;
    }

    public String getDocumentName() {
        return documentName;
    }

    public void setDocumentName(String documentName) {
        this.documentName = documentName;
    }

    public String getGeneratedByUserId() {
        return generatedByUserId;
    }

    public void setGeneratedByUserId(String generatedByUserId) {
        this.generatedByUserId = generatedByUserId;
    }

    public String getGeneratedAt() {
        return generatedAt;
    }

    public void setGeneratedAt(String generatedAt) {
        this.generatedAt = generatedAt;
    }

    public String getFileReference() {
        return fileReference;
    }

    public void setFileReference(String fileReference) {
        this.fileReference = fileReference;
    }

    public Long getFileSize() {
        return fileSize;
    }

    public void setFileSize(Long fileSize) {
        this.fileSize = fileSize;
    }
}
