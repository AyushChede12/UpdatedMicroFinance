package com.microfinance.controller;

import java.time.LocalDate;
import java.util.HashMap;

import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.microfinance.dto.ApiResponse;
import com.microfinance.dto.PolicyManagementDto;
import com.microfinance.dto.SavingAccountDto;
import com.microfinance.model.AddnewinvestmentPM;
import com.microfinance.model.CreateSavingsAccount;
import com.microfinance.model.DailyDepositPM;
import com.microfinance.model.DailyPremiumRenewalPM;
import com.microfinance.model.FixedDepositPM;
import com.microfinance.model.FlexibleRenewal;
import com.microfinance.model.FullMaturity;
import com.microfinance.model.MISDepositPM;
import com.microfinance.model.MisPayoutLedger;
import com.microfinance.model.PolicyRenewal;
import com.microfinance.model.RecurringDepositPM;
import com.microfinance.model.addCustomer;
import com.microfinance.repository.AddInvestmentRepo;
import com.microfinance.repository.CreateSavingAccountRepo;
import com.microfinance.repository.DailyPremiumRenewalRepo;
import com.microfinance.repository.FlexibleRenewalRepo;
import com.microfinance.repository.PolicyRenewalRepo;
import com.microfinance.service.PolicyManagementService;

@RestController
@RequestMapping("/api/Policymangment")
public class PolicyManagementController {

	@Autowired
	private PolicyManagementService policyManagementService;

	@Autowired
	AddInvestmentRepo addinvestmentrepo;

	@Autowired
	PolicyRenewalRepo policyRenewalRepo;

	@Autowired
	FlexibleRenewalRepo flexibleRenewalRepo;

	@Autowired
	DailyPremiumRenewalRepo dailyPremiumRenewalRepo;

	@Autowired
	CreateSavingAccountRepo createSavingAccountRepo;

	// save daily Deposite
	@PostMapping("daily-depositsave")
	public ResponseEntity<ApiResponse<DailyDepositPM>> savedailyDeposite(@RequestBody DailyDepositPM dailyDepositPM) {
		boolean isSaved = policyManagementService.savedailydeposite(dailyDepositPM);

		if (isSaved) {
			ApiResponse<DailyDepositPM> response = ApiResponse.success(HttpStatus.CREATED,
					"Daily Deposite saved successfully", dailyDepositPM);
			return ResponseEntity.status(HttpStatus.CREATED).body(response);

		} else {
			ApiResponse<DailyDepositPM> response = ApiResponse.error(HttpStatus.BAD_REQUEST,
					"Failed to save fixed deposit.");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);

		}
	}

	@GetMapping("check-plan-name")
	public boolean checkPlanName(@RequestParam String planName) {

		return policyManagementService.planNameExists(planName);

	}

	// View All daily Deposits
	@GetMapping("daily-deposit/view")
	public ResponseEntity<ApiResponse<List<DailyDepositPM>>> getAlldailyDeposits() {
		List<DailyDepositPM> deposits = policyManagementService.getAlldailydepositedata();

		if (deposits != null && !deposits.isEmpty()) {
			ApiResponse<List<DailyDepositPM>> response = ApiResponse.success(HttpStatus.OK,
					"Daily deposits fetched successfully.", deposits);
			return new ResponseEntity<>(response, HttpStatus.OK);
		} else {
			ApiResponse<List<DailyDepositPM>> response = ApiResponse.success(HttpStatus.OK,
					"No daily deposits found.", java.util.Collections.emptyList());
			return new ResponseEntity<>(response, HttpStatus.OK);
		}
	}

	// feacth by id daily deposite
	@GetMapping("dailyedit/{id}")
	public ResponseEntity<ApiResponse<DailyDepositPM>> getDailyDepositById(@PathVariable Long id) {
		DailyDepositPM deposit = policyManagementService.getDailyDepositById(id);

		if (deposit != null) {
			ApiResponse<DailyDepositPM> response = ApiResponse.success(HttpStatus.OK,
					"Daily deposit fetched successfully.", deposit);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<DailyDepositPM> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"Daily deposit not found for ID: " + id);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// update the deposite daily data
	@PostMapping("/dailyupdate/{id}")
	public ResponseEntity<ApiResponse<DailyDepositPM>> updateDailyDeposit(@PathVariable Long id,
			@RequestBody DailyDepositPM updatedData) {

		DailyDepositPM updated = policyManagementService.updateDailyDeposit(id, updatedData);

		if (updated != null) {
			ApiResponse<DailyDepositPM> response = ApiResponse.success(HttpStatus.OK,
					"Daily deposit updated successfully.", updated);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<DailyDepositPM> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"Daily deposit not found or failed to update.");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// delete the data of the daily deposite
	@PostMapping("/dailydelete/{id}")
	public ResponseEntity<ApiResponse<Void>> deleteDailyDeposit(@PathVariable Long id) {
		boolean deleted = policyManagementService.deleteDailyDeposit(id);

		if (deleted) {
			ApiResponse<Void> response = ApiResponse.success(HttpStatus.OK, "Daily deposit deleted successfully.",
					null);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<Void> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"Daily deposit not found for ID: " + id);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// Save Recurring Deposit
	@PostMapping("/recurring-depositsave")
	public ResponseEntity<ApiResponse<RecurringDepositPM>> saveRecurringDeposit(
			@RequestBody RecurringDepositPM recurringDepositPM) {
		boolean isSaved = policyManagementService.saveRecuringDailyDeposite(recurringDepositPM);
		System.out.println("Received Term: " + recurringDepositPM.getRdterm());

		if (isSaved) {
			ApiResponse<RecurringDepositPM> response = ApiResponse.success(HttpStatus.CREATED,
					"Recurring deposit saved successfully.", recurringDepositPM);
			return new ResponseEntity<>(response, HttpStatus.CREATED);
		} else {
			ApiResponse<RecurringDepositPM> response = ApiResponse.error(HttpStatus.BAD_REQUEST,
					"Failed to save recurring deposit.");
			return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
		}
	}

	// View All Recurring Deposits
	@GetMapping("/recurring-depositview")
	public ResponseEntity<ApiResponse<List<RecurringDepositPM>>> getAllRecurringDeposits() {
		List<RecurringDepositPM> deposits = policyManagementService.getAllData1();

		if (deposits != null && !deposits.isEmpty()) {
			ApiResponse<List<RecurringDepositPM>> response = ApiResponse.success(HttpStatus.OK,
					"Recurring deposits fetched successfully.", deposits);
			return new ResponseEntity<>(response, HttpStatus.OK);
		} else {
			ApiResponse<List<RecurringDepositPM>> response = ApiResponse.success(HttpStatus.OK,
					"No recurring deposits found.", java.util.Collections.emptyList());
			return new ResponseEntity<>(response, HttpStatus.OK);
		}
	}

	// GET BY ID reccuring deposite
	@GetMapping("/recurringedit/{id}")
	public ResponseEntity<ApiResponse<RecurringDepositPM>> getRecurringDepositById(@PathVariable Long id) {
		RecurringDepositPM deposit = policyManagementService.getRecurringDepositById(id);

		if (deposit != null) {
			ApiResponse<RecurringDepositPM> response = ApiResponse.success(HttpStatus.OK,
					"Recurring deposit fetched successfully.", deposit);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<RecurringDepositPM> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"Recurring deposit not found for ID: " + id);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// Update reccuring deposite
	@PostMapping("/recurringupdate/{id}")
	public ResponseEntity<ApiResponse<RecurringDepositPM>> updateRecurringDeposit(@PathVariable Long id,
			@RequestBody RecurringDepositPM updatedData) {

		RecurringDepositPM updated = policyManagementService.updateRecurringDeposit(id, updatedData);

		if (updated != null) {
			ApiResponse<RecurringDepositPM> response = ApiResponse.success(HttpStatus.OK,
					"Recurring deposit updated successfully.", updated);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<RecurringDepositPM> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"Recurring deposit not found or failed to update.");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// delete reccuring deposite
	@PostMapping("/recurringdelete/{id}")
	public ResponseEntity<ApiResponse<Void>> deleteRecurringDeposit(@PathVariable Long id) {
		boolean deleted = policyManagementService.deleteRecurringDeposit(id);

		if (deleted) {
			ApiResponse<Void> response = ApiResponse.success(HttpStatus.OK, "Recurring deposit deleted successfully.",
					null);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<Void> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"Recurring deposit not found for ID: " + id);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// Save Fixed Deposit
	@PostMapping("/fixed-depositsave")
	public ResponseEntity<ApiResponse<FixedDepositPM>> saveFixedDeposit(@RequestBody FixedDepositPM fixedDepositPM) {
		boolean isSaved = policyManagementService.saveFixedDeposite(fixedDepositPM);

		if (isSaved) {
			ApiResponse<FixedDepositPM> response = ApiResponse.success(HttpStatus.CREATED,
					"Fixed deposit saved successfully.", fixedDepositPM);
			return ResponseEntity.status(HttpStatus.CREATED).body(response);
		} else {
			ApiResponse<FixedDepositPM> response = ApiResponse.error(HttpStatus.BAD_REQUEST,
					"Failed to save fixed deposit.");
			return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
		}
	}

	// View All Fixed Deposits
	@GetMapping("/fixed-depositview")
	public ResponseEntity<ApiResponse<List<FixedDepositPM>>> getAllFixedDeposits() {
		List<FixedDepositPM> deposits = policyManagementService.getAllFixeddata();

		if (deposits != null && !deposits.isEmpty()) {
			ApiResponse<List<FixedDepositPM>> response = ApiResponse.success(HttpStatus.OK,
					"Fixed deposits fetched successfully.", deposits);
			return new ResponseEntity<>(response, HttpStatus.OK);
		} else {
			ApiResponse<List<FixedDepositPM>> response = ApiResponse.success(HttpStatus.OK,
					"No fixed deposits found.", java.util.Collections.emptyList());
			return new ResponseEntity<>(response, HttpStatus.OK);
		}
	}

	// fetch by id fixed deposit
	@GetMapping("/fixededit/{id}")
	public ResponseEntity<ApiResponse<FixedDepositPM>> getFixedDepositById(@PathVariable Long id) {
		FixedDepositPM deposit = policyManagementService.getFixedDepositById(id);

		if (deposit != null) {
			ApiResponse<FixedDepositPM> response = ApiResponse.success(HttpStatus.OK,
					"Fixed deposit fetched successfully.", deposit);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<FixedDepositPM> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"Fixed deposit not found for ID: " + id);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// Update Fixed deposit
	@PostMapping("/fixedupdate/{id}")
	public ResponseEntity<ApiResponse<FixedDepositPM>> updateFixedDeposit(@PathVariable Long id,
			@RequestBody FixedDepositPM updatedData) {

		FixedDepositPM updated = policyManagementService.updateFixedDeposit(id, updatedData);

		if (updated != null) {
			ApiResponse<FixedDepositPM> response = ApiResponse.success(HttpStatus.OK,
					"Fixed deposit updated successfully.", updated);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<FixedDepositPM> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"Fixed deposit not found or failed to update.");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// Delete fixed deposit
	@PostMapping("/fixeddelete/{id}")
	public ResponseEntity<ApiResponse<Void>> deleteFixedDeposit(@PathVariable Long id) {
		boolean deleted = policyManagementService.deleteFixedDeposit(id);

		if (deleted) {
			ApiResponse<Void> response = ApiResponse.success(HttpStatus.OK, "Fixed deposit deleted successfully.",
					null);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<Void> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"Fixed deposit not found for ID: " + id);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// MIS Deposit save

	@PostMapping("/mis-deposit/save")
	public ResponseEntity<ApiResponse<MISDepositPM>> savemisdeposite(@RequestBody MISDepositPM misDepositPM) {
		boolean isSaved = policyManagementService.savemistdeposite(misDepositPM);
		if (isSaved) {
			ApiResponse<MISDepositPM> response = ApiResponse.success(HttpStatus.CREATED,
					"The MIS Deposite saved succesfully", misDepositPM);
			return new ResponseEntity<>(response, HttpStatus.CREATED);

		} else {
			ApiResponse<MISDepositPM> response = ApiResponse.error(HttpStatus.BAD_REQUEST,
					"Failed to save MIS deposit.");
			return new ResponseEntity<>(response, HttpStatus.BAD_REQUEST);
		}
	}

	// View All MIS Deposits
	@GetMapping("/mis-deposit/view")
	public ResponseEntity<ApiResponse<List<MISDepositPM>>> getAllMISDeposits() {
		List<MISDepositPM> deposits = policyManagementService.getAllMISDepositData();

		if (deposits != null && !deposits.isEmpty()) {
			ApiResponse<List<MISDepositPM>> response = ApiResponse.success(HttpStatus.OK,
					"MIS deposits fetched successfully.", deposits);
			return new ResponseEntity<>(response, HttpStatus.OK);
		} else {
			ApiResponse<List<MISDepositPM>> response = ApiResponse.success(HttpStatus.OK,
					"No MIS deposits found.", java.util.Collections.emptyList());
			return new ResponseEntity<>(response, HttpStatus.OK);
		}
	}

	// Get MIS deposit by ID
	@GetMapping("/misedit/{id}")
	public ResponseEntity<ApiResponse<MISDepositPM>> getMISDepositById(@PathVariable Long id) {
		MISDepositPM deposit = policyManagementService.getMISDepositById(id);

		if (deposit != null) {
			ApiResponse<MISDepositPM> response = ApiResponse.success(HttpStatus.OK, "MIS deposit fetched successfully.",
					deposit);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<MISDepositPM> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"MIS deposit not found for ID: " + id);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}
	// Update MIS deposit

	@PostMapping("/misupdate/{id}")
	public ResponseEntity<ApiResponse<MISDepositPM>> updateMISDeposit(@PathVariable Long id,
			@RequestBody MISDepositPM updatedData) {

		MISDepositPM updated = policyManagementService.updateMISDeposit(id, updatedData);

		if (updated != null) {
			ApiResponse<MISDepositPM> response = ApiResponse.success(HttpStatus.OK, "MIS deposit updated successfully.",
					updated);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<MISDepositPM> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"MIS deposit not found or failed to update.");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// Delete MIS deposit
	@DeleteMapping("/misdelete/{id}")
	public ResponseEntity<ApiResponse<Void>> deleteMISDeposit(@PathVariable Long id) {
		boolean deleted = policyManagementService.deleteMISDeposit(id);

		if (deleted) {
			ApiResponse<Void> response = ApiResponse.success(HttpStatus.OK, "MIS deposit deleted successfully.", null);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<Void> response = ApiResponse.error(HttpStatus.NOT_FOUND, "MIS deposit not found for ID: " + id);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	// Get Scheme Name by Scheme Term

	@GetMapping("/getSchemeNameBySchemeType")
	public Map<String, List<String>> getSchemeNameBySchemeType(
			@RequestParam(value = "drd", required = false) String drd,
			@RequestParam(value = "rd", required = false) String rd,
			@RequestParam(value = "fd", required = false) String fd,
			@RequestParam(value = "mis", required = false) String mis) {

		Map<String, List<String>> response = new HashMap<>();

		if (drd != null) {
			response.put("allBrands", policyManagementService.getSchemeNameBySchemeType(drd));
		}
		if (rd != null) {
			response.put("allRds", policyManagementService.getRRDBySchemeType(rd));
		}
		if (fd != null) {
			response.put("allFRDs", policyManagementService.getFRDBySchemeType(fd));
		}
		if (mis != null) {
			response.put("allMISRDs", policyManagementService.getMISRDBySchemeType(mis));
		}

		return response;
	}

	// view add new Investment details
	// Ashwini
	@GetMapping("/getaddinvestmentdetails")
	public ResponseEntity<ApiResponse<List<AddnewinvestmentPM>>> getAddInvestmentDetails() {
		List<AddnewinvestmentPM> invest = policyManagementService.getAddInvestmentDetails();

		if (invest != null && !invest.isEmpty()) {
			ApiResponse<List<AddnewinvestmentPM>> response = ApiResponse.success(HttpStatus.OK,
					"Investment Details fetched successfully.", invest);
			return new ResponseEntity<>(response, HttpStatus.OK);
		} else {
			ApiResponse<List<AddnewinvestmentPM>> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"No Details found.");
			return new ResponseEntity<>(response, HttpStatus.NOT_FOUND);
		}
	}

	// fetch new investment details by BranchName
	// Ashwini

	@GetMapping("/getinvestmentdetails")
	public ResponseEntity<ApiResponse<List<AddnewinvestmentPM>>> findByBranch(@RequestParam String branchName) {
		List<AddnewinvestmentPM> invest = policyManagementService.findByBranch(branchName);

		ApiResponse<List<AddnewinvestmentPM>> response = new ApiResponse<>(HttpStatus.FOUND,
				"investment fetched successfully.", invest);
		return ResponseEntity.ok(response);

	}

	@GetMapping("/ddterm")
	public ResponseEntity<ApiResponse<DailyDepositPM>> getDDTermAndInterestRate(
			@RequestParam(name = "planNameDD", required = true) String planNameDD) {

		DailyDepositPM response = policyManagementService.getDDTermAndInterestRate(planNameDD);
		if (response != null) {
			return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Daily Deposit plan details found", response));
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND)
					.body(ApiResponse.error(HttpStatus.NOT_FOUND, "Daily Deposit plan not found"));
		}
	}

	@GetMapping("/rdterm")
	public ResponseEntity<ApiResponse<RecurringDepositPM>> getRDTermAndInterestRate(
			@RequestParam(name = "planNameRD", required = true) String planNameRD) {

		RecurringDepositPM response = policyManagementService.getRDTermAndInterestRate(planNameRD);
		if (response != null) {
			return ResponseEntity
					.ok(ApiResponse.success(HttpStatus.OK, "Recurring Deposit plan details found", response));
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND)
					.body(ApiResponse.error(HttpStatus.NOT_FOUND, "Recurring Deposit plan not found"));
		}
	}

	@GetMapping("/fdterm")
	public ResponseEntity<ApiResponse<FixedDepositPM>> getFDTermAndInterestRate(
			@RequestParam(name = "planNameFD", required = true) String planNameFD) {

		FixedDepositPM response = policyManagementService.getFDTermAndInterestRate(planNameFD);
		if (response != null) {
			return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "Fixed Deposit plan details found", response));
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND)
					.body(ApiResponse.error(HttpStatus.NOT_FOUND, "Fixed Deposit plan not found"));
		}
	}

	@GetMapping("/misterm")
	public ResponseEntity<?> getMISTermAndInterestRate(
			@RequestParam(name = "planNameMD", required = true) String planNameMD) {
		MISDepositPM response = policyManagementService.getMISTermAndInterestRate(planNameMD);
		if (response != null) {
			return ResponseEntity.ok(response);
		} else {
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body("Data not found");
		}
	}

	@PostMapping("/saveInvestment")
	public ResponseEntity<ApiResponse<AddnewinvestmentPM>> saveInvestment(@RequestBody AddnewinvestmentPM investment) {
		try {
			AddnewinvestmentPM savedInvestment = policyManagementService.saveInvestment(investment);
			ApiResponse<AddnewinvestmentPM> response = new ApiResponse<>(HttpStatus.OK,
					"✅ Investment saved successfully", savedInvestment);
			return new ResponseEntity<>(response, HttpStatus.OK);
		} catch (Exception e) {
			e.printStackTrace(); // Debugging only
			ApiResponse<AddnewinvestmentPM> errorResponse = new ApiResponse<>(HttpStatus.INTERNAL_SERVER_ERROR,
					"❌ Failed to save investment", null);
			return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	@GetMapping("/getAllDDTerm") // Niraj
	public List<DailyDepositPM> getAllDDTerm() {
		List<DailyDepositPM> list = policyManagementService.getAllDDTerm();
		return list;
	}

	@GetMapping("/getAllRDPolicies")
	public ResponseEntity<ApiResponse<List<AddnewinvestmentPM>>> getAllRDPolicies() {
		List<AddnewinvestmentPM> rdPolicies = policyManagementService.getApprovedRDPolicies();

		ApiResponse<List<AddnewinvestmentPM>> response = new ApiResponse<>(HttpStatus.OK,
				"Approved RD policies fetched successfully", rdPolicies);

		return ResponseEntity.ok(response);
	}

	@GetMapping("/getAllFDPolicies")
	public ResponseEntity<ApiResponse<List<AddnewinvestmentPM>>> getAllFDPolicies() {
		List<AddnewinvestmentPM> fdPolicies = policyManagementService.getApprovedFDPolicies();

		ApiResponse<List<AddnewinvestmentPM>> response = new ApiResponse<>(HttpStatus.OK,
				"Approved FD policies fetched successfully", fdPolicies);

		return ResponseEntity.ok(response);
	}

	@GetMapping("/getAllDDPolicies")
	public ResponseEntity<ApiResponse<List<AddnewinvestmentPM>>> getAllDDPolicies() {
		List<AddnewinvestmentPM> ddPolicies = policyManagementService.getApprovedDDPolicies();

		ApiResponse<List<AddnewinvestmentPM>> response = new ApiResponse<>(HttpStatus.OK,
				"Approved DD policies fetched successfully", ddPolicies);

		return ResponseEntity.ok(response);
	}

	@GetMapping("/getPolicyByPolicyCode")
	public ResponseEntity<ApiResponse<AddnewinvestmentPM>> getPolicyByPolicyCode(
			@RequestParam("policyCode") String policyCode) {
		Optional<AddnewinvestmentPM> optionalPolicy = policyManagementService.findByPolicyCode(policyCode);

		if (optionalPolicy.isPresent()) {
			ApiResponse<AddnewinvestmentPM> response = new ApiResponse<>(HttpStatus.OK, "Policy found successfully",
					optionalPolicy.get());
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<AddnewinvestmentPM> response = new ApiResponse<>(HttpStatus.NOT_FOUND,
					"Policy not found for code: " + policyCode, null);
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	@GetMapping("/getAllPolicyManagementData")
	public ResponseEntity<ApiResponse<List<AddnewinvestmentPM>>> getAllPolicyManagementData() {
		List<AddnewinvestmentPM> allPolicies = policyManagementService.getAllPolicyManagementData();

		ApiResponse<List<AddnewinvestmentPM>> response = new ApiResponse<>(HttpStatus.OK,
				"All policy management data fetched successfully", allPolicies);

		return ResponseEntity.ok(response);
	}

	@GetMapping("/getNextPolicyCode")
	public ResponseEntity<String> getNextPolicyCode(@RequestParam String schemeType) {
		String prefix = schemeType.toUpperCase(); // e.g., RD, FD, DRD

		// Get the highest ID in the table
		Long maxId = addinvestmentrepo.findMaxId(); // Custom method
		long nextId = (maxId != null) ? maxId + 1 : 1;

		// Generate a unique part (timestamp or 4-digit random)
		String uniquePart = String.valueOf((int) (Math.random() * 9000) + 1000); // Random 4-digit number
		// Alternative: String uniquePart =
		// String.valueOf(System.currentTimeMillis()).substring(8); // Last 5 digits of
		// timestamp

		// Final policy code: e.g., RD-7284-0004
		String nextPolicyCode = String.format("%s-%s-%04d", prefix, uniquePart, nextId);

		return ResponseEntity.ok(nextPolicyCode);
	}

	@PostMapping("/updateDueAndInstallment")
	public ResponseEntity<ApiResponse<String>> updateDueAndInstallment(@RequestBody Map<String, Object> data) {
		try {
			String policyCode = (String) data.get("policyCode");
			double policyAmount = Double.parseDouble(data.get("policyAmount").toString());
			int noOfInstallments = Integer.parseInt(data.get("noOfInstallments").toString());
			String modeOfPayment = data.get("modeOfPayment") != null ? data.get("modeOfPayment").toString() : "";

			Optional<AddnewinvestmentPM> optional = addinvestmentrepo.findByPolicyCode(policyCode);
			if (!optional.isPresent()) {
				return ResponseEntity.status(HttpStatus.NOT_FOUND)
						.body(new ApiResponse<>(HttpStatus.NOT_FOUND, "Policy not found", null));
			}

			AddnewinvestmentPM investment = optional.get();

			// Parse current values
			double currentDue = parseDoubleSafe(investment.getAmountDue());
			int currentPaid = parseIntSafe(investment.getLastInstPaid());
			double currentPaidAmount = parseDoubleSafe(investment.getPaidAmount());

			// Calculate updated values
			double totalDeduction = policyAmount * noOfInstallments;
			double updatedDue = currentDue - totalDeduction;
			int updatedPaid = currentPaid + noOfInstallments;
			double updatedPaidAmount = currentPaidAmount + totalDeduction;

			// Check if no payment is needed
			if (currentDue <= 0) {
				return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK,
						"No payment needed. Policy is already settled or overpaid.", null));
			}

			// --- FIX 1: Deduct from Savings Account if payment mode is Savings Account ---
			if ("savingaccount".equalsIgnoreCase(modeOfPayment.replaceAll("\\s+", ""))
					|| "saving account".equalsIgnoreCase(modeOfPayment.trim())) {
				String customerCode = investment.getMemberSelection();
				List<CreateSavingsAccount> accounts = createSavingAccountRepo.findBySelectByCustomer(customerCode);
				if (accounts == null || accounts.isEmpty()) {
					return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>(
							HttpStatus.BAD_REQUEST, "No Saving Account found for customer: " + customerCode, null));
				}
				CreateSavingsAccount savingAcc = accounts.get(0);
				double balance = 0.0;
				try {
					balance = Double.parseDouble(savingAcc.getBalance());
				} catch (Exception ex) {
					balance = 0.0;
				}
				if (balance < totalDeduction) {
					return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>(
							HttpStatus.BAD_REQUEST,
							"Insufficient Saving Account balance! Available: " + balance + ", Required: "
									+ totalDeduction,
							null));
				}
				savingAcc.setBalance(String.valueOf(balance - totalDeduction));
				createSavingAccountRepo.save(savingAcc);
			}
			// -----------------------------------------------------------------------

			// Update the investment
			investment.setAmountDue(String.valueOf(updatedDue));
			investment.setLastInstPaid(String.valueOf(updatedPaid));
			investment.setPaidAmount(String.valueOf(updatedPaidAmount));
			addinvestmentrepo.save(investment);

			// Save to PolicyRenewal
			PolicyRenewal renewal = new PolicyRenewal();
			renewal.setPolicyCode(investment.getPolicyCode());
			renewal.setRenewalDate(LocalDate.now().toString());
			renewal.setPolicyDate(investment.getPolicyStartDate());
			renewal.setMaturityDate(investment.getMaturityDate());
			renewal.setCustomerCode(investment.getMemberSelection());
			renewal.setClientName(investment.getCustomerName());
			renewal.setContactNo(investment.getContactNo());
			renewal.setPolicyAmount(parseDoubleSafe(investment.getPolicyAmount()));
			renewal.setPolicyType(investment.getSchemeType());
			renewal.setPolicyTerm(investment.getSchemeTerm());
			renewal.setMaturityAmount(parseDoubleSafe(investment.getMaturityAmount()));
			renewal.setTotalDeposit(parseDoubleSafe(investment.getPaidAmount()));
			renewal.setPaymentDue(parseDoubleSafe(investment.getAmountDue()));
			renewal.setLastPaymentDate(investment.getLastPaymentDate());
			renewal.setDueDate(investment.getDueDate());
			renewal.setBranchname(investment.getBranchName());
			renewal.setNoOfInst(parseIntSafe(investment.getNoOfInstallments()));
			renewal.setNoOfInstPaid(parseIntSafe(investment.getLastInstPaid()));
			renewal.setModeOfPayment(modeOfPayment.isEmpty() ? investment.getModeOfPayment() : modeOfPayment);
			policyRenewalRepo.save(renewal);

			// Final message based on updatedDue
			if (updatedDue == 0) {
				return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK, "Policy is ready for maturity.", null));
			} else if (updatedDue < 0) {
				return ResponseEntity
						.ok(new ApiResponse<>(HttpStatus.OK, "No payment needed. Policy is overpaid.", null));
			} else {
				return ResponseEntity.ok(
						new ApiResponse<>(HttpStatus.OK, "Installment updated and renewal saved successfully", null));
			}

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
					new ApiResponse<>(HttpStatus.INTERNAL_SERVER_ERROR, "Update failed: " + e.getMessage(), null));
		}
	}

	private Double parseDoubleSafe(String value) {
		if (value == null || value.trim().isEmpty())
			return 0.0;
		return Double.parseDouble(value);
	}

	private Integer parseIntSafe(String value) {
		if (value == null || value.trim().isEmpty())
			return 0;
		return Integer.parseInt(value);
	}

	@PostMapping("/updateFDDueAndInstallment")
	public ResponseEntity<ApiResponse<String>> updateFDDueAndInstallment(@RequestBody Map<String, Object> data) {
		try {
			String policyCode = (String) data.get("policyCode");
			double policyAmount = Double.parseDouble(data.get("policyAmount").toString());
			int noOfInstallments = Integer.parseInt(data.get("noOfInstallments").toString());

			// Fetch policy first — totalDeposit, paymentDue, noOfInstPaid may not be
			// sent by the frontend; read them from the stored investment record instead.
			Optional<AddnewinvestmentPM> optional = addinvestmentrepo.findByPolicyCode(policyCode);
			if (!optional.isPresent()) {
				return ResponseEntity.status(HttpStatus.NOT_FOUND)
						.body(new ApiResponse<>(HttpStatus.NOT_FOUND, "Policy not found", null));
			}

			AddnewinvestmentPM investment = optional.get();

			// Use request-body values when explicitly sent, otherwise fall back to DB
			// values
			double totalDeposit = (data.get("totalDeposit") != null)
					? Double.parseDouble(data.get("totalDeposit").toString())
					: parseDoubleSafe(investment.getPaidAmount());
			double paymentDue = (data.get("paymentDue") != null)
					? Double.parseDouble(data.get("paymentDue").toString())
					: parseDoubleSafe(investment.getAmountDue());
			int noOfInstPaid = (data.get("noOfInstPaid") != null)
					? Integer.parseInt(data.get("noOfInstPaid").toString())
					: parseIntSafe(investment.getLastInstPaid());

			int oldLastInstPaid = parseIntSafe(investment.getLastInstPaid());
			int todayInstallments = noOfInstallments;
			int updatedLastInstPaid = oldLastInstPaid + todayInstallments;

			// If policy fully paid already
			if (paymentDue <= 0) {
				return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK,
						"No payment needed. Policy is already settled.", null));
			}

			// Today's deposit
			double NetDeposit = policyAmount * noOfInstallments;

			// Updated values
			// int updatedPaid = currentPaid + noOfInstallments;
			double updatedTotalDeposit = totalDeposit + NetDeposit;
			double updatedDue = paymentDue - NetDeposit;

			System.out.println("Payment Due :" + updatedDue);
			System.out.println("Deposite :" + updatedTotalDeposit);
			System.out.println("Last : " + noOfInstPaid);

			// Save updated values to AddnewinvestmentPM
			investment.setAmountDue(String.valueOf(updatedDue));
			investment.setLastInstPaid(String.valueOf(updatedLastInstPaid));
			investment.setPaidAmount(String.valueOf(updatedTotalDeposit));
			addinvestmentrepo.save(investment);

			// Save to PolicyRenewal
			FlexibleRenewal fRenewal = new FlexibleRenewal();
			fRenewal.setPolicyCode(investment.getPolicyCode());
			fRenewal.setRenewalDate(LocalDate.now().toString());
			fRenewal.setPolicyDate(investment.getPolicyStartDate());
			fRenewal.setMaturityDate(investment.getMaturityDate());
			fRenewal.setCustomerCode(investment.getMemberSelection());
			fRenewal.setClientName(investment.getCustomerName());
			fRenewal.setContactNo(investment.getContactNo());
			fRenewal.setPolicyAmount(parseDoubleSafe(investment.getPolicyAmount()));
			fRenewal.setPolicyType(investment.getSchemeType());
			fRenewal.setPolicyTerm(investment.getSchemeTerm());
			fRenewal.setBranchname(investment.getBranchName());
			fRenewal.setMaturityAmount(parseDoubleSafe(investment.getMaturityAmount()));
			fRenewal.setTotalDeposit(parseDoubleSafe(investment.getPaidAmount()));
			fRenewal.setPaymentDue(parseDoubleSafe(investment.getAmountDue()));
			fRenewal.setLastPaymentDate(investment.getLastPaymentDate());
			fRenewal.setDueDate(investment.getDueDate());
			fRenewal.setNoOfInst(parseIntSafe(investment.getNoOfInstallments()));
			fRenewal.setNoOfInstPaid(parseIntSafe(investment.getLastInstPaid()));
			fRenewal.setModeOfPayment(investment.getModeOfPayment());

			// >>>>>> MOST IMPORTANT FIX <<<<<<
			fRenewal.setNetDeposit(NetDeposit); // today's deposit
			System.out.println("Net Deposite :" + NetDeposit);

			flexibleRenewalRepo.save(fRenewal);

			// Final message based on updatedDue
			if (updatedDue == 0) {
				return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK, "Policy is ready for maturity.", null));
			} else if (updatedDue < 0) {
				return ResponseEntity
						.ok(new ApiResponse<>(HttpStatus.OK, "No payment needed. Policy is overpaid.", null));
			} else {
				return ResponseEntity.ok(
						new ApiResponse<>(HttpStatus.OK, "Installment updated and renewal saved successfully", null));
			}

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
					new ApiResponse<>(HttpStatus.INTERNAL_SERVER_ERROR, "Update failed: " + e.getMessage(), null));
		}
	}

	// @PostMapping("/updateDDDueAndInstallment")
	// public ResponseEntity<ApiResponse<String>>
	// updateDDDueAndInstallments(@RequestBody Map<String, Object> data) {
	// try {
	// String policyCode = (String) data.get("policyCode");
	// double policyAmount =
	// Double.parseDouble(data.get("policyAmount").toString());
	// int noOfInstallments =
	// Integer.parseInt(data.get("noOfInstallments").toString());
	//
	// Optional<AddnewinvestmentPM> optional =
	// addinvestmentrepo.findByPolicyCode(policyCode);
	// if (!optional.isPresent()) {
	// return ResponseEntity.status(HttpStatus.NOT_FOUND)
	// .body(new ApiResponse<>(HttpStatus.NOT_FOUND, "Policy not found", null));
	// }
	//
	// AddnewinvestmentPM investment = optional.get();
	//
	// // Parse current values
	// double currentDue = parseDoubleSafe(investment.getAmountDue());
	// int currentPaid = parseIntSafe(investment.getLastInstPaid());
	// double currentPaidAmount = parseDoubleSafe(investment.getPaidAmount());
	//
	// // Calculate updated values
	// double totalDeduction = policyAmount * noOfInstallments;
	// double updatedDue = currentDue - totalDeduction;
	// int updatedPaid = currentPaid + noOfInstallments;
	// double updatedPaidAmount = currentPaidAmount + totalDeduction;
	//
	// // Check if no payment is needed
	// if (currentDue <= 0) {
	// return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK,
	// "No payment needed. Policy is already settled or overpaid.", null));
	// }
	//
	// // Update the investment
	// investment.setAmountDue(String.valueOf(updatedDue));
	// investment.setLastInstPaid(String.valueOf(updatedPaid));
	// investment.setPaidAmount(String.valueOf(updatedPaidAmount));
	// addinvestmentrepo.save(investment);
	//
	// // Save to PolicyRenewal
	// DailyPremiumRenewalPM ddRenewal = new DailyPremiumRenewalPM();
	// ddRenewal.setPolicyCode(investment.getPolicyCode());
	// ddRenewal.setRenewalDate(LocalDate.now().toString());
	// ddRenewal.setPolicyDate(investment.getPolicyStartDate());
	// ddRenewal.setMaturityDate(investment.getMaturityDate());
	// ddRenewal.setCustomerCode(investment.getMemberSelection());
	// ddRenewal.setClientName(investment.getCustomerName());
	// ddRenewal.setContactNo(investment.getContactNo());
	// ddRenewal.setPolicyAmount(parseDoubleSafe(investment.getPolicyAmount()));
	// ddRenewal.setPolicyType(investment.getSchemeType());
	// ddRenewal.setPolicyTerm(investment.getSchemeTerm());
	// ddRenewal.setBranchname(investment.getBranchName());
	// ddRenewal.setMaturityAmount(parseDoubleSafe(investment.getMaturityAmount()));
	// ddRenewal.setTotalDeposit(parseDoubleSafe(investment.getPaidAmount()));
	// ddRenewal.setPaymentDue(parseDoubleSafe(investment.getAmountDue()));
	// ddRenewal.setLastPaymentDate(investment.getLastPaymentDate());
	// ddRenewal.setDueDate(investment.getDueDate());
	// ddRenewal.setNoOfInst(parseIntSafe(investment.getNoOfInstallments()));
	// ddRenewal.setNoOfInstPaid(parseIntSafe(investment.getLastInstPaid()));
	// ddRenewal.setModeOfPayment(investment.getModeOfPayment());
	// dailyPremiumRenewalRepo.save(ddRenewal);
	//
	// // Final message based on updatedDue
	// if (updatedDue == 0) {
	// return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK, "Policy is ready
	// for maturity.", null));
	// } else if (updatedDue < 0) {
	// return ResponseEntity
	// .ok(new ApiResponse<>(HttpStatus.OK, "No payment needed. Policy is
	// overpaid.", null));
	// } else {
	// return ResponseEntity.ok(
	// new ApiResponse<>(HttpStatus.OK, "Installment updated and renewal saved
	// successfully", null));
	// }
	//
	// } catch (Exception e) {
	// return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
	// new ApiResponse<>(HttpStatus.INTERNAL_SERVER_ERROR, "Update failed: " +
	// e.getMessage(), null));
	// }
	// }

	@PostMapping("/updateDDDueAndInstallment")
	public ResponseEntity<ApiResponse<String>> updateDDDueAndInstallments(@RequestBody Map<String, Object> data) {
		try {
			String policyCode = (String) data.get("policyCode");
			double policyAmount = Double.parseDouble(data.get("policyAmount").toString());
			int noOfInstallments = Integer.parseInt(data.get("noOfInstallments").toString());
			double totalDeposit = Double.parseDouble(data.get("totalDeposit").toString());
			double paymentDue = Double.parseDouble(data.get("paymentDue").toString());
			int noOfInstPaid = Integer.parseInt(data.get("noOfInstPaid").toString());
			String modeOfPayment = data.get("modeOfPayment") != null ? data.get("modeOfPayment").toString() : "";

			// fetch all records
			List<AddnewinvestmentPM> investments = addinvestmentrepo.findAllByPolicyCode(policyCode);
			if (investments.isEmpty()) {
				return ResponseEntity.status(HttpStatus.NOT_FOUND)
						.body(new ApiResponse<>(HttpStatus.NOT_FOUND, "Policy not found", null));
			}

			// if multiple records → handle first or loop all
			AddnewinvestmentPM investment = investments.get(0);

			int oldLastInstPaid = parseIntSafe(investment.getLastInstPaid());
			int todayInstallments = noOfInstallments;
			int updatedLastInstPaid = oldLastInstPaid + todayInstallments;

			if (paymentDue <= 0) {
				return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK,
						"No payment needed. Policy is already settled.", null));
			}

			// Today's deposit
			double NetDeposit = policyAmount * noOfInstallments;

			// Updated values
			double updatedTotalDeposit = totalDeposit + NetDeposit;
			double updatedDue = paymentDue - NetDeposit;

			System.out.println("Payment Due :" + updatedDue);
			System.out.println("Deposite :" + updatedTotalDeposit);
			System.out.println("Last : " + noOfInstPaid);

			// --- FIX 1: Deduct from Savings Account if payment mode is Savings Account ---
			if ("savingaccount".equalsIgnoreCase(modeOfPayment.replaceAll("\\s+", ""))
					|| "saving account".equalsIgnoreCase(modeOfPayment.trim())) {
				String customerCode = investment.getMemberSelection();
				List<CreateSavingsAccount> accounts = createSavingAccountRepo.findBySelectByCustomer(customerCode);
				if (accounts == null || accounts.isEmpty()) {
					return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>(
							HttpStatus.BAD_REQUEST, "No Saving Account found for customer: " + customerCode, null));
				}
				CreateSavingsAccount savingAcc = accounts.get(0);
				double balance = 0.0;
				try {
					balance = Double.parseDouble(savingAcc.getBalance());
				} catch (Exception ex) {
					balance = 0.0;
				}
				if (balance < NetDeposit) {
					return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(new ApiResponse<>(
							HttpStatus.BAD_REQUEST,
							"Insufficient Saving Account balance! Available: " + balance + ", Required: " + NetDeposit,
							null));
				}
				savingAcc.setBalance(String.valueOf(balance - NetDeposit));
				createSavingAccountRepo.save(savingAcc);
			}
			// -----------------------------------------------------------------------

			// Save updated values to AddnewinvestmentPM
			investment.setAmountDue(String.valueOf(updatedDue));
			investment.setLastInstPaid(String.valueOf(updatedLastInstPaid));
			investment.setPaidAmount(String.valueOf(updatedTotalDeposit));
			addinvestmentrepo.save(investment);

			// Save to DailyPremiumRenewalPM
			DailyPremiumRenewalPM ddRenewal = new DailyPremiumRenewalPM();
			ddRenewal.setPolicyCode(investment.getPolicyCode());
			ddRenewal.setRenewalDate(LocalDate.now().toString());
			ddRenewal.setPolicyDate(investment.getPolicyStartDate());
			ddRenewal.setMaturityDate(investment.getMaturityDate());
			ddRenewal.setCustomerCode(investment.getMemberSelection());
			ddRenewal.setClientName(investment.getCustomerName());
			ddRenewal.setContactNo(investment.getContactNo());
			ddRenewal.setPolicyAmount(parseDoubleSafe(investment.getPolicyAmount()));
			ddRenewal.setPolicyType(investment.getSchemeType());
			ddRenewal.setPolicyTerm(investment.getSchemeTerm());
			ddRenewal.setBranchname(investment.getBranchName());
			ddRenewal.setMaturityAmount(parseDoubleSafe(investment.getMaturityAmount()));
			ddRenewal.setTotalDeposit(parseDoubleSafe(investment.getPaidAmount()));
			ddRenewal.setPaymentDue(parseDoubleSafe(investment.getAmountDue()));
			ddRenewal.setLastPaymentDate(investment.getLastPaymentDate());
			ddRenewal.setDueDate(investment.getDueDate());
			ddRenewal.setNoOfInst(parseIntSafe(investment.getNoOfInstallments()));
			ddRenewal.setNoOfInstPaid(parseIntSafe(investment.getLastInstPaid()));
			ddRenewal.setModeOfPayment(modeOfPayment.isEmpty() ? investment.getModeOfPayment() : modeOfPayment);
			ddRenewal.setNetDeposit(NetDeposit);
			System.out.println("Net Deposite :" + NetDeposit);
			dailyPremiumRenewalRepo.save(ddRenewal);

			if (updatedDue == 0) {
				return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK, "Policy is ready for maturity.", null));
			} else if (updatedDue < 0) {
				return ResponseEntity
						.ok(new ApiResponse<>(HttpStatus.OK, "No payment needed. Policy is overpaid.", null));
			} else {
				return ResponseEntity.ok(
						new ApiResponse<>(HttpStatus.OK, "Installment updated and renewal saved successfully", null));
			}

		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(
					new ApiResponse<>(HttpStatus.INTERNAL_SERVER_ERROR, "Update failed: " + e.getMessage(), null));
		}
	}

	@GetMapping("/getApprovedPolicies")
	public ResponseEntity<ApiResponse<List<AddnewinvestmentPM>>> getApprovedPolicies() {
		List<AddnewinvestmentPM> approvedList = policyManagementService.getAllApprovedPolicies();

		if (approvedList.isEmpty()) {
			return ResponseEntity.status(HttpStatus.NOT_FOUND)
					.body(new ApiResponse<>(HttpStatus.NOT_FOUND, "No approved policies found", null));
		}

		return ResponseEntity
				.ok(new ApiResponse<>(HttpStatus.OK, "Approved policies fetched successfully", approvedList));

		// return ResponseEntity.ok(response);

		// return ResponseEntity.ok(response);

	}

	// return ResponseEntity.ok(response);

	@PostMapping("/updateinvestment")
	public ResponseEntity<ApiResponse<AddnewinvestmentPM>> updateInvestment(@RequestBody AddnewinvestmentPM invest) {
		AddnewinvestmentPM updated = policyManagementService.updateInstalmentDetails(invest.getPolicyCode(),
				invest.getDepositAmount());

		// Niraj Code Above

		if (updated != null) {
			ApiResponse<AddnewinvestmentPM> response = ApiResponse.success(HttpStatus.OK,
					"MIS deposit updated successfully.", updated);
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<AddnewinvestmentPM> response = ApiResponse.error(HttpStatus.NOT_FOUND,
					"MIS deposit not found or failed to update.");
			return ResponseEntity.status(HttpStatus.NOT_FOUND).body(response);
		}
	}

	@GetMapping("/findPolicyData")
	public ResponseEntity<ApiResponse<?>> findPolicyData(@RequestParam String policyCode) {

		List<FlexibleRenewal> fdData = policyManagementService.findBypolicyCode(policyCode);
		if (!fdData.isEmpty()) {
			return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "FD data found", fdData));
		}

		List<DailyPremiumRenewalPM> drdData = policyManagementService.findDailyData(policyCode);
		if (!drdData.isEmpty()) {
			return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "DRD data found", drdData));
		}

		List<PolicyRenewal> renewalData = policyManagementService.findRenewalData(policyCode);
		if (!renewalData.isEmpty()) {
			return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "RD/MIS data found", renewalData));
		}

		// Extend: check MIS policy / renewal data (for MIS policies)
		List<PolicyRenewal> misData = policyManagementService.findMisRenewalData(policyCode);
		if (!misData.isEmpty()) {
			return ResponseEntity.ok(ApiResponse.success(HttpStatus.OK, "MIS data found", misData));
		}

		return ResponseEntity.status(HttpStatus.NOT_FOUND)
				.body(ApiResponse.error(HttpStatus.NOT_FOUND, "No policy data found for policyCode: " + policyCode));
	}

	// Ayush
	@PostMapping("/saveandupdateAddInvestment")
	public ResponseEntity<ApiResponse<AddnewinvestmentPM>> saveandupdateAddInvestmentDetails(
			@ModelAttribute PolicyManagementDto policyManagementDto,
			@RequestParam(value = "image1", required = false) String image1,
			@RequestParam(value = "image2", required = false) String image2) {

		String customerCode = policyManagementDto.getMemberSelection(); // assuming it's Long

		System.out.println("Received photo: " + image1);

		System.out.println("Received signature: " + image2);

		ApiResponse<AddnewinvestmentPM> response = policyManagementService
				.saveandupdateAddInvestmentDetails(policyManagementDto, image1, image2);

		if (response.getStatus() != HttpStatus.OK && response.getStatus() != HttpStatus.CREATED) {
			return ResponseEntity.status(response.getStatus()).body(response);
		}

		return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK,
				policyManagementDto.getId() != null ? "✅ Investment Updated successfully"
						: "✅ Investment saved successfully",
				response.getData()));
	}

	@GetMapping("/getFullMaturityByPolicyCode")
	public ResponseEntity<ApiResponse<List<FullMaturity>>> fetchFullMaturityByPolicyCode(
			@RequestParam("policyCode") String policyCode) {

		List<FullMaturity> policyList = policyManagementService.fetchFullMaturityByPolicyCode(policyCode);

		if (policyList != null && !policyList.isEmpty()) {
			ApiResponse<List<FullMaturity>> response = new ApiResponse<>(HttpStatus.OK,
					"Payment Data found successfully", policyList);
			return ResponseEntity.ok(response);
		}

		// Fallback 1: Daily Premium Renewals
		List<DailyPremiumRenewalPM> drdData = policyManagementService.findDailyData(policyCode);
		if (drdData != null && !drdData.isEmpty()) {
			List<FullMaturity> mappedList = drdData.stream().map(drd -> {
				FullMaturity fm = new FullMaturity();
				fm.setPolicyCode(drd.getPolicyCode());
				fm.setCustomerName(drd.getClientName());
				fm.setPolicyAmount(drd.getPolicyAmount() != null ? String.valueOf(drd.getPolicyAmount()) : "0");
				double amt = drd.getNetDeposit() > 0 ? drd.getNetDeposit()
						: (drd.getPolicyAmount() != null ? drd.getPolicyAmount() : 0);
				fm.setAmount(String.valueOf(amt));
				fm.setPaymentDate(drd.getRenewalDate() != null ? drd.getRenewalDate()
						: (drd.getLastPaymentDate() != null ? drd.getLastPaymentDate() : drd.getPolicyDate()));
				fm.setMaturityDate(drd.getMaturityDate());
				fm.setBranchName(drd.getBranchname());
				fm.setModeofPayment(drd.getModeOfPayment());
				return fm;
			}).collect(Collectors.toList());

			return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK, "Daily Renewal Data found", mappedList));
		}

		// Fallback 2: Policy Renewals (RD/MIS)
		List<PolicyRenewal> renewalData = policyManagementService.findRenewalData(policyCode);
		if (renewalData != null && !renewalData.isEmpty()) {
			List<FullMaturity> mappedList = renewalData.stream().map(ren -> {
				FullMaturity fm = new FullMaturity();
				fm.setPolicyCode(ren.getPolicyCode());
				fm.setCustomerName(ren.getClientName());
				fm.setPolicyAmount(ren.getPolicyAmount() != null ? String.valueOf(ren.getPolicyAmount()) : "0");
				fm.setAmount(ren.getPolicyAmount() != null ? String.valueOf(ren.getPolicyAmount()) : "0");
				fm.setPaymentDate(ren.getRenewalDate() != null ? ren.getRenewalDate()
						: (ren.getLastPaymentDate() != null ? ren.getLastPaymentDate() : ren.getPolicyDate()));
				fm.setMaturityDate(ren.getMaturityDate());
				fm.setBranchName(ren.getBranchname());
				fm.setModeofPayment(ren.getModeOfPayment());
				return fm;
			}).collect(Collectors.toList());

			return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK, "Renewal Data found", mappedList));
		}

		// Fallback 3: Flexible Renewals
		List<FlexibleRenewal> fdData = policyManagementService.findBypolicyCode(policyCode);
		if (fdData != null && !fdData.isEmpty()) {
			List<FullMaturity> mappedList = fdData.stream().map(fd -> {
				FullMaturity fm = new FullMaturity();
				fm.setPolicyCode(fd.getPolicyCode());
				fm.setCustomerName(fd.getClientName());
				fm.setPolicyAmount(fd.getPolicyAmount() != null ? String.valueOf(fd.getPolicyAmount()) : "0");
				double amt = fd.getNetDeposit() > 0 ? fd.getNetDeposit()
						: (fd.getPolicyAmount() != null ? fd.getPolicyAmount() : 0);
				fm.setAmount(String.valueOf(amt));
				fm.setPaymentDate(fd.getRenewalDate() != null ? fd.getRenewalDate()
						: (fd.getLastPaymentDate() != null ? fd.getLastPaymentDate() : fd.getPolicyDate()));
				fm.setMaturityDate(fd.getMaturityDate());
				fm.setBranchName(fd.getBranchname());
				fm.setModeofPayment(fd.getModeOfPayment());
				return fm;
			}).collect(Collectors.toList());

			return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK, "Flexible Renewal Data found", mappedList));
		}

		// Return 200 OK with empty list if no installment data found (prevents JS error
		// alert)
		return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK,
				"No installment data found for code: " + policyCode, java.util.Collections.emptyList()));
	}

	@PostMapping("/deletePolicyDataById")
	public ResponseEntity<ApiResponse<String>> deletePolicyDataById(@RequestParam("id") Long id) {
		boolean isDeleted = policyManagementService.deletePolicyDataById(id);
		if (isDeleted) {
			ApiResponse<String> response = new ApiResponse<>(HttpStatus.OK, "Policy Data deleted successfully",
					"success");
			return ResponseEntity.ok(response);
		} else {
			ApiResponse<String> response = new ApiResponse<>(HttpStatus.NOT_FOUND, "Policy Data deletion failed",
					"failure");
			return ResponseEntity.badRequest().body(response);
		}
	}

	@GetMapping("/getApprovedRDFromFullMaturity")
	public ResponseEntity<ApiResponse<List<FullMaturity>>> getApprovedRD(
			@RequestParam(value = "policyCode", required = false) String policyCode) {
		List<FullMaturity> approvedList = policyManagementService.getAllApprovedRDPolicies(policyCode);

		if (approvedList == null || approvedList.isEmpty()) {
			return ResponseEntity.ok(new ApiResponse<>(HttpStatus.OK, "No approved policies found", java.util.Collections.emptyList()));
		}

		return ResponseEntity
				.ok(new ApiResponse<>(HttpStatus.OK, "Approved RD policies fetched successfully", approvedList));

	}

}
