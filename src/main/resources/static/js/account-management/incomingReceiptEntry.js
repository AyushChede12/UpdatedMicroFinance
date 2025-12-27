$(document).ready(function() {
	BranchNameDropdown();

	toggleTransferFields($('#transferMode').val());

	$('#transferMode').on('change', function() {
		toggleTransferFields(this.value);
	});


	$("#formid").submit(function(e) {
		e.preventDefault();
		saveIncomingReceipt();
	});

	$('#searchBtn').click(function(e) {
		e.preventDefault();
		searchIncomingReceipts();
	});

	$("#entryBranchName").on("change", function() {
		const selectedBranch = $(this).val();
		LedgerDropdown(selectedBranch);
	});
});

function showTableData() {
	const tableBody = $("#tableBody");
	const toggleBtn = $("#toggleBtn");

	if (tableBody.children().length === 0) {
		// No data loaded yet — load and show
		loadIncomingReceipts(); // Will populate #tableBody
		toggleBtn.html('Hide');
	} else {
		// Data exists — toggle visibility
		if (tableBody.is(":visible")) {
			tableBody.hide();
			toggleBtn.html('Show');
		} else {
			tableBody.show();
			toggleBtn.html('Hide');
		}
	}
}
function toggleTransferFields(mode) {
	const m = (mode || '').toLowerCase().trim();

	// Hide all conditional groups by default
	$('.chequeFields').addClass('d-none');
	$('.onlineFields').addClass('d-none');

	// Clear conditional inputs when switching modes to avoid stale values
	$('#chequeNo').val('');
	$('#chequeDate').val('');
	$('#bankName').val('');
	$('#transactionRef').val('');

	if (m === 'cheque') {
		$('.chequeFields').removeClass('d-none');
	} else if (m === 'online transfer') {
		// If only "Online Transfer" should display this, change to: (m === 'online transfer')
		$('.onlineFields').removeClass('d-none');
	}
}


// Save New Incoming Receipt Entry
function saveIncomingReceipt() {
	const receiptData = {
		branchName: $('#entryBranchName').val().trim(),
		dateOfEntry: $('#dateOfEntry').val(),
		transferMode: $('#transferMode').val(),
		creditLedger: $('#creditLedger').val(),
		debitLedger: $('#debitLedger').val(),
		transactionAmount: $('#transactionAmount').val(),
		remarks: $('#remarks').val(),
		chequeNo: $('#chequeNo').val(),
		chequeDate: $('#chequeDate').val(),
		bankName: $('#bankName').val(),
		transactionRef: $('#transactionRef').val()
	};

	// Client-side validation
	if (!receiptData.branchName || !receiptData.dateOfEntry || !receiptData.transferMode ||
		!receiptData.creditLedger || !receiptData.debitLedger || !receiptData.transactionAmount) {
		alert("Please fill in all required fields.");
		return;
	}

	// Conditional validation
	if (receiptData.transferMode.toLowerCase() === "cheque") {
		if (!receiptData.chequeNo || !receiptData.chequeDate || !receiptData.bankName) {
			alert("Cheque No, Date and Bank Name are required for Cheque payments.");
			return;
		}
	}
	if (receiptData.transferMode.toLowerCase() === "online transfer") {
		if (!receiptData.transactionRef) {
			alert("Transaction Ref is required for Online Transfer.");
			return;
		}
	}

	$.ajax({
		type: "POST",
		url: "accountManagement/createIncomingReceipt",
		contentType: "application/json",
		data: JSON.stringify(receiptData),
		success: function(response) {
			if (response?.status === "CREATED") {
				alert(response.message || "Incoming Receipt saved successfully!");
				$("#formid")[0].reset();
				$('.chequeFields').addClass('d-none');
				$('.onlineFields').addClass('d-none');
				loadIncomingReceipts();
			} else {
				alert(response.message || "Unexpected response.");
			}
		},
		error: function(xhr) {
			let errorMsg = "Error saving outgoing payment.";
			try {
				const res = JSON.parse(xhr.responseText);
				if (res?.message) errorMsg = res.message;
			} catch (e) {
				console.error("Error parsing save response:", e);
			}
			alert(errorMsg);
		}
	});
}

// Load all Incoming Receipts
function loadIncomingReceipts() {
	$.ajax({
		type: "GET",
		url: "accountManagement/allIncomingReceipt",
		contentType: "application/json",
		success: function(response) {
			const tbody = $("#tableBody");
			tbody.empty();

			// ✅ Properly handle ApiResponse wrapper
			const receipts = response?.data || [];

			if (receipts.length === 0) {
				tbody.append(`<tr><td colspan="8">No Incoming Receipt Entry found</td></tr>`);
				return;
			}

			// ✅ Safely render all outgoing payments
			receipts.forEach(receipt => {
				const row = `
				<tr> 
					<td>${receipt.id ?? ''}</td>
					<td>${receipt.branchName ?? ''}</td>
					<td>${receipt.voucherID ?? ''}</td>
					<td>${receipt.dateOfEntry ?? ''}</td>
					<td>${receipt.creditLedger ?? ''}</td>
					<td>${receipt.debitLedger ?? ''}</td>
					<td>${receipt.transferMode ?? ''}</td>
					<td>${receipt.transactionAmount ?? ''}</td>
					<td>${receipt.remarks ?? ''}</td>
					<td>
							<button class="iconbutton" onclick="viewIncomingReceipt(${receipt.id})" title="View">
								<i class="fa-solid fa-eye text-primary"></i>
							</button>
					</td>
				</tr>
			`;
				tbody.append(row);
			});
		},
		error: function() {
			alert("Failed to load Incoming payments.");
		}
	});
}
// View a single Incoming Receipt
function viewIncomingReceipt(id) {
	$.ajax({
		type: "GET",
		url: `accountManagement/incomingReceipt/${id}`,
		contentType: "application/json",
		success: function(response) {
			const data = response.data;
			// Branch preselect
			$("#entryBranchName option").each(function() {
				if ($(this).val()?.trim().toLowerCase() === data.branchName?.trim().toLowerCase()) {
					$(this).prop("selected", true);
					return false;
				}
			});


			$("#voucherID").val(data.voucherID);
			$("#dateOfEntry").val(data.dateOfEntry);
			$("#transferMode").val(data.transferMode);
			$("#transactionAmount").val(data.transactionAmount);
			$("#remarks").val(data.remarks);

			toggleTransferFields(data.transferMode);

			$("#chequeNo").val(data.chequeNo ?? "");
			$("#chequeDate").val(data.chequeDate ?? "");
			$("#bankName").val(data.bankName ?? "");
			$("#transactionRef").val(data.transactionRef ?? "");

			LedgerDropdown(data.branchName, data.creditLedger, data.debitLedger);
		},
		error: function() {
			alert("Failed to load incoming receipt data");
		}
	});
}


// Search Incoming Receipts
function searchIncomingReceipts() {
	const branchName = $('#searchBranchName').val();
	const startDate = $('#startDate').val();
	const endDate = $('#endDate').val();

	if (!branchName || !startDate || !endDate) {
		alert("Please fill in Branch Name, Start Date, and End Date.");
		return;
	}

	$.ajax({
		type: "GET",
		url: "accountManagement/searchIncomingReceipt",
		data: {
			branchName: branchName,
			startDate: startDate,
			endDate: endDate
		},
		success: function(response) {
			const tbody = $("#tableBody");
			tbody.empty();

			// ✅ Access response.data now
			const receipts = response.data || [];;

			if (receipts.length === 0) {
				tbody.append(`<tr><td colspan="7">No results found</td></tr>`);
				return;
			}

			$.each(receipts, function(index, receipt) {
				const row = `
                    <tr>
					<td>${receipt.id || ''}</td>
					<td>${receipt.branchName || ''}</td>
					<td>${receipt.voucherID || ''}</td>
					<td>${receipt.dateOfEntry || ''}</td>
					<td>${receipt.creditLedger || ''}</td>
					<td>${receipt.debitLedger || ''}</td>
					<td>${receipt.transferMode || ''}</td>
					<td>${receipt.transactionAmount || ''}</td>
					<td>${receipt.remarks || ''}</td>
					
						<td>
													<button class="iconbutton" onclick="viewIncomingReceipt(${receipt.id})" title="View">
														<i class="fa-solid fa-eye text-primary"></i>
													</button>
												</td>
                    </tr>
                `;
				tbody.append(row);
			});
		},
		error: function() {
			alert("Search failed");
		}
	});

}

// Branch Dropdown Loader
function BranchNameDropdown() {
	$.ajax({
		type: "GET",
		contentType: "application/json",
		url: 'api/preference/getAllBranchModule',
		success: function(response) {
			let options = "<option value=''>Select Branch Name</option>";
			// The actual branch array is inside response.data
			if (response && Array.isArray(response.data)) {
				response.data.forEach(branch => {
					options += `<option value='${branch.branchName}'>${branch.branchName}</option>`;
				});
			}
			$("#searchBranchName").html(options);
			$("#entryBranchName").html(options);
		},
		error: function() {
			alert("Failed to load branch names.");
		}
	});
}
// Load Credit & Debit Ledgers by branch
function LedgerDropdown(branchName, selectedCr = "", selectedDr = "") {
	if (!branchName || branchName.trim() === "") {
		console.warn("Branch name is missing. Skipping ledger dropdown load.");
		return;
	}
	$.ajax({
		type: "GET",
		url: `accountManagement/ledgerByBranch/${branchName}`,
		contentType: "application/json",
		success: function(data) {
			const ledgers = data.data || [];

			// Credit Ledger → Assets (Cash/Bank)
			let crOptions = "<option value=''>Select Credit Ledger</option>";
			// Debit Ledger → Liabilities/Expenses/Equity
			let drOptions = "<option value=''>Select Debit Ledger</option>";

			ledgers.forEach(ledger => {
				const g = ledger.groupName.toLowerCase();
				const t = ledger.accountType.toLowerCase();
				const title = ledger.accountTitle;

				// Debit Ledger (Destination → Cash/Bank under Assets)
				if (g === "assets" && (t === "cash" || t === "bank")) {
					const selected = title.trim().toLowerCase() === selectedDr.trim().toLowerCase() ? "selected" : "";
					drOptions += `<option value="${title}" ${selected}>${title}</option>`;
				}

				// Credit Ledger (Source → Liabilities, Equity, Income, OR Loan under Assets)
				if (g === "liabilities" || g === "equity" || g === "income" || (g === "assets" && t === "loan_to_members" ||
					t === "gold_loans" ||
					t === "joint_loans")) {
					const selected = title.trim().toLowerCase() === selectedCr.trim().toLowerCase() ? "selected" : "";
					crOptions += `<option value="${title}" ${selected}>${title}</option>`;
				}
			});

			$("#creditLedger").html(crOptions);
			$("#debitLedger").html(drOptions);
		},
		error: function() {
			alert("Failed to load ledger accounts for selected branch");
		}
	});
}