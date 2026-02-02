package com.microfinance.controller;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.BankCashTransferDto;
import com.microfinance.dto.IncomingReceiptDto;
import com.microfinance.dto.LedgerAccountDto;
import com.microfinance.dto.LedgerSummaryDto;
import com.microfinance.dto.ManualJournalDto;
import com.microfinance.dto.OutgoingPaymentDto;
import com.microfinance.dto.TrialBalanceReportDto;
import com.microfinance.model.LedgerAccountMaster;
import com.microfinance.service.AccountManagementService;

@RestController
@RequestMapping("/accountManagement")
public class AccountManagementController {

	@Autowired
	private AccountManagementService accountManagementService;

	/**
	 * Create a new ledger account.
	 *
	 * @param dto LedgerAccountDto with input data
	 * @return Created LedgerAccountDto wrapped in ApiResponse
	 */
	@PostMapping("/create")
	public ResponseEntity<ApiResponse<LedgerAccountDto>> createLedger(@Valid @RequestBody LedgerAccountDto dto) {
		LedgerAccountDto created = accountManagementService.createLedger(dto);
		return ResponseEntity.status(HttpStatus.CREATED)
				.body(ApiResponse.success(HttpStatus.CREATED, "Ledger created successfully", created));
	}

	/**
	 * Fetch all ledger accounts.
	 *
	 * @return List of ledgers wrapped in ApiResponse
	 */
	@GetMapping("/all")
	public ResponseEntity<ApiResponse<List<LedgerAccountDto>>> getAllLedgers() {
		List<LedgerAccountDto> ledgers = accountManagementService.getAllLedgers();
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Ledgers retrieved successfully", ledgers));
	}

	/**
	 * Fetch ledger account by ID.
	 *
	 * @param id the ledger ID
	 * @return ApiResponse with ledger details
	 */
	@GetMapping("/{id}")
	public ResponseEntity<ApiResponse<LedgerAccountDto>> getLedgerById(@PathVariable Long id) {
		LedgerAccountDto ledger = accountManagementService.getLedgerById(id);
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Ledger retrieved successfully", ledger));
	}

	@GetMapping("/groupNames")
	public ResponseEntity<ApiResponse<List<String>>> getGroupNames() {
		List<String> groupNames = accountManagementService.groupNames();
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Group names fetched", groupNames));
	}

	/**
	 * Fetch all ledger accounts associated with a specific branch name.
	 *
	 * @param branchName the name of the branch to filter ledger accounts
	 * @return ApiResponse containing a list of matching LedgerAccountDto objects
	 */
	@GetMapping("/ledgerByBranch/{branchName}")
	public ResponseEntity<ApiResponse<List<LedgerAccountDto>>> getLedgersByBranch(@PathVariable String branchName) {
		List<LedgerAccountDto> ledgers = accountManagementService.getLedgersByBranch(branchName);
		return ResponseEntity
				.ok(ApiResponse.success(HttpStatus.OK, "Ledgers for branch retrieved successfully", ledgers));
	}

	// Search OutgoingPayment Entry
	@GetMapping("/search")
	public ResponseEntity<ApiResponse<List<OutgoingPaymentDto>>> searchPayments(@RequestParam String branchName,
			@RequestParam String startDate, @RequestParam String endDate) {
		List<OutgoingPaymentDto> results = accountManagementService.searchPayments(branchName, startDate, endDate);
		return ResponseEntity
				.ok(ApiResponse.success(HttpStatus.OK, "Outgoing Payments retrieved successfully", results));
	}

	// Create OutgoingPayment Entry
	@PostMapping("/createOutgoingPayment")
	public ResponseEntity<ApiResponse<OutgoingPaymentDto>> createOutgoingPayment(
			@Valid @RequestBody OutgoingPaymentDto dto) {
		OutgoingPaymentDto created = accountManagementService.createOutgoingPayment(dto);
		return ResponseEntity.status(HttpStatus.CREATED)
				.body(ApiResponse.success(HttpStatus.CREATED, "Outgoing payment created successfully", created));
	}

	// Get all OutgoingPayment Entries
	@GetMapping("/allOutgoingPayment")
	public ResponseEntity<ApiResponse<List<OutgoingPaymentDto>>> getAllOutgoingPayment() {
		List<OutgoingPaymentDto> payments = accountManagementService.getAllOutgoingPayment();

		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "All outgoing payments fetched", payments));
	}

	// Get OutgoingPayment by ID
	@GetMapping("/outgoingPayment/{id}")
	public ResponseEntity<ApiResponse<OutgoingPaymentDto>> getOutgoingPayment(@PathVariable Long id) {
		OutgoingPaymentDto dto = accountManagementService.getOutgoingPayment(id);

		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Outgoing payment retrieved successfully", dto));
	}

	// SearchIncomingReceiptEntry

	@GetMapping("/searchIncomingReceipt")
	public ResponseEntity<ApiResponse<List<IncomingReceiptDto>>> searchIncomingReceipt(@RequestParam String branchName,
			@RequestParam String startDate, @RequestParam String endDate) {

		List<IncomingReceiptDto> results = accountManagementService.searchIncomingReceipt(branchName, startDate,
				endDate);
		return ResponseEntity
				.ok(ApiResponse.success(HttpStatus.OK, "Incoming Payments retrieved successfully", results));
	}

	// Create IncomingReceiptEntry
	@PostMapping("/createIncomingReceipt")
	public ResponseEntity<ApiResponse<IncomingReceiptDto>> createIncomingReceipt(
			@Valid @RequestBody IncomingReceiptDto dto) {
		IncomingReceiptDto created = accountManagementService.createIncomingReceipt(dto);
		return ResponseEntity.status(HttpStatus.CREATED)
				.body(ApiResponse.success(HttpStatus.CREATED, "Incoming Receipt Entry created successfully", created));

	}

	// Get all IncomingReceiptEntry
	@GetMapping("/allIncomingReceipt")
	public ResponseEntity<ApiResponse<List<IncomingReceiptDto>>> getAllIncomingReceipt() {
		List<IncomingReceiptDto> payments = accountManagementService.getAllIncomingReceipt();
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "All Incoming Receipt Entry fetched", payments));
	}

	// Get IncomingReceiptEntry ID (for View)
	@GetMapping("/incomingReceipt/{id}")
	public ResponseEntity<ApiResponse<IncomingReceiptDto>> getIncomingReceipt(@PathVariable Long id) {
		IncomingReceiptDto dto = accountManagementService.getIncomingReceipt(id);

		return ResponseEntity
				.ok(ApiResponse.success(HttpStatus.OK, "Incoming Receipt Entry retrieved successfully", dto));
	}

	// End Points for BankCashTransferEntry
	@GetMapping("/searchBankCashTransfer")
	public ResponseEntity<ApiResponse<List<BankCashTransferDto>>> searchBankCashTransfer(@RequestParam String branchName,
			@RequestParam String startDate, @RequestParam String endDate) {

		List<BankCashTransferDto> results = accountManagementService.searchBankCashTransfer(branchName, startDate,
				endDate);
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, " BankCashTransfer Entry retrieved successfully", results));

	}

	@PostMapping("/createBankCashTransfer")
	public ResponseEntity<ApiResponse<BankCashTransferDto>> createBankCashTransfer(@Valid @RequestBody BankCashTransferDto dto) {
		BankCashTransferDto created = accountManagementService.createBankCashTransfer(dto);
		return ResponseEntity.status(HttpStatus.CREATED)
				.body(ApiResponse.success(HttpStatus.CREATED," BankCashTransfer Entry created successfully", created));
	}

	@GetMapping("/allBankCashTransfer")
	public ResponseEntity<ApiResponse<List<BankCashTransferDto>>> getAllBankCashTransfer() {
		List<BankCashTransferDto> entries = accountManagementService.getAllBankCashTransfer();
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK,"All BankCashTransfer Entry fetched", entries));
		
	}

	@GetMapping("/bankCashTransfer/{id}")
	public ResponseEntity<ApiResponse<BankCashTransferDto>> getBankCashTransfer(@PathVariable Long id) {
		BankCashTransferDto dto= accountManagementService.getBankCashTransfer(id);
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "BankCashTransfer Entry retrieved successfully With Id", dto));
	}
/*	@GetMapping("/ledgerByBranchAndGroup/{branchName}")
	public ResponseEntity<ApiResponse<List<LedgerAccountMaster>>> getBankCashLedgersByBranch(
	        @PathVariable String branchName) {
	    List<LedgerAccountMaster> ledgers = accountManagementService.getBankCashLedgersByBranch(branchName);
	    return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Filtered Ledgers", ledgers));
	}*/



	// Account Management/Manual Journal Entry
	@GetMapping("/searchManualJournal")
	public ResponseEntity<ApiResponse<List<ManualJournalDto>>> searchManualJournal(@RequestParam String branchName,
			@RequestParam String startDate, @RequestParam String endDate) {
		List<ManualJournalDto> results = accountManagementService.searchManualJournal(branchName, startDate, endDate);
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Manual Journal Entry retrieved Succesfully", results));
		
	}

	@PostMapping("/createManualJournal")
	public ResponseEntity<ApiResponse<ManualJournalDto>> createManualJournal(@Valid @RequestBody ManualJournalDto dto) {
		ManualJournalDto created =accountManagementService.createManualJournal(dto);
		
		return ResponseEntity.status(HttpStatus.CREATED)
				.body(ApiResponse.success(HttpStatus.CREATED,"Manual Journal created successfully", created));
	}
	@GetMapping("/allManualJournal")
	public ResponseEntity<ApiResponse<List<ManualJournalDto>>> getAllManualJournal() {
		List<ManualJournalDto> entries = accountManagementService.getAllManualJournal();
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK,"All ManualJournal Entry fetched", entries));
	}

	@GetMapping("/manualJournal/{id}")
	public ResponseEntity<ApiResponse<ManualJournalDto>> getManualJournal(@PathVariable Long id) {
		ManualJournalDto dto= accountManagementService.getManualJournal(id);
		return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Manual Journal retrieved successfully With Id", dto));
	}
	
	@GetMapping("/eligibleLedgersForManualJournal/{branchName}")
	public ResponseEntity<ApiResponse<List<LedgerAccountMaster>>> getEligibleLedgersForManualJournal(
	        @PathVariable String branchName) {
	    List<LedgerAccountMaster> ledgers = accountManagementService.getEligibleLedgersForManualJournal(branchName);
	    return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Eligible ledgers fetched", ledgers));
	} 
	
	  @GetMapping("/ledger-summary")
	    public ResponseEntity<ApiResponse<List<LedgerSummaryDto>>> getLedgerSummary(
	            @RequestParam String branch,
	            @RequestParam String ledger,
	            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
	            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate) {

	        List<LedgerSummaryDto> result = accountManagementService.getLedgerSummary(branch, ledger, startDate, endDate);
	        return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Fetched Successfully" , result));
	    }
	  
	  @GetMapping("/journal-entry-report")
	    public ResponseEntity<ApiResponse<Map<String, Object>>> getJournalEntryReport(
	            @RequestParam String branch,
	            @RequestParam String voucherType,
	            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
	            @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate) {

	        Map<String, Object> report = accountManagementService.getJournalEntryReport(branch, voucherType, startDate, endDate);

	        return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Journal Report Fetched Successfully", report));
	    }
	  @GetMapping("/trial-balance")
	  public ResponseEntity<ApiResponse<List<TrialBalanceReportDto>>> getTrialBalance(
	          @RequestParam String branch,
	          @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
	          @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate) {

	      List<TrialBalanceReportDto> response =
	              accountManagementService.getTrialBalance(branch, startDate, endDate);

	      return ResponseEntity.ok(
	              ApiResponse.success(HttpStatus.OK, "Trial Balance Fetched Successfully", response)
	      );
	  }



	
	
	
}


