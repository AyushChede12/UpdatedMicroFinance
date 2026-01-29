
package com.microfinance.service;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.Optional;
import java.util.UUID;
import java.util.regex.Pattern;
import java.util.stream.Collectors;

import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.microfinance.dto.BankCashTransferDto;
import com.microfinance.dto.IncomingReceiptDto;
import com.microfinance.dto.JournalEntryReportDto;
import com.microfinance.dto.LedgerAccountDto;
import com.microfinance.dto.LedgerSummaryDto;
import com.microfinance.dto.ManualJournalDto;
import com.microfinance.dto.OutgoingPaymentDto;
import com.microfinance.dto.TrialBalanceReportDto;
import com.microfinance.exception.BadRequestException;
import com.microfinance.exception.BusinessLogicException;
import com.microfinance.exception.ResourceNotFoundException;
import com.microfinance.model.BankCashTransferEntry;
import com.microfinance.model.IncomingReceiptEntry;
import com.microfinance.model.LedgerAccountMaster;
import com.microfinance.model.ManualJournalEntry;
import com.microfinance.model.OutgoingPaymentEntry;
import com.microfinance.repository.BankCashTransferRepo;
import com.microfinance.repository.BranchModuleRepo;
import com.microfinance.repository.IncomingReceiptRepo;
import com.microfinance.repository.JournalEntryReportRepo;
import com.microfinance.repository.LedgerAccountRepository;
import com.microfinance.repository.LedgerSummaryRepo;
import com.microfinance.repository.ManualJournalRepo;
import com.microfinance.repository.OutgoingPaymentRepo;
import com.microfinance.repository.TrialBalanceReportRepo;

@Service
public class AccountManagementService {

	@Autowired
	private BranchModuleRepo branchModuleRepo;

	@Autowired
	private LedgerAccountRepository ledgerAccountRepository;

	@Autowired
	private OutgoingPaymentRepo outgoingPaymentRepo;

	@Autowired
	private IncomingReceiptRepo incomingReceiptRepo;

	@Autowired
	private BankCashTransferRepo bankCashTransferRepo;

	@Autowired
	private ManualJournalRepo manualJournalRepo;

	@Autowired
	private LedgerSummaryRepo ledgerSummaryRepo;

	@Autowired
	private JournalEntryReportRepo journalEntryReportRepo;
	
	@Autowired
	private TrialBalanceReportRepo trialBalanceReportRepo;


	/**
	 * Create a new Ledger Account. Business Logic: - Title must be unique per
	 * branch - Title must have at least 3 characters
	 */
	private static final Pattern ACCOUNT_CODE_PATTERN = Pattern.compile("^[1-5]\\d{2}$"); // 3 digits, 1-5 first digit

	@Transactional
	public LedgerAccountDto createLedger(LedgerAccountDto dto) {

		validateLedgerData(dto);
		if (!ACCOUNT_CODE_PATTERN.matcher(dto.getAccountCode()).matches()) {
			throw new BusinessLogicException(
					"Account code must be a 3-digit code starting with 1..5 (e.g. 101, 201, 501).");
		}

		// 4) validate group and account code first digit consistency
		validateGroupMatchesAccountCode(dto.getGroupName(), dto.getAccountCode());

		// Check by accountCode + branch
		boolean codeExists = ledgerAccountRepository
				.existsByAccountCodeIgnoreCaseAndBranchName(dto.getAccountCode().trim(), dto.getBranchName().trim());
		if (codeExists) {
			throw new BusinessLogicException("Ledger with this account code already exists in this branch");
		}

		// Check by accountTitle + branch
		boolean titleExists = ledgerAccountRepository
				.existsByAccountTitleIgnoreCaseAndBranchNameTrimmed(dto.getAccountTitle(), dto.getBranchName());
		if (titleExists) {
			throw new BusinessLogicException("Ledger with this title already exists in this branch");
		}

		// ✅ Auto-assign Dr/Cr based on Group
		String group = dto.getGroupName().toUpperCase();
		if (group.equals("ASSETS") || group.equals("EXPENSES")) {
			dto.setOpeningBalanceType("DR");
		} else if (group.equals("LIABILITIES") || group.equals("EQUITY") || group.equals("INCOME")) {
			dto.setOpeningBalanceType("CR");
		} else {
			throw new BusinessLogicException("Invalid account group: " + dto.getGroupName());
		}

		// If opening balance is null, set to 0
		if (dto.getOpeningBalance() == null) {
			dto.setOpeningBalance(BigDecimal.ZERO);
		}
		if (dto.getOpeningBalance().compareTo(BigDecimal.ZERO) == 0 && dto.getOpeningBalanceType() == null) {
			// Default based on group (already set above)
			// Or you can force DR for Assets/Expenses, CR for others
		}
		// Validate group/type combination
		if (!isValidCombination(dto.getGroupName(), dto.getAccountType())) {
			throw new IllegalArgumentException(
					"Invalid combination: " + dto.getAccountType() + " cannot belong to " + dto.getGroupName());
		}

		// Initialize current balance = opening balance
		dto.setCurrentBalance(dto.getOpeningBalance());

		// Save
		LedgerAccountMaster entity = mapToEntity(dto);
		LedgerAccountMaster saved = ledgerAccountRepository.save(entity);
		return mapToDto(saved);
	}

	// Minimal guardrail mapping (Java 8 version)
	private static final Map<String, List<String>> ALLOWED_COMBINATIONS;
	static {
		Map<String, List<String>> map = new HashMap<>();
		map.put("ASSETS", Arrays.asList("CASH", "BANK", "LOAN_TO_MEMBERS", "GOLD_LOANS", "JOINT_LOANS", "RECEIVABLE"));
		map.put("LIABILITIES", Arrays.asList("MEMBER_SAVINGS", "RD_PAYABLE", "FD_PAYABLE", "DAILY_DEPOSIT_PAYABLE",
				"MIS_PAYABLE", "LOAN_FROM_BANK", "PAYABLE"));
		map.put("INCOME", Arrays.asList("SERVICE_FEES", "INTEREST", "DIVIDEND", "MEMBER_CONTRIBUTION", "POLICY_FEES"));
		map.put("EQUITY", Arrays.asList("SHARE", "CAPITAL"));
		map.put("EXPENSES", Arrays.asList("SALARY", "RENT", "OFFICE", "UTILITIES", "CONSULTANT_INCENTIVES",
				"COMMISSIONS", "POLICY_ADMIN"));

		ALLOWED_COMBINATIONS = Collections.unmodifiableMap(map);
	}

	private boolean isValidCombination(String group, String type) {
		if (group == null || type == null) {
			return false;
		}

		group = group.trim().toUpperCase();
		type = type.trim().toUpperCase();

		List<String> allowedTypes = ALLOWED_COMBINATIONS.get(group);
		return allowedTypes != null && allowedTypes.contains(type);
	}

	/**
	 * Fetch all ledger accounts.
	 */

	public List<LedgerAccountDto> getAllLedgers() {
		return ledgerAccountRepository.findAll().stream().map(this::mapToDto).collect(Collectors.toList());
	}

	/**
	 * Fetch ledger account by ID.
	 * 
	 */
	public LedgerAccountDto getLedgerById(Long id) {
		LedgerAccountMaster entity = ledgerAccountRepository.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("Ledger", "id", id));
		return mapToDto(entity);
	}

	public List<String> groupNames() {
		return Arrays.asList("ASSETS", "LIABILITIES", "INCOME", "EQUITY", "EXPENSES");
	}

	public List<LedgerAccountDto> getLedgersByBranch(String branchName) {
		List<LedgerAccountMaster> ledgers = ledgerAccountRepository.findByBranchName(branchName);
		if (ledgers.isEmpty()) {
			throw new ResourceNotFoundException("No ledgers found for branch '" + branchName + "'");
		}
		return ledgers.stream().map(this::mapToDto).collect(Collectors.toList());
	}

	// ====== Private util methods ======
	private void validateLedgerData(LedgerAccountDto dto) {
		if (dto.getAccountTitle().trim().length() < 3) {
			throw new BusinessLogicException("Account title must be at least 3 characters long");
		}
		if (dto.getAccountCode().trim().isEmpty()) {
			throw new BusinessLogicException("Account code is required");
		}
	}

	private void validateGroupMatchesAccountCode(String group, String accountCode) {
		if (accountCode == null || accountCode.length() < 1)
			return;
		char first = accountCode.charAt(0);
		switch (group.toUpperCase(Locale.ROOT)) {
		case "ASSETS":
			if (first != '1')
				throw new BusinessLogicException("ASSETS must have account codes in 1XX range.");
			break;
		case "LIABILITIES":
			if (first != '2')
				throw new BusinessLogicException("LIABILITIES must have account codes in 2XX range.");
			break;
		case "INCOME":
			if (first != '3')
				throw new BusinessLogicException("INCOME must have account codes in 3XX range.");
			break;
		case "EQUITY":
			if (first != '4')
				throw new BusinessLogicException("EQUITY must have account codes in 4XX range.");
			break;
		case "EXPENSES":
			if (first != '5')
				throw new BusinessLogicException("EXPENSES must have account codes in 5XX range.");
			break;
		default:
			throw new BusinessLogicException("Unknown group: " + group);
		}
	}

	private LedgerAccountMaster mapToEntity(LedgerAccountDto dto) {
		LedgerAccountMaster entity = new LedgerAccountMaster();
		entity.setAccountId(dto.getAccountId());
		entity.setAccountCode(dto.getAccountCode());
		entity.setAccountTitle(dto.getAccountTitle());
		entity.setGroupName(dto.getGroupName());
		entity.setAccountType(dto.getAccountType());
		entity.setOpeningBalance(dto.getOpeningBalance());
		entity.setOpeningBalanceType(dto.getOpeningBalanceType()); // <-- NEW
		entity.setCurrentBalance(dto.getCurrentBalance());
		entity.setStatus(dto.getStatus());
		entity.setBranchName(dto.getBranchName());
		return entity;
	}

	private void updateLedgerBalances(String branchName, String debitLedgerTitle, String creditLedgerTitle,
			BigDecimal amount) {

		// Debit Ledger (DR)
		LedgerAccountMaster debitLedger = ledgerAccountRepository
				.findByBranchNameAndAccountTitleIgnoreCase(branchName, debitLedgerTitle)
				.orElseThrow(() -> new BadRequestException("Debit Ledger not found: " + debitLedgerTitle));

		// Credit Ledger (CR)
		LedgerAccountMaster creditLedger = ledgerAccountRepository
				.findByBranchNameAndAccountTitleIgnoreCase(branchName, creditLedgerTitle)
				.orElseThrow(() -> new BadRequestException("Credit Ledger not found: " + creditLedgerTitle));

		// DR Ledger: Increase
		debitLedger.setCurrentBalance(debitLedger.getCurrentBalance().add(amount));

		// CR Ledger: Decrease
		creditLedger.setCurrentBalance(creditLedger.getCurrentBalance().subtract(amount));

		// Save both ledgers
		ledgerAccountRepository.save(debitLedger);
		ledgerAccountRepository.save(creditLedger);
	}

	private LedgerAccountDto mapToDto(LedgerAccountMaster entity) {
		LedgerAccountDto dto = new LedgerAccountDto();
		dto.setAccountId(entity.getAccountId());
		dto.setAccountCode(entity.getAccountCode());
		dto.setAccountTitle(entity.getAccountTitle());
		dto.setGroupName(entity.getGroupName());
		dto.setAccountType(entity.getAccountType());
		dto.setOpeningBalance(entity.getOpeningBalance());
		dto.setOpeningBalanceType(entity.getOpeningBalanceType()); // <-- NEW
		dto.setCurrentBalance(entity.getCurrentBalance());
		dto.setStatus(entity.getStatus());
		dto.setBranchName(entity.getBranchName());
		return dto;
	}

	/**
	 * Searches for outgoing payment entries by branch name and date range.
	 *
	 * @param branchName The name of the branch to search payments for.
	 * @param startDate  The start date of the range in yyyy-MM-dd format.
	 * @param endDate    The end date of the range in yyyy-MM-dd format.
	 * @return List of {@link OutgoingPaymentEntry} matching the search criteria.
	 * @throws BadRequestException if the date format is invalid, if the end date is
	 *                             before the start date, or if the end date is in
	 *                             the future.
	 */
	public List<OutgoingPaymentDto> searchPayments(String branchName, String startDate, String endDate) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate start;
		LocalDate end;

		try {
			start = LocalDate.parse(startDate, formatter);
			end = LocalDate.parse(endDate, formatter);
		} catch (DateTimeParseException e) {
			throw new BadRequestException("Invalid date format. Expected yyyy-MM-dd.");
		}

		if (!branchModuleRepo.existsByBranchNameIgnoreCase(branchName)) {
			throw new BadRequestException("Invalid branch name: " + branchName);
		}

		if (end.isBefore(start)) {
			throw new BadRequestException("End date cannot be before start date.");
		}

		if (end.isAfter(LocalDate.now())) {
			throw new BadRequestException("End date cannot be in the future.");
		}

		// If your repository expects LocalDate range
		// If your repository still expects String format, then:
		List<OutgoingPaymentEntry> entries = outgoingPaymentRepo.findByBranchNameAndDateOfEntryBetween(branchName,
				start.format(formatter), end.format(formatter));
		return entries.stream().map(this::mapToDto).collect(Collectors.toList());
	}

	/**
	 * Create a new Outgoing Payment Entry.
	 * 
	 * Business Logic: - Branch and Ledger must exist (validated with
	 * case-insensitive match, but saved with original DB casing) - Date must be in
	 * 'yyyy-MM-dd' format and cannot be in the future - Duplicate entries are
	 * prevented using branch, ledger, date, amount, mode, and remarks - Receipt ID
	 * is auto-generated in the format: RCPT-{BRANCH}-{DATE}-{UUID}
	 */
	@Transactional
	public OutgoingPaymentDto createOutgoingPayment(OutgoingPaymentDto dto) {
		// Trimming & Normalization
		dto.setBranchName(dto.getBranchName() != null ? dto.getBranchName().trim() : null);
		dto.setDebitLedger(dto.getDebitLedger() != null ? dto.getDebitLedger().trim() : null);
		dto.setCreditLedger(dto.getCreditLedger() != null ? dto.getCreditLedger().trim() : null);
		dto.setRemarks(dto.getRemarks() != null ? dto.getRemarks().replaceAll("\\s+", " ").trim().toLowerCase() : null);

		validateOutgoingPayment(dto);
		OutgoingPaymentEntry entity = mapToEntity(dto);

		// 📌 Auto-generate Receipt ID
		String branch = dto.getBranchName().toUpperCase();
		String dateStr = dto.getDateOfEntry().replace("-", "");
		String shortUUID = UUID.randomUUID().toString().substring(0, 8);
		String voucherId = "PMT-" + branch + "-" + dateStr + "-" + shortUUID;
		entity.setVoucherID(voucherId);

		BigDecimal amount = new BigDecimal(dto.getTransactionAmount());
		updateLedgerBalances(dto.getBranchName(), dto.getDebitLedger(), dto.getCreditLedger(), amount);
		return mapToDto(outgoingPaymentRepo.save(entity));
	}

	/**
	 * Validates the fields of an outgoing payment DTO.
	 *
	 * Checks include:
	 * <ul>
	 * <li>Branch must exist in DB.</li>
	 * <li>Date format must be 'yyyy-MM-dd' and not in the future.</li>
	 * <li>Ledger account must exist.</li>
	 * <li>Transfer mode must be from allowed values.</li>
	 * <li>Transaction amount must be numeric.</li>
	 * </ul>
	 *
	 * @param dto The {@link OutgoingPaymentDto} to validate.
	 * @throws BadRequestException if any validation rule fails.
	 */
	private void validateOutgoingPayment(OutgoingPaymentDto dto) {

		// 1. Validate branch
		if (!branchModuleRepo.existsByBranchNameIgnoreCase(dto.getBranchName())) {
			throw new BadRequestException("Invalid branch name: " + dto.getBranchName());
		}

		// 2. Validate date format
		LocalDate parsedDate;
		try {
			parsedDate = LocalDate.parse(dto.getDateOfEntry(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			if (parsedDate.isAfter(LocalDate.now())) {
				throw new BadRequestException("Date of entry cannot be in the future.");
			}
			dto.setDateOfEntry(parsedDate.toString());
		} catch (DateTimeParseException e) {
			throw new BadRequestException("Invalid date format. Expected yyyy-MM-dd.");
		}

		// 3. Validate Credit Ledger (Source of Payment → Cash/Bank under Assets)
		LedgerAccountMaster creditLedger = ledgerAccountRepository
				.findByBranchNameAndAccountTitleIgnoreCase(dto.getBranchName(), dto.getCreditLedger())
				.orElseThrow(() -> new BadRequestException("Invalid Credit Ledger for branch: " + dto.getBranchName()));

		if (!"Assets".equalsIgnoreCase(creditLedger.getGroupName())
				|| !(creditLedger.getAccountType().equalsIgnoreCase("Cash")
						|| creditLedger.getAccountType().equalsIgnoreCase("Bank"))) {
			throw new BadRequestException("Cr Ledger must be Cash/Bank under Assets group.");
		}

		// 4. Validate Debit Ledger (Destination → Liabilities, Expenses, Equity only)
		LedgerAccountMaster debitLedger = ledgerAccountRepository
				.findByBranchNameAndAccountTitleIgnoreCase(dto.getBranchName(), dto.getDebitLedger())
				.orElseThrow(() -> new BadRequestException("Invalid Dr Ledger for branch: " + dto.getBranchName()));

		if (!(debitLedger.getGroupName().equalsIgnoreCase("Liabilities")
				|| debitLedger.getGroupName().equalsIgnoreCase("Expenses")
				|| debitLedger.getGroupName().equalsIgnoreCase("Equity")
				|| (debitLedger.getGroupName().equalsIgnoreCase("Assets")
						&& (debitLedger.getAccountType().equalsIgnoreCase("LOAN_TO_MEMBERS")
								|| debitLedger.getAccountType().equalsIgnoreCase("GOLD_LOANS")
								|| debitLedger.getAccountType().equalsIgnoreCase("JOINT_LOANS"))))) {
			throw new BadRequestException("Debit Ledger must belong to Liabilities, Expenses, or Equity.");
		}

		// 5. Validate transfer mode
		List<String> validModes = Arrays.asList("Cash", "Bank", "UPI", "Cheque", "Online Transfer");
		if (!validModes.contains(dto.getTransferMode())) {
			throw new BadRequestException("Invalid transfer mode: " + dto.getTransferMode());

		}
		if ("CHEQUE".equalsIgnoreCase(dto.getTransferMode())) {
			if (dto.getChequeNo() == null || dto.getChequeNo().trim().isEmpty()) {
				throw new BadRequestException("Cheque No is required");
			}
			if (dto.getChequeDate() == null) {
				throw new BadRequestException("Cheque Date is required");
			}
			if (dto.getBankName() == null || dto.getBankName().trim().isEmpty()) {
				throw new BadRequestException("Bank Name is required");
			}
		}

		if ("ONLINE_TRANSFER".equalsIgnoreCase(dto.getTransferMode())) {
			if (dto.getTransactionRef() == null || dto.getTransactionRef().trim().isEmpty()) {
				throw new BadRequestException("Transaction Ref is required");
			}
		}

		// 6. Validate amount
		try {
			BigDecimal amount = new BigDecimal(dto.getTransactionAmount());
			if (amount.compareTo(BigDecimal.ZERO) <= 0) {
				throw new BadRequestException("Transaction amount must be greater than zero.");
			}
		} catch (NumberFormatException e) {
			throw new BadRequestException("Invalid transaction amount.");
		}

	}

	/**
	 * Retrieves all outgoing payment entries from the database.
	 *
	 * @return List of {@link OutgoingPaymentDto} representing all outgoing
	 *         payments.
	 */
	public List<OutgoingPaymentDto> getAllOutgoingPayment() {
		return outgoingPaymentRepo.findAll().stream().map(this::mapToDto).collect(Collectors.toList());
	}

	/**
	 * Retrieves a specific outgoing payment by its unique identifier.
	 *
	 * @param id The ID of the outgoing payment to retrieve.
	 * @return {@link OutgoingPaymentDto} representing the found outgoing payment.
	 * @throws ResourceNotFoundException if no payment is found with the given ID.
	 */
	public OutgoingPaymentDto getOutgoingPayment(Long id) {
		OutgoingPaymentEntry entity = outgoingPaymentRepo.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("OutgoingPayment", "id", id));
		return mapToDto(entity);
	}

	private OutgoingPaymentEntry mapToEntity(OutgoingPaymentDto dto) {
		OutgoingPaymentEntry entity = new OutgoingPaymentEntry();
		entity.setId(dto.getId());
		entity.setBranchName(dto.getBranchName());
		entity.setDateOfEntry(dto.getDateOfEntry());
		entity.setCreditLedger(dto.getCreditLedger());
		entity.setDebitLedger(dto.getDebitLedger());
		entity.setTransferMode(dto.getTransferMode());
		entity.setChequeDate(dto.getChequeDate());
		entity.setChequeNo(dto.getChequeNo());
		entity.setBankName(dto.getBankName());
		entity.setTransactionRef(dto.getTransactionRef());
		entity.setTransactionAmount(dto.getTransactionAmount());
		entity.setRemarks(dto.getRemarks());
		return entity;
	}

	private OutgoingPaymentDto mapToDto(OutgoingPaymentEntry entity) {
		OutgoingPaymentDto dto = new OutgoingPaymentDto();
		dto.setId(entity.getId());
		dto.setBranchName(entity.getBranchName());
		dto.setVoucherID(entity.getVoucherID());
		dto.setDateOfEntry(entity.getDateOfEntry());
		dto.setCreditLedger(entity.getCreditLedger());
		dto.setDebitLedger(entity.getDebitLedger());
		dto.setTransferMode(entity.getTransferMode());
		dto.setChequeDate(entity.getChequeDate());
		dto.setChequeNo(entity.getChequeNo());
		dto.setBankName(entity.getBankName());
		dto.setTransactionRef(entity.getTransactionRef());
		dto.setTransactionAmount(entity.getTransactionAmount());
		dto.setRemarks(entity.getRemarks());
		return dto;
	}

	/**
	 * Searches for Incoming Receipt entries by branch name and date range.
	 *
	 * @param branchName The name of the branch to search payments for.
	 * @param startDate  The start date of the range in yyyy-MM-dd format.
	 * @param endDate    The end date of the range in yyyy-MM-dd format.
	 * @return List of {@link OutgoingPaymentEntry} matching the search criteria.
	 * @throws BadRequestException if the date format is invalid, if the end date is
	 *                             before the start date, or if the end date is in
	 *                             the future.
	 */

	public List<IncomingReceiptDto> searchIncomingReceipt(String branchName, String startDate, String endDate) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate start;
		LocalDate end;

		try {
			start = LocalDate.parse(startDate, formatter);
			end = LocalDate.parse(endDate, formatter);
		} catch (DateTimeParseException e) {
			throw new BadRequestException("Invalid date format. Expected yyyy-MM-dd.");
		}
		if (!branchModuleRepo.existsByBranchNameIgnoreCase(branchName)) {
			throw new BadRequestException("Invalid branch name: " + branchName);
		}

		if (end.isBefore(start)) {
			throw new BadRequestException("End date cannot be before start date.");
		}

		if (end.isAfter(LocalDate.now())) {
			throw new BadRequestException("End date cannot be in the future.");
		}

		List<IncomingReceiptEntry> entries = incomingReceiptRepo.findByBranchNameAndDateOfEntryBetween(branchName,
				start.format(formatter), end.format(formatter));

		return entries.stream().map(this::mapToDto).collect(Collectors.toList());

	}

	/**
	 * Create a new Incoming Receipt Entry.
	 * 
	 * Business Logic: - Branch and Ledger must exist (validated with
	 * case-insensitive match, but saved with original DB casing) - Date must be in
	 * 'yyyy-MM-dd' format and cannot be in the future - Duplicate entries are
	 * prevented using branch, ledger, date, amount, mode, and remarks - Receipt ID
	 * is auto-generated in the format: RCPT-{BRANCH}-{DATE}-{UUID}
	 */

	@Transactional
	public IncomingReceiptDto createIncomingReceipt(IncomingReceiptDto dto) {

		// Trimming & Normalization
		dto.setBranchName(dto.getBranchName() != null ? dto.getBranchName().trim() : null);
		dto.setDebitLedger(dto.getDebitLedger() != null ? dto.getDebitLedger().trim() : null);
		dto.setCreditLedger(dto.getCreditLedger() != null ? dto.getCreditLedger().trim() : null);
		dto.setRemarks(dto.getRemarks() != null ? dto.getRemarks().replaceAll("\\s+", " ").trim().toLowerCase() : null);

		// Branch validation
		branchModuleRepo.findByBranchNameIgnoreCase(dto.getBranchName()).map(branch -> {
			dto.setBranchName(branch.getBranchName());
			return branch;
		}).orElseThrow(() -> new BadRequestException("Invalid branch name: " + dto.getBranchName()));

		validateIncomingReceipt(dto);

		IncomingReceiptEntry entity = mapToEntity(dto);

		// 📌 Auto-generate Receipt ID
		String branch = dto.getBranchName().toUpperCase();
		String dateStr = dto.getDateOfEntry().replace("-", "");
		String shortUUID = UUID.randomUUID().toString().substring(0, 8);
		String voucherID = "RCPT-" + branch + "-" + dateStr + "-" + shortUUID;

		entity.setVoucherID(voucherID);

		// Update ledger balances
		BigDecimal amount = new BigDecimal(dto.getTransactionAmount());
		updateLedgerBalances(dto.getBranchName(), dto.getDebitLedger(), dto.getCreditLedger(), amount);

		return mapToDto(incomingReceiptRepo.save(entity));
	}

	private void validateIncomingReceipt(IncomingReceiptDto dto) {

		// 1. Validate branch
		if (!branchModuleRepo.existsByBranchNameIgnoreCase(dto.getBranchName())) {
			throw new BadRequestException("Invalid branch name: " + dto.getBranchName());
		}

		// 2. Validate date format
		LocalDate parsedDate;
		try {
			parsedDate = LocalDate.parse(dto.getDateOfEntry(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			if (parsedDate.isAfter(LocalDate.now())) {
				throw new BadRequestException("Date of entry cannot be in the future.");
			}
			dto.setDateOfEntry(parsedDate.toString());
		} catch (DateTimeParseException e) {
			throw new BadRequestException("Invalid date format. Expected yyyy-MM-dd.");
		}

		// 3. Validate Debit Ledger (Destination → Cash/Bank under Assets)
		LedgerAccountMaster debitLedger = ledgerAccountRepository
				.findByBranchNameAndAccountTitleIgnoreCase(dto.getBranchName(), dto.getDebitLedger())
				.orElseThrow(() -> new BadRequestException("Invalid Debit Ledger for branch: " + dto.getBranchName()));

		if (!"Assets".equalsIgnoreCase(debitLedger.getGroupName())
				|| !(debitLedger.getAccountType().equalsIgnoreCase("Cash")
						|| debitLedger.getAccountType().equalsIgnoreCase("Bank"))) {
			throw new BadRequestException("Debit Ledger must be Cash/Bank under Assets group.");
		}

		// 4. Validate Credit Ledger (Source → Liabilities, Equity, or Income)
		LedgerAccountMaster creditLedger = ledgerAccountRepository
				.findByBranchNameAndAccountTitleIgnoreCase(dto.getBranchName(), dto.getCreditLedger())
				.orElseThrow(() -> new BadRequestException("Invalid Credit Ledger for branch: " + dto.getBranchName()));

		if (!(creditLedger.getGroupName().equalsIgnoreCase("Liabilities")
				|| creditLedger.getGroupName().equalsIgnoreCase("Equity")
				|| creditLedger.getGroupName().equalsIgnoreCase("Income")
				|| (creditLedger.getGroupName().equalsIgnoreCase("Assets")
						&& (creditLedger.getAccountType().equalsIgnoreCase("LOAN_TO_MEMBERS")
								|| creditLedger.getAccountType().equalsIgnoreCase("GOLD_LOANS")
								|| creditLedger.getAccountType().equalsIgnoreCase("JOINT_LOANS"))))) {
			throw new BadRequestException("Credit Ledger must belong to Liabilities, Equity, or Income.");
		}

		// 5. Validate transfer mode
		List<String> validModes = Arrays.asList("Cash", "Bank", "UPI", "Cheque", "Online Transfer");
		if (!validModes.contains(dto.getTransferMode())) {
			throw new BadRequestException("Invalid transfer mode: " + dto.getTransferMode());

		}
		if ("CHEQUE".equalsIgnoreCase(dto.getTransferMode())) {
			if (dto.getChequeNo() == null || dto.getChequeNo().trim().isEmpty()) {
				throw new BadRequestException("Cheque No is required");
			}
			if (dto.getChequeDate() == null) {
				throw new BadRequestException("Cheque Date is required");
			}
			if (dto.getBankName() == null || dto.getBankName().trim().isEmpty()) {
				throw new BadRequestException("Bank Name is required");
			}
		}

		if ("ONLINE_TRANSFER".equalsIgnoreCase(dto.getTransferMode())) {
			if (dto.getTransactionRef() == null || dto.getTransactionRef().trim().isEmpty()) {
				throw new BadRequestException("Transaction Ref is required");
			}
		}

		if ("ONLINE_TRANSFER".equalsIgnoreCase(dto.getTransferMode())) {
			if (dto.getTransactionRef() == null || dto.getTransactionRef().trim().isEmpty()) {
				throw new BadRequestException("Transaction Ref is required");
			}
		}

		// 6. Validate amount
		try {
			BigDecimal amount = new BigDecimal(dto.getTransactionAmount());
			if (amount.compareTo(BigDecimal.ZERO) <= 0) {
				throw new BadRequestException("Transaction amount must be greater than zero.");
			}
		} catch (NumberFormatException e) {
			throw new BadRequestException("Invalid transaction amount.");
		}

	}

	public List<IncomingReceiptDto> getAllIncomingReceipt() {
		return incomingReceiptRepo.findAll().stream().map(this::mapToDto).collect(Collectors.toList());
	}

	public IncomingReceiptDto getIncomingReceipt(Long id) {
		IncomingReceiptEntry entity = incomingReceiptRepo.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("IncomingReceipt", "id", id));
		return mapToDto(entity);
	}

	private IncomingReceiptEntry mapToEntity(IncomingReceiptDto dto) {
		IncomingReceiptEntry entity = new IncomingReceiptEntry();
		entity.setId(dto.getId());
		entity.setBranchName(dto.getBranchName());
		entity.setDateOfEntry(dto.getDateOfEntry());
		entity.setCreditLedger(dto.getCreditLedger());
		entity.setDebitLedger(dto.getDebitLedger());
		entity.setTransferMode(dto.getTransferMode());
		entity.setChequeDate(dto.getChequeDate());
		entity.setChequeNo(dto.getChequeNo());
		entity.setBankName(dto.getBankName());
		entity.setTransactionRef(dto.getTransactionRef());
		entity.setTransactionAmount(dto.getTransactionAmount());
		entity.setRemarks(dto.getRemarks());
		return entity;
	}

	private IncomingReceiptDto mapToDto(IncomingReceiptEntry entity) {
		IncomingReceiptDto dto = new IncomingReceiptDto();
		dto.setId(entity.getId());
		dto.setBranchName(entity.getBranchName());
		dto.setVoucherID(entity.getVoucherID());
		dto.setDateOfEntry(entity.getDateOfEntry());
		dto.setCreditLedger(entity.getCreditLedger());
		dto.setDebitLedger(entity.getDebitLedger());
		dto.setTransferMode(entity.getTransferMode());
		dto.setChequeDate(entity.getChequeDate());
		dto.setChequeNo(entity.getChequeNo());
		dto.setBankName(entity.getBankName());
		dto.setTransactionRef(entity.getTransactionRef());
		dto.setTransactionAmount(entity.getTransactionAmount());
		dto.setRemarks(entity.getRemarks());
		return dto;
	}

	// BankCashTransferEntry

	public List<BankCashTransferDto> searchBankCashTransfer(String branchName, String startDate, String endDate) {

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate start;
		LocalDate end;

		try {
			start = LocalDate.parse(startDate, formatter);
			end = LocalDate.parse(endDate, formatter);
		} catch (DateTimeParseException e) {
			throw new BadRequestException("Invalid date format. Expected yyyy-MM-dd.");
		}
		if (!branchModuleRepo.existsByBranchNameIgnoreCase(branchName)) {
			throw new BadRequestException("Invalid branch name: " + branchName);
		}

		if (end.isBefore(start)) {
			throw new BadRequestException("End date cannot be before start date.");
		}

		if (end.isAfter(LocalDate.now())) {
			throw new BadRequestException("End date cannot be in the future.");
		}
		System.out.println("Searching for Branch: [" + branchName + "], Start: " + start + ", End: " + end);

		// ✅ Main repo call
		List<BankCashTransferEntry> entries = bankCashTransferRepo.findByBranchNameIgnoreCaseAndDateOfEntryBetween(
				branchName, start.format(formatter), end.format(formatter));
		if (entries.isEmpty()) {
			throw new BadRequestException("No transfers found for given search criteria.");
		}

		// ✅ DEBUG LOG AFTER QUERY
		System.out.println("Records found: " + entries.size());

		return entries.stream().map(this::mapToDto).collect(Collectors.toList());

	}

	@Transactional
	public BankCashTransferDto createBankCashTransfer(BankCashTransferDto dto) {
		BankCashTransferEntry entity = mapToEntity(dto);

		validateBankCashTransfer(dto);
		System.out.println("Duplicate Check (Bank Cash): " + dto.getBranchName() + ", " + dto.getDateOfEntry() + ", "
				+ dto.getDebitLedger() + ", " + dto.getCreditLedger() + ", " + dto.getTransactionAmount());

		boolean exists = bankCashTransferRepo
				.existsByBranchNameIgnoreCaseAndDateOfEntryAndDebitLedgerIgnoreCaseAndCreditLedgerIgnoreCaseAndTransactionAmount(
						dto.getBranchName().trim(), dto.getDateOfEntry().trim(), dto.getDebitLedger().trim(),
						dto.getCreditLedger().trim(), dto.getTransactionAmount().trim());

		if (exists) {
			throw new BadRequestException(
					"Duplicate bank/cash transfer entry detected for the same branch, date, ledgers, and amount.");
		}

		String branch = dto.getBranchName().toUpperCase();
		String dateStr = dto.getDateOfEntry().replace("-", "");
		String shortUUID = UUID.randomUUID().toString().substring(0, 8);
		String voucherId = "CNTR-" + branch + "-" + dateStr + "-" + shortUUID;

		entity.setVoucherID(voucherId);

		// Update ledger balances
		BigDecimal amount = new BigDecimal(dto.getTransactionAmount());
		updateLedgerBalances(dto.getBranchName(), dto.getDebitLedger(), dto.getCreditLedger(), amount);

		return mapToDto(bankCashTransferRepo.save(entity));

	}

	private void validateBankCashTransfer(BankCashTransferDto dto) {

		// A. Validate Branch
		if (!branchModuleRepo.existsByBranchNameIgnoreCase(dto.getBranchName())) {
			throw new BadRequestException("Invalid branch name: " + dto.getBranchName());
		}

		// B. Validate Date Format and Future Date
		LocalDate parsedDate;
		try {
			parsedDate = LocalDate.parse(dto.getDateOfEntry(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			dto.setDateOfEntry(parsedDate.toString()); // normalize
		} catch (DateTimeParseException e) {
			throw new BadRequestException("Invalid date format. Expected yyyy-MM-dd.");
		}

		if (parsedDate.isAfter(LocalDate.now())) {
			throw new BadRequestException("Date of entry cannot be in the future.");
		}

		// C. Validate Amount
		try {
			BigDecimal amount = new BigDecimal(dto.getTransactionAmount());

			if (amount.compareTo(BigDecimal.ZERO) <= 0) {
				throw new BadRequestException("Transaction amount must be greater than zero.");
			}
		} catch (NumberFormatException e) {
			throw new BadRequestException("Invalid transaction amount format.");
		}

		// D. Validate Ledgers & Groups (re-use existing method)
		validateLedgerGroups(dto.getDebitLedger(), dto.getCreditLedger(), dto.getBranchName());

		// E. Validate transfer mode
		List<String> validModes = Arrays.asList("Cash Deposit", "Cash Withdrawal", "Cheque", "Online Transfer");
		if (!validModes.contains(dto.getTransferMode())) {
			throw new BadRequestException("Invalid transfer mode: " + dto.getTransferMode());

		}
		if ("Cheque".equalsIgnoreCase(dto.getTransferMode())) {
			if (dto.getChequeNo() == null || dto.getChequeNo().trim().isEmpty()) {
				throw new BadRequestException("Cheque No is required");
			}
			if (dto.getChequeDate() == null) {
				throw new BadRequestException("Cheque Date is required");
			}
			if (dto.getBankName() == null || dto.getBankName().trim().isEmpty()) {
				throw new BadRequestException("Bank Name is required");
			}
		}

		if ("Online transfer".equalsIgnoreCase(dto.getTransferMode())) {
			if (dto.getTransactionRef() == null || dto.getTransactionRef().trim().isEmpty()) {
				throw new BadRequestException("Transaction Ref is required");
			}
		}

	}

	private void validateLedgerGroups(String debitLedger, String creditLedger, String branchName) {
		LedgerAccountMaster debit = ledgerAccountRepository.findByAccountTitleAndBranchName(debitLedger, branchName)
				.orElseThrow(() -> new BadRequestException("Invalid debit ledger: " + debitLedger));

		LedgerAccountMaster credit = ledgerAccountRepository.findByAccountTitleAndBranchName(creditLedger, branchName)
				.orElseThrow(() -> new BadRequestException("Invalid credit ledger: " + creditLedger));

		// ✅ Both must be Assets group
		if (!"Assets".equalsIgnoreCase(debit.getGroupName()) || !("Cash".equalsIgnoreCase(debit.getAccountType())
				|| "Bank".equalsIgnoreCase(debit.getAccountType()))) {
			throw new BadRequestException("Debit ledger must be Cash/Bank under Assets group.");
		}

		if (!"Assets".equalsIgnoreCase(credit.getGroupName()) || !("Cash".equalsIgnoreCase(credit.getAccountType())
				|| "Bank".equalsIgnoreCase(credit.getAccountType()))) {
			throw new BadRequestException("Credit ledger must be Cash/Bank under Assets group.");
		}

		// ✅ Prevent Cash→Cash or Bank→Bank same ledger
		if (debitLedger.equalsIgnoreCase(creditLedger)) {
			throw new BadRequestException("Debit and Credit ledgers cannot be the same.");
		}

		// ✅ Branch consistency
		if (!debit.getBranchName().equalsIgnoreCase(credit.getBranchName())) {
			throw new BadRequestException("Both ledgers must belong to the same branch.");
		}
	}

	public List<BankCashTransferDto> getAllBankCashTransfer() {
		return bankCashTransferRepo.findAll().stream().map(this::mapToDto).collect(Collectors.toList());
	}

	public BankCashTransferDto getBankCashTransfer(Long id) {
		BankCashTransferEntry entity = bankCashTransferRepo.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("BankCashTransfer", "id", id));
		return mapToDto(entity);
	}

	/*
	 * public List<LedgerAccountMaster> getBankCashLedgersByBranch(String
	 * branchName) { List<String> groups = Arrays.asList("Bank", "Cash"); return
	 * ledgerAccountRepository.findByBranchNameIgnoreCaseAndGroupNameIn(branchName,
	 * groups); }
	 */

	private BankCashTransferEntry mapToEntity(BankCashTransferDto dto) {
		BankCashTransferEntry entity = new BankCashTransferEntry();
		entity.setId(dto.getId());
		entity.setBranchName(dto.getBranchName());
		entity.setDateOfEntry(dto.getDateOfEntry());
		entity.setCreditLedger(dto.getCreditLedger());
		entity.setDebitLedger(dto.getDebitLedger());
		entity.setTransferMode(dto.getTransferMode());
		entity.setChequeDate(dto.getChequeDate());
		entity.setChequeNo(dto.getChequeNo());
		entity.setBankName(dto.getBankName());
		entity.setTransactionRef(dto.getTransactionRef());
		entity.setTransactionAmount(dto.getTransactionAmount());
		entity.setRemarks(dto.getRemarks());
		return entity;
	}

	private BankCashTransferDto mapToDto(BankCashTransferEntry entity) {
		BankCashTransferDto dto = new BankCashTransferDto();
		dto.setId(entity.getId());
		dto.setBranchName(entity.getBranchName());
		dto.setVoucherID(entity.getVoucherID());
		dto.setDateOfEntry(entity.getDateOfEntry());
		dto.setCreditLedger(entity.getCreditLedger());
		dto.setDebitLedger(entity.getDebitLedger());
		dto.setTransferMode(entity.getTransferMode());
		dto.setChequeDate(entity.getChequeDate());
		dto.setChequeNo(entity.getChequeNo());
		dto.setBankName(entity.getBankName());
		dto.setTransactionRef(entity.getTransactionRef());
		dto.setTransactionAmount(entity.getTransactionAmount());
		dto.setRemarks(entity.getRemarks());
		return dto;
	}

	/**
	 * Searches Manual Journal entries for a given branch and date range.
	 * 
	 * Business Logic: - Validates date format and range. - Validates branch
	 * existence. - Prevents future end dates and end date before start date.
	 * 
	 * @param branchName The branch to search in.
	 * @param startDate  Start date in yyyy-MM-dd format.
	 * @param endDate    End date in yyyy-MM-dd format.
	 * @return List of ManualJournalDto objects matching criteria.
	 * @throws BadRequestException if validation fails.
	 */
	public List<ManualJournalDto> searchManualJournal(String branchName, String startDate, String endDate) {
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		LocalDate start;
		LocalDate end;

		try {
			start = LocalDate.parse(startDate, formatter);
			end = LocalDate.parse(endDate, formatter);
		} catch (DateTimeParseException e) {
			throw new BadRequestException("Invalid date format. Expected yyyy-MM-dd.");
		}

		if (!branchModuleRepo.existsByBranchNameIgnoreCase(branchName)) {
			throw new BadRequestException("Invalid branch name: " + branchName);
		}

		if (end.isBefore(start)) {
			throw new BadRequestException("End date cannot be before start date.");
		}

		if (end.isAfter(LocalDate.now())) {
			throw new BadRequestException("End date cannot be in the future.");
		}

		List<ManualJournalEntry> entries = manualJournalRepo.findByBranchNameAndDateOfEntryBetween(branchName,
				start.format(formatter), end.format(formatter));

		return entries.stream().map(this::mapToDto).collect(Collectors.toList());
	}

	/**
	 * Retrieves all eligible ledgers for Manual Journal entry for a branch.
	 * 
	 * Business Logic: - Only ledgers belonging to allowed groups are eligible.
	 * 
	 * @param branchName Branch name.
	 * @return List of LedgerAccountMaster objects in allowed groups for that
	 *         branch.
	 */

	public List<LedgerAccountMaster> getEligibleLedgersForManualJournal(String branchName) {
		List<String> allowedGroups = Arrays.asList("ASSETS", "LIABILITIES", "INCOME", "EXPENSES", "EQUITY");

		return ledgerAccountRepository.findByBranchNameIgnoreCaseAndGroupNameIn(branchName, allowedGroups);
	}

	/**
	 * Creates a new Manual Journal entry.
	 * 
	 * Business Logic: - Validates input via validateManualJournal. - Prevents
	 * duplicate entries based on branch, date, ledgers, and amount. -
	 * Auto-generates receipt ID.
	 * 
	 * @param dto ManualJournalDto containing entry data.
	 * @return ManualJournalDto for the created entry.
	 * @throws BadRequestException if business validation fails or duplicate exists.
	 */
	@Transactional
	public ManualJournalDto createManualJournal(ManualJournalDto dto) {
		ManualJournalEntry entity = mapToEntity(dto);

		validateManualJournal(dto);
		System.out.println("Duplicate Check (Manual Journal): " + dto.getBranchName() + ", " + dto.getDateOfEntry()
				+ ", " + dto.getDebitLedger() + ", " + dto.getCreditLedger() + ", " + dto.getTransactionAmount());

		boolean exists = manualJournalRepo
				.existsByBranchNameIgnoreCaseAndDateOfEntryAndDebitLedgerIgnoreCaseAndCreditLedgerIgnoreCaseAndTransactionAmount(
						dto.getBranchName().trim(), dto.getDateOfEntry().trim(), dto.getDebitLedger().trim(),
						dto.getCreditLedger().trim(), dto.getTransactionAmount().trim());

		if (exists) {
			throw new BadRequestException(
					"Duplicate bank/cash transfer entry detected for the same branch, date, ledgers, and amount.");
		}

		// 📌 Auto-generate Receipt ID
		String branch = dto.getBranchName().toUpperCase();
		String dateStr = dto.getDateOfEntry().replace("-", "");
		String shortUUID = UUID.randomUUID().toString().substring(0, 8);
		String voucherId = "JV-" + branch + "-" + dateStr + "-" + shortUUID;

		entity.setVoucherID(voucherId);

		// Update ledger balances
		BigDecimal amount = new BigDecimal(dto.getTransactionAmount());
		updateLedgerBalances(dto.getBranchName(), dto.getDebitLedger(), dto.getCreditLedger(), amount);

		return mapToDto(manualJournalRepo.save(entity));
	}

	/**
	 * Validates Manual Journal entry business rules.
	 * 
	 * Checks: - Branch existence. - Date format and future date prevention. -
	 * Positive numeric transaction amount. - Ledgers are valid and belong to
	 * allowed groups and same branch.
	 * 
	 * @param dto ManualJournalDto to validate.
	 * @throws BadRequestException if any validation fails.
	 */
	private void validateManualJournal(ManualJournalDto dto) {

		// A. Validate Branch
		if (!branchModuleRepo.existsByBranchNameIgnoreCase(dto.getBranchName().trim())) {
			throw new BadRequestException("Invalid branch name: " + dto.getBranchName());
		}

		// B. Validate Date Format and Future Date
		LocalDate parsedDate;
		try {
			parsedDate = LocalDate.parse(dto.getDateOfEntry().trim(), DateTimeFormatter.ofPattern("yyyy-MM-dd"));
			dto.setDateOfEntry(parsedDate.toString()); // normalize
		} catch (DateTimeParseException e) {
			throw new BadRequestException("Invalid date format. Expected yyyy-MM-dd.");
		}

		if (parsedDate.isAfter(LocalDate.now())) {
			throw new BadRequestException("Date of entry cannot be in the future.");
		}

		// C. Validate Amount
		try {
			BigDecimal amount = new BigDecimal(dto.getTransactionAmount().trim());

			if (amount.compareTo(BigDecimal.ZERO) <= 0) {
				throw new BadRequestException("Transaction amount must be greater than zero.");
			}
		} catch (NumberFormatException e) {
			throw new BadRequestException("Invalid transaction amount format.");
		}

		// D. Validate Ledgers & Groups (re-use existing method)
		validateLedgerGroupsManual(dto.getDebitLedger(), dto.getCreditLedger(), dto.getBranchName());
	}

	/**
	 * Validates selected ledgers for Manual Journal entry.
	 * 
	 * Checks: - Both ledgers exist for branch. - Both ledgers belong to allowed
	 * groups. - Debit/Credit ledgers are not the same. - Both ledgers are for the
	 * same branch.
	 * 
	 * @param debitLedger  Debit ledger account title.
	 * @param creditLedger Credit ledger account title.
	 * @param branchName   Branch name.
	 * @throws IllegalArgumentException if any validation fails.
	 */
	private void validateLedgerGroupsManual(String debitLedger, String creditLedger, String branchName) {

		List<String> allowedGroups = Arrays.asList("ASSETS", "LIABILITIES", "INCOME", "EXPENSES", "EQUITY");

		String sanitizedDebitLedger = debitLedger.trim();
		String sanitizedCreditLedger = creditLedger.trim();
		String sanitizedBranch = branchName.trim();

		LedgerAccountMaster debit = ledgerAccountRepository
				.findByAccountTitleAndBranchName(sanitizedDebitLedger, sanitizedBranch)
				.orElseThrow(() -> new IllegalArgumentException("Invalid debit ledger: " + sanitizedDebitLedger));

		LedgerAccountMaster credit = ledgerAccountRepository
				.findByAccountTitleAndBranchName(sanitizedCreditLedger, sanitizedBranch)
				.orElseThrow(() -> new IllegalArgumentException("Invalid credit ledger: " + sanitizedCreditLedger));

		// 1. Ledger groups must be valid
		if (!allowedGroups.contains(debit.getGroupName())) {
			throw new BadRequestException("Invalid group for Debit Ledger '" + debit.getAccountTitle()
					+ "'. Allowed groups: " + allowedGroups);
		}
		if (!allowedGroups.contains(credit.getGroupName())) {
			throw new BadRequestException("Invalid group for Credit Ledger '" + credit.getAccountTitle()
					+ "'. Allowed groups: " + allowedGroups);
		}

		// 2. Debit and Credit ledger cannot be the same
		if (sanitizedDebitLedger.equalsIgnoreCase(sanitizedCreditLedger)) {
			throw new BadRequestException("Debit and Credit ledgers cannot be the same.");
		}

		// 3. Branch validation
		if (!debit.getBranchName().equalsIgnoreCase(credit.getBranchName())) {
			throw new BadRequestException("Debit and Credit Ledgers must belong to the same branch.");
		}

		// 4. JV-specific validation: Do not allow BOTH debit or credit as Cash/Bank
		if ("Cash".equalsIgnoreCase(debit.getAccountType()) || "Bank".equalsIgnoreCase(debit.getAccountType())
				|| "Cash".equalsIgnoreCase(credit.getAccountType())
				|| "Bank".equalsIgnoreCase(credit.getAccountType())) {
			throw new BadRequestException(
					"Cash/Bank ledgers are not allowed in Journal Voucher. Use Payment/Receipt/Contra for such entries.");
		}

	}

	public List<ManualJournalDto> getAllManualJournal() {
		return manualJournalRepo.findAll().stream().map(this::mapToDto).collect(Collectors.toList());
	}

	public ManualJournalDto getManualJournal(Long id) {
		ManualJournalEntry entity = manualJournalRepo.findById(id)
				.orElseThrow(() -> new ResourceNotFoundException("ManualJournal", "id", id));
		return mapToDto(entity);
	}

	private ManualJournalEntry mapToEntity(ManualJournalDto dto) {
		ManualJournalEntry entity = new ManualJournalEntry();
		entity.setId(dto.getId());
		entity.setBranchName(dto.getBranchName());
		entity.setDateOfEntry(dto.getDateOfEntry());
		entity.setCreditLedger(dto.getCreditLedger());
		entity.setDebitLedger(dto.getDebitLedger());
		entity.setTransactionAmount(dto.getTransactionAmount());
		entity.setRemarks(dto.getRemarks());
		return entity;
	}

	private ManualJournalDto mapToDto(ManualJournalEntry entity) {
		ManualJournalDto dto = new ManualJournalDto();
		dto.setId(entity.getId());
		dto.setBranchName(entity.getBranchName());
		dto.setVoucherID(entity.getVoucherID());
		dto.setDateOfEntry(entity.getDateOfEntry());
		dto.setCreditLedger(entity.getCreditLedger());
		dto.setDebitLedger(entity.getDebitLedger());
		dto.setTransactionAmount(entity.getTransactionAmount());
		dto.setRemarks(entity.getRemarks());
		return dto;
	}

	public List<LedgerSummaryDto> getLedgerSummary(String branch, String ledger, LocalDate startDate,
			LocalDate endDate) {
		List<LedgerSummaryDto> summaryList = new ArrayList<>();

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String startDateStr = startDate.format(formatter);
		String endDateStr = endDate.format(formatter);

		// Fetch all types of transactions
		List<OutgoingPaymentEntry> outgoing = ledgerSummaryRepo.findOutgoingTransactions(branch, ledger, startDateStr,
				endDateStr);
		List<IncomingReceiptEntry> incoming = ledgerSummaryRepo.findIncomingTransactions(branch, ledger, startDateStr,
				endDateStr);
		List<BankCashTransferEntry> transfer = ledgerSummaryRepo.findTransferTransactions(branch, ledger, startDateStr,
				endDateStr);
		List<ManualJournalEntry> journal = ledgerSummaryRepo.findJournalTransactions(branch, ledger, startDateStr,
				endDateStr);

		String accountCode = "";
		Optional<LedgerAccountMaster> ledgerMaster = ledgerAccountRepository.findByAccountTitleAndBranchName(ledger,
				branch);
		if (ledgerMaster.isPresent()) {
			accountCode = ledgerMaster.get().getAccountCode();
		}
		// Combine all into one list
		for (OutgoingPaymentEntry o : outgoing) {
			LedgerSummaryDto dto = new LedgerSummaryDto();
			dto.setDateOfEntry(o.getDateOfEntry());
			dto.setVoucherId(o.getVoucherID());
			dto.setRemarks(o.getRemarks());
			dto.setAccountCode(accountCode);

			if (ledger.equalsIgnoreCase(o.getCreditLedger())) {
				dto.setCredit(new BigDecimal(o.getTransactionAmount()).toPlainString());
				dto.setDebit(BigDecimal.ZERO.toPlainString());
			} else if (ledger.equalsIgnoreCase(o.getDebitLedger())) {
				dto.setDebit(new BigDecimal(o.getTransactionAmount()).toPlainString());
				dto.setCredit(BigDecimal.ZERO.toPlainString());
			}
			summaryList.add(dto);
		}

		for (IncomingReceiptEntry i : incoming) {
			LedgerSummaryDto dto = new LedgerSummaryDto();
			dto.setDateOfEntry(i.getDateOfEntry());
			dto.setVoucherId(i.getVoucherID());
			dto.setRemarks(i.getRemarks());
			dto.setAccountCode(accountCode);

			if (ledger.equalsIgnoreCase(i.getCreditLedger())) {
				dto.setCredit(new BigDecimal(i.getTransactionAmount()).toPlainString());
				dto.setDebit(BigDecimal.ZERO.toPlainString());
			} else if (ledger.equalsIgnoreCase(i.getDebitLedger())) {
				dto.setDebit(new BigDecimal(i.getTransactionAmount()).toPlainString());
				dto.setCredit(BigDecimal.ZERO.toPlainString());
			}
			summaryList.add(dto);
		}

		for (BankCashTransferEntry t : transfer) {
			LedgerSummaryDto dto = new LedgerSummaryDto();
			dto.setDateOfEntry(t.getDateOfEntry());
			dto.setVoucherId(t.getVoucherID());
			dto.setRemarks(t.getRemarks());
			dto.setAccountCode(accountCode);

			if (ledger.equalsIgnoreCase(t.getCreditLedger())) {
				dto.setCredit(new BigDecimal(t.getTransactionAmount()).toPlainString());
				dto.setDebit(BigDecimal.ZERO.toPlainString());
			} else if (ledger.equalsIgnoreCase(t.getDebitLedger())) {
				dto.setDebit(new BigDecimal(t.getTransactionAmount()).toPlainString());
				dto.setCredit(BigDecimal.ZERO.toPlainString());
			}
			summaryList.add(dto);
		}

		for (ManualJournalEntry j : journal) {
			LedgerSummaryDto dto = new LedgerSummaryDto();
			dto.setDateOfEntry(j.getDateOfEntry());
			dto.setVoucherId(j.getVoucherID());
			dto.setRemarks(j.getRemarks());
			dto.setAccountCode(accountCode);

			if (ledger.equalsIgnoreCase(j.getCreditLedger())) {
				dto.setCredit(new BigDecimal(j.getTransactionAmount()).toPlainString());
				dto.setDebit(BigDecimal.ZERO.toPlainString());
			} else if (ledger.equalsIgnoreCase(j.getDebitLedger())) {
				dto.setDebit(new BigDecimal(j.getTransactionAmount()).toPlainString());
				dto.setCredit(BigDecimal.ZERO.toPlainString());
			}

			summaryList.add(dto);
		}

		// Add Opening & Closing Balances
		// --- Add Opening and Closing Balances ---
		Optional<LedgerAccountMaster> ledgerAccount = ledgerAccountRepository.findByAccountTitleAndBranchName(ledger,
				branch);
		ledgerAccount.ifPresent(account -> {
			final BigDecimal opening = account.getOpeningBalance();
			final BigDecimal current = account.getCurrentBalance();

			for (LedgerSummaryDto s : summaryList) {
				s.setOpeningBalance(opening);
				s.setClosingBalance(current);
			}
		});

		return summaryList;
	}

	public Map<String, Object> getJournalEntryReport(String branch, String voucherType, LocalDate startDate,
			LocalDate endDate) {

		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
		String startDateStr = startDate.format(formatter);
		String endDateStr = endDate.format(formatter);

		List<JournalEntryReportDto> entries = new ArrayList<>();
		BigDecimal totalDebit = BigDecimal.ZERO;
		BigDecimal totalCredit = BigDecimal.ZERO;

		switch (voucherType.toLowerCase()) {
		case "payment":
			List<OutgoingPaymentEntry> outgoing = journalEntryReportRepo.findAllOutgoing(branch, startDateStr,
					endDateStr);
			for (OutgoingPaymentEntry o : outgoing) {
				BigDecimal amount = o.getTransactionAmount() != null ? new BigDecimal(o.getTransactionAmount())
						: BigDecimal.ZERO;
				// Debit entry
				if (o.getDebitLedger() != null && !o.getDebitLedger().isEmpty()) {
					JournalEntryReportDto debitDto = mapEntryToDto(o.getDateOfEntry(), o.getVoucherID(), o.getRemarks(),
							branch, o.getDebitLedger(), null, amount);
					entries.add(debitDto);
					totalDebit = totalDebit.add(amount);
				}

				// Credit entry
				if (o.getCreditLedger() != null && !o.getCreditLedger().isEmpty()) {
					JournalEntryReportDto creditDto = mapEntryToDto(o.getDateOfEntry(), o.getVoucherID(),
							o.getRemarks(), branch, null, o.getCreditLedger(), amount);
					entries.add(creditDto);
					totalCredit = totalCredit.add(amount);
				}
			}
			break;

		case "receipt":
			List<IncomingReceiptEntry> incoming = journalEntryReportRepo.findAllIncoming(branch, startDateStr,
					endDateStr);
			for (IncomingReceiptEntry i : incoming) {
				BigDecimal amount = i.getTransactionAmount() != null ? new BigDecimal(i.getTransactionAmount())
						: BigDecimal.ZERO;
				if (i.getDebitLedger() != null && !i.getDebitLedger().isEmpty()) {
					JournalEntryReportDto debitDto = mapEntryToDto(i.getDateOfEntry(), i.getVoucherID(), i.getRemarks(),
							branch, i.getDebitLedger(), null, amount);
					entries.add(debitDto);
					totalDebit = totalDebit.add(amount);
				}

				if (i.getCreditLedger() != null && !i.getCreditLedger().isEmpty()) {
					JournalEntryReportDto creditDto = mapEntryToDto(i.getDateOfEntry(), i.getVoucherID(),
							i.getRemarks(), branch, null, i.getCreditLedger(), amount);
					entries.add(creditDto);
					totalCredit = totalCredit.add(amount);
				}
			}
			break;

		case "contra":
			List<BankCashTransferEntry> transfers = journalEntryReportRepo.findAllTransfers(branch, startDateStr,
					endDateStr);
			for (BankCashTransferEntry t : transfers) {
				BigDecimal amount = t.getTransactionAmount() != null ? new BigDecimal(t.getTransactionAmount())
						: BigDecimal.ZERO;
				if (t.getDebitLedger() != null && !t.getDebitLedger().isEmpty()) {
					JournalEntryReportDto debitDto = mapEntryToDto(t.getDateOfEntry(), t.getVoucherID(), t.getRemarks(),
							branch, t.getDebitLedger(), null, amount);
					entries.add(debitDto);
					totalDebit = totalDebit.add(amount);
				}

				if (t.getCreditLedger() != null && !t.getCreditLedger().isEmpty()) {
					JournalEntryReportDto creditDto = mapEntryToDto(t.getDateOfEntry(), t.getVoucherID(),
							t.getRemarks(), branch, null, t.getCreditLedger(), amount);
					entries.add(creditDto);
					totalCredit = totalCredit.add(amount);
				}
			}
			break;

		case "manual journal":
			List<ManualJournalEntry> journals = journalEntryReportRepo.findJournalEntryReport(branch, startDateStr,
					endDateStr);
			for (ManualJournalEntry j : journals) {
				BigDecimal amount = j.getTransactionAmount() != null ? new BigDecimal(j.getTransactionAmount())
						: BigDecimal.ZERO;
				if (j.getDebitLedger() != null && !j.getDebitLedger().isEmpty()) {
					JournalEntryReportDto debitDto = mapEntryToDto(j.getDateOfEntry(), j.getVoucherID(), j.getRemarks(),
							branch, j.getDebitLedger(), null, amount);
					entries.add(debitDto);
					totalDebit = totalDebit.add(amount);
				}

				if (j.getCreditLedger() != null && !j.getCreditLedger().isEmpty()) {
					JournalEntryReportDto creditDto = mapEntryToDto(j.getDateOfEntry(), j.getVoucherID(),
							j.getRemarks(), branch, null, j.getCreditLedger(), amount);
					entries.add(creditDto);
					totalCredit = totalCredit.add(amount);
				}
			}
			break;

		default:
			// Unknown type
			break;
		}

		Map<String, Object> response = new LinkedHashMap<>();
		response.put("branchName", branch);
		response.put("voucherType", voucherType);
		response.put("startDate", startDateStr);
		response.put("endDate", endDateStr);
		response.put("entries", entries);

		Map<String, String> totals = new LinkedHashMap<>();
		totals.put("totalDebit", totalDebit.setScale(2, RoundingMode.HALF_UP).toPlainString());
		totals.put("totalCredit", totalCredit.setScale(2, RoundingMode.HALF_UP).toPlainString());
		response.put("totals", totals);

		return response;
	}

	
	private JournalEntryReportDto mapEntryToDto(String date, String voucherID, String remarks, String branch,
			String debitLedger, String creditLedger, BigDecimal transactionAmount) {

		JournalEntryReportDto dto = new JournalEntryReportDto();
		dto.setDateOfEntry(date);
		dto.setVoucherID(voucherID);
		dto.setRemarks(remarks);

// pick correct ledger name
		String ledgerName = debitLedger != null ? debitLedger : creditLedger;

// fetch account code from master
		String accountCode = ledgerAccountRepository.findByAccountTitleAndBranchName(ledgerName, branch)
				.map(LedgerAccountMaster::getAccountCode).orElse("");

		dto.setAccountCode(accountCode);

		if (debitLedger != null) {
			dto.setDebit(transactionAmount.setScale(2, RoundingMode.HALF_UP).toPlainString());
			dto.setCredit("0.00");
		} else {
			dto.setDebit("0.00");
			dto.setCredit(transactionAmount.setScale(2, RoundingMode.HALF_UP).toPlainString());
		}

		return dto;
	}
	
	
	public List<TrialBalanceReportDto> getTrialBalance(String branch, LocalDate startDate, LocalDate endDate) {

	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	    String start = startDate.format(formatter);
	    String end = endDate.format(formatter);

	    List<Object[]> rows = trialBalanceReportRepo.fetchTrialBalanceEntries(branch, start, end);

	    List<TrialBalanceReportDto> result = new ArrayList<>();

	    for (Object[] r : rows) {

	        String ledgerName = (String) r[0];
	        String debit = r[1] != null ? r[1].toString() : "0";
	        String credit = r[2] != null ? r[2].toString() : "0";

	        // Fetch opening & closing from Ledger Master
	        LedgerAccountMaster master = ledgerAccountRepository
	                .findByAccountTitleAndBranchName(ledgerName, branch)
	                .orElse(null);

	        String opening = master != null ? master.getOpeningBalance().toPlainString() : "0";
	        String closing = master != null ? master.getCurrentBalance().toPlainString() : "0";
	        String accountCode = master != null ? master.getAccountCode() : "";

	        TrialBalanceReportDto dto = new TrialBalanceReportDto();
	       
	        dto.setLedgerName(ledgerName);
	        dto.setAccountCode(accountCode);
	        dto.setOpening(opening);
	        dto.setDebit(debit);
	        dto.setCredit(credit);
	        dto.setClosing(closing);

	        result.add(dto);
	    }

	    return result;
	}


}
