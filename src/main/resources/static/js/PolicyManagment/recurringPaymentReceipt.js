$(document).ready(function () {

	// =========================================================
	// Load Policy Dropdown
	// =========================================================
	$.ajax({
		url: "api/Policymangment/getAllRDPolicies",
		type: "GET",

		success: function (response) {

			if (response.data && response.data.length > 0) {

				const policySelect = $("#policyCode");

				response.data.forEach(policy => {

					const optionText = `${policy.policyCode} - ${policy.customerName.toUpperCase()}`;

					policySelect.append(
						`<option value="${policy.policyCode}">${optionText}</option>`
					);

				});
			}
		},

		error: function () {
			alert("Failed to load policies.");
		}
	});


	// =========================================================
	// Common Function - Create Policy Table
	// =========================================================
	function loadPolicyTable(data) {

		const tbody = $("#policyTableBody");

		tbody.empty();

		// Convert single object into array
		const policies = Array.isArray(data) ? data : [data];

		if (policies.length === 0) {

			tbody.html(
				`<tr>
					<td colspan="15" class="text-center">No data available</td>
				</tr>`
			);

			return;
		}

		policies.forEach((item, index) => {

			const newRow = `
				<tr style="font-family: 'Poppins', sans-serif;">

					<td>${index + 1}</td>

					<td>${item.policyCode || ''}</td>

					<td>${item.customerName.toUpperCase() || ''}</td>

					<td>${item.paymentDate || ''}</td>

					<td>${item.policyAmount || ''}</td>

					<td>${item.planCode || ''}</td>

					<td>${item.maturityDate || ''}</td>

					<td>${item.maturityAmount || ''}</td>

					<td>${item.duration || ''}</td>

					<td>${item.branchName.toUpperCase() || ''}</td>

					<td>${item.modeofPayment.toUpperCase() || ''}</td>

					<td>
						<a href="#"
						   class="print-btn"
						   data-policy='${JSON.stringify(item)}'
						   style="color: green;">

							<i class="bi bi-printer-fill"></i>

						</a>
					</td>

				</tr>
			`;

			tbody.append(newRow);
		});


		// =====================================================
		// Bind Print Button
		// =====================================================
		$(".print-btn").off("click").on("click", function (e) {

			e.preventDefault();

			const policyData = $(this).data("policy");

			$("#certificateTemplate").show();

			printCertificate(policyData);
		});


		// =====================================================
		// Fill Certificate Preview
		// =====================================================
		const first = policies[0];

		$("#certClientName").text(
			first.clientName || first.customerName || ''
		);

		$("#certPolicyCode").text(
			first.policyCode || ''
		);

		$("#certPolicyAmount").text(
			first.policyAmount || ''
		);

		$("#certMaturityAmount").text(
			first.maturityAmount || ''
		);

		$("#certMaturityDate").text(
			first.maturityDate || ''
		);

		$("#certContact").text(
			first.contactNo || ''
		);

		$("#certNominee").text(
			first.suggestedNominee || ''
		);

		$("#certAddress").text(
			first.address || ''
		);
	}


	// =========================================================
	// Load All RD Policies
	// =========================================================
	$.ajax({
		url: "api/Policymangment/getAllRDPoliciesFromFullMaturity",
		type: "GET",
		contentType: "application/json",

		success: function (response) {

			if (response.status === "OK") {

				loadPolicyTable(response.data);

			} else {

				$("#policyTableBody").html(
					`<tr>
						<td colspan="15" class="text-center">
							No data available
						</td>
					</tr>`
				);
			}
		},

		error: function (xhr, status, error) {

			console.error("❌ Error fetching policies:", error);

			alert("Failed to load policy data.");
		}
	});


	// =========================================================
	// Find Policy By Policy Code
	// =========================================================
	$("#findBtn").click(function () {

		const policyCode = $("#policyCode").val();

		if (!policyCode) {

			$("#policyTableBody").empty();

			return;
		}


		$.ajax({
			url: "api/Policymangment/getFullMaturityByPolicyCode",
			method: "GET",
			data: {
				policyCode: policyCode
			},
			dataType: "json",

			success: function (response) {

				console.log("✅ Response:", response);

				if (response.status === "OK" && response.data) {

					loadPolicyTable(response.data);

				} else {

					alert("No data found for the selected policy.");

					$("#policyTableBody").empty();
				}
			},

			error: function (xhr) {

				console.error("❌ Error:", xhr);

				alert("Error while fetching policy data.");
			}
		});

	});

});


// =========================================================
// Print Certificate
// =========================================================
function printCertificate(policyData) {

	// Fill receipt template
	$("#rPolicyCode").text(
		policyData.policyCode || ''
	);

	$("#rCustomerName").text(
		policyData.customerName.toUpperCase() || ''
	);

	$("#rPaymentDate").text(
		policyData.paymentDate || ''
	);

	$("#rPolicyAmount").text(
		policyData.policyAmount || ''
	);

	$("#rPlanCode").text(
		policyData.planCode || ''
	);

	$("#rMaturityDate").text(
		policyData.maturityDate || ''
	);

	$("#rMaturityAmount").text(
		policyData.maturityAmount || ''
	);

	$("#rDuration").text(
		policyData.duration || ''
	);

	$("#rBranchName").text(
		policyData.branchName.toUpperCase() || ''
	);

	$("#rModeOfPayment").text(
		policyData.modeofPayment.toUpperCase() || ''
	);


	// Get receipt HTML
	const receiptContent =
		document.getElementById("receiptTemplate").innerHTML;


	// Open print window
	const printWindow =
		window.open("", "_blank", "width=800,height=600");


	printWindow.document.write(`

		<!DOCTYPE html>

		<html lang="en">

		<head>

			<meta charset="UTF-8">

			<title>RD Receipt</title>

			<style>

				body {
					font-family: 'Poppins', sans-serif;
					margin: 20px;
				}

				h2 {
					text-align: center;
					margin-bottom: 15px;
				}

				p {
					font-size: 14px;
					line-height: 1.6;
					margin: 4px 0;
				}

				hr {
					margin: 10px 0;
				}

			</style>

		</head>

		<body>

			${receiptContent}

			<script>

				window.onload = function() {

					window.print();

					window.close();

				};

			<\/script>

		</body>

		</html>

	`);

	printWindow.document.close();
}