package com.microfinance.dto;

/**
 * Request DTO for premature MIS policy closure.
 */
public class MisPrematureCloseRequestDto {
    private String reason;

    public String getReason() { return reason; }
    public void setReason(String reason) { this.reason = reason; }
}
