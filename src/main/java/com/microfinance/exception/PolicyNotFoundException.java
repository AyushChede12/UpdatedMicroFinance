package com.microfinance.exception;

public class PolicyNotFoundException extends RuntimeException {
    public PolicyNotFoundException(String message) {
        super(message);
    }
    public PolicyNotFoundException(Long id) {
        super("MIS Policy not found for ID: " + id);
    }
}
