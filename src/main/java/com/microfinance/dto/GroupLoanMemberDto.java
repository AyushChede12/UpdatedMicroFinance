package com.microfinance.dto;

import javax.validation.constraints.DecimalMin;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;
import java.math.BigDecimal;

public class GroupLoanMemberDto {

    @NotBlank(message = "Member code is required")
    private String memberCode;

    @NotBlank(message = "Member name is required")
    private String memberName;

    @NotNull(message = "Individual loan amount is required")
    @DecimalMin(value = "0.01", message = "Individual loan amount must be greater than 0")
    private BigDecimal individualLoanAmount;

    private BigDecimal netDisbursementAmount;

    public GroupLoanMemberDto() {}

    public GroupLoanMemberDto(String memberCode, String memberName) {
        this.memberCode = memberCode;
        this.memberName = memberName;
    }

    public GroupLoanMemberDto(String memberCode, String memberName, BigDecimal individualLoanAmount) {
        this.memberCode = memberCode;
        this.memberName = memberName;
        this.individualLoanAmount = individualLoanAmount;
    }

    public GroupLoanMemberDto(String memberCode, String memberName, BigDecimal individualLoanAmount, BigDecimal netDisbursementAmount) {
        this.memberCode = memberCode;
        this.memberName = memberName;
        this.individualLoanAmount = individualLoanAmount;
        this.netDisbursementAmount = netDisbursementAmount;
    }

    public String getMemberCode() { return memberCode; }
    public void setMemberCode(String memberCode) { this.memberCode = memberCode; }

    public String getMemberName() { return memberName; }
    public void setMemberName(String memberName) { this.memberName = memberName; }

    public BigDecimal getIndividualLoanAmount() { return individualLoanAmount; }
    public void setIndividualLoanAmount(BigDecimal individualLoanAmount) { this.individualLoanAmount = individualLoanAmount; }

    public BigDecimal getNetDisbursementAmount() { return netDisbursementAmount; }
    public void setNetDisbursementAmount(BigDecimal netDisbursementAmount) { this.netDisbursementAmount = netDisbursementAmount; }
}
