package com.microfinance.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class GoldLoanPayment {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// -------------------- Customer Details --------------------
	private String goldID;
	private String customerCode;
	private String customerName;
	private String dateOfBirth;
	private String age;
	private String contactNo;
	private String address;
	private String pinCode;
	private String branchName;

	// -------------------- Loan Details --------------------
	private String goldLoanDate;
	private String loanPlanName;
	private String typeOfLoan;
	private String loanTerm;
	private String loanMode;
	private String rateOfInterest;
	private String loanAmount;
	private String interestType;
	private String emiPayment;
	private String purposeOfLoan;

	// -------------------- Gold/Silver Details --------------------
	private String karat;
	private String itemType;
	private String custgoldRate;
	private String itemName;
	private String lockerBranch;
	private String purity;
	private String itemQty;
	private String itemWt;
	private String grossWt;
	private String stoneWt;
	private String netWt;
	private String marketValuation;
	private String eligibleLoan;

	// -------------------- Guarantor Details --------------------
	private String guarantorcustomerCode;
	private String guarantorIdentity;
	private String guarantorAddress;
	private String guarantorPinCode;
	private String guarantorContactNo;
	private String guarantorSecurityType;

	// -------------------- Co-Applicant Details --------------------
	private String coApplicantMemberId;
	private String coApplicantIdentity;
	private String coApplicantAddress;
	private String coAge;
	private String coApplicantContactNo;
	private String securityDetails;

	// -------------------- Deduction Details --------------------
	private String processingFee;
	private String legalCharges;
	private String stampDuty;
	private String smsCharges;
	private String mainCharges;
	private String stationaryFee;
	private String gst;
	private String insuFee;
	private String penaltyCharge;
	private String valuationFees;
	private String overdueInterestCharge;
	private String collectionCharge;
	private String financialCode;
	private String financialName;

	// Payment Details
	private String paymentDate;
	private String paymentStatus;
	private String modeOfPayment;
	private String chargeDeductCash;
	private String remarks;
	private String amountDue;
	private String chequeNo;
	private String chequeDate;
	private String depositAccount;
	private String upiID;

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getGoldID() {
		return goldID;
	}

	public void setGoldID(String goldID) {
		this.goldID = goldID;
	}

	public String getCustomerCode() {
		return customerCode;
	}

	public void setCustomerCode(String customerCode) {
		this.customerCode = customerCode;
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

	public String getGoldLoanDate() {
		return goldLoanDate;
	}

	public void setGoldLoanDate(String goldLoanDate) {
		this.goldLoanDate = goldLoanDate;
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

	public String getLoanTerm() {
		return loanTerm;
	}

	public void setLoanTerm(String loanTerm) {
		this.loanTerm = loanTerm;
	}

	public String getLoanMode() {
		return loanMode;
	}

	public void setLoanMode(String loanMode) {
		this.loanMode = loanMode;
	}

	public String getRateOfInterest() {
		return rateOfInterest;
	}

	public void setRateOfInterest(String rateOfInterest) {
		this.rateOfInterest = rateOfInterest;
	}

	public String getLoanAmount() {
		return loanAmount;
	}

	public void setLoanAmount(String loanAmount) {
		this.loanAmount = loanAmount;
	}

	public String getInterestType() {
		return interestType;
	}

	public void setInterestType(String interestType) {
		this.interestType = interestType;
	}

	public String getEmiPayment() {
		return emiPayment;
	}

	public void setEmiPayment(String emiPayment) {
		this.emiPayment = emiPayment;
	}

	public String getPurposeOfLoan() {
		return purposeOfLoan;
	}

	public void setPurposeOfLoan(String purposeOfLoan) {
		this.purposeOfLoan = purposeOfLoan;
	}

	public String getKarat() {
		return karat;
	}

	public void setKarat(String karat) {
		this.karat = karat;
	}

	public String getItemType() {
		return itemType;
	}

	public void setItemType(String itemType) {
		this.itemType = itemType;
	}

	public String getCustgoldRate() {
		return custgoldRate;
	}

	public void setCustgoldRate(String custgoldRate) {
		this.custgoldRate = custgoldRate;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public String getLockerBranch() {
		return lockerBranch;
	}

	public void setLockerBranch(String lockerBranch) {
		this.lockerBranch = lockerBranch;
	}

	public String getPurity() {
		return purity;
	}

	public void setPurity(String purity) {
		this.purity = purity;
	}

	public String getItemQty() {
		return itemQty;
	}

	public void setItemQty(String itemQty) {
		this.itemQty = itemQty;
	}

	public String getItemWt() {
		return itemWt;
	}

	public void setItemWt(String itemWt) {
		this.itemWt = itemWt;
	}

	public String getGrossWt() {
		return grossWt;
	}

	public void setGrossWt(String grossWt) {
		this.grossWt = grossWt;
	}

	public String getStoneWt() {
		return stoneWt;
	}

	public void setStoneWt(String stoneWt) {
		this.stoneWt = stoneWt;
	}

	public String getNetWt() {
		return netWt;
	}

	public void setNetWt(String netWt) {
		this.netWt = netWt;
	}

	public String getMarketValuation() {
		return marketValuation;
	}

	public void setMarketValuation(String marketValuation) {
		this.marketValuation = marketValuation;
	}

	public String getEligibleLoan() {
		return eligibleLoan;
	}

	public void setEligibleLoan(String eligibleLoan) {
		this.eligibleLoan = eligibleLoan;
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

	public String getProcessingFee() {
		return processingFee;
	}

	public void setProcessingFee(String processingFee) {
		this.processingFee = processingFee;
	}

	public String getLegalCharges() {
		return legalCharges;
	}

	public void setLegalCharges(String legalCharges) {
		this.legalCharges = legalCharges;
	}

	public String getStampDuty() {
		return stampDuty;
	}

	public void setStampDuty(String stampDuty) {
		this.stampDuty = stampDuty;
	}

	public String getSmsCharges() {
		return smsCharges;
	}

	public void setSmsCharges(String smsCharges) {
		this.smsCharges = smsCharges;
	}

	public String getMainCharges() {
		return mainCharges;
	}

	public void setMainCharges(String mainCharges) {
		this.mainCharges = mainCharges;
	}

	public String getStationaryFee() {
		return stationaryFee;
	}

	public void setStationaryFee(String stationaryFee) {
		this.stationaryFee = stationaryFee;
	}

	public String getGst() {
		return gst;
	}

	public void setGst(String gst) {
		this.gst = gst;
	}

	public String getInsuFee() {
		return insuFee;
	}

	public void setInsuFee(String insuFee) {
		this.insuFee = insuFee;
	}

	public String getPenaltyCharge() {
		return penaltyCharge;
	}

	public void setPenaltyCharge(String penaltyCharge) {
		this.penaltyCharge = penaltyCharge;
	}

	public String getValuationFees() {
		return valuationFees;
	}

	public void setValuationFees(String valuationFees) {
		this.valuationFees = valuationFees;
	}

	public String getOverdueInterestCharge() {
		return overdueInterestCharge;
	}

	public void setOverdueInterestCharge(String overdueInterestCharge) {
		this.overdueInterestCharge = overdueInterestCharge;
	}

	public String getCollectionCharge() {
		return collectionCharge;
	}

	public void setCollectionCharge(String collectionCharge) {
		this.collectionCharge = collectionCharge;
	}

	public String getFinancialCode() {
		return financialCode;
	}

	public void setFinancialCode(String financialCode) {
		this.financialCode = financialCode;
	}

	public String getFinancialName() {
		return financialName;
	}

	public void setFinancialName(String financialName) {
		this.financialName = financialName;
	}

	public String getPaymentDate() {
		return paymentDate;
	}

	public void setPaymentDate(String paymentDate) {
		this.paymentDate = paymentDate;
	}

	public String getPaymentStatus() {
		return paymentStatus;
	}

	public void setPaymentStatus(String paymentStatus) {
		this.paymentStatus = paymentStatus;
	}

	public String getModeOfPayment() {
		return modeOfPayment;
	}

	public void setModeOfPayment(String modeOfPayment) {
		this.modeOfPayment = modeOfPayment;
	}

	public String getChequeNo() {
		return chequeNo;
	}

	public void setChequeNo(String chequeNo) {
		this.chequeNo = chequeNo;
	}

	public String getChequeDate() {
		return chequeDate;
	}

	public void setChequeDate(String chequeDate) {
		this.chequeDate = chequeDate;
	}

	public String getDepositAccount() {
		return depositAccount;
	}

	public void setDepositAccount(String depositAccount) {
		this.depositAccount = depositAccount;
	}

	public String getUpiID() {
		return upiID;
	}

	public void setUpiID(String upiID) {
		this.upiID = upiID;
	}

	public String getChargeDeductCash() {
		return chargeDeductCash;
	}

	public void setChargeDeductCash(String chargeDeductCash) {
		this.chargeDeductCash = chargeDeductCash;
	}

	public String getRemarks() {
		return remarks;
	}

	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}

	public String getAmountDue() {
		return amountDue;
	}

	public void setAmountDue(String amountDue) {
		this.amountDue = amountDue;
	}

}
