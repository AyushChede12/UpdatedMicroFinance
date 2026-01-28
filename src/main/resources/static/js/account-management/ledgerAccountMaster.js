$(document).ready(function() {
	
	BranchNameDropdown();
	GroupNameDropdown();

	// Form submit
	$("#formid").submit(function(e) {
		e.preventDefault();
		if (validateLedgerForm()) {
			saveLedger();
		}
	});

	// Clear form
	$("#clearBtn").click(function() {
		$("#formid")[0].reset();
		clearErrorMessages();
		$("#accountId").val("");
		$("#currentBalance").val("0.00");
	});
	// Auto set Dr/Cr when group changes
	$("#groupName").change(function() {
		const group = $(this).val();
		let drcr = "";

		if (group === "ASSETS" || group === "EXPENSES") {
			drcr = "DR";
		} else if (group === "LIABILITIES" || group === "EQUITY" || group === "INCOME") {
			drcr = "CR";
		}
		$("#openingBalanceType").val(drcr); // ✅ just set value
		const $accountType = $("#accountType");
		$accountType.empty().append('<option value="">SELECT TYPE</option>');

		if (group && allowedCombinations[group]) {
			allowedCombinations[group].forEach(type => {
				$accountType.append('<option value="' + type + '">' + type.replaceAll("_", " ") + '</option>');
			});
		}

	});
});

function showTableData() {
	const tableBody = $("#tableBody");
	const toggleBtn = $("#toggleBtn");

	if (tableBody.children().length === 0) {
		// No data loaded yet — load and show
		loadLedgerData(); // Will populate #tableBody
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

// ✅ Validation
function validateLedgerForm() {
	let isValid = true;

	const accountCode = $('#accountCode').val().trim();
	const accountTitle = $('#accountTitle').val().trim();
	const groupName = $('#groupName').val();
	const accountType = $('#accountType').val();
	const status = $('#status').val();
	const branchName = $('#branchName').val().trim();

	clearErrorMessages();

	if (accountCode === "") {
		$('#accountCodeError').text("* This field is required");
		isValid = false;
	}
	if (accountTitle === "") {
		$('#accountTitleError').text("* This field is required");
		isValid = false;
	}
	if (groupName === "") {
		$('#groupNameError').text("* This field is required");
		isValid = false;
	}
	if (accountType === "") {
		$('#accountTypeError').text("* This field is required");
		isValid = false;
	}
	if (status === "") {
		$('#statusError').text("* This field is required");
		isValid = false;
	}
	if (branchName === "") {
		$('#branchNameError').text("* This field is required");
		isValid = false;
	}

	return isValid;
}

function clearErrorMessages() {
	$('#accountCodeError').text("");
	$('#accountTitleError').text("");
	$('#groupNameError').text("");
	$('#accountTypeError').text("");
	$('#statusError').text("");
	$('#branchNameError').text("");
}

// Save Ledger
function saveLedger() {
	const ledgerData = {
		accountId: $('#accountId').val() || null,
		accountCode: $('#accountCode').val().trim(),
		accountTitle: $('#accountTitle').val().trim(),
		groupName: $('#groupName').val(),
		accountType: $('#accountType').val(),
		openingBalance: parseFloat($('#openingBalance').val()) || 0.00,
		openingBalanceType: $('#openingBalanceType').val(),   // <-- NEW
		currentBalance: $('#accountId').val()
			? parseFloat($('#currentBalance').val()) || 0.00   // update case
			: parseFloat($('#openingBalance').val()) || 0.00,  // new ledger case
		status: $('#status').val(),
		branchName: $('#branchName').val()
	};

	$.ajax({
		type: "POST",
		url: "accountManagement/create",
		contentType: "application/json",
		data: JSON.stringify(ledgerData),
		success: function(response, status, xhr) {
			if (xhr.status === 201) {
				alert(response.message);
				$("#formid")[0].reset();
				$("#accountId").val("");
				loadLedgerData();
			} else {
				alert("Unexpected response: " + response.message);
			}
		},
		error: function(xhr) {
			const err = xhr.responseJSON;
			const message = err && err.message ? err.message : "Error saving ledger account";
			alert(message);
		}
	});
}

// Load data table
let allLedgers = [];
function loadLedgerData() {
	$.ajax({
		type: "GET",
		url: "accountManagement/all",
		contentType: "application/json",
		success: function(response) {
			allLedgers = response.data || [];   // 👈 store data globally
			renderLedgerTable(allLedgers);      // 👈 common render function
		},
		error: function(xhr) {
			const err = xhr.responseJSON;
			const message = err && err.message ? err.message : "Failed to load ledger account list.";
			$("#tableBody").html(`<tr><td colspan="11">${message}</td></tr>`);
		}
	});
}
function renderLedgerTable(ledgers) {
	const tbody = $("#tableBody");
	tbody.empty();

	if (ledgers.length === 0) {
		tbody.append(`<tr><td colspan="11" class="text-center">No ledgers found.</td></tr>`);
		return;
	}

	$.each(ledgers, function(index, ledger) {
		const row = `
			<tr>
				<td>${ledger.accountId || ''}</td>
				<td>${ledger.accountCode || ''}</td>
				<td>${(ledger.accountTitle || '').toUpperCase()}</td>
				<td>${(ledger.groupName || '').toUpperCase()}</td>
				<td>${(ledger.accountType || '').toUpperCase()}</td>
				<td>${ledger.openingBalance != null ? ledger.openingBalance.toFixed(2) : ''}</td>
				<td>${(ledger.openingBalanceType || '').toUpperCase()}</td>
				<td>${ledger.currentBalance != null ? ledger.currentBalance.toFixed(2) : ''}</td>
				<td>${(ledger.status || '').toUpperCase()}</td>
				<td>${(ledger.branchName || '').toUpperCase()}</td>
				<td>
					<button class="iconbutton" onclick="viewLedger(${ledger.accountId})">
						<i class="fa-solid fa-eye text-primary"></i>
					</button>
				</td>
			</tr>
		`;
		tbody.append(row);
	});
}
function searchLedger() {
	let keyword = $("#ledgerSearch").val().toLowerCase();

	let filteredData = allLedgers.filter(ledger =>
		(ledger.accountCode || '').toLowerCase().includes(keyword) ||
		(ledger.accountTitle || '').toLowerCase().includes(keyword) ||
		(ledger.groupName || '').toLowerCase().includes(keyword) ||
		(ledger.accountType || '').toLowerCase().includes(keyword) ||
		(ledger.status || '').toLowerCase().includes(keyword) ||
		(ledger.branchName || '').toLowerCase().includes(keyword)
	);

	renderLedgerTable(filteredData);
}

// View ledger by ID
function viewLedger(id) {
	$.ajax({
		type: "GET",
		url: `accountManagement/${id}`,
		success: function(response) {
			const ledger = response.data;
			$('#accountId').val(ledger.accountId);
			$('#accountCode').val(ledger.accountCode);
			$('#accountTitle').val(ledger.accountTitle);
			$('#groupName').val(ledger.groupName);
			$('#accountType').val(ledger.accountType);
			$('#openingBalance').val(ledger.openingBalance);
			$('#openingBalanceType').val(ledger.openingBalanceType);
			$('#currentBalance').val(ledger.currentBalance);
			$('#status').val(ledger.status);
			$('#branchName').val(ledger.branchName);
		},
		error: function(xhr) {
			const err = xhr.responseJSON;
			const message = err && err.message ? err.message : "Error fetching ledger account.";
			alert(message);
		}
	});
}

// Branch Dropdown
function BranchNameDropdown() {
	$.ajax({
		type: "GET",
		contentType: "application/json",
		url: 'api/preference/getAllBranchModule',
		success: function(response) {
			let options = "<option value=''>SELECT BRANCH NAME</option>";
			if (response && Array.isArray(response.data)) {
				response.data.forEach(branch => {
					options += `<option value='${branch.branchName}'>${branch.branchName}</option>`;
				});
			}
			$("#branchName").html(options);
		},
		error: function() {
			alert("Failed to load branch names.");
		}
	});
}

// Group Dropdown
function GroupNameDropdown() {
	$.ajax({
		type: "GET",
		contentType: "application/json",
		url: 'accountManagement/groupNames',
		success: function(response) {
			const groupNames = response.data;
			let options = "<option value=''>SELECT GROUP NAME</option>";
			groupNames.forEach(group => {
				options += `<option value='${group}'>${group}</option>`;
			});
			$("#groupName").html(options);
		},
		error: function() {
			alert("Failed to load group names.");
		}
	});
}

const allowedCombinations = {
	"ASSETS": ["CASH", "BANK", "LOAN_TO_MEMBERS", "GOLD_LOANS", "JOINT_LOANS", "RECEIVABLE"],
	"LIABILITIES": ["MEMBER_SAVINGS", "RD_PAYABLE", "FD_PAYABLE", "DAILY_DEPOSIT_PAYABLE", "MIS_PAYABLE", "LOAN_FROM_BANK", "PAYABLE"],
	"INCOME": ["SERVICE_FEES", "INTEREST", "DIVIDEND", "MEMBER_CONTRIBUTION", "POLICY_FEES"],
	"EQUITY": ["SHARE", "CAPITAL"],
	"EXPENSES": ["SALARY", "RENT", "OFFICE", "UTILITIES", "CONSULTANT_INCENTIVES", "COMMISSIONS", "POLICY_ADMIN"]
};

