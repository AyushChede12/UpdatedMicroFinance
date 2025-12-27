$(document).ready(function() {
	$.ajax({
		url: "api/datacorrection/fetchAllApprovedLoanApplications",
		type: "GET",
		success: function(response) {
			if (response.status === "OK") {
				const branchList = response.data;

				// Use Set to store unique branch names
				const uniqueBranches = new Set();
				branchList.forEach(item => {
					if (item.branchName) {
						uniqueBranches.add(item.branchName.trim());
					}
				});

				// Clear existing options and add default
				$("#branchName1").empty();
				$("#branchName1").append("<option value=''>-- Select Branch Name --</option>");

				// Append unique branch names
				uniqueBranches.forEach(branchName => {
					$("#branchName1").append(
						`<option value="${branchName}">${branchName}</option>`
					);
				});
			} else {
				alert("Error: " + response.message);
			}
		},
		error: function(xhr) {
			console.error("Error loading branches:", xhr.responseText);
			alert("Failed to load dropdown data.");
		}
	});

	$.ajax({
		url: "api/datacorrection/fetchAllApprovedLoanApplications",
		type: "GET",
		success: function(response) {
			if (response.status === "OK") {
				const loanList = response.data;

				// Use Set to store unique branch names
				const uniqueBranches = new Set();
				loanList.forEach(item => {
					if (item.loanPlanName) {
						uniqueBranches.add(item.loanPlanName.trim());
					}
				});

				// Clear existing options and add default
				$("#loanPlanName").empty();
				$("#loanPlanName").append("<option value=''>-- Select Loan Name --</option>");

				// Append unique branch names
				uniqueBranches.forEach(loanPlanName => {
					$("#loanPlanName").append(
						`<option value="${loanPlanName}">${loanPlanName}</option>`
					);
				});
			} else {
				alert("Error: " + response.message);
			}
		},
		error: function(xhr) {
			console.error("Error loading branches:", xhr.responseText);
			alert("Failed to load dropdown data.");
		}
	});
});

$(document).ready(function() {
	// 🟢 Step 1: Load all data when page opens
	loadApprovedLoanApplications();

	// 🟢 Step 2: Filter when "Find" button clicked
	$('#findBtn').click(function(e) {
		e.preventDefault();

		let branch = $('#branchName1').val();
		let policy = $('#loanPlanName').val();
		let financialCode = $('#financialCode').val().trim().toUpperCase();
		let toDate = $('#toDate').val(); // frontend filter on loanDate

		loadApprovedLoanApplications(branch, policy, financialCode, toDate);
	});
});

// 🟢 Function to fetch & bind data (with optional filters)
function loadApprovedLoanApplications(branch = '', policy = '', financialCode = '', toDate = '') {
	$.ajax({
		url: 'api/datacorrection/fetchAllApprovedLoanApplications',
		method: 'GET',
		dataType: 'json',
		success: function(response) {
			if (response && response.data && response.data.length > 0) {
				let loans = response.data;

				// 🔹 Apply filters if provided
				if (branch) {
					loans = loans.filter(item => item.branchName === branch);
				}
				if (policy) {
					loans = loans.filter(item => item.loanPlanName === policy);
				}
				if (financialCode) {
					loans = loans.filter(item =>
						item.financialConsultantId &&
						item.financialConsultantId.toUpperCase().includes(financialCode)
					);
				}
				if (toDate) {
					loans = loans.filter(item => {
						let loanDate = parseDate(item.loanDate); // ❌ loanDate used
						let tDate = parseDate(toDate);
						return loanDate <= tDate;
					});
				}

				// 🔹 Bind final data to table
				bindLoanTable(loans);
			} else {
				bindLoanTable([]);
			}
		},
		error: function(xhr) {
			console.error('Error:', xhr);
			$('table tbody').html(`<tr><td colspan="13" class="text-center text-danger">Error fetching data.</td></tr>`);
		}
	});
}

// 🟢 Bind data to table
function bindLoanTable(data) {
	let tbody = $('.datatable tbody');
	tbody.empty();

	if (!data || data.length === 0) {
		tbody.append(`<tr><td colspan="13" class="text-center text-danger">No Records Found</td></tr>`);
		return;
	}

	let sn = 1;
	data.forEach(item => {
		// 🧮 Calculations
		let loanAmount = parseFloat(item.loanAmount || 0);
		let roi = parseFloat(item.rateOfInterest || 0);
		let loanTerm = parseInt(item.loanTerm || 1);

		let monthlyInterest = (loanAmount * roi / 100) / loanTerm;
		let installmentAmount = (loanAmount / loanTerm) + monthlyInterest;

		let totalInstallments = loanTerm;
		let paidInstallments = (item.paymentStatus === "Paid") ? totalInstallments : Math.floor(totalInstallments / 2);
		let pendingInstallments = totalInstallments - paidInstallments;
		let outstandingBalance = pendingInstallments * installmentAmount;

		let lastPaymentDate = item.paymentDate || "-";

		// 🔹 Table row
		let row = `
            <tr>
                <td>${sn++}</td>
                <td>${item.loanId || ''}</td>
                <td>${item.branchName || ''}</td>
                <td>${item.memberName || ''}</td>
				<td>${item.financialConsultantId || ''}</td>
                <td>${item.loanAmount || ''}</td>
                <td>${installmentAmount.toFixed(2)}</td>
                <td>${totalInstallments}</td>
                <td>${paidInstallments}</td>
                <td>${pendingInstallments}</td>
                <td>${outstandingBalance.toFixed(2)}</td>
                <td>${lastPaymentDate}</td>
                <td>${item.loanStatus || ''}</td>
                <td>${item.remarks || ''}</td>
                <td><button class="btn btn-sm btn-primary">Print</button></td>
            </tr>
        `;
		tbody.append(row);
	});
}

// 🟢 Helper: parse date string in yyyy-mm-dd format
function parseDate(dateStr) {
	if (!dateStr) return new Date(0);
	let parts = dateStr.split('-');
	return new Date(parts[0], parts[1] - 1, parts[2]);
}
