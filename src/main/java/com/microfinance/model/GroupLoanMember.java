package com.microfinance.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import javax.persistence.*;
import java.math.BigDecimal;

@Entity
@Table(name = "group_loan_member")
public class GroupLoanMember {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "group_loan_application_id", nullable = false)
    @JsonIgnore
    private GroupLoanApplication groupLoanApplication;

    @Column(name = "member_code", nullable = false, length = 50)
    private String memberCode;

    @Column(name = "member_name", nullable = false, length = 150)
    private String memberName;

    @Column(name = "individual_loan_amount", nullable = false, precision = 15, scale = 2)
    private BigDecimal individualLoanAmount;

    @Column(name = "net_disbursement_amount", precision = 15, scale = 2)
    private BigDecimal netDisbursementAmount;

    public GroupLoanMember() {}

    public GroupLoanMember(String memberCode, String memberName, BigDecimal individualLoanAmount) {
        this.memberCode = memberCode;
        this.memberName = memberName;
        this.individualLoanAmount = individualLoanAmount;
    }

    public GroupLoanMember(String memberCode, String memberName, BigDecimal individualLoanAmount, BigDecimal netDisbursementAmount) {
        this.memberCode = memberCode;
        this.memberName = memberName;
        this.individualLoanAmount = individualLoanAmount;
        this.netDisbursementAmount = netDisbursementAmount;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public GroupLoanApplication getGroupLoanApplication() { return groupLoanApplication; }
    public void setGroupLoanApplication(GroupLoanApplication groupLoanApplication) { this.groupLoanApplication = groupLoanApplication; }

    public String getMemberCode() { return memberCode; }
    public void setMemberCode(String memberCode) { this.memberCode = memberCode; }

    public String getMemberName() { return memberName; }
    public void setMemberName(String memberName) { this.memberName = memberName; }

    public BigDecimal getIndividualLoanAmount() { return individualLoanAmount; }
    public void setIndividualLoanAmount(BigDecimal individualLoanAmount) { this.individualLoanAmount = individualLoanAmount; }

    public BigDecimal getNetDisbursementAmount() { return netDisbursementAmount; }
    public void setNetDisbursementAmount(BigDecimal netDisbursementAmount) { this.netDisbursementAmount = netDisbursementAmount; }
}
