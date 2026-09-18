package com.microfinance;

import static org.junit.jupiter.api.Assertions.*;

import java.time.LocalDate;
import java.util.Map;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import com.microfinance.dto.ForeclosureSettlementDto;
import com.microfinance.model.LoanApplication;
import com.microfinance.model.LoanClosure;
import com.microfinance.repository.LoanApplicationRepo;
import com.microfinance.service.LoanDocumentService;
import com.microfinance.service.LoanManagementService;

@SpringBootTest
public class ForeclosureSettlementTest {

	@Autowired
	private LoanManagementService loanManagementService;

	@Autowired
	private LoanApplicationRepo loanApplicationRepo;

	@Autowired
	private LoanDocumentService loanDocumentService;

	@Test
	public void testCalculateForeclosureSettlement_ActiveLoan() {
		String loanId = "LP00001";
		ForeclosureSettlementDto dto = loanManagementService.calculateForeclosureSettlement(loanId);

		assertNotNull(dto, "ForeclosureSettlementDto should not be null");
		assertEquals(loanId, dto.getLoanId(), "Loan ID should match");
		assertTrue(dto.getSanctionedPrincipal() > 0, "Sanctioned principal should be positive");
		assertTrue(dto.getPrincipalOutstanding() > 0, "Principal outstanding should be positive");
		assertTrue(dto.getNetPayoffAmount() >= dto.getPrincipalOutstanding(), 
				"Net payoff should be at least equal to principal outstanding");
		assertNotNull(dto.getMemberName(), "Member name should be populated");
	}

	@Test
	public void testCalculateForeclosureSettlement_SameDayEdgeCase() {
		// When loan payment or start date is today, elapsed days must be 0 and accrued interest must be 0.00
		LoanApplication testLoan = new LoanApplication();
		testLoan.setLoanId("TEST_SAME_DAY");
		testLoan.setMemberId("M_TEST");
		testLoan.setMemberName("Test Borrower");
		testLoan.setLoanAmount("100000");
		testLoan.setRateOfInterest("12");
		testLoan.setEmiPayment("9000");
		testLoan.setLoanTerm("12");
		testLoan.setLoanMode("Monthly");
		testLoan.setInterestType("Reducing");
		testLoan.setLoanDate(LocalDate.now().toString());
		testLoan.setLoanStatus("APPROVED");
		loanApplicationRepo.save(testLoan);

		try {
			ForeclosureSettlementDto dto = loanManagementService.calculateForeclosureSettlement("TEST_SAME_DAY");
			assertEquals(0, dto.getElapsedDaysSinceLastPayment(), "Elapsed days on exact same day must be 0");
			assertEquals(0.0, dto.getAccruedInterestTillDate(), 0.01, "Accrued interest on exact same day must be 0");
			assertEquals(100000.0, dto.getPrincipalOutstanding(), 0.01, "Principal outstanding must equal sanctioned principal");
			assertEquals(100000.0, dto.getNetPayoffAmount(), 0.01, "Net payoff must equal principal when elapsed days is 0");
		} finally {
			loanApplicationRepo.delete(testLoan);
		}
	}

	@Test
	public void testCalculateForeclosureSettlement_ArrearsScenario() {
		// Loan started 3 months ago with 0 payments made
		LoanApplication overdueLoan = new LoanApplication();
		overdueLoan.setLoanId("TEST_ARREARS");
		overdueLoan.setMemberId("M_TEST_ARR");
		overdueLoan.setMemberName("Overdue Borrower");
		overdueLoan.setLoanAmount("100000");
		overdueLoan.setRateOfInterest("12");
		overdueLoan.setEmiPayment("9000");
		overdueLoan.setLoanTerm("12");
		overdueLoan.setLoanMode("Monthly");
		overdueLoan.setInterestType("Reducing");
		overdueLoan.setLoanDate(LocalDate.now().minusMonths(3).toString());
		overdueLoan.setLoanStatus("APPROVED");
		loanApplicationRepo.save(overdueLoan);

		try {
			ForeclosureSettlementDto dto = loanManagementService.calculateForeclosureSettlement("TEST_ARREARS");
			assertTrue(dto.getOverdueArrears() > 0, "Overdue arrears must be positive when past installments unpaid");
			assertTrue(dto.getAccruedInterestTillDate() > 0, "Accrued interest must be positive after 3 months");
			assertTrue(dto.getNetPayoffAmount() > dto.getPrincipalOutstanding(), "Net payoff must include arrears and accrued interest");
		} finally {
			loanApplicationRepo.delete(overdueLoan);
		}
	}

	@Test
	public void testCloseLoan_RejectsShortPayment() {
		LoanClosure closure = new LoanClosure();
		closure.setLoanId("LP00001");
		closure.setNetAmount("10.00");
		closure.setPaymentAmount("10.00");
		closure.setPaymentMode("Cash");
		closure.setPaymentDate(LocalDate.now().toString());
		closure.setReasonForClosure("Voluntary Prepayment");

		assertThrows(IllegalArgumentException.class, () -> {
			loanManagementService.closeLoan(closure);
		}, "closeLoan must reject payment amounts below the required net settlement payoff");
	}

	@Test
	public void testNocDocumentGatedByClosedStatus() {
		// Verify NOC document is only available when loanStatus is CLOSED
		java.util.List<com.microfinance.dto.AvailableDocumentDto> unclosedDocs = loanDocumentService.getAvailableDocuments("LP00001");
		com.microfinance.dto.AvailableDocumentDto nocDoc = unclosedDocs.stream()
				.filter(d -> "NOC".equalsIgnoreCase(d.getDocType()))
				.findFirst()
				.orElse(null);

		assertNotNull(nocDoc, "NOC entry should be listed");
		assertFalse(nocDoc.isAvailable(), "NOC must NOT be available while loanStatus is APPROVED/DISBURSED");
	}
}
