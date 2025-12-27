$(document).ready(function () {
	let allRecurringData = [];

	// ✅ 1. Fetch all approved loan applications on page load
	$.ajax({
		url: "api/datacorrection/fetchAllApprovedPolicyRenewal",
		method: "GET",
		success: function (response) {
			console.log("API Response:", response);

			if (response && response.data && Array.isArray(response.data)) {
				allRecurringData = response.data;

				// ✅ Fill branch dropdown
				let branches = new Set();
				allRecurringData.forEach(policy => {
					if (policy.branchname) branches.add(policy.branchname);
				});
				branches.forEach(branch => {
					$('#branchName1').append(`<option value="${branch}">${branch}</option>`);
				});

				// ✅ Render full table initially
				renderTable(allRecurringData);
			} else {
				$(".datatable tbody").html("<tr><td colspan='10'>No Recurring Date Found</td></tr>");
			}
		},
		error: function () {
			alert("Error while fetching loan data.");
		}
	});

	// ✅ 2. Filter on Find button click
	$('#findBtn').click(function (e) {
		e.preventDefault();

		const selectedBranch = $('#branchName1').val();
		const fromDate = $('#fromDate').val();
		const toDate = $('#toDate').val();

		if (!fromDate || !toDate) {
			alert("Please select both From and To dates.");
			return;
		}

		const filtered = allRecurringData.filter(policy => {
			const policyDate = policy.policyDate;
			return (
				(!selectedBranch || policy.branchname === selectedBranch) &&
				policyDate >= fromDate &&
				policyDate <= toDate
			);
		});

		renderTable(filtered);
	});

	// ✅ 3. Render the table and handle print popup
	function renderTable(data) {
		let tableBody = $(".datatable tbody");
		tableBody.empty();

		if (!data.length) {
			tableBody.append("<tr><td colspan='10'>No matching Loan Applications found.</td></tr>");
			return;
		}

		data.forEach((policy, index) => {
			let row = `
				<tr>
					<td>${index + 1}</td>
					<td>${policy.policyCode || ''}</td>
					<td>${policy.policyDate || ''}</td>
					<td>${policy.clientName || ''}</td>
					<td>${policy.contactNo || ''}</td>
					<td>${policy.policyAmount || ''}</td>
					<td>${policy.policyType || ''}</td>
					<td>${policy.policyTerm || ''}</td>
					<td>${policy.isApproved ? 'No' : 'Yes'}</td>
					<td>
						<button class="iconbutton printPopupBtn" data-id="${policy.id}" data-bs-toggle="modal" data-bs-target="#printModal">
							<i class="bi bi-printer" style="color: green;"></i>
						</button>
					</td>
				</tr>
			`;
			tableBody.append(row);
		});

		// ✅ Handle print popup
		$(".printPopupBtn").click(function () {
			const id = $(this).data("id");
			const selectedPolicy = allRecurringData.find(p => p.id === id);

			if (selectedPolicy) {
				let html = `
					<h4 class="text-center mb-4">Recurring Installment Due Report</h4>
					<div class="row">
					${createField("Policy Code", selectedPolicy.policyCode)}
					        ${createField("Renewal Date", selectedPolicy.renewalDate)}
					        ${createField("Policy Date", selectedPolicy.policyDate)}
					        ${createField("Maturity Date", selectedPolicy.maturityDate)}
					        ${createField("Customer Code", selectedPolicy.customerCode)}
					        ${createField("Client Name", selectedPolicy.clientName)}
					        ${createField("Contact No", selectedPolicy.contactNo)}
					        ${createField("Policy Amount", selectedPolicy.policyAmount)}
					        ${createField("Policy Type", selectedPolicy.policyType)}
					        ${createField("Policy Term", selectedPolicy.policyTerm)}
					        ${createField("Maturity Amount", selectedPolicy.maturityAmount)}
					        ${createField("Total Deposit", selectedPolicy.totalDeposit)}
					        ${createField("Payment Due", selectedPolicy.paymentDue)}
					        ${createField("Last Payment Date", selectedPolicy.lastPaymentDate)}
					        ${createField("Due Date", selectedPolicy.dueDate)}
					        ${createField("No. of Installments", selectedPolicy.noOfInst)}
					        ${createField("No. of Installments Paid", selectedPolicy.noOfInstPaid)}
					        ${createField("Mode of Payment", selectedPolicy.modeOfPayment)}
					        ${createField("Approved", selectedPolicy.approved ? "Yes" : "No")}
					        ${createField("Fees", selectedPolicy.fees)}
					        ${createField("Branch Name", selectedPolicy.branchname)}
					</div>
				`;
				$("#modalDataContainer").html(html);
			}
		});
	}

	// ✅ Helper to render label-value field
	function createField(label, value) {
		return `
			<div class="col-md-6 mb-3">
				<strong>${label}:</strong> <span>${value || ''}</span>
			</div>
		`;
	}

	// ✅ 4. Print modal data
	$("#printBtn").click(function () {
		const content = document.getElementById("modalDataContainer").innerHTML;
		const printWindow = window.open('', '', 'width=900,height=700');

		printWindow.document.write(`
			<html>
			<head>
				<title>Print</title>
				<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
				<style>
					body { font-family: Arial; padding: 30px; background: #fff; color: #000; }
					.print-container { width: 100%; margin: auto; }
					.heading { text-align: center; margin-bottom: 30px; font-size: 24px; font-weight: bold; border-bottom: 2px solid #000; padding-bottom: 10px; }
					.row { display: flex; flex-wrap: wrap; }
					.col-md-6 { width: 50%; padding: 10px 15px; box-sizing: border-box; }
				</style>
			</head>
			<body>
				<div class="print-container">
					<div class="heading">Loan Application Full Details</div>
					${content}
				</div>
			</body>
			</html>
		`);
		printWindow.document.close();
		printWindow.focus();
		printWindow.print();
		printWindow.close();
	});

	// ✅ 5. Download as PDF
	$("#downloadBtn").click(function () {
		const { jsPDF } = window.jspdf;
		const doc = new jsPDF({
			orientation: "portrait",
			unit: "pt",
			format: "a4"
		});
		const content = document.getElementById("modalDataContainer");

		doc.html(content, {
			callback: function (doc) {
				doc.save("LoanApplicationDetails.pdf");
			},
			x: 10,
			y: 10,
			autoPaging: 'text',
			html2canvas: { scale: 0.5 }
		});
	});
});
