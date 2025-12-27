package com.microfinance.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Entity
public class LoanAprroval {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	 // Data Search Panel
	private Long id;
    private String groupcode;

    // Loan Details
    private String openingDate;
    private String communityName;
    private String allocatedStaff;
    private String branchName;
    private String collectionDays;
    private String paymentMode;
    private String contactNumber;
    private String purposeOfLoan;

    // Loan Approval Info
    private String dateOfApproval;
    private String approvalStatus;
    
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	public String getGroupcode() {
		return groupcode;
	}
	public void setGroupcode(String groupcode) {
		this.groupcode = groupcode;
	}
	public String getOpeningDate() {
		return openingDate;
	}
	public void setOpeningDate(String openingDate) {
		this.openingDate = openingDate;
	}
	public String getCommunityName() {
		return communityName;
	}
	public void setCommunityName(String communityName) {
		this.communityName = communityName;
	}
	public String getAllocatedStaff() {
		return allocatedStaff;
	}
	public void setAllocatedStaff(String allocatedStaff) {
		this.allocatedStaff = allocatedStaff;
	}
	public String getBranchName() {
		return branchName;
	}
	public void setBranchName(String branchName) {
		this.branchName = branchName;
	}
	
	public String getCollectionDays() {
		return collectionDays;
	}
	public void setCollectionDays(String collectionDays) {
		this.collectionDays = collectionDays;
	}
	public String getPaymentMode() {
		return paymentMode;
	}
	public void setPaymentMode(String paymentMode) {
		this.paymentMode = paymentMode;
	}
	public String getContactNumber() {
		return contactNumber;
	}
	public void setContactNumber(String contactNumber) {
		this.contactNumber = contactNumber;
	}
	public String getPurposeOfLoan() {
		return purposeOfLoan;
	}
	public void setPurposeOfLoan(String purposeOfLoan) {
		this.purposeOfLoan = purposeOfLoan;
	}
	public String getDateOfApproval() {
		return dateOfApproval;
	}
	public void setDateOfApproval(String dateOfApproval) {
		this.dateOfApproval = dateOfApproval;
	}
	public String getApprovalStatus() {
		return approvalStatus;
	}
	public void setApprovalStatus(String approvalStatus) {
		this.approvalStatus = approvalStatus;
	} 
    

}
