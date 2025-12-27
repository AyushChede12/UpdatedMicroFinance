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
	loadEmiReport();
});

$('#findBtn').click(function(e) {
	e.preventDefault();
	loadEmiReport();
});

function loadEmiReport() {
	const branchName = $('#branchName').val()?.trim().toLowerCase() || "";
	const loanPlanName = $('#loanPlanName').val()?.trim().toLowerCase() || "";
	const financialCode = $('#financialCode').val()?.trim().toLowerCase() || "";
	const toDateStr = $('#toDate').val()?.trim() || "";

	const toDate = parseDateSafe(toDateStr);

	$.ajax({
		url: 'api/datacorrection/fetchAllApprovedLoanApplications',
		type: 'GET',
		dataType: 'json',
		success: function(response) {
			let data = (response && response.data) || [];

			const filtered = data.filter(item => {
				const branchMatch = branchName === "" || (item.branchName || "").toLowerCase().includes(branchName);
				const planMatch = loanPlanName === "" || (item.typeOfLoan || "").toLowerCase().includes(loanPlanName);
				const codeMatch = financialCode === "" || (item.financialConsultantId || "").toLowerCase().includes(financialCode);

				const approvalDate = parseDateSafe(item.approvalDate);
				const loanTerm = parseInt(item.loanTerm) || 0;

				// DueDate = approvalDate + loanTerm months
				let dueDate = null;
				if (approvalDate) {
					dueDate = new Date(approvalDate.getTime());
					dueDate.setMonth(dueDate.getMonth() + loanTerm);
				}

				// Date filter
				let dateMatch = true;
				if (toDate && dueDate) {
					dateMatch = dueDate.getTime() <= toDate.getTime();
				}

				return branchMatch && planMatch && codeMatch;
			});

			bindTable(filtered);
		},
		error: function(xhr, status, error) {
			console.error("Error fetching EMI data:", error);
			alert("Something went wrong while fetching EMI data.");
		}
	});
}

// Parse any date format safely
function parseDateSafe(str) {
	if (!str) return null;
	str = str.trim();
	let d;

	// DD/MM/YYYY
	if (str.includes('/')) {
		const parts = str.split('/');
		if (parts.length === 3) {
			const [dd, mm, yyyy] = parts;
			d = new Date(`${yyyy}-${mm}-${dd}`);
		}
	}
	// YYYY-MM-DD or YYYY/MM/DD
	else if (str.includes('-') || str.includes('/')) {
		const parts = str.split(/[-/]/);
		if (parts.length === 3 && parts[0].length === 4) {
			const [yyyy, mm, dd] = parts;
			d = new Date(`${yyyy}-${mm}-${dd}`);
		}
	}
	if (d && !isNaN(d)) return d;
	return null;
}

function bindTable(data) {
	const tbody = $('.datatable tbody');
	tbody.empty();
	if (!data || data.length === 0) {
		tbody.append(`<tr><td colspan="13" class="text-center text-danger">No records found</td></tr>`);
		return;
	}
	let count = 1;
	data.forEach(item => {
		const approvalDate = parseDateSafe(item.approvalDate);
		const loanTerm = parseInt(item.loanTerm) || 0;
		let dueDate = '-';
		if (approvalDate) {
			const d = new Date(approvalDate.getTime());
			d.setMonth(d.getMonth() + loanTerm);
			const yyyy = d.getFullYear();
			const mm = String(d.getMonth() + 1).padStart(2, '0');
			const dd = String(d.getDate()).padStart(2, '0');
			dueDate = `${yyyy}-${mm}-${dd}`;
		}
		const row = `
			<tr>
				<td>${count++}</td>
				<td>${item.loanId || '-'}</td>
				<td>${item.memberId || '-'}</td>
				<td>${item.memberName || '-'}</td>
				<td>${item.branchName || '-'}</td>``
				<td>${item.typeOfLoan || '-'}</td>
				<td>${item.contactNo || '-'}</td>
				<td>${item.loanAmount || '-'}</td>
				<td>${item.emiPayment || '-'}</td>
				<td>${dueDate}</td>
				<td>${calculateOutstanding(item)}</td>
				<td>${item.loanStatus || '-'}</td>
			</tr>
		`;
		tbody.append(row);
	});
}

function calculateOutstanding(item) {
	const total = parseFloat(item.loanAmount || 0);
	const paid = parseFloat(item.charges || 0);
	const outstanding = total - paid;
	return isNaN(outstanding) ? '-' : outstanding.toFixed(2);
}



