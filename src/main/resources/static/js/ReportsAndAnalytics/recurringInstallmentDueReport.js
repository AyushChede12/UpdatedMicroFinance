$(document).ready(function () {

	let allRecurringData = [];

	// ================= TODAY DATE =================
	function getToday() {
		let today = new Date();
		today.setHours(0,0,0,0);
		return today;
	}

	// ================= DUE STATUS =================
	function getDueStatus(dueDateStr) {

		if (!dueDateStr) return { text: "-", color: "black", days: "-" };

		let today = getToday();
		let dueDate = new Date(dueDateStr);
		dueDate.setHours(0,0,0,0);

		let diffTime = dueDate - today;
		let diffDays = Math.ceil(diffTime / (1000 * 60 * 60 * 24));

		if (diffDays < 0) {
			return { text: "Overdue", color: "red", days: Math.abs(diffDays) + " days overdue" };
		}
		else if (diffDays === 0) {
			return { text: "Due Today", color: "orange", days: "Today" };
		}
		else {
			return { text: "Upcoming", color: "green", days: diffDays + " days remaining" };
		}
	}

	// ================= FETCH DATA =================
	$.ajax({
		url: "api/datacorrection/fetchAllApprovedPolicyRenewal",
		method: "GET",
		success: function (response) {

			if (response && response.data && Array.isArray(response.data)) {

				// ✅ Only recurring due policies
				allRecurringData = response.data.filter(p => {
					return p.paymentDue > 0 || new Date(p.dueDate) <= getToday();
				});

				// ===== branch dropdown =====
				let branches = new Set();
				allRecurringData.forEach(policy => {
					if (policy.branchname) branches.add(policy.branchname);
				});
				branches.forEach(branch => {
					$('#branchName1').append(`<option value="${branch}">${branch}</option>`);
				});

				renderTable(allRecurringData);
			}
		}
	});

	// ================= FILTER =================
	$('#findBtn').click(function (e) {
		e.preventDefault();

		const selectedBranch = $('#branchName1').val();
		const fromDate = $('#fromDate').val();
		const toDate = $('#toDate').val();

		const filtered = allRecurringData.filter(policy => {

			let dueDate = policy.dueDate;

			return (
				(!selectedBranch || policy.branchname === selectedBranch) &&
				(!fromDate || dueDate >= fromDate) &&
				(!toDate || dueDate <= toDate)
			);
		});

		renderTable(filtered);
	});

	// ================= RENDER TABLE =================
	function renderTable(data) {

		let tableBody = $(".datatable tbody");
		tableBody.empty();

		if (!data.length) {
			tableBody.append("<tr><td colspan='13'>No Due Installments Found</td></tr>");
			return;
		}

		data.forEach((policy, index) => {

			let status = getDueStatus(policy.dueDate);

			let row = `
			<tr>
				<td>${index + 1}</td>
				<td>${policy.policyCode || ''}</td>
				<td>${policy.clientName || ''}</td>
				<td>${policy.policyAmount || ''}</td>
				<td>${policy.lastPaymentDate || ''}</td>
				<td>${policy.dueDate || ''}</td>
				<td>${status.days}</td>
				<td style="color:${status.color};font-weight:bold;">
					${status.text}
				</td>
				<td>
					<button class="iconbutton printPopupBtn" data-id="${policy.id}" data-bs-toggle="modal" data-bs-target="#printModal">
						<i class="bi bi-printer" style="color: green;"></i>
					</button>
				</td>
			</tr>
			`;
			tableBody.append(row);
		});

		// ================= PRINT POPUP =================
		$(".printPopupBtn").click(function () {

			const id = $(this).data("id");
			const selectedPolicy = allRecurringData.find(p => p.id === id);

			let status = getDueStatus(selectedPolicy.dueDate);

			let html = `
				<h4 class="text-center mb-4">Recurring Installment Due Report</h4>
				<div class="row">
					${createField("Policy Code", selectedPolicy.policyCode)}
					${createField("Client Name", selectedPolicy.clientName)}
					${createField("Policy Amount", selectedPolicy.policyAmount)}
					${createField("Last Payment Date", selectedPolicy.lastPaymentDate)}
					${createField("Due Date", selectedPolicy.dueDate)}
					${createField("Payment Due", selectedPolicy.paymentDue)}
					${createField("Status", status.text)}
					${createField("Days", status.days)}
					${createField("Branch", selectedPolicy.branchname)}
				</div>
			`;

			$("#modalDataContainer").html(html);
		});
	}

	// ================= FIELD =================
	function createField(label, value) {
		return `<div class="col-md-6 mb-3"><strong>${label}:</strong> ${value || '-'}</div>`;
	}

});