package com.microfinance.dto;

import java.io.Serializable;

public class AvailableDocumentDto implements Serializable {
    private static final long serialVersionUID = 1L;

    private String docType;
    private String name;
    private boolean available;
    private String reason;

    public AvailableDocumentDto() {
    }

    public AvailableDocumentDto(String docType, String name, boolean available, String reason) {
        this.docType = docType;
        this.name = name;
        this.available = available;
        this.reason = reason;
    }

    public String getDocType() {
        return docType;
    }

    public void setDocType(String docType) {
        this.docType = docType;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }
}
