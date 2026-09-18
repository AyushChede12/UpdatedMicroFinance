// JS for fetching the account number on the dropdown according to the account type
$(document).ready(function() {
	// Auto-fetch account numbers on load (if accountType is chosen or fetch all by default)
	const initialType = $("#accountType").val() || "savingaccount";
	if (!$("#accountType").val()) {
		$("#accountType").val("savingaccount");
	}
	fetchAccountNumbers($("#accountType").val() || "");

	$("#accountType").on("change", function() {
		const selectedType = $(this).val() || "";
		fetchAccountNumbers(selectedType);
	});
});

function formatCurrency(num) {
	const val = parseFloat(num) || 0;
	return '₹ ' + val.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

function formatDateDisplay(dateStr) {
	if (!dateStr) return '-';
	const parts = dateStr.split('-');
	if (parts.length === 3) {
		return parts[2] + '-' + parts[1] + '-' + parts[0];
	}
	return dateStr;
}

// fetch account numbers on dropdown
function fetchAccountNumbers(accountType) {
	$.ajax({
		type: "GET",
		url: "api/customersavings/fetchAccountNumbers",
		data: { accountType: accountType || "" },
		success: function(response) {
			const $dropdown = $("#accountNumber");
			$dropdown.empty().append('<option value="">--SELECT ACCOUNT NO--</option>');

			if (response.status === "OK" && Array.isArray(response.data)) {
				response.data.forEach(function(accNo) {
					$dropdown.append(`<option value="${accNo}">${accNo}</option>`);
				});
			}
		},
		error: function(xhr) {
			console.error("Error fetching account numbers: ", xhr.responseText);
		}
	});
}

let isFetchingTransactions = false;

// Function for fetching transaction data according to account number (All transactions)
function displaySavingTransaction() {
	if (isFetchingTransactions) return;

	let accountNumber = ($("#accountNumber").val() || "").trim();
	if (!accountNumber) {
		alert("Please select an Account Number.");
		return;
	}

	isFetchingTransactions = true;

	// 1. Fetch Account Details to populate header
	$.ajax({
		type: "GET",
		url: "api/customersavings/getDataByAccountNumber",
		data: { accountNumber: accountNumber },
		success: function(accRes) {
			if (accRes && accRes.status === "OK" && accRes.data) {
				const acc = accRes.data;
				let branch = (acc.branchName && acc.branchName.branchName) ? acc.branchName.branchName : "";

				$("#txnHdrAccountNo").text("A/C: " + (acc.accountNumber || accountNumber));
				$("#txnHdrCustName").text((acc.enterCustomerName || "-").toUpperCase());
				$("#txnHdrMemberCode").text(acc.selectByCustomer || "-");
				$("#txnHdrBranch").text(branch.toUpperCase() || "-");
				$("#txnHdrMobile").text(acc.contactNumber || "-");
				$("#txnHdrAccType").text((acc.typeofaccount || "SAVING ACCOUNT").toUpperCase());
				const bal = parseFloat(acc.balance) || 0;
				$("#txnHdrCurrentBal").text(formatCurrency(bal));
			}

			// 2. Fetch all transactions
			fetchTransactionRecords(accountNumber);
		},
		error: function() {
			// Fallback: fetch transactions anyway
			fetchTransactionRecords(accountNumber);
		}
	});
}

function fetchTransactionRecords(accountNumber) {
	$.ajax({
		type: "GET",
		url: "api/customersavings/getsavingaccountactivity",
		data: { accountNumber: accountNumber },
		success: function(response) {
			isFetchingTransactions = false;

			let data = (response && response.data && Array.isArray(response.data)) ? response.data : [];
			let tableBody = $("#tableBody1");
			tableBody.empty();

			if (data.length > 0) {
				data.forEach((item, index) => {
					let tType = (item.transactionType || "").toUpperCase();
					let amt = parseFloat(item.transactionAmount) || 0;
					let isDeposit = tType.includes("DEPOSIT") || tType.includes("CREDIT");
					let isWithdrawal = tType.includes("WITHDRAW") || tType.includes("DEBIT");

					let crText = isDeposit ? `<span class="text-success fw-bold">${formatCurrency(amt)}</span>` : '-';
					let drText = isWithdrawal ? `<span class="text-danger fw-bold">${formatCurrency(amt)}</span>` : '-';
					let balText = item.averageBalance ? formatCurrency(item.averageBalance) : '-';
					let particulars = item.comments || item.transactionFor || "Account Transaction";
					let payMode = item.payBy || "Cash";

					let row = `<tr>
						<td class="text-center">${index + 1}</td>
						<td class="text-center text-nowrap">${formatDateDisplay(item.transactionDate)}</td>
						<td class="text-start">${particulars}</td>
						<td class="text-center"><span class="badge bg-secondary">${payMode}</span></td>
						<td class="text-end">${crText}</td>
						<td class="text-end">${drText}</td>
						<td class="text-end fw-bold">${balText}</td>
					</tr>`;
					tableBody.append(row);
				});

				$('#printbtnSection').show();
				$('#passbookSection').hide();
				$("#headingSection").hide();
				$("#TransactionSection").show();
			} else {
				tableBody.append(`<tr><td colspan="7" class="text-center text-muted p-4">No transactions found for account ${accountNumber}.</td></tr>`);
				$('#printbtnSection').show();
				$('#passbookSection').hide();
				$("#headingSection").hide();
				$("#TransactionSection").show();
			}
		},
		error: function(xhr) {
			isFetchingTransactions = false;
			alert("Error fetching transactions: " + (xhr.responseJSON?.message || xhr.statusText || "Server error"));
			$('#TransactionSection').hide();
		}
	});
}

// Show saving acc details in table format & also load transactions
function displayTransactionDataList() {
	let accountNumber = ($("#accountNumber").val() || "").trim();
	if (!accountNumber) {
		alert("Please select an Account Number.");
		return;
	}

	$.ajax({
		type: "GET",
		url: "api/customersavings/getDataByAccountNumber",
		data: { accountNumber: accountNumber },
		success: function(response) {
			if (response.status === "OK" && response.data) {
				const data = response.data;
				let branch = "";

				if (data.branchName != null) {
					branch = data.branchName.branchName || "";
				}

				// Inject table row dynamically
				$("#customerDetails").html(`
					<tr>
						<td>${data.id || ''}</td>
						<td>${branch || ''}</td>
						<td>${data.accountNumber || ''}</td>
						<td>${(data.enterCustomerName || '').toUpperCase()}</td>
						<td>${data.selectByCustomer || ''}</td>
						<td>${data.contactNumber || ''}</td>
						<td>${(data.address || '').toUpperCase()}</td>
						<td>${data.openingDate || ''}</td>
						<td>${data.balance || ''}</td>
					</tr>
				`);
				$("#tableSection").show();
				$('#printbtnSection').hide();
				$('#passbookSection').hide();
				$("#headingSection").hide();

				// Also auto-fetch and display transactions below
				displaySavingTransaction();
			} else {
				alert("No data found for this account.");
				$("#customerDetails").empty();
			}
		},
		error: function(xhr) {
			alert("Error: " + xhr.responseText);
			$("#customerDetails").empty();
		}
	});
}

function displaySavingfrontPage() {
	let accountNumber = ($("#accountNumber").val() || "").trim();

	if (!accountNumber) {
		alert("Please select an account number!");
		return;
	}

	$.ajax({
		type: "GET",
		url: "api/customersavings/getDataByAccountNumber",
		data: { accountNumber: accountNumber },
		success: function(response) {
			if (response.status === "OK" && response.data) {
				const data = response.data;
				let branch = "";

				if (data.branchName != null) {
					branch = data.branchName.branchName || "";
				}
				let fullAddress = `${data.address || ''}, ${data.district || ''}, ${data.state || ''}, ${data.pinCode || ''}`.replace(/^,\s*|,\s*$/g, '');

				$("#customerNo").text(data.selectByCustomer || '-');
				$("#accountNo").text(data.accountNumber || '-');
				$("#customerName").text((data.enterCustomerName || '-').toUpperCase());
				$("#familyDetails").text((data.familyDetails || '-').toUpperCase());
				$("#dateOfBirth").text(data.dateOfBirth || '-');
				$("#contactNo").text(data.contactNumber || '-');
				$("#emailId").text((data.emailId || '-').toUpperCase());
				$("#operationType").text((data.operationType || 'Single').toUpperCase());
				$("#aadharNo").text(data.aadharNo || '-');
				$("#address").text(fullAddress.toUpperCase() || '-');
				$("#dateOfIssue").text(data.openingDate || '-');
				$("#typeofaccount").text((data.typeofaccount || 'Saving Account').toUpperCase());
				$("#branchName").text(branch.toUpperCase() || '-');

				$("#IFSCCode").text(data.ifscCode || '-');
				$("#nominationStatus").text(data.suggestedNomineeName ? 'YES' : 'NO');
				$("#nominationName").text((data.suggestedNomineeName || '-').toUpperCase());
				$("#upi").text(data.upi || '-');

				$("#tableSection").hide();
				$('#printbtnSection').show();
				$('#passbookSection').show();
				$("#headingSection").hide();
				$("#TransactionSection").hide();
			} else {
				alert("No account data found.");
			}
		},
		error: function(xhr) {
			alert("Error fetching data: " + (xhr.responseJSON?.error || xhr.statusText));
		}
	});
}

function displayHeadingSA() {
	$("#tableSection").hide();
	$('#printbtnSection').show();
	$('#passbookSection').hide();
	$("#headingSection").show();
	$("#TransactionSection").hide();
}

// Print button code for passbook & transactions
function printTransactionSection1() {
	let visibleSection = null;
	let title = "Print";

	if ($("#passbookSection").is(":visible")) {
		visibleSection = document.getElementById("passbookSection");
		title = "Customer Passbook Front Page";
	} else if ($("#TransactionSection").is(":visible")) {
		visibleSection = document.getElementById("TransactionSection");
		title = "Customer Savings Passbook Ledger";
	} else if ($("#headingSection").is(":visible")) {
		visibleSection = document.getElementById("headingSection");
		title = "Passbook Header";
	} else {
		alert("No section visible to print.");
		return;
	}

	const printWindow = window.open('', '', 'width=1100,height=850');

	printWindow.document.write(`
		<html>
		<head>
			<title>${title}</title>
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
			<style>
				body {
					margin: 15px;
					font-family: Arial, sans-serif;
					color: #000;
				}
				.card {
					box-shadow: none !important;
					border: 1px solid #ccc;
				}
				table {
					width: 100%;
					border-collapse: collapse;
					margin-top: 10px;
				}
				th, td {
					border: 1px solid #333 !important;
					padding: 6px 8px;
					font-size: 12px;
				}
				th {
					background-color: #f2f2f2 !important;
					color: #000 !important;
					font-weight: bold;
				}
				.badge {
					border: 1px solid #666;
					color: #000;
					background: transparent !important;
				}
				@media print {
					@page {
						margin: 15mm;
					}
				}
			</style>
		</head>
		<body>
			${visibleSection.outerHTML}
		</body>
		</html>
	`);

	printWindow.document.close();

	printWindow.onload = function() {
		setTimeout(() => {
			printWindow.print();
			printWindow.close();
		}, 400);
	};
}
