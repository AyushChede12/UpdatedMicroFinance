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
		let toDate = $('#tDate').val();

		loadApprovedLoanApplications(branch, policy, financialCode, toDate);
	});
});

// 🟢 Function to fetch & bind data (with optional filters)
function loadApprovedLoanApplications(branch = '', policy = '', financialCode = '', toDate = '') {
	$.ajax({
		url: 'api/datacorrection/fetchAllApprovedLoanApplications',   // adjust path if your backend prefix differs
		method: 'GET',
		dataType: 'json',
		success: function(response) {
			if (response && response.data && response.data.length > 0) {
				let filteredData = response.data;

				// 🔹 Apply filters if provided
				if (branch) {
					filteredData = filteredData.filter(item => item.branchName === branch);
				}
				if (policy) {
					filteredData = filteredData.filter(item => item.loanPlanName === policy);
				}
				if (financialCode) {
					filteredData = filteredData.filter(item =>
						item.financialConsultantId &&
						item.financialConsultantId.toUpperCase().includes(financialCode)
					);
				}
				if (toDate) {
					filteredData = filteredData.filter(item => {
						let approvalDate = parseDate(item.approvalDate);
						let tDate = parseDate(toDate);
						return approvalDate <= tDate;
					});
				}

				// 🔹 Bind final data to table
				bindLoanTable(filteredData);
			} else {
				bindLoanTable([]);
			}
		},
		error: function(xhr) {
			console.error('Error:', xhr);
			$('table tbody').html(`<tr><td colspan="12" class="text-center text-danger">Error fetching data.</td></tr>`);
		}
	});
}

// 🟢 Bind data to table
function bindLoanTable(data) {
	let tbody = $('.datatable tbody');
	tbody.empty();

	if (!data || data.length === 0) {
		tbody.append(`<tr><td colspan="12" class="text-center text-danger">No Records Found</td></tr>`);
		return;
	}

	let sn = 1;
	data.forEach(item => {
		let loanAmount = parseFloat(item.loanAmount || 0);
		let totalPaid = parseFloat(item.sanctionedAmount || 0);
		let emiPayment = parseFloat(item.emiPayment || 0);
		let overdue = (loanAmount - totalPaid) > 0 ? (loanAmount - totalPaid).toFixed(2) : '0.00';
		let currentDue = emiPayment.toFixed(2);

		let row = `
            <tr>
                <td>${sn++}</td>
                <td>${item.loanId || ''}</td>
				<td>${item.memberId || ''}</td>
                <td>${item.memberName || ''}</td>
				<td>${item.loanDate || ''}</td>
                <td>${item.branchName || ''}</td>
				<td>${item.contactNo || ''}</td>
                <td>${item.loanPlanName || ''}</td>
                <td>${totalPaid}</td>
                <td>${overdue}</td>
                <td>${currentDue}</td>
                <td><button class="btn btn-sm btn-primary">Print</button></td>
            </tr>
        `;
		tbody.append(row);
	});
}

// 🟢 Helper for dd/MM/yyyy → JS Date
function parseDate(dateStr) {
	if (!dateStr) return new Date('');
	let parts = dateStr.split('/');
	if (parts.length === 3) {
		return new Date(parts[2], parts[1] - 1, parts[0]);
	}
	return new Date(dateStr);
}