package com.microfinance.repository;

import java.util.Collection;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.microfinance.dto.GoldLoanDropdownDto;
import com.microfinance.model.ApplyForGold;

@Repository
public interface ApplyForGoldRepo extends JpaRepository<ApplyForGold, Long> {

	@Query("select coalesce(max(id), 0) from ApplyForGold")
	Long getMaxId();

	@Query("SELECT a FROM ApplyForGold a WHERE a.goldID = :goldID")
	List<ApplyForGold> findByGoldID(@Param("goldID") String goldID);

	@Query("SELECT DISTINCT a.goldID FROM ApplyForGold a WHERE a.goldID IS NOT NULL AND TRIM(a.goldID) != '' ORDER BY a.goldID")
	List<String> findPrintableGoldLoanIds();

	ApplyForGold findSingleByGoldID(String goldID);

	List<ApplyForGold> findByApprovalStatusTrue();

	List<ApplyForGold> findByGoldLoanStatus(String string);

	List<ApplyForGold> findByApprovalStatusFalse();

	@Query("SELECT new com.microfinance.dto.GoldLoanDropdownDto(a.goldID, a.customerName, a.memberCode, a.goldLoanStatus, a.approvalStatus, a.paymentStatus, a.loanDate, a.loanAmount) FROM ApplyForGold a WHERE UPPER(a.goldLoanStatus) = 'ACTIVE' ORDER BY a.id DESC")
	List<GoldLoanDropdownDto> findActiveGoldLoanDropdown();

	@Query("SELECT new com.microfinance.dto.GoldLoanDropdownDto(a.goldID, a.customerName, a.memberCode, a.goldLoanStatus, a.approvalStatus, a.paymentStatus, a.loanDate, a.loanAmount) FROM ApplyForGold a WHERE a.approvalStatus = false ORDER BY a.id DESC")
	List<GoldLoanDropdownDto> findNotApprovedGoldLoanDropdown();

	@Query("SELECT new com.microfinance.dto.GoldLoanDropdownDto(a.goldID, a.customerName, a.memberCode, a.goldLoanStatus, a.approvalStatus, a.paymentStatus, a.loanDate, a.loanAmount) FROM ApplyForGold a WHERE a.approvalStatus = true ORDER BY a.id DESC")
	List<GoldLoanDropdownDto> findApprovedGoldLoanDropdown();

	@Query("SELECT new com.microfinance.dto.GoldLoanDropdownDto(a.goldID, a.customerName, a.memberCode, a.goldLoanStatus, a.approvalStatus, a.paymentStatus, a.loanDate, a.loanAmount) FROM ApplyForGold a ORDER BY a.id DESC")
	List<GoldLoanDropdownDto> findAllGoldLoanDropdown();

	@Query("SELECT new com.microfinance.dto.GoldLoanDropdownDto(a.goldID, a.customerName, a.memberCode, a.goldLoanStatus, a.approvalStatus, a.paymentStatus, a.loanDate, a.loanAmount) FROM ApplyForGold a WHERE a.approvalStatus = true AND (a.goldLoanStatus IS NULL OR UPPER(a.goldLoanStatus) != 'CLOSED') ORDER BY a.id DESC")
	List<GoldLoanDropdownDto> findClosableGoldLoans();

	long countByFinancialConsultantIdInAndLoanDateContaining(List<String> financialConsultantCode, String yearMonth);

	List<ApplyForGold> findByFinancialConsultantIdIn(List<String> financialCodes);

}
