package com.microfinance.dto;

public class GroupLoanDropdownDto {
    private String groupCode;
    private String displayName;

    public GroupLoanDropdownDto() {}

    public GroupLoanDropdownDto(String groupCode, String displayName) {
        this.groupCode = groupCode;
        this.displayName = displayName;
    }

    public String getGroupCode() { return groupCode; }
    public void setGroupCode(String groupCode) { this.groupCode = groupCode; }

    public String getDisplayName() { return displayName; }
    public void setDisplayName(String displayName) { this.displayName = displayName; }
}
