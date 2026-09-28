package com.microfinance.dto;

import com.fasterxml.jackson.annotation.JsonProperty;

public class GoldLoanDropdownDto {
	private String goldID;
	private String customerName;
	private String memberCode;
	private String goldLoanStatus;
	private Boolean approvalStatus;
	private String paymentStatus;
	private String loanDate;
	private String loanAmount;

	public GoldLoanDropdownDto() {
	}

	public GoldLoanDropdownDto(String goldID, String customerName, String memberCode, String goldLoanStatus,
			Boolean approvalStatus, String paymentStatus) {
		this.goldID = goldID;
		this.customerName = customerName;
		this.memberCode = memberCode;
		this.goldLoanStatus = goldLoanStatus;
		this.approvalStatus = approvalStatus;
		this.paymentStatus = paymentStatus;
	}

	public GoldLoanDropdownDto(String goldID, String customerName, String memberCode, String goldLoanStatus,
			Boolean approvalStatus, String paymentStatus, String loanDate, String loanAmount) {
		this.goldID = goldID;
		this.customerName = customerName;
		this.memberCode = memberCode;
		this.goldLoanStatus = goldLoanStatus;
		this.approvalStatus = approvalStatus;
		this.paymentStatus = paymentStatus;
		this.loanDate = loanDate;
		this.loanAmount = loanAmount;
	}

	@JsonProperty("goldID")
	public String getGoldID() {
		return goldID;
	}

	public void setGoldID(String goldID) {
		this.goldID = goldID;
	}

	// Alias for frontend code accessing item.goldId
	@JsonProperty("goldId")
	public String getGoldId() {
		return goldID;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}

	public String getGoldLoanStatus() {
		return goldLoanStatus;
	}

	public void setGoldLoanStatus(String goldLoanStatus) {
		this.goldLoanStatus = goldLoanStatus;
	}

	public Boolean getApprovalStatus() {
		return approvalStatus;
	}

	public void setApprovalStatus(Boolean approvalStatus) {
		this.approvalStatus = approvalStatus;
	}

	public String getPaymentStatus() {
		return paymentStatus != null ? paymentStatus : "UNPAID";
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public String getLoanDate() {
		return loanDate;
	}

	public void setLoanDate(String loanDate) {
		this.loanDate = loanDate;
	}

	public String getLoanAmount() {
		return loanAmount;
	}

	public void setLoanAmount(String loanAmount) {
		this.loanAmount = loanAmount;
	}
}
