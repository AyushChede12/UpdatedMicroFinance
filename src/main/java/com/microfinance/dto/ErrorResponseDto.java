package com.microfinance.dto;

import java.io.Serializable;

public class ErrorResponseDto implements Serializable {
    private static final long serialVersionUID = 1L;

    private String errorCode;
    private String message;

    public ErrorResponseDto() {
    }

    public ErrorResponseDto(String errorCode, String message) {
        this.errorCode = errorCode;
        this.message = message;
    }

    public String getErrorCode() {
        return errorCode;
    }

    public void setErrorCode(String errorCode) {
        this.errorCode = errorCode;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
