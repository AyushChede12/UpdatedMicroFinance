// =========================================================================
// EARLY GOLD LOAN CLOSURE (FORECLOSURE) CONTROLLER
// =========================================================================

let currentGoldSettlementData = null;

$(document).ready(function() {
	populateClosableGoldLoans();
	populateFinancialConsultants();
	initializeDateDefaults();
	bindEventHandlers();
});

// 1. Initialize today's date on payment and due date fields
function initializeDateDefaults() {
	const today = new Date().toISOString().split('T')[0];
	$('#paymentDate').val(today);
	$('#dueDate').val(today);
	$('#chequeDate').val(today);
}

// 2. Fetch all closable gold loans for dropdown
function populateClosableGoldLoans() {
	$.ajax({
		url: "api/securedGoldLoan/getClosableGoldLoans",
		type: "GET",
		dataType: "json",
		success: function(response) {
			const $dropdown = $("#earlyGoldLoanId");
			$dropdown.empty().append('<option value="" disabled selected>-- SELECT ACTIVE GOLD LOAN ID --</option>');

			let list = [];
			if (response && response.status === "OK" && Array.isArray(response.data)) {
				list = response.data;
			}

			if (list.length === 0) {
				// Fallback to getAllActive if closable list is empty
				$.ajax({
					url: "api/securedGoldLoan/getAllActive",
					type: "GET",
					dataType: "json",
					success: function(res) {
						if (res && res.data && Array.isArray(res.data)) {
							res.data.forEach(function(item) {
								const id = item.goldId || item.goldID;
								const name = item.customerName || item.clientName || '';
								$dropdown.append(`<option value="${id}">${id} - ${name}</option>`);
							});
						}
					}
				});
			} else {
				list.forEach(function(item) {
					const id = item.goldId || item.goldID;
					const name = item.customerName || item.clientName || '';
					$dropdown.append(`<option value="${id}">${id} - ${name}</option>`);
				});
			}
		},
		error: function(xhr) {
			console.error("Error fetching Gold Loan IDs:", xhr.responseText);
		}
	});
}

// 3. Fetch Financial Consultants
function populateFinancialConsultants() {
	$.ajax({
		url: 'api/financialconsultant/getAllFinancialConsultantDetails',
		type: 'POST',
		dataType: 'json',
		success: function(response) {
			const $dropdown = $('#financialConsultantId');
			$dropdown.empty().append('<option value="">-- SELECT CONSULTANT ID --</option>');

			if (response && response.data && Array.isArray(response.data)) {
				response.data.forEach(function(c) {
					const code = c.financialCode || '';
					const name = c.financialName || '';
					$dropdown.append(`<option value="${code}">${code} - ${name}</option>`);
				});

				if (currentGoldSettlementData && currentGoldSettlementData.financialConsultantId) {
					$dropdown.val(currentGoldSettlementData.financialConsultantId);
					$('#financialConsultantName').val(currentGoldSettlementData.financialConsultantName || '');
				}
			}
		},
		error: function(xhr) {
			console.error("Error loading financial consultants:", xhr.responseText);
		}
	});
}

// 4. Bind Event Handlers
function bindEventHandlers() {
	// Consultant selection -> auto-fill consultant name
	$('#financialConsultantId').on('change', function() {
		const code = $(this).val();
		if (!code) {
			$('#financialConsultantName').val('');
			return;
		}
		$.ajax({
			url: 'api/financialconsultant/getfinancialHierarchyByFinancialCode',
			type: 'GET',
			data: { financialCode: code },
			success: function(res) {
				if (res && res.data && res.data[0]) {
					$('#financialConsultantName').val(res.data[0].financialName || '');
				}
			}
		});
	});

	// Gold Loan ID selection -> fetch full foreclosure settlement from backend
	$('#earlyGoldLoanId').on('change', function() {
		const selectedGoldId = $(this).val();
		if (!selectedGoldId) return;

		fetchGoldForeclosureSettlement(selectedGoldId);
	});

	// Deduct Fine toggle
	$('#deductfine').on('change', function() {
		if ($(this).val() === 'NO') {
			$('#deductFineAmount').val('0.00');
		} else {
			if (currentGoldSettlementData && currentGoldSettlementData.pendingPenalties > 0) {
				$('#deductFineAmount').val(currentGoldSettlementData.pendingPenalties.toFixed(2));
			}
		}
		recalculateNetSettlement();
	});

	// Real-time calculation listeners
	$('#deductFineAmount, #waiver').on('input change', function() {
		recalculateNetSettlement();
	});

	// Reason for Closure selection
	$('#reasonForClosure').on('change', function() {
		if ($(this).val() === 'Other') {
			$('#remarksReqStar').show();
			$('#remarks').attr('required', 'required');
		} else {
			$('#remarksReqStar').hide();
			$('#remarks').removeAttr('required');
		}
	});

	// Payment Mode toggle
	$('#paymentMode').on('change', function() {
		handlePaymentModeChange($(this).val());
	});

	// Main Close Loan Button Click -> Validate & open confirmation modal
	$('#closeLoanBtn').on('click', function(e) {
		e.preventDefault();
		initiateClosureConfirmation();
	});

	// Final Confirm Button in Modal -> Submit Transaction
	$('#confirmProceedCloseBtn').on('click', function() {
		executeGoldLoanClosure();
	});

	// Post-Closure Action Buttons
	$('#printReceiptBtn').on('click', function() {
		printForeclosureReceipt();
	});

	$('#downloadNocBtn').on('click', function() {
		if (currentGoldSettlementData && currentGoldSettlementData.goldId) {
			window.location.href = `printNOC?goldId=${encodeURIComponent(currentGoldSettlementData.goldId)}`;
		} else {
			window.location.href = `printNOC`;
		}
	});

	// Modal dismiss buttons click handler
	$(document).on('click', '[data-dismiss="modal"], [data-bs-dismiss="modal"], .close', function() {
		hideModal('#closureConfirmModal');
		hideModal('#closureSuccessModal');
	});
}

// 5. Fetch server-side foreclosure settlement calculation
function fetchGoldForeclosureSettlement(goldId) {
	$('#settlementSummaryCard').slideUp(200);
	$('#goldCollateralContainer').slideUp(200);

	$.ajax({
		url: `api/securedGoldLoan/calculateForeclosure?goldId=${encodeURIComponent(goldId)}`,
		type: "GET",
		dataType: "json",
		success: function(response) {
			if (response.status !== "OK" || !response.data) {
				alert("Failed to calculate foreclosure: " + (response.message || "Unknown error"));
				return;
			}

			const d = response.data;
			currentGoldSettlementData = d;

			// Populate Read-Only Loan Details
			$('#loanDate').val(d.loanDate || '');
			$('#memberCode').val(`${d.customerCode || ''} - ${d.customerName || ''}`);
			$('#customerName').val(d.customerName || '');
			$('#relativeDetails').val(d.guarantorName || d.coApplicantName || '--');
			$('#contactNo').val(d.contactNo || '');
			$('#branchName').val(d.branchName || '');
			$('#paymentBranch').val(d.branchName || '');
			$('#loanPlanName').val(d.loanPlanName || 'Gold Loan Standard');
			$('#loanTerm').val(d.loanTerm || '');
			$('#loanMode').val(d.loanMode || '');
			$('#loanAmount').val(d.sanctionedPrincipal ? d.sanctionedPrincipal.toFixed(2) : '0.00');
			$('#rateOfInterest').val(d.rateOfInterest || '');
			$('#interestType').val(d.interestType || '');
			$('#emiPayment').val(d.emiPayment || '');
			$('#sanctionedAmount').val(d.sanctionedPrincipal ? d.sanctionedPrincipal.toFixed(2) : '0.00');
			$('#typeOfLoan').val(d.typeOfLoan || 'GOLD LOAN');
			$('#totalinterestofLoan').val(d.totalInterest ? parseFloat(d.totalInterest).toFixed(2) : '0.00');
			$('#totalPayableofLoan').val(d.totalPayableAmount ? parseFloat(d.totalPayableAmount).toFixed(2) : '0.00');

			// Auto-select financial consultant if available
			if (d.financialConsultantId) {
				$('#financialConsultantId').val(d.financialConsultantId);
				$('#financialConsultantName').val(d.financialConsultantName || '');
			}

			// Populate Repayment & Due Breakdown
			$('#noOfInst').val(`${d.paidInstallments || 0} / ${d.totalInstallments || 0} Paid`);
			$('#principalDue').val((d.principalOutstanding || 0).toFixed(2));
			$('#interestDue').val((d.accruedInterestTillDate || 0).toFixed(2));
			$('#amountPaid').val((d.totalPrincipalPaid || 0).toFixed(2));
			$('#balanceLoanAmount').val((d.principalOutstanding || 0).toFixed(2));
			$('#foreclosureFee').val((d.foreclosureFeeAmount || 0).toFixed(2));

			const arrearsTotal = (d.overdueArrears || 0) + (d.pendingPenalties || 0);
			if (arrearsTotal > 0) {
				$('#deductfine').val('YES');
				$('#deductFineAmount').val((d.pendingPenalties || 0).toFixed(2));
			} else {
				$('#deductfine').val('NO');
				$('#deductFineAmount').val('0.00');
			}
			$('#waiver').val('0.00');

			// Populate Net Payoff
			const netPayoff = d.netPayoffAmount || 0;
			$('#paymentAmount').val(netPayoff.toFixed(2));
			$('#netAmount').val(netPayoff.toFixed(2));

			// Update Summary Card
			$('#summaryLoanIdBadge').text(d.goldId);
			$('#summarySanctioned').text(`₹${(d.sanctionedPrincipal || 0).toLocaleString('en-IN', {minimumFractionDigits: 2})}`);
			$('#summaryPrincipalPaid').text(`₹${(d.totalPrincipalPaid || 0).toLocaleString('en-IN', {minimumFractionDigits: 2})}`);
			$('#summaryPrincipalDue').text(`₹${(d.principalOutstanding || 0).toLocaleString('en-IN', {minimumFractionDigits: 2})}`);
			$('#summaryAccruedInterest').text(`₹${(d.accruedInterestTillDate || 0).toLocaleString('en-IN', {minimumFractionDigits: 2})}`);
			$('#summaryElapsedDays').text(`(${d.elapsedDaysSinceLastPayment || 0} days accrued)`);
			$('#summaryArrearsFines').text(`₹${arrearsTotal.toLocaleString('en-IN', {minimumFractionDigits: 2})}`);
			$('#summaryNetPayoff').text(`₹${netPayoff.toLocaleString('en-IN', {minimumFractionDigits: 2})}`);

			// Collateral Badge & Inventory
			$('#collateralStatusBadgeContainer').show();
			$('#collateralDetailText').text(`Total Net Wt: ${d.totalNetWt || '0'} g | Locker: ${d.lockerBranch || d.branchName || '--'}`);
			$('#lockerLocationBadge').text(`Locker Branch: ${d.lockerBranch || d.branchName || '--'}`);

			// Populate Pledged Ornaments Table
			const $tbody = $('#goldItemsTableBody');
			$tbody.empty();

			let sumGross = 0;
			let sumNet = 0;
			let sumValuation = 0;

			if (Array.isArray(d.items) && d.items.length > 0) {
				d.items.forEach(function(item, idx) {
					const gWt = parseFloat(item.itemWt || item.grossWt || 0) || 0;
					const nWt = parseFloat(item.netWt || 0) || 0;
					const val = parseFloat(item.marketValuation || 0) || 0;

					sumGross += gWt;
					sumNet += nWt;
					sumValuation += val;

					$tbody.append(`
						<tr>
							<td>${idx + 1}</td>
							<td>${item.itemType || '--'}</td>
							<td>${item.itemName || '--'}</td>
							<td>${item.purity || '--'}</td>
							<td>${item.itemQty || '1'}</td>
							<td>${gWt.toFixed(2)}</td>
							<td>${nWt.toFixed(2)}</td>
							<td>₹${val.toLocaleString('en-IN', {minimumFractionDigits: 2})}</td>
						</tr>
					`);
				});
				$('#totGrossWt').text(`${sumGross.toFixed(2)} g`);
				$('#totNetWt').text(`${sumNet.toFixed(2)} g`);
				$('#totValuation').text(`₹${sumValuation.toLocaleString('en-IN', {minimumFractionDigits: 2})}`);
			} else {
				$tbody.append(`
					<tr>
						<td>1</td>
						<td>Gold Ornaments</td>
						<td>Pledged Collateral Ornaments</td>
						<td>22K</td>
						<td>1 Lot</td>
						<td>${d.totalGrossWt || '0.00'}</td>
						<td>${d.totalNetWt || '0.00'}</td>
						<td>₹${parseFloat(d.totalMarketValuation || 0).toLocaleString('en-IN', {minimumFractionDigits: 2})}</td>
					</tr>
				`);
				$('#totGrossWt').text(`${d.totalGrossWt || '0.00'} g`);
				$('#totNetWt').text(`${d.totalNetWt || '0.00'} g`);
				$('#totValuation').text(`₹${parseFloat(d.totalMarketValuation || 0).toLocaleString('en-IN', {minimumFractionDigits: 2})}`);
			}

			// Pre-populate savings account details if linked
			if (d.savingsAccountNumber) {
				$('#accountNo').val(`${d.savingsAccountNumber} (Available Bal: ₹${(d.savingsAccountBalance || 0).toFixed(2)})`);
			} else {
				$('#accountNo').val('');
			}

			// Slide in cards smoothly
			$('#settlementSummaryCard').slideDown(300);
			$('#goldCollateralContainer').slideDown(300);
		},
		error: function(xhr) {
			alert("Error fetching foreclosure settlement: " + xhr.responseText);
		}
	});
}

// 6. Recalculate Net Settlement Amount dynamically
function recalculateNetSettlement() {
	if (!currentGoldSettlementData) return;

	const principalDue = parseFloat($('#principalDue').val()) || 0;
	const interestDue = parseFloat($('#interestDue').val()) || 0;
	const fine = parseFloat($('#deductFineAmount').val()) || 0;
	const fee = parseFloat($('#foreclosureFee').val()) || 0;
	const waiver = parseFloat($('#waiver').val()) || 0;

	let net = (principalDue + interestDue + fine + fee) - waiver;
	if (net < 0) net = 0;

	$('#paymentAmount').val(net.toFixed(2));
	$('#netAmount').val(net.toFixed(2));
	$('#summaryNetPayoff').text(`₹${net.toLocaleString('en-IN', {minimumFractionDigits: 2})}`);
}

// 7. Handle Payment Mode changes
function handlePaymentModeChange(mode) {
	$('#displaySavingsAccount').hide();
	$('#displayCheque').hide();
	$('#displaycheqdate').hide();
	$('#displaydeposit').hide();
	$('#displayRef').hide();

	$('#chequeNo').removeAttr('required');
	$('#chequeDate').removeAttr('required');
	$('#ref_UpiId').removeAttr('required');

	if (mode === 'Saving Account' || mode === 'Savings Account') {
		$('#displaySavingsAccount').show();
		if (!currentGoldSettlementData || !currentGoldSettlementData.savingsAccountNumber) {
			alert("Notice: No savings account found for this customer. Please create/link a savings account or choose another payment mode.");
		}
	} else if (mode === 'Cheque') {
		$('#displayCheque').show();
		$('#displaycheqdate').show();
		$('#displaydeposit').show();
		$('#chequeNo').attr('required', 'required');
		$('#chequeDate').attr('required', 'required');
	} else if (mode === 'Online' || mode === 'NEFT') {
		$('#displayRef').show();
		$('#displaydeposit').show();
		$('#ref_UpiId').attr('required', 'required');
	}
}

// 8. Initiate Confirmation Modal
function initiateClosureConfirmation() {
	const goldId = $('#earlyGoldLoanId').val();
	if (!goldId) {
		alert("Please select a Gold Loan ID to close.");
		$('#earlyGoldLoanId').focus();
		return;
	}

	const paymentMode = $('#paymentMode').val();
	if (!paymentMode) {
		alert("Please select Mode of Payment.");
		$('#paymentMode').focus();
		return;
	}

	if (paymentMode === 'Saving Account') {
		if (!currentGoldSettlementData || !currentGoldSettlementData.savingsAccountNumber) {
			alert("Cannot proceed with Auto-Debit: Borrower has no active savings account.");
			return;
		}
		const netReq = parseFloat($('#netAmount').val()) || 0;
		const curBal = currentGoldSettlementData.savingsAccountBalance || 0;
		if (curBal < netReq) {
			alert(`Insufficient balance in Savings Account ${currentGoldSettlementData.savingsAccountNumber}.\nAvailable: ₹${curBal.toFixed(2)}\nRequired: ₹${netReq.toFixed(2)}`);
			return;
		}
	} else if (paymentMode === 'Cheque') {
		if (!$('#chequeNo').val().trim()) {
			alert("Please enter Cheque Number.");
			$('#chequeNo').focus();
			return;
		}
	} else if (paymentMode === 'Online' || paymentMode === 'NEFT') {
		if (!$('#ref_UpiId').val().trim()) {
			alert("Please enter Transaction Reference / UPI ID.");
			$('#ref_UpiId').focus();
			return;
		}
	}

	if ($('#reasonForClosure').val() === 'Other' && !$('#remarks').val().trim()) {
		alert("Please enter Remarks / Closure Notes when reason is 'Other'.");
		$('#remarks').focus();
		return;
	}

	// Populate Confirmation Modal values
	$('#modalConfLoanId').text(goldId);
	$('#modalConfBorrower').text($('#memberCode').val());
	$('#modalConfPayMode').text(paymentMode);
	$('#modalConfPayoff').text(`₹${parseFloat($('#netAmount').val() || 0).toLocaleString('en-IN', {minimumFractionDigits: 2})}`);
	$('#modalConfCollateral').text(`${currentGoldSettlementData.totalNetWt || '0.00'} g (Released upon closure)`);
	$('#modalConfReason').text($('#reasonForClosure').val());

	showModal('#closureConfirmModal');
}

// 9. Execute Loan Closure via AJAX POST
function executeGoldLoanClosure() {
	const $confirmBtn = $('#confirmProceedCloseBtn');
	$confirmBtn.prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-1"></span> Processing Foreclosure...');

	const payload = {
		goldID: $('#earlyGoldLoanId').val(),
		dateOfLoan: $('#loanDate').val(),
		customerCode: currentGoldSettlementData ? currentGoldSettlementData.customerCode : '',
		customerName: $('#customerName').val(),
		contactNo: $('#contactNo').val(),
		branchName: $('#branchName').val(),
		loanPlanName: $('#loanPlanName').val(),
		loanTerm: $('#loanTerm').val(),
		loanMode: $('#loanMode').val(),
		loanAmount: $('#loanAmount').val(),
		rateOfInterest: $('#rateOfInterest').val(),
		interestType: $('#interestType').val(),
		emiPayment: $('#emiPayment').val(),
		totalInterestOfLoan: $('#totalinterestofLoan').val(),
		sanctionedAmount: $('#sanctionedAmount').val(),
		totalPayableOfLoan: $('#totalPayableofLoan').val(),
		noOfInstPaid: $('#noOfInst').val(),
		interestDue: $('#interestDue').val(),
		principalDue: $('#principalDue').val(),
		amountPaidTillDate: $('#amountPaid').val(),
		loanBalanceAmount: $('#balanceLoanAmount').val(),
		dueDate: $('#dueDate').val(),
		paymentBranch: $('#paymentBranch').val(),
		paymentDate: $('#paymentDate').val(),
		deductFine: $('#deductfine').val(),
		deductFineAmount: $('#deductFineAmount').val(),
		paymentAmount: $('#paymentAmount').val(),
		netAmount: $('#netAmount').val(),
		financialCode: $('#financialConsultantId').val(),
		financialName: $('#financialConsultantName').val(),
		remarks: $('#remarks').val(),
		goldLoanStatus: "CLOSED",
		paymentMode: $('#paymentMode').val(),
		accountNo: currentGoldSettlementData ? (currentGoldSettlementData.savingsAccountNumber || '') : '',
		chequeNo: $('#chequeNo').val(),
		chequeDate: $('#chequeDate').val(),
		depositAccount: $('#depositAccount').val(),
		ref_UpiId: $('#ref_UpiId').val(),
		waiver: $('#waiver').val(),
		foreclosureFee: $('#foreclosureFee').val(),
		reasonForClosure: $('#reasonForClosure').val(),
		accruedInterest: $('#interestDue').val()
	};

	$.ajax({
		url: 'api/securedGoldLoan/executeEarlyLoanClosure',
		type: 'POST',
		contentType: 'application/json',
		data: JSON.stringify(payload),
		success: function(response) {
			$confirmBtn.prop('disabled', false).html('<i class="bi bi-check-circle me-1"></i> YES, EXECUTE FORECLOSURE');
			hideModal('#closureConfirmModal');

			if (response.status === 'OK' || response.status === '200') {
				const closureObj = response.data || {};
				const receiptNo = closureObj.settlementReceiptNo || ('EGLC-' + Date.now());

				// Populate Receipt Modal
				$('#succModalMsg').text(response.message || `Gold Loan ${payload.goldID} successfully foreclosed.`);
				$('#recReceiptNo').text(receiptNo);
				$('#recDate').text(payload.paymentDate);
				$('#recLoanId').text(payload.goldID);
				$('#recBranch').text(payload.paymentBranch);
				$('#recBorrower').text(payload.customerName);
				$('#recMode').text(payload.paymentMode);
				$('#recPrincipal').text(parseFloat(payload.principalDue || 0).toLocaleString('en-IN', {minimumFractionDigits: 2}));
				$('#recInterest').text(parseFloat(payload.interestDue || 0).toLocaleString('en-IN', {minimumFractionDigits: 2}));
				$('#recFines').text(parseFloat(payload.deductFineAmount || 0).toLocaleString('en-IN', {minimumFractionDigits: 2}));
				$('#recFee').text(parseFloat(payload.foreclosureFee || 0).toLocaleString('en-IN', {minimumFractionDigits: 2}));
				$('#recWaiver').text('-' + parseFloat(payload.waiver || 0).toLocaleString('en-IN', {minimumFractionDigits: 2}));
				$('#recTotal').text('₹' + parseFloat(payload.netAmount || 0).toLocaleString('en-IN', {minimumFractionDigits: 2}));

				showModal('#closureSuccessModal');
			} else {
				alert("Closure failed: " + (response.message || "Unknown error"));
			}
		},
		error: function(xhr) {
			$confirmBtn.prop('disabled', false).html('<i class="bi bi-check-circle me-1"></i> YES, EXECUTE FORECLOSURE');
			hideModal('#closureConfirmModal');
			let err = "Closure failed.";
			try {
				const res = JSON.parse(xhr.responseText);
				if (res && res.message) err = res.message;
			} catch(e) {
				if (xhr.responseText) err = xhr.responseText;
			}
			alert("Error executing early closure: " + err);
		}
	});
}

// 10. Print Foreclosure Settlement Receipt
function printForeclosureReceipt() {
	const printContents = document.getElementById('printableReceiptArea').innerHTML;
	const originalContents = document.body.innerHTML;

	const printWindow = window.open('', '_blank', 'height=650,width=850');
	printWindow.document.write('<html><head><title>Gold Loan Foreclosure Receipt</title>');
	printWindow.document.write('<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">');
	printWindow.document.write('<style>body{padding:25px;font-family:"Courier New", monospace;} .table td,.table th{padding:4px 8px;}</style>');
	printWindow.document.write('</head><body>');
	printWindow.document.write(printContents);
	printWindow.document.write('</body></html>');
	printWindow.document.close();
	printWindow.focus();
	setTimeout(function() {
		printWindow.print();
		printWindow.close();
	}, 500);
}

// Helper: Modal Show compatible with Bootstrap 4 & 5
function showModal(selector) {
	const el = document.querySelector(selector);
	if (!el) return;
	if (typeof bootstrap !== 'undefined' && bootstrap.Modal) {
		let modal = bootstrap.Modal.getInstance(el);
		if (!modal) modal = new bootstrap.Modal(el);
		modal.show();
	} else if ($(selector).modal) {
		$(selector).modal('show');
	} else {
		$(selector).addClass('show').css('display', 'block');
	}
}

// Helper: Modal Hide compatible with Bootstrap 4 & 5
function hideModal(selector) {
	const el = document.querySelector(selector);
	if (!el) return;
	if (typeof bootstrap !== 'undefined' && bootstrap.Modal) {
		let modal = bootstrap.Modal.getInstance(el);
		if (modal) modal.hide();
	} else if ($(selector).modal) {
		$(selector).modal('hide');
	} else {
		$(selector).removeClass('show').css('display', 'none');
		$('.modal-backdrop').remove();
	}
}
