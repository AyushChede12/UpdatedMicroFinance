// =========================================
// CLEAR FORM FUNCTION
// =========================================
function clearAccountForm() {
	$('#customerCode, #customerName, #contactNumber, #jointHolderName, #savingPlanName, #averageBalance, #selectBranchName')
		.val('')
		.prop("readonly", false);

	$('#tbody').empty();
}

// =========================================
// FETCH ACCOUNT DETAILS ON ACCOUNT CHANGE
// =========================================
$('#accountNumber').on('change', function () {

	let accountNumber = $(this).val().trim();

	if (accountNumber === "") {
		clearAccountForm();
		return;
	}

	$.ajax({
		url: "/api/customersavings/getallbyaccountnumber",
		type: "GET",
		data: { accountNumber: accountNumber },
		dataType: "json",
		success: function (response) {

			if ((response.status === "OK" || response.status === "FOUND")
				&& response.data && response.data.length > 0) {

				let customer = response.data[0];

				$('#customerCode').val(customer.selectByCustomer || '');
				$('#customerName').val(customer.enterCustomerName || '');
				$('#contactNumber').val(customer.contactNumber || '');
				$('#jointHolderName').val(customer.jointSurvivorCode || '');
				$('#savingPlanName').val(customer.selectPlan || '');
				$('#averageBalance').val(customer.balance || '');
				$('#selectBranchName').val(customer.branch || customer.branchName || '');

				// READ ONLY
				$('#customerCode, #customerName, #contactNumber, #jointHolderName, #savingPlanName, #averageBalance, #selectBranchName')
					.prop("readonly", true);

				// ✅ LOAD TABLE
				reloadTransactionTable(accountNumber);

			} else {
				alert("No account found!");
				clearAccountForm();
			}
		},
		error: function () {
			alert("Server error while fetching account data");
			clearAccountForm();
		}
	});
});

// =========================================
// SAVE TRANSACTION
// =========================================
$(document).ready(function () {

	$('#saveBtn').click(function (event) {
		event.preventDefault();

		const transactionDate = $('#transactionDate').val();
		const accountNumber = $('#accountNumber').val();
		const transactionType = $('#transactionType').val();
		const transactionAmount = parseFloat($('#transactionAmount').val());
		let avgBalance = parseFloat($('#averageBalance').val()) || 0;

		if (!transactionDate || !accountNumber || !transactionType || isNaN(transactionAmount)) {
			alert("Please fill all required fields");
			return;
		}

		// BALANCE CALCULATION
		if (transactionType === 'Deposit') {
			avgBalance += transactionAmount;
		} else if (transactionType === 'Withdraw') {
			avgBalance -= transactionAmount;
		}

		if (avgBalance < 0) {
			alert("Balance cannot be negative");
			return;
		}

		$('#averageBalance').val(avgBalance.toFixed(2));

		const accountData = {
			selectSavingTransactionId: $('#selectSavingTransactionId').val(),
			transactionDate: transactionDate,
			selectBranchName: $('#selectBranchName').val(),
			accountNumber: accountNumber,
			customerCode: $('#customerCode').val(),
			customerName: $('#customerName').val(),
			contactNumber: $('#contactNumber').val(),
			jointHolderName: $('#jointHolderName').val(),
			savingPlanName: $('#savingPlanName').val(),
			averageBalance: avgBalance.toFixed(2),
			transactionFor: $('#transactionFor').val(),
			comments: $('#comments').val(),
			transactionType: transactionType,
			transactionAmount: transactionAmount.toFixed(2),
			payBy: $('#payBy').val(),
			chequeNo: $('#chequeNo').val(),
			chequeDate: $('#chequeDate').val(),
			depositAcc1: $('#depositAcc1').val(),
			depositAcc2: $('#depositAcc2').val(),
			refNumber1: $('#refNumber1').val(),
			depositAcc3: $('#depositAcc3').val(),
			refNumber2: $('#refNumber2').val()
		};

		$.ajax({
			url: "api/customersavings/savesavingaccountactivity",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(accountData),
			success: function () {
				alert("Transaction saved successfully");

				// ✅ UPDATE MAIN BALANCE
				updateMainAccountBalance(accountNumber, avgBalance);

				// ✅ RELOAD TABLE
				reloadTransactionTable(accountNumber);
			},
			error: function () {
				alert("Failed to save transaction");
			}
		});
	});
});

// =========================================
// LOAD TRANSACTION TABLE
// =========================================
function reloadTransactionTable(accountNumber) {

	$.ajax({
		type: "GET",
		url: "api/customersavings/getsavingaccountactivity",
		data: { accountNumber: accountNumber },
		success: function (response) {

			let tbody = $('#tbody');
			tbody.empty();

			if (response.data && response.data.length > 0) {

				$.each(response.data, function (index, txn) {

					let row = `
						<tr>
							<td>${index + 1}</td>
							<td>${(txn.selectBranchName || '').toUpperCase()}</td>
							<td>${txn.transactionDate || ''}</td>
							<td>${txn.accountNumber || ''}</td>
							<td>${(txn.transactionType || '').toUpperCase()}</td>
							<td>${txn.transactionAmount || ''}</td>
							<td>${txn.averageBalance || ''}</td>
							<td>${(txn.payBy || '').toUpperCase()}</td>
							<td>${(txn.comments || '').toUpperCase()}</td>
							<td>${txn.selectSavingTransactionId || ''}</td>
							<td>${txn.createdBy || 'ADMIN'}</td>
						</tr>
					`;

					tbody.append(row);
				});

			} else {
				tbody.append(`<tr><td colspan="11" class="text-center">No Data Found</td></tr>`);
			}
		},
		error: function () {
			alert("Failed to load table data");
		}
	});
}

// =========================================
// UPDATE MAIN ACCOUNT BALANCE
// =========================================
function updateMainAccountBalance(accountNumber, newBalance) {

	$.ajax({
		type: "POST",
		url: "api/customersavings/updateaveragebalance",
		contentType: "application/json",
		data: JSON.stringify({
			accountNumber: accountNumber,
			balance: newBalance
		}),
		success: function (response) {
			alert(response.message);
		},
		error: function () {
			alert("Failed to update main balance");
		}
	});
}
