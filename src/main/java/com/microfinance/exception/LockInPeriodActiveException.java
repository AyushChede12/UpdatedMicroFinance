package com.microfinance.exception;

public class LockInPeriodActiveException extends RuntimeException {
    public LockInPeriodActiveException(String message) {
        super(message);
    }
}
