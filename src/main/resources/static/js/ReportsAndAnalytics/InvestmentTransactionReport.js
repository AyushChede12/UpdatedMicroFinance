$(document).ready(function() {
	let allPolicies = [];

	// ✅ 1. Fetch all approved policies on load
	$.ajax({
		url: "api/Policymangment/getApprovedPolicies",
		method: "GET",
		contentType: "application/json",
		success: function(response) {
			if (response?.data && Array.isArray(response.data)) {
				allPolicies = response.data;
				populateBranches(allPolicies);
				renderTable(allPolicies);
			} else {
				$(".datatable tbody").html(
					"<tr><td colspan='10'>No approved policies found.</td></tr>"
				);
			}
		},
		error: function() {
			alert("Error while fetching policies data.");
		},
	});

	// ✅ 2. Populate branch dropdown
	function populateBranches(policies) {
		let branches = new Set();
		policies.forEach((p) => {
			if (p.branchName) branches.add(p.branchName);
		});
		branches.forEach((branch) => {
			$("#branchName1").append(`<option value="${branch}">${branch}</option>`);
		});
	}

	// ✅ 3. Filter policies by branch/date
	$("#findBtn").click(function(e) {
		e.preventDefault();
		const selectedBranch = $("#branchName1").val();
		const fromDate = $("#fromDate").val();
		const toDate = $("#toDate").val();

		if (!fromDate || !toDate) {
			alert("Please select both From and To dates.");
			return;
		}

		const filtered = allPolicies.filter((p) => {
			const date = p.policyStartDate;
			return (
				(!selectedBranch || p.branchName === selectedBranch) &&
				date >= fromDate &&
				date <= toDate
			);
		});

		renderTable(filtered);
	});

	// ✅ 4. Render Policy Table
	function renderTable(data) {
		const tbody = $(".datatable tbody");
		tbody.empty();

		if (!data.length) {
			tbody.append("<tr><td colspan='10'>No matching policies found.</td></tr>");
			return;
		}

		data.forEach((policy, i) => {
			tbody.append(`
				<tr>
					<td>${i + 1}</td>
					<td>${policy.policyCode || ""}</td>
					<td>${policy.customerName || ""}</td>
					<td>${policy.schemeType || ""}</td>
					<td>${policy.policyStartDate || ""}</td>
					<td>${policy.policyAmount || ""}</td>
					<td>${policy.contactNo || ""}</td>
					<td>${policy.branchName || ""}</td>
					<td>${policy.approved ? "Yes" : "No"}</td>
					<td>
						<button class="btn btn-outline-success btn-sm bankReportBtn"
							data-id="${policy.id}"
							data-bs-toggle="modal"
							data-bs-target="#bankReportModal"
							title="View Report">
							<i class="bi bi-printer"></i>
						</button>
					</td>
				</tr>
			`);
		});

		bindModalEvents();
	}

	// ✅ 5. Bank Report Modal Handler
	function bindModalEvents() {
		$(".bankReportBtn").off("click").on("click", function() {
			const id = $(this).data("id");
			const policy = allPolicies.find((p) => p.id === id);
			if (!policy) return;

			// ✅ Fill modal header and bank info
			$("#bankLogo").attr("src", "https://i.ibb.co/zFSWbkC/banklogo.png");
			$("#bankName").text("Sterling Bank");
			$("#reportTitle").text("Microfinance Transaction Report");

			$("#accountNumber").text(policy.memberSelection || "N/A");
			$("#periodCovered").text(`${policy.policyStartDate} - ${policy.maturityDate}`);

			// ✅ Customer and summary details
			$("#customerName").text(policy.customerName || "");
			$("#customerAddress1").text(policy.address ? `Address: ${policy.address}` : "");
			$("#customerAddress2").text(policy.branchName ? `Branch: ${policy.branchName}` : "");

			$("#startingBalance").html(`&#8377; ${policy.policyAmount || 0}`);
			$("#incomeAmount").html(`&#8377; ${policy.depositAmount || 0}`);
			$("#expensesAmount").html(`&#8377; ${policy.amountDue || 0}`);
			$("#closingBalance").html(`&#8377; ${policy.maturityAmount || 0}`);

			// ✅ Fill Transactions Table
			const tbody = $("#transactionTableBody");
			tbody.empty();

			if (policy.policyCode != null) {
				tbody.append(`
						<tr>
							<td>${policy.policyCode || ""}</td>
							<td>${policy.policyStartDate || ""}</td>
							<td>${policy.policyAmount || ""}</td>
							<td>${policy.schemeType || ""}</td>
							<td>${policy.schemeMode || ""}</td>
						</tr>
					`);
			} else {
				tbody.append(`
					<tr>
						<td colspan="5" class="text-center text-muted">
							No transaction data available
						</td>
					</tr>
				`);
			}

			// ✅ Show modal
			$("#bankReportModal").modal("show");
		});
	}

	// ✅ 6. Print Modal Content
	$("#printBankReportBtn").click(function() {
		const content = document.getElementById("bankReportContent").innerHTML;
		const printWindow = window.open("", "", "width=900,height=700");
		printWindow.document.write(`
			<html>
				<head>
					<title>Transaction Report</title>
					<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
					<style>
						body { font-family: Arial, sans-serif; padding: 20px; }
						h4, h5, h6 { color: #0d6efd; }
						table { width: 100%; border-collapse: collapse; }
						th, td { padding: 8px; border: 1px solid #ddd; }
						th { background-color: #f2f2f2; }
						.text-end { text-align: right; }
						.text-center { text-align: center; }
					</style>
				</head>
				<body>${content}</body>
			</html>
		`);
		printWindow.document.close();
		printWindow.focus();
		printWindow.print();
	});
});
