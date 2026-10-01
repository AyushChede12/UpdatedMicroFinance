package com.microfinance.dto;

import java.util.ArrayList;
import java.util.List;

public class GroupProfileDto {
    private String groupCode;
    private String communityName;
    private String openingDate;
    private String communityAddress;
    private String leaderAddress;
    private String branch;
    private String allocatedStaff;
    private String scheduledCollectionDay;
    private String communityLeader;
    private String leaderContactNumber;
    private List<GroupLoanMemberDto> members = new ArrayList<>();

    public GroupProfileDto() {}

    public String getGroupCode() { return groupCode; }
    public void setGroupCode(String groupCode) { this.groupCode = groupCode; }

    public String getCommunityName() { return communityName; }
    public void setCommunityName(String communityName) { this.communityName = communityName; }

    public String getOpeningDate() { return openingDate; }
    public void setOpeningDate(String openingDate) { this.openingDate = openingDate; }

    public String getCommunityAddress() { return communityAddress; }
    public void setCommunityAddress(String communityAddress) { this.communityAddress = communityAddress; }

    public String getLeaderAddress() { return leaderAddress; }
    public void setLeaderAddress(String leaderAddress) { this.leaderAddress = leaderAddress; }

    public String getBranch() { return branch; }
    public void setBranch(String branch) { this.branch = branch; }

    public String getAllocatedStaff() { return allocatedStaff; }
    public void setAllocatedStaff(String allocatedStaff) { this.allocatedStaff = allocatedStaff; }

    public String getScheduledCollectionDay() { return scheduledCollectionDay; }
    public void setScheduledCollectionDay(String scheduledCollectionDay) { this.scheduledCollectionDay = scheduledCollectionDay; }

    public String getCommunityLeader() { return communityLeader; }
    public void setCommunityLeader(String communityLeader) { this.communityLeader = communityLeader; }

    public String getLeaderContactNumber() { return leaderContactNumber; }
    public void setLeaderContactNumber(String leaderContactNumber) { this.leaderContactNumber = leaderContactNumber; }

    public List<GroupLoanMemberDto> getMembers() { return members; }
    public void setMembers(List<GroupLoanMemberDto> members) { this.members = members; }
}
