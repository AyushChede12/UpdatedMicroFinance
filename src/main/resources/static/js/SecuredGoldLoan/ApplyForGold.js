// =========================================================================
// ApplyForGold.js - Secured Gold Loan Application Business Logic & Auto-calc
// =========================================================================

let goldDirectories = [];
let customers = [];
let goldSecurePlans = [];
let additionalGoldItems = []; // Repeatable gold items array

$(document).ready(function() {

	// 1. Fetch Financial Consultants
	$.ajax({
		url: 'api/financialconsultant/getAllFinancialConsultantDetails',
		type: 'POST',
		success: function(response) {
			const consultantDropdown = $('#financialConsultantId');
			consultantDropdown.empty();
			consultantDropdown.append('<option value="">SELECT CONSULTANT</option>');

			if (response && response.data) {
				response.data.forEach(function(fc) {
					consultantDropdown.append('<option value="' + fc.financialCode + '">' + fc.financialCode + " - " + (fc.financialName || '') + '</option>');
				});
			}
		},
		error: function(err) {
			console.error('Error fetching consultant data:', err);
		}
	});

	// 2. Fetch Gold Directories
	$.ajax({
		url: "api/securedGoldLoan/getAllGoldDirectories",
		type: "GET",
		success: function(response) {
			if (response && response.data) {
				goldDirectories = response.data;
			}
			populateCustomerDropdown();
		}
	});

	// 3. Fetch All Customers for Primary, Guarantor, and Co-Applicant dropdowns
	$.ajax({
		url: "api/securedGoldLoan/getAllCustomers",
		type: "GET",
		success: function(response) {
			if (response && response.data) {
				customers = response.data;
			}
			populateCustomerDropdown();
			populateGuarantorAndCoApplicantDropdowns();
		}
	});

	// 4. Fetch Gold Secure Plans (for scheme processing fee % & terms)
	$.ajax({
		url: "api/securedGoldLoan/allDataFetchGoldSecurePlan",
		type: "GET",
		success: function(response) {
			if (response && response.data) {
				goldSecurePlans = response.data;
			}
			populateLoanPlanDropdown();
		},
		error: function() {
			populateLoanPlanDropdown();
		}
	});

	// ---------------------------------------------------------------------
	// Loan Plan Selection & Auto-fill Scheme Defaults
	// ---------------------------------------------------------------------
	$("#loanPlanName").on("change", function() {
		const selectedPlanName = $(this).val();
		if (!selectedPlanName) return;

		let plan = null;
		if (goldSecurePlans && goldSecurePlans.length > 0) {
			plan = goldSecurePlans.find(p => p.loanPlanName && p.loanPlanName.trim().toUpperCase() === selectedPlanName.trim().toUpperCase());
		}

		if (plan) {
			if (plan.typeOfLoan && plan.typeOfLoan.trim() !== "") {
				$("#typeOfLoan").val(plan.typeOfLoan.trim());
			}
			if (plan.loanMode && plan.loanMode.trim() !== "") {
				const lm = plan.loanMode.trim().toUpperCase();
				if (lm.includes("BULLET")) $("#loanMode").val("Bullet");
				else if (lm.includes("MONTHLY")) $("#loanMode").val("Monthly");
				else if (lm.includes("WEEKLY")) $("#loanMode").val("Weekly");
				else if (lm.includes("DAILY")) $("#loanMode").val("Daily");
				else $("#loanMode").val("EMI");
			}
			if (plan.loanTerm && plan.loanTerm.trim() !== "") {
				$("#loanTerm").val(plan.loanTerm.trim());
			} else if (!$("#loanTerm").val() || $("#loanTerm").val() === "0") {
				$("#loanTerm").val("12");
			}
			if (plan.rateInterestType && plan.rateInterestType.trim() !== "") {
				$("#rateOfInterest").val(plan.rateInterestType.trim());
			} else if (!$("#rateOfInterest").val()) {
				$("#rateOfInterest").val("12.0");
			}
			if (plan.interestType && plan.interestType.trim() !== "") {
				const it = plan.interestType.trim().toUpperCase();
				if (it.includes("REDUC")) {
					$("#interestType").val("REDUCING");
				} else if (it.includes("RULE")) {
					$("#interestType").val("Rule 78");
				} else {
					$("#interestType").val("FLAT");
				}
			}
		}

		handleLoanModeToggle();
		calculateDeductions();
		calculateEMI();
	});

	// ---------------------------------------------------------------------
	// Primary Customer Selection (Find Customers)
	// ---------------------------------------------------------------------
	$("#memberCode").on("change", function() {
		const selectedCode = $(this).val();
		if (!selectedCode) return;

		const cust = customers.find(c => c.memberCode === selectedCode);
		const gold = goldDirectories.find(g => g.customerCode === selectedCode);

		if (cust) {
			const fullName = [cust.firstName, cust.middleName, cust.lastName].filter(Boolean).join(" ") || cust.customerName || "";
			$("#customerName").val(fullName.toUpperCase());
			$("#dateOfBirth").val(cust.dob || "");
			$("#age").val(cust.customerAge || "");
			$("#contactNo").val(cust.contactNo || "");
			$("#address").val((cust.customerAddress || "").toUpperCase());
			$("#pinCode").val(cust.pinCode || "");
			$("#branchName").val((cust.branchName || "").toUpperCase());
			if (!$("#lockerBranch").val() && cust.branchName) {
				$("#lockerBranch").val(cust.branchName.toUpperCase());
			}

			// Photo
			if (cust.customerPhoto) {
				const photoPath = "Uploads/" + cust.customerPhoto;
				$("#photoPreview").attr("src", photoPath);
				$("#photoHidden").val(photoPath);
			} else {
				$("#photoPreview").attr("src", "Uploads/upload.png");
				$("#photoHidden").val("");
			}

			// Signature
			if (cust.customerSignature) {
				const signPath = "Uploads/" + cust.customerSignature;
				$("#signaturePreview").attr("src", signPath);
				$("#signatureHidden").val(signPath);
			} else {
				$("#signaturePreview").attr("src", "Uploads/upload.png");
				$("#signatureHidden").val("");
			}
		}

		if (gold && gold.loanPlanName) {
			if ($("#loanPlanName option[value='" + gold.loanPlanName + "']").length === 0) {
				$("#loanPlanName").append('<option value="' + gold.loanPlanName + '">' + gold.loanPlanName.toUpperCase() + '</option>');
			}
			$("#loanPlanName").val(gold.loanPlanName);

			if (gold.typeOfLoan) $("#typeOfLoan").val(gold.typeOfLoan);
			if (gold.loanMode) $("#loanMode").val(gold.loanMode);
			if (gold.loanTerm) $("#loanTerm").val(gold.loanTerm);
			if (gold.rateOfInterest) $("#rateOfInterest").val(gold.rateOfInterest);
			if (gold.typeIntrest) $("#interestType").val(gold.typeIntrest.toUpperCase());
			if (gold.itemMasterType) $("#itemType").val(gold.itemMasterType.toUpperCase());
			if (gold.itemName) $("#itemName").val(gold.itemName.toUpperCase());
			if (gold.lockerBranch) $("#lockerBranch").val(gold.lockerBranch.toUpperCase());
			if (gold.purity) $("#purity").val(gold.purity);

			if (gold.karat) {
				const cleanK = gold.karat.replace(/[^0-9]/g, '');
				if (["18", "20", "22", "24"].includes(cleanK)) {
					$("#karat").val(cleanK);
					fetchKaratRate(cleanK);
				}
			}

			if (gold.itemWeight) {
				$("#itemWt").val(gold.itemWeight);
			}

			handleLoanModeToggle();
			calculateDeductions();
			calculateValuation();
		} else {
			// If customer does not have gold directory entry, auto-select first loan plan if none chosen
			if (!$("#loanPlanName").val() && $("#loanPlanName option").length > 1) {
				$("#loanPlanName").prop("selectedIndex", 1).trigger("change");
			}
		}
	});

	// ---------------------------------------------------------------------
	// Auto-fetch Customer Karat Rate on Karat Selection (18/20/22/24)
	// ---------------------------------------------------------------------
	$("#karat").on("change", function() {
		const karat = $(this).val();
		if (karat) {
			const kNum = parseFloat(karat);
			if (kNum > 0) {
				$("#purity").val((kNum / 24).toFixed(4));
			}
			fetchKaratRate(karat);
		} else {
			$("#custgoldRate").val("");
			$("#purity").val("");
			calculateValuation();
		}
	});

	// ---------------------------------------------------------------------
	// Live Auto-calc on Blur & Input of Gold Weight & Rate Fields
	// ---------------------------------------------------------------------
	$("#itemQty, #itemWt").on("blur input", function() {
		const qty = parseFloat($("#itemQty").val()) || 1;
		const itemWt = parseFloat($("#itemWt").val()) || 0;
		if (itemWt > 0) {
			$("#grossWt").val((qty * itemWt).toFixed(3));
		}
		calculateValuation();
	});

	$("#grossWt").on("blur input", function() {
		const gross = parseFloat($(this).val()) || 0;
		const qty = parseFloat($("#itemQty").val()) || 1;
		if (gross > 0 && qty > 0) {
			$("#itemWt").val((gross / qty).toFixed(3));
		}
		calculateValuation();
	});

	$("#stoneWt, #custgoldRate").on("blur input", function() {
		calculateValuation();
	});

	// ---------------------------------------------------------------------
	// Live Loan Amount Validation & Cascade Calculations
	// ---------------------------------------------------------------------
	$("#loanAmount").on("input blur", function() {
		validateLoanAmount();
		calculateDeductions();
		calculateEMI();
	});

	// ---------------------------------------------------------------------
	// Live Deduction Fields Trigger
	// ---------------------------------------------------------------------
	$("#processingFee, #valuationFees, #legalCharges, #stampDuty, #smsCharges, #mainCharges, #stationaryFee, #insuFee, #penaltyCharge, #overCharge, #collectionCharge").on("input blur", function() {
		calculateDeductions();
	});

	// ---------------------------------------------------------------------
	// Loan Mode & EMI Triggers
	// ---------------------------------------------------------------------
	$("#loanMode, #rateOfInterest, #loanTerm, #interestType").on("change input", function() {
		handleLoanModeToggle();
		calculateEMI();
	});

	// ---------------------------------------------------------------------
	// Guarantor Lookup via /api/customer/{code}
	// ---------------------------------------------------------------------
	$("#guarantorcustomerCode").on("change", function() {
		const code = $(this).val();
		if (code) {
			lookupCustomerDetails(code, function(data) {
				$("#gurantorIdentity").val(data.identityType || "Aadhar");
				$("#guarantorAddress").val(data.address || "").prop("readonly", true);
				$("#guarantorPinCode").val(data.pinCode || "").prop("readonly", true);
				$("#guarantorContactNo").val(data.contactNo || "").prop("readonly", true);
			});
		} else {
			$("#guarantorAddress, #guarantorPinCode, #guarantorContactNo").val("");
		}
	});

	// ---------------------------------------------------------------------
	// Co-Applicant Lookup via /api/customer/{code}
	// ---------------------------------------------------------------------
	$("#coApplicantMemberId").on("change", function() {
		const code = $(this).val();
		if (code) {
			lookupCustomerDetails(code, function(data) {
				$("#coApplicantIdentity").val(data.identityType || "Aadhar");
				$("#coApplicantAddress").val(data.address || "").prop("readonly", true);
				$("#coAge").val(data.age || "").prop("readonly", true);
				$("#coApplicantContactNo").val(data.contactNo || "").prop("readonly", true);
			});
		} else {
			$("#coApplicantAddress, #coAge, #coApplicantContactNo").val("");
		}
	});

	// Financial Consultant Change
	$("#financialConsultantId").on("change", function() {
		const code = $(this).val();
		if (code) {
			$.ajax({
				url: "api/financialconsultant/getfinancialHierarchyByFinancialCode",
				type: "GET",
				data: { financialCode: code },
				success: function(response) {
					if (response && response.data && response.data.length > 0) {
						$("#financialConsultantName").val(response.data[0].financialName || "");
					}
				}
			});
		} else {
			$("#financialConsultantName").val("");
		}
	});

	// Initial defaults for Gold Details
	if (!$("#itemQty").val()) $("#itemQty").val("1");
	if (!$("#stoneWt").val()) $("#stoneWt").val("0.00");
	if (!$("#itemType").val()) $("#itemType").val("Gold");

	// Initial toggle check
	handleLoanModeToggle();
});

// =========================================================================
// Dropdown Population Functions
// =========================================================================
function populateCustomerDropdown() {
	const select = $("#memberCode");
	if (select.children("option").length > 1) return;

	select.empty().append('<option value="">SELECT CUSTOMER CODE</option>');

	// First try Gold Directory records
	if (goldDirectories && goldDirectories.length > 0) {
		goldDirectories.forEach(function(g) {
			const name = (g.customerName || "").toUpperCase();
			select.append('<option value="' + g.customerCode + '">' + g.customerCode + " - " + name + '</option>');
		});
	} else if (customers && customers.length > 0) {
		customers.forEach(function(c) {
			const name = (c.customerName || c.memberCode).toUpperCase();
			select.append('<option value="' + c.memberCode + '">' + c.memberCode + " - " + name + '</option>');
		});
	}
}

function populateLoanPlanDropdown() {
	const select = $("#loanPlanName");
	const currentVal = select.val();
	select.empty().append('<option value="">SELECT LOAN PLAN</option>');

	const uniqueNames = new Set();
	if (goldSecurePlans && goldSecurePlans.length > 0) {
		goldSecurePlans.forEach(function(p) {
			if (p.loanPlanName && p.loanPlanName.trim() !== "" && !uniqueNames.has(p.loanPlanName.trim().toUpperCase())) {
				uniqueNames.add(p.loanPlanName.trim().toUpperCase());
				select.append('<option value="' + p.loanPlanName.trim() + '">' + p.loanPlanName.trim().toUpperCase() + '</option>');
			}
		});
	}

	// Always ensure standard defaults exist if not already in DB
	const defaultPlans = ["Gold Loan", "Silver Loan", "Gold Mudra Loan", "Gold Prashthan"];
	defaultPlans.forEach(function(dp) {
		if (!uniqueNames.has(dp.toUpperCase())) {
			select.append('<option value="' + dp + '">' + dp.toUpperCase() + '</option>');
		}
	});

	if (currentVal && select.find("option[value='" + currentVal + "']").length > 0) {
		select.val(currentVal);
	}
}

function populateGuarantorAndCoApplicantDropdowns() {
	const guarantorSelect = $("#guarantorcustomerCode");
	const coApplicantSelect = $("#coApplicantMemberId");

	guarantorSelect.empty().append('<option value="">SELECT CUSTOMER CODE</option>');
	coApplicantSelect.empty().append('<option value="">CUSTOMER CODE</option>');

	if (customers && customers.length > 0) {
		customers.forEach(function(c) {
			const label = c.memberCode + (c.customerName ? " - " + c.customerName.toUpperCase() : "");
			guarantorSelect.append('<option value="' + c.memberCode + '">' + label + '</option>');
			coApplicantSelect.append('<option value="' + c.memberCode + '">' + label + '</option>');
		});
	}
}

// =========================================================================
// API Lookup Functions
// =========================================================================
function fetchKaratRate(karat) {
	if (!karat) return;

	const kNum = parseFloat(karat);
	if (kNum > 0) {
		$("#purity").val((kNum / 24).toFixed(4));
	}

	$.ajax({
		url: 'api/gold-rate/today',
		type: 'GET',
		data: { karat: karat },
		success: function(response) {
			if (response && response.data) {
				let rate = 0;
				if (response.data.rate) {
					rate = response.data.rate;
				} else if (response.data.rates && response.data.rates[karat]) {
					rate = response.data.rates[karat];
				}
				if (rate) {
					$("#custgoldRate").val(parseFloat(rate).toFixed(2));
					calculateValuation();
				}
			}
		},
		error: function(err) {
			console.error("Failed to fetch today gold rate:", err);
			const fallbackRates = { "24": 7500, "22": 6875, "20": 6250, "18": 5625 };
			if (fallbackRates[karat]) {
				$("#custgoldRate").val(fallbackRates[karat].toFixed(2));
				calculateValuation();
			}
		}
	});
}

function lookupCustomerDetails(code, callback) {
	if (!code) return;

	$.ajax({
		url: 'api/customer/' + encodeURIComponent(code.trim()),
		type: 'GET',
		success: function(response) {
			if (response && response.data) {
				callback(response.data);
			}
		},
		error: function(err) {
			console.error("Failed to lookup customer " + code + ":", err);
			// Fallback to local customers cache
			const local = customers.find(c => c.memberCode === code);
			if (local) {
				callback({
					identityType: local.aadharNo ? "Aadhar" : (local.panNo ? "PAN" : "Aadhar"),
					address: local.customerAddress || "",
					pinCode: local.pinCode || "",
					contactNo: local.contactNo || "",
					age: local.customerAge || ""
				});
			}
		}
	});
}

// =========================================================================
// Calculations: Net Weight, Market Valuation & Tiered LTV Eligible Loan
// =========================================================================
function calculateValuation() {
	const itemQuantity = parseFloat($("#itemQty").val()) || 1;
	const itemWeight = parseFloat($("#itemWt").val()) || 0;
	let grossWeight = parseFloat($("#grossWt").val());

	if (isNaN(grossWeight) || grossWeight === 0 || document.activeElement === document.getElementById("itemWt") || document.activeElement === document.getElementById("itemQty")) {
		grossWeight = itemQuantity * itemWeight;
		if (grossWeight > 0) {
			$("#grossWt").val(grossWeight.toFixed(3));
		}
	}

	const stoneWeight = parseFloat($("#stoneWt").val()) || 0;
	const karat = parseFloat($("#karat").val()) || 0;
	const custRate = parseFloat($("#custgoldRate").val()) || 0;

	// Validation inline: grossWeight > stoneWt
	if (grossWeight > 0 && stoneWeight >= grossWeight) {
		$("#vstoneWt").text("*Stone weight must be less than gross weight");
	} else {
		$("#vstoneWt").text("");
	}

	// 2. Net Weight = Gross Weight - Stone Weight
	const netWeight = Math.max(0, grossWeight - stoneWeight);

	// 3. Purity = Karat / 24
	const purity = karat > 0 ? (karat / 24) : 0;
	if (purity > 0) {
		$("#purity").val(purity.toFixed(4));
	}

	// 4. Market Valuation = Net Weight * (Karat / 24) * Customer Karat Rate
	const marketValuation = netWeight * purity * custRate;

	// 5. Eligible Loan per Tiered RBI LTV Direction
	// 85% for <= 2.5L, 80% for <= 5L, 75% for above
	let ltv = 0.75;
	if (marketValuation <= 250000) {
		ltv = 0.85;
	} else if (marketValuation <= 500000) {
		ltv = 0.80;
	} else {
		ltv = 0.75;
	}
	const primaryEligibleLoan = marketValuation * ltv;

	// Set primary row fields
	$("#netWt").val(netWeight > 0 ? netWeight.toFixed(3) : "0.000");
	$("#marketValuation").val(marketValuation > 0 ? marketValuation.toFixed(2) : "0.00");
	$("#eligibleLoan").val(primaryEligibleLoan > 0 ? primaryEligibleLoan.toFixed(2) : "0.00");

	// Recalculate total across primary + repeatable items
	const totalEligible = getTotalEligibleLoan();
	if (!$("#loanAmount").val() || parseFloat($("#loanAmount").val()) === 0) {
		$("#loanAmount").val(totalEligible > 0 ? totalEligible.toFixed(2) : "");
	}

	validateLoanAmount();
	calculateDeductions();
	calculateEMI();
}

function getTotalEligibleLoan() {
	let total = parseFloat($("#eligibleLoan").val()) || 0;
	if (additionalGoldItems && additionalGoldItems.length > 0) {
		additionalGoldItems.forEach(item => {
			total += (parseFloat(item.eligibleLoan) || 0);
		});
	}
	return total;
}

function getTotalMarketValuation() {
	let total = parseFloat($("#marketValuation").val()) || 0;
	if (additionalGoldItems && additionalGoldItems.length > 0) {
		additionalGoldItems.forEach(item => {
			total += (parseFloat(item.marketValuation) || 0);
		});
	}
	return total;
}

function validateLoanAmount() {
	const loanAmount = parseFloat($("#loanAmount").val()) || 0;
	const totalEligible = getTotalEligibleLoan();

	if (totalEligible > 0 && loanAmount > totalEligible) {
		$("#vloanAmount").text("*Loan Amount (₹" + loanAmount.toFixed(2) + ") cannot exceed Eligible Loan (₹" + totalEligible.toFixed(2) + ")");
		$("#loanAmount").css("border-color", "#dc3545");
		return false;
	} else {
		$("#vloanAmount").text("");
		$("#loanAmount").css("border-color", "");
		return true;
	}
}

// =========================================================================
// Deductions & Net Disbursement Auto-calc
// =========================================================================
function calculateDeductions() {
	const loanAmount = parseFloat($("#loanAmount").val()) || 0;
	const planName = $("#loanPlanName").val();

	// 1. Processing Fee = % of loan amount (from scheme / plan)
	let procFeePercent = 2.0; // standard default 2%
	if (planName && goldSecurePlans && goldSecurePlans.length > 0) {
		const plan = goldSecurePlans.find(p => p.loanPlanName && p.loanPlanName.toUpperCase() === planName.toUpperCase());
		if (plan && plan.procFee) {
			const parsed = parseFloat(plan.procFee.replace("%", "").trim());
			if (!isNaN(parsed) && parsed >= 0) {
				procFeePercent = parsed;
			}
		}
	}

	let processingFee = (procFeePercent / 100) * loanAmount;
	$("#processingFee").val(processingFee.toFixed(2));

	// 2. GST = 18% of (Processing Fee + Valuation Fees + Legal Charges)
	const valFees = parseFloat($("#valuationFees").val()) || 0;
	const legalCharges = parseFloat($("#legalCharges").val()) || 0;
	const gstBase = processingFee + valFees + legalCharges;
	const gst = gstBase * 0.18;
	$("#gst").val(gst.toFixed(2));

	// 3. Other deductions
	const stampDuty = parseFloat($("#stampDuty").val()) || 0;
	const smsCharges = parseFloat($("#smsCharges").val()) || 0;
	const mainCharges = parseFloat($("#mainCharges").val()) || 0;
	const stationaryFee = parseFloat($("#stationaryFee").val()) || 0;
	const insuFee = parseFloat($("#insuFee").val()) || 0;
	const penaltyCharge = parseFloat($("#penaltyCharge").val()) || 0;
	const overCharge = parseFloat($("#overCharge").val()) || 0;
	const collectionCharge = parseFloat($("#collectionCharge").val()) || 0;

	const sumDeductions = processingFee + legalCharges + stampDuty + smsCharges + mainCharges +
		stationaryFee + gst + insuFee + penaltyCharge + valFees + overCharge + collectionCharge;

	// 4. Net Disbursement = Amount of Loan - sum(all deduction fields)
	const netDisbursement = Math.max(0, loanAmount - sumDeductions);
	$("#netDisbursement").val(netDisbursement.toFixed(2));
}

// =========================================================================
// EMI Auto-calc & Bullet Mode Handler
// =========================================================================
function handleLoanModeToggle() {
	const mode = ($("#loanMode").val() || "").trim().toUpperCase();

	if (mode === "BULLET") {
		$("#emiPayment").val("0").prop("readonly", true).prop("disabled", true);
		$("#emiPayment").attr("placeholder", "NOT APPLICABLE (BULLET MODE)");
	} else {
		$("#emiPayment").prop("disabled", false).prop("readonly", true);
		$("#emiPayment").attr("placeholder", "ENTER EMI PAYMENT");
		calculateEMI();
	}
}

function calculateEMI() {
	const mode = ($("#loanMode").val() || "").trim().toUpperCase();
	if (mode === "BULLET") {
		$("#emiPayment").val("0");
		return;
	}

	const P = parseFloat($("#loanAmount").val()) || 0;
	const R = parseFloat($("#rateOfInterest").val()) || 0;
	const N = parseInt($("#loanTerm").val()) || 12;
	const interestType = ($("#interestType").val() || "FLAT").trim().toUpperCase();

	if (P <= 0 || N <= 0) {
		$("#emiPayment").val("0.00");
		return;
	}

	let emi = 0;
	if (interestType === "REDUCING") {
		if (R <= 0) {
			emi = P / N;
		} else {
			const r = (R / 12) / 100;
			emi = (P * r * Math.pow(1 + r, N)) / (Math.pow(1 + r, N) - 1);
		}
	} else {
		// Flat Rate
		const totalInterest = P * (R / 100) * (N / 12);
		const totalAmount = P + totalInterest;
		emi = totalAmount / N;
	}

	$("#emiPayment").val(emi.toFixed(2));
}

// =========================================================================
// Repeatable Gold Items Support
// =========================================================================
function addRepeatableGoldItem() {
	const karat = $("#karat").val();
	const custRate = parseFloat($("#custgoldRate").val()) || 0;
	const itemName = $("#itemName").val() || "ADDITIONAL GOLD ITEM";
	const itemType = $("#itemType").val() || "Gold";
	const lockerBranch = $("#lockerBranch").val() || "";

	if (!karat || custRate <= 0) {
		alert("Please select Karat and ensure Customer Karat Rate is loaded before adding additional items.");
		return;
	}

	const itemQty = prompt("Enter Item Quantity:", "1");
	if (itemQty === null) return;
	const qty = parseInt(itemQty) || 1;

	const itemWtPrompt = prompt("Enter Item Weight in grams:", "10.00");
	if (itemWtPrompt === null) return;
	const itemWt = parseFloat(itemWtPrompt) || 0;
	if (itemWt <= 0) {
		alert("Item weight must be positive.");
		return;
	}

	const stoneWtPrompt = prompt("Enter Stone Weight in grams (0 if none):", "0.00");
	if (stoneWtPrompt === null) return;
	const stoneWt = parseFloat(stoneWtPrompt) || 0;

	if (itemWt <= stoneWt) {
		alert("Item weight must be strictly greater than stone weight.");
		return;
	}

	const grossWt = qty * itemWt;
	const netWt = grossWt - stoneWt;
	const purity = parseFloat(karat) / 24;
	const valuation = netWt * purity * custRate;

	let ltv = 0.75;
	if (valuation <= 250000) ltv = 0.85;
	else if (valuation <= 500000) ltv = 0.80;
	else ltv = 0.75;

	const eligible = valuation * ltv;

	const newItem = {
		itemName: itemName,
		itemType: itemType,
		karat: parseInt(karat),
		custgoldRate: custRate,
		lockerBranch: lockerBranch,
		purity: purity.toFixed(4),
		itemQty: qty,
		itemWt: itemWt,
		grossWt: grossWt,
		stoneWt: stoneWt,
		netWt: netWt,
		marketValuation: valuation.toFixed(2),
		eligibleLoan: eligible.toFixed(2)
	};

	additionalGoldItems.push(newItem);
	renderAdditionalItemsTable();
	calculateValuation();
}

function removeRepeatableGoldItem(index) {
	additionalGoldItems.splice(index, 1);
	renderAdditionalItemsTable();
	calculateValuation();
}

function renderAdditionalItemsTable() {
	const tableBody = $("#additionalItemsBody");
	const section = $("#repeatableItemsSection");

	if (!additionalGoldItems || additionalGoldItems.length === 0) {
		section.hide();
		tableBody.empty();
		return;
	}

	section.show();
	tableBody.empty();

	additionalGoldItems.forEach((item, index) => {
		const row = `<tr>
			<td>${index + 2}</td>
			<td>${item.itemName}</td>
			<td>${item.karat}K</td>
			<td>₹${parseFloat(item.custgoldRate).toFixed(2)}</td>
			<td>${item.itemQty}</td>
			<td>${parseFloat(item.itemWt).toFixed(2)}</td>
			<td>${parseFloat(item.grossWt).toFixed(2)}</td>
			<td>${parseFloat(item.stoneWt).toFixed(2)}</td>
			<td>${parseFloat(item.netWt).toFixed(2)}</td>
			<td>₹${parseFloat(item.marketValuation).toFixed(2)}</td>
			<td>₹${parseFloat(item.eligibleLoan).toFixed(2)}</td>
			<td>
				<button type="button" class="btn btn-outline-danger btn-sm py-0 px-1" onclick="removeRepeatableGoldItem(${index})">
					<i class="bi bi-trash"></i> Remove
				</button>
			</td>
		</tr>`;
		tableBody.append(row);
	});
}

// =========================================================================
// Form Save & Submission
// =========================================================================
function saveGoldapplication() {
	let isValid = true;

	// Reset validation messages
	$('#vmemberCode').text('');
	$('#vloanPlanName').text('');
	$('#vpurposeOfLoan').text('');
	$('#vkarat').text('');
	$('#vitemQty').text('');
	$('#vitemWt').text('');
	$('#vstoneWt').text('');
	$('#vloanAmount').text('');
	$('#vgurantorIdentity').text('');
	$('#vcoApplicantIdentity').text('');
	$('#vprocessingFee').text('');
	$('#vfinancialConsultantId').text('');

	// 1. Mandatory Photo & Signature Check
	const photo = $('#photoHidden').val();
	const signature = $('#signatureHidden').val();

	if (!photo || photo.trim() === "" || photo.includes("default-placeholder") || photo.includes("upload.png")) {
		alert("❌ Upload Photo is mandatory before saving!");
		$('#photo').focus();
		return;
	}
	if (!signature || signature.trim() === "" || signature.includes("default-placeholder") || signature.includes("upload.png")) {
		alert("❌ Upload Signature is mandatory before saving!");
		$('#signature').focus();
		return;
	}

	// 2. Member Code Check
	const memberCode = $('#memberCode').val();
	if (!memberCode) {
		$('#vmemberCode').text('*please select customer code');
		$('#memberCode').focus();
		isValid = false;
	}

	// 2.1 Loan Plan Name Check
	const loanPlanName = $('#loanPlanName').val();
	if (!loanPlanName) {
		$('#vloanPlanName').text('*please select loan plan name');
		$('#loanPlanName').focus();
		isValid = false;
	}

	// 3. Karat Check (18/20/22/24)
	const karatVal = $('#karat').val();
	if (!karatVal || !["18", "20", "22", "24"].includes(karatVal)) {
		$('#vkarat').text('*karat must be 18, 20, 22, or 24');
		$('#karat').focus();
		isValid = false;
	}

	// 4. Weight Validation
	const itemQty = parseFloat($('#itemQty').val()) || 0;
	const itemWt = parseFloat($('#itemWt').val()) || 0;
	const stoneWt = parseFloat($('#stoneWt').val()) || 0;

	if (itemQty <= 0) {
		$('#vitemQty').text('*item quantity must be at least 1');
		isValid = false;
	}
	if (itemWt <= 0) {
		$('#vitemWt').text('*item weight must be greater than 0');
		isValid = false;
	}
	if (itemWt <= stoneWt) {
		$('#vstoneWt').text('*item weight must be strictly greater than stone weight');
		isValid = false;
	}

	// 5. Loan Amount vs Eligible Loan Validation
	if (!validateLoanAmount()) {
		alert("❌ Amount of Loan cannot exceed Eligible Loan!");
		$('#loanAmount').focus();
		return;
	}

	const loanAmount = parseFloat($('#loanAmount').val()) || 0;
	if (loanAmount <= 0) {
		$('#vloanAmount').text('*please enter a valid loan amount');
		$('#loanAmount').focus();
		isValid = false;
	}

	// 6. Identity Checks
	if (!$('#gurantorIdentity').val()) {
		$('#vgurantorIdentity').text('*please select guarantor identity');
		isValid = false;
	}
	if (!$('#coApplicantIdentity').val()) {
		$('#vcoApplicantIdentity').text('*please select coapplicant identity');
		isValid = false;
	}

	if (!isValid) {
		alert("⚠️ Please resolve the validation errors before saving.");
		return;
	}

	// Construct Items List (Primary Item + Additional Items)
	const primaryItem = {
		itemName: $('#itemName').val() || "Gold Item",
		itemType: $('#itemType').val() || "Gold",
		karat: parseInt($('#karat').val()),
		custgoldRate: parseFloat($('#custgoldRate').val()) || 0,
		lockerBranch: $('#lockerBranch').val() || "",
		purity: parseFloat($('#purity').val()) || (parseInt($('#karat').val()) / 24),
		itemQty: parseInt($('#itemQty').val()) || 1,
		itemWt: parseFloat($('#itemWt').val()) || 0,
		grossWt: parseFloat($('#grossWt').val()) || 0,
		stoneWt: parseFloat($('#stoneWt').val()) || 0,
		netWt: parseFloat($('#netWt').val()) || 0,
		marketValuation: parseFloat($('#marketValuation').val()) || 0,
		eligibleLoan: parseFloat($('#eligibleLoan').val()) || 0,
		itemPhoto: $('#ornamentPhotoHidden').val() || ""
	};

	const allItems = [primaryItem, ...additionalGoldItems];

	const applyForGoldRequest = {
		goldID: $('#goldID').val(),
		loanNo: $('#goldID').val(),
		loanDate: $('#loanDate').val(),
		memberCode: $('#memberCode').val(),
		customerName: $('#customerName').val(),
		dateOfBirth: $('#dateOfBirth').val(),
		age: $('#age').val(),
		contactNo: $('#contactNo').val(),
		address: $('#address').val(),
		pinCode: $('#pinCode').val(),
		branchName: $('#branchName').val(),
		loanPlanName: $('#loanPlanName').val(),
		typeOfLoan: $('#typeOfLoan').val(),
		loanMode: $('#loanMode').val(),
		loanTerm: $('#loanTerm').val(),
		rateOfInterest: $('#rateOfInterest').val(),
		loanAmount: loanAmount,
		interestType: $('#interestType').val() || "FLAT",
		emiPayment: parseFloat($('#emiPayment').val()) || 0,
		purposeOfLoan: $('#purposeOfLoan').val() || "Business/Personal",
		smsSend: $('#toggle-sms-send').is(':checked') ? "1" : "0",

		photo: photo,
		signature: signature,
		ornamentPhoto: $('#ornamentPhotoHidden').val() || "",
		ornamentPhoto2: $('#ornamentPhoto2Hidden').val() || "",

		items: allItems,

		// Guarantor Details
		guarantorcustomerCode: $('#guarantorcustomerCode').val(),
		guarantorIdentity: $('#gurantorIdentity').val(),
		guarantorAddress: $('#guarantorAddress').val(),
		guarantorPinCode: $('#guarantorPinCode').val(),
		guarantorContactNo: $('#guarantorContactNo').val(),
		guarantorSecurityType: $('#guarantorSecurityType').val(),

		// Co-Applicant Details
		coApplicantMemberId: $('#coApplicantMemberId').val(),
		coApplicantIdentity: $('#coApplicantIdentity').val(),
		coApplicantAddress: $('#coApplicantAddress').val(),
		coAge: $('#coAge').val(),
		coApplicantContactNo: $('#coApplicantContactNo').val(),
		securityDetails: $('#securityDetails').val(),

		// Deduction Details
		processingFee: parseFloat($('#processingFee').val()) || 0,
		legalCharges: parseFloat($('#legalCharges').val()) || 0,
		stampDuty: parseFloat($('#stampDuty').val()) || 0,
		smsCharges: parseFloat($('#smsCharges').val()) || 0,
		mainCharges: parseFloat($('#mainCharges').val()) || 0,
		stationaryFee: parseFloat($('#stationaryFee').val()) || 0,
		gst: parseFloat($('#gst').val()) || 0,
		insuFee: parseFloat($('#insuFee').val()) || 0,
		penaltyCharge: parseFloat($('#penaltyCharge').val()) || 0,
		valuationFees: parseFloat($('#valuationFees').val()) || 0,
		overCharge: parseFloat($('#overCharge').val()) || 0,
		collectionCharge: parseFloat($('#collectionCharge').val()) || 0,
		financialConsultantId: $('#financialConsultantId').val(),
		financialConsultantName: $('#financialConsultantName').val(),
		netDisbursement: parseFloat($('#netDisbursement').val()) || 0
	};

	$('#saveBtn').prop('disabled', true).text('SAVING...');

	$.ajax({
		url: 'api/securedGoldLoan/saveApplyForGold',
		type: 'POST',
		contentType: 'application/json',
		data: JSON.stringify(applyForGoldRequest),
		success: function(response) {
			$('#saveBtn').prop('disabled', false).text('SAVE');

			if (response.status === 'CREATED' || response.status === 'OK') {
				const saved = response.data;
				const loanNo = (saved && (saved.goldID || saved.loanNo)) ? (saved.goldID || saved.loanNo) : applyForGoldRequest.goldID;
				alert("✅ Gold Loan Application Saved Successfully!\n\nLoan No / Gold ID: " + loanNo + "\nStatus: PENDING_APPROVAL\n(Routed to Board Approvals)");
				location.reload();
			} else {
				alert('❌ Failed to save application: ' + (response.message || 'Unknown error'));
			}
		},
		error: function(xhr, status, error) {
			$('#saveBtn').prop('disabled', false).text('SAVE');
			console.error('Error saving gold loan:', xhr);
			let errorMsg = 'Error while saving Gold Loan Application.';
			try {
				const res = JSON.parse(xhr.responseText);
				if (res.message) errorMsg = res.message;
			} catch (e) {}
			alert('⚠️ ' + errorMsg);
		}
	});
}

// =========================================================================
// Photo & Signature Upload Helpers
// =========================================================================
function photoSizeEdit(e) {
	const preview = document.getElementById("photoPreview");
	preview.src = e.target.result;
	preview.style.width = "100%";
	preview.style.height = "100%";
	preview.style.objectFit = "cover";
	preview.style.borderRadius = "15px";
}

function signatureSizeEdit(e) {
	const preview = document.getElementById("signaturePreview");
	preview.src = e.target.result;
	preview.style.width = "100%";
	preview.style.height = "100%";
	preview.style.objectFit = "cover";
	preview.style.borderRadius = "15px";
}

function photoUpload() {
	const file = document.getElementById("photo").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			photoSizeEdit(e);
			$("#photoHidden").val(e.target.result);
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for photo.");
	}
}

function signatureUpload() {
	const file = document.getElementById("signature").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			signatureSizeEdit(e);
			$("#signatureHidden").val(e.target.result);
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for signature.");
	}
}

function ornamentPhotoSizeEdit(e) {
	const preview = document.getElementById("ornamentPhotoPreview");
	preview.src = e.target.result;
	preview.style.width = "100%";
	preview.style.height = "100%";
	preview.style.objectFit = "cover";
	preview.style.borderRadius = "15px";
}

function ornamentPhotoSizeEdit2(e) {
	const preview = document.getElementById("ornamentPhoto2Preview");
	preview.src = e.target.result;
	preview.style.width = "100%";
	preview.style.height = "100%";
	preview.style.objectFit = "cover";
	preview.style.borderRadius = "15px";
}

function ornamentPhotoUpload() {
	const file = document.getElementById("ornamentPhoto").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			ornamentPhotoSizeEdit(e);
			$("#ornamentPhotoHidden").val(e.target.result);
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for Ornament Photo 1.");
	}
}

function ornamentPhotoUpload2() {
	const file = document.getElementById("ornamentPhoto2").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			ornamentPhotoSizeEdit2(e);
			$("#ornamentPhoto2Hidden").val(e.target.result);
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for Ornament Photo 2.");
	}
}
