let customerSavingsAccounts = [];
let currentGoldLoanData = null;
let currentGoldPayments = [];
let hasAlertedMatch = false;

// 1. Period Days helper matching Credit and Advances
function getPeriodDays(mode) {
	switch ((mode || "").trim()) {
		case "Daily": return 1;
		case "Weekly": return 7;
		case "Fortnightly": return 14;
		case "Quarterly": return 91;
		default: return 30; // Monthly
	}
}

// 2. Due Date calculation matching Credit and Advances
function calculateDueDate(baseDateStr, instNum, mode) {
	if (!baseDateStr) return "";
	try {
		const base = new Date(baseDateStr);
		const periodDays = getPeriodDays(mode);
		base.setDate(base.getDate() + (instNum * periodDays));
		return base.toISOString().split('T')[0];
	} catch (e) {
		return "";
	}
}

// 3. Penalty Recalculation (5 grace days, 2% rate)
function recalculatePenalty() {
	const emiDueDateVal = $("#emiDueDate").val();
	const payDateVal = $("#PaymentDate").val();
	const emiAmt = parseFloat($("#paymentAmount").val()) || parseFloat($("#dueAmount").val()) || 0;

	if (!emiDueDateVal || !payDateVal) {
		$("#penaltyAmount").val("Rs. 0.00").css("color", "#2e7d32");
		$("#daysLate").val("0");
		updateNetAmount();
		return;
	}

	const emiDue = new Date(emiDueDateVal);
	const payDate = new Date(payDateVal);
	const graceDays = 5;

	// Deadline = due date + 5 days grace
	const deadline = new Date(emiDue);
	deadline.setDate(deadline.getDate() + graceDays);

	const diffTime = payDate.getTime() - deadline.getTime();
	const diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));
	const daysLate = Math.max(0, diffDays);

	$("#daysLate").val(daysLate);

	if (daysLate > 0) {
		const penaltyRate = 0.02; // 2% penalty
		const penalty = Math.round(emiAmt * penaltyRate * 100) / 100;
		$("#penaltyAmount").val("Rs. " + penalty.toFixed(2)).css("color", "#c62828");
	} else {
		$("#penaltyAmount").val("Rs. 0.00").css("color", "#2e7d32");
	}

	updateNetAmount();
	if ($("#sourcePayment").val() === "Cash") {
		calculateDenomination();
	}
}

// 4. Update Net Amount = Payment Amount + Penalty
function updateNetAmount() {
	const emiAmt = parseFloat($("#paymentAmount").val()) || 0;
	const rawPenalty = ($("#penaltyAmount").val() || "").replace(/[^0-9.]/g, "");
	const penaltyAmt = parseFloat(rawPenalty) || 0;
	const total = emiAmt + penaltyAmt;
	$("#netAmount").val(total.toFixed(2));
}

// 5. Cash Note Denomination Calculation
function calculateDenomination() {
	const c500 = parseInt($("#denom500").val()) || 0;
	const c200 = parseInt($("#denom200").val()) || 0;
	const c100 = parseInt($("#denom100").val()) || 0;
	const c50  = parseInt($("#denom50").val())  || 0;
	const c20  = parseInt($("#denom20").val())  || 0;
	const c10  = parseInt($("#denom10").val())  || 0;
	const c5   = parseInt($("#denom5").val())   || 0;
	const c2   = parseInt($("#denom2").val())   || 0;
	const c1   = parseInt($("#denom1").val())   || 0;

	const s500 = c500 * 500;
	const s200 = c200 * 200;
	const s100 = c100 * 100;
	const s50  = c50 * 50;
	const s20  = c20 * 20;
	const s10  = c10 * 10;
	const s5   = c5 * 5;
	const s2   = c2 * 2;
	const s1   = c1 * 1;

	$("#denomSub500").text("Rs. " + s500.toLocaleString('en-IN'));
	$("#denomSub200").text("Rs. " + s200.toLocaleString('en-IN'));
	$("#denomSub100").text("Rs. " + s100.toLocaleString('en-IN'));
	$("#denomSub50").text("Rs. " + s50.toLocaleString('en-IN'));
	$("#denomSub20").text("Rs. " + s20.toLocaleString('en-IN'));
	$("#denomSub10").text("Rs. " + s10.toLocaleString('en-IN'));
	$("#denomSub5").text("Rs. " + s5.toLocaleString('en-IN'));
	$("#denomSub2").text("Rs. " + s2.toLocaleString('en-IN'));
	$("#denomSub1").text("Rs. " + s1.toLocaleString('en-IN'));

	const totalNotes = c500 + c200 + c100 + c50 + c20 + c10 + c5 + c2 + c1;
	const grandTotal = s500 + s200 + s100 + s50 + s20 + s10 + s5 + s2 + s1;

	$("#totalNotesCount").text(totalNotes);
	$("#denominationGrandTotal").text("Rs. " + grandTotal.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 }));

	const expectedAmt = parseFloat($("#netAmount").val()) || parseFloat($("#paymentAmount").val()) || 0;
	const $badge = $("#denominationMatchBadge");
	const $alertBox = $("#denominationAlertMsg");

	if (expectedAmt > 0 && grandTotal > 0) {
		$badge.show();
		$alertBox.show();
		const diff = Math.round((grandTotal - expectedAmt) * 100) / 100;
		if (Math.abs(diff) < 0.01) {
			$badge.text("✓ Exact Match").css({ "background": "#d1fae5", "color": "#065f46" });
			$alertBox.html('<i class="bi bi-check-circle-fill" style="margin-right: 6px;"></i> Cash Note Denomination Total (Rs. ' + grandTotal.toFixed(2) + ') matches Net Payment successfully!')
				.css({ "background": "#d1fae5", "color": "#065f46", "border": "1px solid #6ee7b7" });

			if (!hasAlertedMatch) {
				hasAlertedMatch = true;
				setTimeout(function() {
					alert("✓ Cash Note Denomination Total (Rs. " + grandTotal.toFixed(2) + ") matches Net Payment Amount successfully!");
				}, 80);
			}
		} else {
			hasAlertedMatch = false;
			if (diff > 0) {
				$badge.text("+ Rs. " + diff.toFixed(2) + " Extra").css({ "background": "#fef3c7", "color": "#92400e" });
				$alertBox.html('<i class="bi bi-exclamation-triangle-fill" style="margin-right: 6px;"></i> Cash Denomination (Rs. ' + grandTotal.toFixed(2) + ') exceeds Net Payment (Rs. ' + expectedAmt.toFixed(2) + ') by Rs. ' + diff.toFixed(2))
					.css({ "background": "#fef3c7", "color": "#92400e", "border": "1px solid #fcd34d" });
			} else {
				$badge.text("- Rs. " + Math.abs(diff).toFixed(2) + " Short").css({ "background": "#fee2e2", "color": "#991b1b" });
				$alertBox.html('<i class="bi bi-exclamation-circle-fill" style="margin-right: 6px;"></i> Cash Denomination (Rs. ' + grandTotal.toFixed(2) + ') is short by Rs. ' + Math.abs(diff).toFixed(2) + ' (Net Payment: Rs. ' + expectedAmt.toFixed(2) + ')')
					.css({ "background": "#fee2e2", "color": "#991b1b", "border": "1px solid #fca5a5" });
			}
		}
	} else {
		hasAlertedMatch = false;
		$badge.hide();
		$alertBox.hide();
	}
}

// 6. Reset Denominations
function resetDenominations() {
	hasAlertedMatch = false;
	$(".denom-count").val("");
	$("#denomSub500, #denomSub200, #denomSub100, #denomSub50, #denomSub20, #denomSub10, #denomSub5, #denomSub2, #denomSub1").text("Rs. 0");
	$("#totalNotesCount").text("0");
	$("#denominationGrandTotal").text("Rs. 0.00");
	$("#denominationMatchBadge").hide();
	$("#denominationAlertMsg").hide();
}

// 7. Load Savings Accounts
function loadSavingsAccounts(memberId) {
	customerSavingsAccounts = [];
	const $accDropdown = $("#savingAccountNo");
	$accDropdown.empty().append('<option value="">Loading accounts...</option>');
	$("#savingBalance").val("Fetching balance...").css({ "background": "#f9f9f9", "color": "#555" });

	if (!memberId) {
		memberId = $("#customerCode").val();
	}

	if (!memberId) {
		$accDropdown.empty().append('<option value="">Please select Gold Loan ID first</option>');
		$("#savingBalance").val("No Customer Selected").css({ "background": "#f9f9f9", "color": "#757575" });
		return;
	}

	$.ajax({
		url: "api/customersavings/getAccountNumbersByCode",
		type: "GET",
		data: { selectByCustomer: memberId },
		dataType: "json",
		success: function(response) {
			$accDropdown.empty();
			if (response.data && Array.isArray(response.data) && response.data.length > 0) {
				customerSavingsAccounts = response.data;
				$accDropdown.append('<option value="" disabled>Select Account</option>');
				customerSavingsAccounts.forEach(function(acc) {
					let accNum = acc.accountNumber || (typeof acc === "string" ? acc : "");
					$accDropdown.append(`<option value="${accNum}">${accNum}</option>`);
				});

				// Auto-select first account
				const firstAcc = customerSavingsAccounts[0];
				$accDropdown.val(firstAcc.accountNumber);
				$("#accountNumber").val(firstAcc.accountNumber);
				updateBalanceDisplay(firstAcc);
			} else {
				$accDropdown.append('<option value="">No Savings Account Found</option>');
				$("#savingBalance").val("No Account Found").css({ "background": "#f9f9f9", "color": "#757575" });
			}
		},
		error: function(xhr, status, error) {
			console.error("Error fetching savings accounts:", error);
			$accDropdown.empty().append('<option value="">Error Loading Accounts</option>');
			$("#savingBalance").val("Error Fetching Balance").css({ "background": "#ffebee", "color": "#c62828" });
		}
	});
}

// 8. Update Balance Display
function updateBalanceDisplay(acc) {
	if (!acc) {
		$("#savingBalance").val("Rs. 0.00").css({ "background": "#e8f5e9", "color": "#1b5e20" });
		return;
	}

	const rawBal = acc.balance;
	const bal = parseFloat(rawBal || 0);
	const formattedBal = "Rs. " + bal.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
	$("#savingBalance").val(formattedBal);

	const dueAmt = parseFloat($("#netAmount").val()) || parseFloat($("#paymentAmount").val()) || 0;
	if (dueAmt > 0 && bal < dueAmt) {
		$("#savingBalance").css({ "background": "#ffebee", "color": "#c62828" });
	} else {
		$("#savingBalance").css({ "background": "#e8f5e9", "color": "#1b5e20" });
	}
}

// 9. Load Financial Consultants
function loadFinancialConsultants(selectedCode) {
	$.ajax({
		url: 'api/financialconsultant/getAllFinancialConsultantDetails',
		type: 'GET',
		dataType: 'json',
		success: function(response) {
			const $dropdown = $('#financialConsultantId');
			$dropdown.empty().append('<option value="">-- SELECT FINANCIAL CONSULTANT --</option>');
			if (response && response.data && Array.isArray(response.data)) {
				response.data.forEach(function(c) {
					const code = c.financialCode || '';
					const name = (c.financialName || '').toUpperCase();
					if (code) {
						$dropdown.append(`<option value="${code}" data-name="${name}">${code} - ${name}</option>`);
					}
				});
				if (selectedCode) {
					$dropdown.val(selectedCode).trigger('change');
				}
			}
		},
		error: function(xhr) {
			console.error("Error loading financial consultants:", xhr);
		}
	});
}

// 10. Document Ready Initialization
$(document).ready(function() {

	// Default Payment Date to today
	const todayStr = new Date().toISOString().split('T')[0];
	$("#PaymentDate").val(todayStr);

	// Load financial consultants
	loadFinancialConsultants();

	// Load Gold Loans into Select2
	$.ajax({
		url: 'api/securedGoldLoan/getAllActive',
		type: 'GET',
		success: function(response) {
			if (!(response && response.data && Array.isArray(response.data))) {
				console.warn("No Gold Data found.");
				return;
			}

			let distinctMap = new Map();
			response.data.forEach(function(item) {
				let goldId = item.goldID || item.goldId;
				if (goldId && goldId.trim() !== "") {
					distinctMap.set(goldId.trim(), (item.customerName || "").toUpperCase());
				}
			});

			let goldOptions = [];
			distinctMap.forEach((customerName, goldId) => {
				goldOptions.push({
					id: goldId,
					text: goldId + (customerName ? " - " + customerName : "")
				});
			});

			$('#findByGoldLoanId').select2({
				placeholder: '-- Search Gold ID or Name --',
				data: goldOptions,
				matcher: function(params, data) {
					if ($.trim(params.term) === '') return data;
					if (typeof data.text === 'undefined') return null;

					const term = params.term.toLowerCase();
					const text = data.text.toLowerCase();
					return text.includes(term) ? data : null;
				}
			});
		},
		error: function(xhr, status, error) {
			console.error("Error fetching Gold Data:", error);
		}
	});

	// Consultant selection -> auto-fill consultant name
	$("#financialConsultantId").on("change", function() {
		const selectedOpt = $(this).find("option:selected");
		const name = selectedOpt.data("name") || "";
		if (name) {
			$("#financialConsultantName").val(name);
		}
	});

	// Date changes trigger penalty recalculation
	$("#PaymentDate").on("change", function() {
		recalculatePenalty();
	});

	// Note Denomination input listeners
	$(document).on("input change", ".denom-count", function() {
		calculateDenomination();
	});

	// Payment Amount input listener
	$("#paymentAmount").on("input", function() {
		recalculatePenalty();
		updateNetAmount();
		if ($("#sourcePayment").val() === "Cash") {
			calculateDenomination();
		}
	});

	// Mode of payment change: toggle Cash Denomination OR Savings Account
	$("#sourcePayment").on("change", function() {
		const mode = $(this).val();
		$("#modeofPayment").val(mode);

		if (mode === "Cash") {
			$("#cashDenominationWrapper").slideDown(200);
			$("#savingAccountWrapper").hide();
			$("#savingBalanceWrapper").hide();
			$("#savingAccountNo").empty().append('<option value="">SELECT ACCOUNT</option>');
			$("#savingBalance").val("");
			$("#accountNumber").val("");
			calculateDenomination();
		} else if (mode === "Saving Account" || mode === "SAVINGS ACCOUNT") {
			$("#cashDenominationWrapper").hide();
			resetDenominations();
			$("#savingAccountWrapper").show();
			$("#savingBalanceWrapper").show();
			const memberId = $("#customerCode").val();
			loadSavingsAccounts(memberId);
		} else {
			$("#cashDenominationWrapper").hide();
			resetDenominations();
			$("#savingAccountWrapper").hide();
			$("#savingBalanceWrapper").hide();
			$("#savingAccountNo").empty().append('<option value="">SELECT ACCOUNT</option>');
			$("#savingBalance").val("");
			$("#accountNumber").val("");
		}
	});

	// When savings account dropdown changes
	$("#savingAccountNo").on("change", function() {
		const selAccNo = $(this).val();
		$("#accountNumber").val(selAccNo);
		const matched = customerSavingsAccounts.find(a => (a.accountNumber || a) === selAccNo);
		updateBalanceDisplay(matched);
	});

	// When Gold Loan ID changes:
	$("#findByGoldLoanId").on("change", function() {
		const selectedGoldId = $(this).val();
		if (!selectedGoldId) return;

		$.ajax({
			url: "api/securedGoldLoan/getByGoldIDforApproval",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify({ goldID: selectedGoldId }),
			dataType: "json",
			success: function(response) {
				if (response.status === "OK" && response.data && response.data.length > 0) {
					currentGoldLoanData = response.data[0];
					const data = currentGoldLoanData;

					// Populate loan details
					$("#loanDate").val(data.loanDate || "");
					$("#customerCode").val(data.memberCode || "");
					$("#customerName").val((data.customerName || "").toUpperCase());
					$("#contactNo").val(data.contactNo || "");
					$("#branchName").val((data.branchName || "").toUpperCase());
					$("#loanPlanName").val((data.loanPlanName || "").toUpperCase());
					$("#typeOfLoan").val((data.typeOfLoan || "").toUpperCase());
					$("#loanMode").val((data.loanMode || "").toUpperCase());
					$("#loanTerm").val(data.loanTerm || "");
					$("#rateOfInterest").val(data.rateOfInterest || "");
					$("#loanAmount").val(data.loanAmount || "");
					$("#interestType").val((data.interestType || "").toUpperCase());
					$("#emiPayment").val((data.emiPayment || "").toUpperCase());

					// Pre-select financial consultant if available
					if (data.financialConsultantId) {
						$("#financialConsultantId").val(data.financialConsultantId).trigger('change');
					}
					if (data.financialConsultantName) {
						$("#financialConsultantName").val(data.financialConsultantName);
					}

					// Reset payment mode
					$("#sourcePayment").val("");
					$("#modeofPayment").val("");
					$("#savingAccountWrapper").hide();
					$("#savingBalanceWrapper").hide();
					$("#cashDenominationWrapper").hide();
					resetDenominations();
					$("#savingAccountNo").empty().append('<option value="">SELECT ACCOUNT</option>');
					$("#savingBalance").val("");
					$("#accountNumber").val("");

					// Fetch EMI payment history and construct installment schedule
					fetchEmiHistoryAndBuildDropdown(selectedGoldId, data);
				} else {
					alert("No loan details found for selected Gold ID.");
				}
			},
			error: function(xhr) {
				console.error("Error fetching loan details:", xhr);
				alert("Error fetching loan details.");
			}
		});
	});

	// Fetch EMI history and build dynamic installment dropdown
	function fetchEmiHistoryAndBuildDropdown(goldId, loanInfo) {
		$.ajax({
			url: "api/securedGoldLoan/getEMIInstallmentDataByGoldID?goldID=" + encodeURIComponent(goldId),
			type: "GET",
			dataType: "json",
			success: function(instResp) {
				const paidList = (instResp && instResp.data && Array.isArray(instResp.data)) ? instResp.data : [];
				currentGoldPayments = paidList;

				const paidSet = new Set();
				const emiTableBody = $("#emiHistoryBody");
				emiTableBody.empty();

				paidList.forEach(function(p, idx) {
					const num = parseInt(p.installment);
					if (!isNaN(num)) paidSet.add(num);

					emiTableBody.append(`<tr>
						<td>${idx + 1}</td>
						<td><span class="badge bg-success">Installment ${p.installment}</span></td>
						<td>₹${p.dueAmount || '-'}</td>
						<td>₹${p.paymentAmount || '-'}</td>
						<td>₹${p.penaltyAmount || '0.00'}</td>
						<td>${p.paymentDate || '-'}</td>
						<td><span class="badge ${p.paymentMode === 'Saving Account' || p.paymentMode === 'SAVINGS ACCOUNT' ? 'bg-primary' : 'bg-secondary'}">${p.paymentMode || 'Cash'}</span></td>
						<td>${p.accountNumber || '-'}</td>
						<td>${p.remarks || '-'}</td>
					</tr>`);
				});

				if (paidList.length > 0) {
					$("#emiHistorySection").show();
				} else {
					$("#emiHistorySection").hide();
				}

				$("#paidInstallments").val(paidSet.size);

				// Render installment dropdown
				const dropdown = $("#installment");
				dropdown.empty();
				dropdown.append('<option value="" disabled>-SELECT INSTALLMENT-</option>');

				const term = parseInt(loanInfo.loanTerm) || 0;
				let firstUnpaidNumber = null;

				for (let i = 1; i <= term; i++) {
					const isPaid = paidSet.has(i);
					const dueDate = calculateDueDate(loanInfo.loanDate, i, loanInfo.loanMode);
					const dateFormatted = dueDate ? " (Due: " + dueDate + ")" : "";

					if (isPaid) {
						dropdown.append(`<option value="${i}" disabled style="color: #999; background: #f0f0f0;">Installment ${i} - PAID ${dateFormatted}</option>`);
					} else {
						dropdown.append(`<option value="${i}">Installment ${i}${dateFormatted}</option>`);
						if (firstUnpaidNumber === null) {
							firstUnpaidNumber = i;
						}
					}
				}

				if (firstUnpaidNumber !== null) {
					dropdown.val(firstUnpaidNumber).trigger("change");
					$("#payEmiBtn").prop("disabled", false).html('<i class="bi bi-credit-card-2-front" style="margin-right: 6px;"></i> PAY EMI');
				} else if (term > 0 && paidSet.size >= term) {
					dropdown.append('<option value="" disabled selected>All ' + term + ' Installments Paid (CLOSED)</option>');
					alert("🎉 All " + term + " installments for this Gold Loan have already been paid! This loan is CLOSED.");
					$("#payEmiBtn").prop("disabled", true).text("LOAN CLOSED - ALL PAID");
					$("#dueAmount").val("0.00");
					$("#paymentAmount").val("0.00");
					$("#netAmount").val("0.00");
					$("#penaltyAmount").val("Rs. 0.00");
					$("#daysLate").val("0");
				}
			},
			error: function() {
				console.error("Could not fetch EMI history.");
			}
		});
	}

	// 11. Installment selection change: update due date, amounts & recalculate penalty
	$("#installment").on("change", function() {
		const instNum = parseInt($(this).val());
		if (!instNum || !currentGoldLoanData) return;

		const data = currentGoldLoanData;
		const dueDate = calculateDueDate(data.loanDate, instNum, data.loanMode);
		$("#emiDueDate").val(dueDate);
		$("#registrationDate").val(dueDate);

		// Calculate EMI breakdown based on interest type
		const loanAmount = parseFloat(data.loanAmount) || 0;
		const rateOfInterest = parseFloat(data.rateOfInterest) || 0;
		const loanTerm = parseInt(data.loanTerm) || 1;
		const interestType = (data.interestType || "").trim().toUpperCase();

		let pendingPrincipal = loanAmount;
		let pendingInterest = 0;
		let emi = parseFloat(data.emiPayment) || 0;

		if (interestType === "FLAT INTEREST" || interestType === "FLAT") {
			const totalInterest = (loanAmount * rateOfInterest * loanTerm) / (100 * 12);
			const monthlyInterest = totalInterest / loanTerm;
			emi = (loanAmount + totalInterest) / loanTerm;
			const principalPart = emi - monthlyInterest;
			pendingInterest = Math.max(0, totalInterest - (monthlyInterest * instNum));
			pendingPrincipal = Math.max(0, loanAmount - (principalPart * instNum));
		} else if (interestType === "REDUCING INTEREST" || interestType === "REDUCING") {
			const monthlyRate = (rateOfInterest / 100) / 12;
			if (monthlyRate > 0) {
				emi = loanAmount * monthlyRate * Math.pow(1 + monthlyRate, loanTerm) / (Math.pow(1 + monthlyRate, loanTerm) - 1);
			}
			let remPrincipal = loanAmount;
			let totalIntPaid = 0;
			for (let i = 1; i <= instNum; i++) {
				let intM = remPrincipal * monthlyRate;
				let prM = emi - intM;
				totalIntPaid += intM;
				remPrincipal = Math.max(0, remPrincipal - prM);
			}
			pendingPrincipal = remPrincipal;
			const totalInterest = (emi * loanTerm) - loanAmount;
			pendingInterest = Math.max(0, totalInterest - totalIntPaid);
		} else {
			const totalInterest = (loanAmount * rateOfInterest * loanTerm) / (100 * 12);
			emi = (loanAmount + totalInterest) / loanTerm;
			pendingInterest = 0;
			pendingPrincipal = 0;
		}

		const dueAmtStr = emi.toFixed(2);
		$("#dueAmount").val(dueAmtStr);
		$("#totalDue").val(dueAmtStr);
		$("#pendingInterest").val(pendingInterest.toFixed(2));
		$("#pendingPrincipal").val(pendingPrincipal.toFixed(2));
		$("#paymentAmount").val(dueAmtStr);

		recalculatePenalty();
	});

	// 12. PAY EMI Button Handler
	$("#payEmiBtn, #saveBtn").on("click", function(e) {
		e.preventDefault();

		const goldId = $("#findByGoldLoanId").val();
		if (!goldId) {
			alert("Please search and select a Gold Loan ID first.");
			return;
		}

		const installment = $("#installment").val();
		if (!installment) {
			alert("Please select an Installment to pay.");
			return;
		}

		const paymentAmt = parseFloat($("#paymentAmount").val()) || 0;
		if (paymentAmt <= 0) {
			alert("Payment Amount must be greater than 0.");
			return;
		}

		const paymentDate = $("#PaymentDate").val();
		if (!paymentDate) {
			alert("Please select a valid Payment Date.");
			return;
		}

		const mode = $("#sourcePayment").val();
		if (!mode) {
			alert("Please select a Payment Mode (Cash or Saving Account).");
			return;
		}

		const rawPenalty = ($("#penaltyAmount").val() || "").replace(/[^0-9.]/g, "");
		const penaltyAmt = parseFloat(rawPenalty) || 0;
		const totalPayable = paymentAmt + penaltyAmt;

		let accountNo = $("#savingAccountNo").val() || $("#accountNumber").val() || "";

		// Validation for Saving Account mode
		if (mode === "Saving Account" || mode === "SAVINGS ACCOUNT") {
			if (!accountNo) {
				alert("Please select a Customer Savings Account.");
				return;
			}
			const matched = customerSavingsAccounts.find(a => (a.accountNumber || a) === accountNo);
			const bal = matched ? parseFloat(matched.balance || 0) : 0;
			if (bal < totalPayable) {
				alert("❌ Insufficient balance in Savings Account (" + accountNo + ")!\n\n" +
					  "Required: ₹" + totalPayable.toFixed(2) + " (EMI: ₹" + paymentAmt.toFixed(2) + " + Penalty: ₹" + penaltyAmt.toFixed(2) + ")\n" +
					  "Available: ₹" + bal.toFixed(2));
				return;
			}
		}

		// Validation for Cash mode: Check cash denomination
		if (mode === "Cash") {
			const grandTotal = (parseInt($("#denom500").val()) || 0) * 500 +
							   (parseInt($("#denom200").val()) || 0) * 200 +
							   (parseInt($("#denom100").val()) || 0) * 100 +
							   (parseInt($("#denom50").val())  || 0) * 50  +
							   (parseInt($("#denom20").val())  || 0) * 20  +
							   (parseInt($("#denom10").val())  || 0) * 10  +
							   (parseInt($("#denom5").val())   || 0) * 5   +
							   (parseInt($("#denom2").val())   || 0) * 2   +
							   (parseInt($("#denom1").val())   || 0) * 1;

			if (grandTotal > 0) {
				const diff = Math.round((grandTotal - totalPayable) * 100) / 100;
				if (Math.abs(diff) >= 0.01) {
					if (!confirm("⚠️ Warning: Cash Denomination Total (₹" + grandTotal.toFixed(2) + ") does not match the Net Payment Amount (₹" + totalPayable.toFixed(2) + ").\n\nDo you still wish to proceed?")) {
						return;
					}
				}
			}
		}

		const confirmMsg = "Are you sure you want to process this EMI payment?\n\n" +
			"Gold ID: " + goldId + "\n" +
			"Installment: " + installment + "\n" +
			"EMI Amount: ₹" + paymentAmt.toFixed(2) + "\n" +
			(penaltyAmt > 0 ? "Penalty Amount: ₹" + penaltyAmt.toFixed(2) + "\n" : "") +
			"Total Payable: ₹" + totalPayable.toFixed(2) + "\n" +
			"Mode: " + mode + (accountNo ? " (A/C: " + accountNo + ")" : "");

		if (!confirm(confirmMsg)) return;

		const $btn = $("#payEmiBtn");
		$btn.prop("disabled", true).html('<span class="spinner-border spinner-border-sm" role="status"></span> Processing...');

		const payload = {
			goldID: goldId,
			loanDate: $("#loanDate").val(),
			customerCode: $("#customerCode").val(),
			customerName: $("#customerName").val(),
			loanPlanName: $("#loanPlanName").val(),
			interestType: $("#interestType").val(),
			loanMode: $("#loanMode").val(),
			loanTerm: $("#loanTerm").val(),
			emiPayment: $("#emiPayment").val(),
			typeOfLoan: $("#typeOfLoan").val(),
			rateOfInterest: $("#rateOfInterest").val(),
			contactNo: $("#contactNo").val(),
			loanAmount: $("#loanAmount").val(),
			branchName: $("#branchName").val(),

			// Payment details
			installment: installment,
			registrationDate: $("#registrationDate").val(),
			emiDueDate: $("#emiDueDate").val(),
			dueAmount: $("#dueAmount").val(),
			pendingInterest: $("#pendingInterest").val(),
			pendingPrincipal: $("#pendingPrincipal").val(),
			totalDue: $("#totalDue").val(),
			paymentAmount: paymentAmt.toFixed(2),
			penaltyAmount: penaltyAmt.toFixed(2),
			daysLate: $("#daysLate").val() || "0",
			paymentDate: paymentDate,
			netAmount: totalPayable.toFixed(2),
			paymentMode: mode,
			accountNumber: accountNo,
			financialCode: $("#financialConsultantId").val(),
			financialName: $("#financialConsultantName").val(),
			remarks: $("#remarks").val() || ("EMI " + installment)
		};

		$.ajax({
			url: "api/securedGoldLoan/saveEMIInstallmentData",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(payload),
			success: function(res) {
				$btn.prop("disabled", false).html('<i class="bi bi-credit-card-2-front"></i> PAY EMI');
				if (res.status === "OK" || res.status === 200 || res.status === "SUCCESS") {
					alert("✓ " + (res.data || res.message || "EMI Installment Saved Successfully!"));
					// Refresh loan data to update installment schedule and history
					$("#findByGoldLoanId").trigger("change");
				} else {
					alert("❌ " + (res.data || res.message || "Failed to process payment."));
				}
			},
			error: function(xhr) {
				$btn.prop("disabled", false).html('<i class="bi bi-credit-card-2-front"></i> PAY EMI');
				let errMsg = "Server error while saving payment.";
				try {
					const json = JSON.parse(xhr.responseText);
					if (json.data || json.message) errMsg = json.data || json.message;
				} catch (e) {}
				alert("❌ Payment Failed: " + errMsg);
			}
		});
	});

	// 13. Reset Button Handler
	$("#resetBtn").on("click", function() {
		if (confirm("Reset the payment form?")) {
			$("#formid")[0].reset();
			resetDenominations();
			$("#savingAccountWrapper").hide();
			$("#savingBalanceWrapper").hide();
			$("#cashDenominationWrapper").hide();
			$("#findByGoldLoanId").val("").trigger("change");
			$("#PaymentDate").val(new Date().toISOString().split('T')[0]);
		}
	});

});