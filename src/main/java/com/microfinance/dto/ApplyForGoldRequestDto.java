package com.microfinance.dto;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import javax.validation.Valid;
import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.NotNull;

public class ApplyForGoldRequestDto {

	private String goldID;
	private String loanNo;

	@NotBlank(message = "Loan date is required")
	private String loanDate;

	@NotBlank(message = "Member code is required")
	private String memberCode;

	private String customerName;
	private String dateOfBirth;
	private String age;
	private String contactNo;
	private String address;
	private String pinCode;
	private String branchName;

	@NotBlank(message = "Loan plan name is required")
	private String loanPlanName;

	private String typeOfLoan;
	private String loanMode; // e.g. "EMI" or "Bullet"
	private String loanTerm; // in months
	private String rateOfInterest;

	@NotNull(message = "Amount of loan is required")
	@DecimalMin(value = "1.0", message = "Amount of loan must be greater than 0")
	private BigDecimal loanAmount;

	private String interestType; // "FLAT" or "REDUCING"
	private BigDecimal emiPayment;
	private String purposeOfLoan;
	private String smsSend;

	@NotBlank(message = "Photo upload is mandatory before saving")
	private String photo;

	@NotBlank(message = "Signature upload is mandatory before saving")
	private String signature;

	private String ornamentPhoto;
	private String ornamentPhoto2;

	// Repeatable Gold Items
	@Valid
	@NotEmpty(message = "At least one gold item is required")
	private List<GoldItemDto> items = new ArrayList<>();

	// Guarantor Details
	private String guarantorcustomerCode;
	private String guarantorIdentity;
	private String guarantorAddress;
	private String guarantorPinCode;
	private String guarantorContactNo;
	private String guarantorSecurityType;

	// Co-Applicant Details
	private String coApplicantMemberId;
	private String coApplicantIdentity;
	private String coApplicantAddress;
	private String coAge;
	private String coApplicantContactNo;
	private String securityDetails;

	// Deduction Details
	private BigDecimal processingFee = BigDecimal.ZERO;
	private BigDecimal legalCharges = BigDecimal.ZERO;
	private BigDecimal stampDuty = BigDecimal.ZERO;
	private BigDecimal smsCharges = BigDecimal.ZERO;
	private BigDecimal mainCharges = BigDecimal.ZERO;
	private BigDecimal stationaryFee = BigDecimal.ZERO;
	private BigDecimal gst = BigDecimal.ZERO;
	private BigDecimal insuFee = BigDecimal.ZERO;
	private BigDecimal penaltyCharge = BigDecimal.ZERO;
	private BigDecimal valuationFees = BigDecimal.ZERO;
	private BigDecimal overCharge = BigDecimal.ZERO;
	private BigDecimal collectionCharge = BigDecimal.ZERO;
	private String financialConsultantId;
	private String financialConsultantName;

	private BigDecimal netDisbursement;
	private BigDecimal totalInterest;
	private BigDecimal totalPayableAmount;
	private BigDecimal totalEligibleLoan;
	private BigDecimal totalMarketValuation;

	public String getGoldID() {
		return goldID;
	}

	public void setGoldID(String goldID) {
		this.goldID = goldID;
	}

	public String getLoanNo() {
		return loanNo;
	}

	public void setLoanNo(String loanNo) {
		this.loanNo = loanNo;
	}

	public String getLoanDate() {
		return loanDate;
	}

	public void setLoanDate(String loanDate) {
		this.loanDate = loanDate;
	}

	public String getMemberCode() {
		return memberCode;
	}

	public void setMemberCode(String memberCode) {
		this.memberCode = memberCode;
	}

	public String getCustomerName() {
		return customerName;
	}

	public void setCustomerName(String customerName) {
		this.customerName = customerName;
	}

	public String getDateOfBirth() {
		return dateOfBirth;
	}

	public void setDateOfBirth(String dateOfBirth) {
		this.dateOfBirth = dateOfBirth;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPinCode() {
		return pinCode;
	}

	public void setPinCode(String pinCode) {
		this.pinCode = pinCode;
	}

	public String getBranchName() {
		return branchName;
	}

	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}

	public String getLoanPlanName() {
		return loanPlanName;
	}

	public void setLoanPlanName(String loanPlanName) {
		this.loanPlanName = loanPlanName;
	}

	public String getTypeOfLoan() {
		return typeOfLoan;
	}

	public void setTypeOfLoan(String typeOfLoan) {
		this.typeOfLoan = typeOfLoan;
	}

	public String getLoanMode() {
		return loanMode;
	}

	public void setLoanMode(String loanMode) {
		this.loanMode = loanMode;
	}

	public String getLoanTerm() {
		return loanTerm;
	}

	public void setLoanTerm(String loanTerm) {
		this.loanTerm = loanTerm;
	}

	public String getRateOfInterest() {
		return rateOfInterest;
	}

	public void setRateOfInterest(String rateOfInterest) {
		this.rateOfInterest = rateOfInterest;
	}

	public BigDecimal getLoanAmount() {
		return loanAmount;
	}

	public void setLoanAmount(BigDecimal loanAmount) {
		this.loanAmount = loanAmount;
	}

	public String getInterestType() {
		return interestType;
	}

	public void setInterestType(String interestType) {
		this.interestType = interestType;
	}

	public BigDecimal getEmiPayment() {
		return emiPayment;
	}

	public void setEmiPayment(BigDecimal emiPayment) {
		this.emiPayment = emiPayment;
	}

	public String getPurposeOfLoan() {
		return purposeOfLoan;
	}

	public void setPurposeOfLoan(String purposeOfLoan) {
		this.purposeOfLoan = purposeOfLoan;
	}

	public String getSmsSend() {
		return smsSend;
	}

	public void setSmsSend(String smsSend) {
		this.smsSend = smsSend;
	}

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public String getSignature() {
		return signature;
	}

	public void setSignature(String signature) {
		this.signature = signature;
	}

	public List<GoldItemDto> getItems() {
		return items;
	}

	public void setItems(List<GoldItemDto> items) {
		this.items = items;
	}

	public String getGuarantorcustomerCode() {
		return guarantorcustomerCode;
	}

	public void setGuarantorcustomerCode(String guarantorcustomerCode) {
		this.guarantorcustomerCode = guarantorcustomerCode;
	}

	public String getGuarantorIdentity() {
		return guarantorIdentity;
	}

	public void setGuarantorIdentity(String guarantorIdentity) {
		this.guarantorIdentity = guarantorIdentity;
	}

	public String getGuarantorAddress() {
		return guarantorAddress;
	}

	public void setGuarantorAddress(String guarantorAddress) {
		this.guarantorAddress = guarantorAddress;
	}

	public String getGuarantorPinCode() {
		return guarantorPinCode;
	}

	public void setGuarantorPinCode(String guarantorPinCode) {
		this.guarantorPinCode = guarantorPinCode;
	}

	public String getGuarantorContactNo() {
		return guarantorContactNo;
	}

	public void setGuarantorContactNo(String guarantorContactNo) {
		this.guarantorContactNo = guarantorContactNo;
	}

	public String getGuarantorSecurityType() {
		return guarantorSecurityType;
	}

	public void setGuarantorSecurityType(String guarantorSecurityType) {
		this.guarantorSecurityType = guarantorSecurityType;
	}

	public String getCoApplicantMemberId() {
		return coApplicantMemberId;
	}

	public void setCoApplicantMemberId(String coApplicantMemberId) {
		this.coApplicantMemberId = coApplicantMemberId;
	}

	public String getCoApplicantIdentity() {
		return coApplicantIdentity;
	}

	public void setCoApplicantIdentity(String coApplicantIdentity) {
		this.coApplicantIdentity = coApplicantIdentity;
	}

	public String getCoApplicantAddress() {
		return coApplicantAddress;
	}

	public void setCoApplicantAddress(String coApplicantAddress) {
		this.coApplicantAddress = coApplicantAddress;
	}

	public String getCoAge() {
		return coAge;
	}

	public void setCoAge(String coAge) {
		this.coAge = coAge;
	}

	public String getCoApplicantContactNo() {
		return coApplicantContactNo;
	}

	public void setCoApplicantContactNo(String coApplicantContactNo) {
		this.coApplicantContactNo = coApplicantContactNo;
	}

	public String getSecurityDetails() {
		return securityDetails;
	}

	public void setSecurityDetails(String securityDetails) {
		this.securityDetails = securityDetails;
	}

	public BigDecimal getProcessingFee() {
		return processingFee;
	}

	public void setProcessingFee(BigDecimal processingFee) {
		this.processingFee = processingFee;
	}

	public BigDecimal getLegalCharges() {
		return legalCharges;
	}

	public void setLegalCharges(BigDecimal legalCharges) {
		this.legalCharges = legalCharges;
	}

	public BigDecimal getStampDuty() {
		return stampDuty;
	}

	public void setStampDuty(BigDecimal stampDuty) {
		this.stampDuty = stampDuty;
	}

	public BigDecimal getSmsCharges() {
		return smsCharges;
	}

	public void setSmsCharges(BigDecimal smsCharges) {
		this.smsCharges = smsCharges;
	}

	public BigDecimal getMainCharges() {
		return mainCharges;
	}

	public void setMainCharges(BigDecimal mainCharges) {
		this.mainCharges = mainCharges;
	}

	public BigDecimal getStationaryFee() {
		return stationaryFee;
	}

	public void setStationaryFee(BigDecimal stationaryFee) {
		this.stationaryFee = stationaryFee;
	}

	public BigDecimal getGst() {
		return gst;
	}

	public void setGst(BigDecimal gst) {
		this.gst = gst;
	}

	public BigDecimal getInsuFee() {
		return insuFee;
	}

	public void setInsuFee(BigDecimal insuFee) {
		this.insuFee = insuFee;
	}

	public BigDecimal getPenaltyCharge() {
		return penaltyCharge;
	}

	public void setPenaltyCharge(BigDecimal penaltyCharge) {
		this.penaltyCharge = penaltyCharge;
	}

	public BigDecimal getValuationFees() {
		return valuationFees;
	}

	public void setValuationFees(BigDecimal valuationFees) {
		this.valuationFees = valuationFees;
	}

	public BigDecimal getOverCharge() {
		return overCharge;
	}

	public void setOverCharge(BigDecimal overCharge) {
		this.overCharge = overCharge;
	}

	public BigDecimal getCollectionCharge() {
		return collectionCharge;
	}

	public void setCollectionCharge(BigDecimal collectionCharge) {
		this.collectionCharge = collectionCharge;
	}

	public String getFinancialConsultantId() {
		return financialConsultantId;
	}

	public void setFinancialConsultantId(String financialConsultantId) {
		this.financialConsultantId = financialConsultantId;
	}

	public String getFinancialConsultantName() {
		return financialConsultantName;
	}

	public void setFinancialConsultantName(String financialConsultantName) {
		this.financialConsultantName = financialConsultantName;
	}

	public BigDecimal getNetDisbursement() {
		return netDisbursement;
	}

	public void setNetDisbursement(BigDecimal netDisbursement) {
		this.netDisbursement = netDisbursement;
	}

	public BigDecimal getTotalEligibleLoan() {
		return totalEligibleLoan;
	}

	public void setTotalEligibleLoan(BigDecimal totalEligibleLoan) {
		this.totalEligibleLoan = totalEligibleLoan;
	}

	public BigDecimal getTotalMarketValuation() {
		return totalMarketValuation;
	}

	public void setTotalMarketValuation(BigDecimal totalMarketValuation) {
		this.totalMarketValuation = totalMarketValuation;
	}

	public String getOrnamentPhoto() {
		return ornamentPhoto;
	}

	public void setOrnamentPhoto(String ornamentPhoto) {
		this.ornamentPhoto = ornamentPhoto;
	}

	public String getOrnamentPhoto2() {
		return ornamentPhoto2;
	}

	public void setOrnamentPhoto2(String ornamentPhoto2) {
		this.ornamentPhoto2 = ornamentPhoto2;
	}

	public BigDecimal getTotalInterest() {
		return totalInterest;
	}

	public void setTotalInterest(BigDecimal totalInterest) {
		this.totalInterest = totalInterest;
	}

	public BigDecimal getTotalPayableAmount() {
		return totalPayableAmount;
	}

	public void setTotalPayableAmount(BigDecimal totalPayableAmount) {
		this.totalPayableAmount = totalPayableAmount;
	}
}
