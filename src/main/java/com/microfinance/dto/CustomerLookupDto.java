package com.microfinance.dto;

public class CustomerLookupDto {

	private String memberCode;
	private String customerName;
	private String identityType;
	private String identityNumber;
	private String address;
	private String pinCode;
	private String contactNo;
	private String age;

	public CustomerLookupDto() {
	}

	public CustomerLookupDto(String memberCode, String customerName, String identityType, String identityNumber,
			String address, String pinCode, String contactNo, String age) {
		this.memberCode = memberCode;
		this.customerName = customerName;
		this.identityType = identityType;
		this.identityNumber = identityNumber;
		this.address = address;
		this.pinCode = pinCode;
		this.contactNo = contactNo;
		this.age = age;
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

	public String getIdentityType() {
		return identityType;
	}

	public void setIdentityType(String identityType) {
		this.identityType = identityType;
	}

	public String getIdentityNumber() {
		return identityNumber;
	}

	public void setIdentityNumber(String identityNumber) {
		this.identityNumber = identityNumber;
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

	public String getContactNo() {
		return contactNo;
	}

	public void setContactNo(String contactNo) {
		this.contactNo = contactNo;
	}

	public String getAge() {
		return age;
	}

	public void setAge(String age) {
		this.age = age;
	}
}
