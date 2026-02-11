$(document).ready(function() {
	loadBranchDropdown();
	loadVoucherTypeDropdown();

	// Handle form submit
	$("#formid").on("submit", function(e) {
		e.preventDefault();
		fetchJournalEntryReport();
	});
});


// 🔹 Load Branch Dropdown
function loadBranchDropdown() {
	$.ajax({
		type: "GET",
		url: "api/preference/getAllBranchModule",
		contentType: "application/json",
		success: function(response) {
			let options = "<option value=''>--SELECT BRANCH NAME--</option>";
			if (response && Array.isArray(response.data)) {
				response.data.forEach(branch => {
					options += `<option value="${branch.branchName}">${branch.branchName.toUpperCase()}</option>`;
				});
			}
			$("#branchName").html(options);
		},
		error: function() {
			alert("Failed to load branch names.");
		}
	});
}


// 🔹 Load Voucher Type Dropdown
function loadVoucherTypeDropdown() {
	const voucherTypes = [
		"Payment",
		"Receipt",
		"Contra",
		"Manual Journal"
	];
	let options = "<option value=''>--SELECT TYPE--</option>";
	voucherTypes.forEach(type => {
		options += `<option value="${type.toLowerCase()}">${type.toUpperCase()}</option>`;
	});
	$("#voucherType").html(options);
}


// 🔹 Fetch Journal Entry Report
function fetchJournalEntryReport() {
	const branch = $("#branchName").val();
	const voucherType = $("#voucherType").val();
	const startDate = $("#startDate").val();
	const endDate = $("#endDate").val();

	// ✅ Validation
	if (!branch || !voucherType || !startDate || !endDate) {
		alert("Please fill all required fields.");
		return;
	}

	$.ajax({
		type: "GET",
		url: "accountManagement/journal-entry-report",
		data: {
			branch: branch,
			voucherType: voucherType,
			startDate: startDate,
			endDate: endDate
		},
		success: function(response) {
			const report = response?.data || {};
			const entries = report.entries || [];
			const totals = report.totals || {};
			const tbody = $("table tbody");
			tbody.empty();

			// No records
			if (entries.length === 0) {
				tbody.append(`<tr><td colspan="6" class="text-center">No records found</td></tr>`);
				return;
			}

			// ✅ Initialize totals
			let totalDebit = 0;
			let totalCredit = 0;

			// ✅ Render table rows
			entries.forEach(entry => {
				const debit = parseFloat(entry.debit || 0);
				const credit = parseFloat(entry.credit || 0);
				totalDebit += debit;
				totalCredit += credit;

				const row = `
                    <tr>
                        <td>${entry.dateOfEntry || ''}</td>
                        <td>${entry.voucherID || ''}</td>
                        <td>${entry.remarks || ''}</td>
                        <td>${entry.accountCode || ''}</td>
                        <td class="text-right">${Number(debit).toLocaleString('en-IN', { minimumFractionDigits: 2 })}</td>
                        <td class="text-right">${Number(credit).toLocaleString('en-IN', { minimumFractionDigits: 2 })}</td>
                    </tr>
                `;
				tbody.append(row);
			});

			// ✅ Add Totals Row
			tbody.append(`
                <tr class="font-weight-bold table-warning">
                    <td colspan="4" class="text-right">Total:</td>
                    <td class="text-right">${Number(totalDebit).toLocaleString('en-IN', { minimumFractionDigits: 2 })}</td>
                    <td class="text-right">${Number(totalCredit).toLocaleString('en-IN', { minimumFractionDigits: 2 })}</td>
                </tr>
            `);

			// ✅ Optional: Summary Section (below table)
			const summaryDiv = $("#summaryInfo");
			if (summaryDiv.length === 0) {
				$(".card-body").prepend(`<div id="summaryInfo" class="alert alert-info py-2 mb-3"></div>`);
			}
			$("#summaryInfo").html(`
                <strong>Branch:</strong> ${branch} |
                <strong>Voucher Type:</strong> ${voucherType.toUpperCase()} |
                <strong>Report Period:</strong> ${startDate} to ${endDate} |
                <strong>Total Debit:</strong> ₹${Number(totalDebit).toLocaleString('en-IN', { minimumFractionDigits: 2 })} |
                <strong>Total Credit:</strong> ₹${Number(totalCredit).toLocaleString('en-IN', { minimumFractionDigits: 2 })}
            `);
		},
		error: function(xhr) {
			alert("Failed to load Journal Entry Report.");
			console.error(xhr.responseText);
		}
	});
}
