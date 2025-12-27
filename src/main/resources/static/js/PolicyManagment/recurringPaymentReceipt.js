$(document).ready(function() {
	$.ajax({
		url: "api/Policymangment/getApprovedRDFromFullMaturity",
		type: "GET",
		success: function(response) {
			if (response.data && response.data.length > 0) {
				const policySelect = $("#policyCode");
				response.data.forEach(policy => {
					const optionText = `${policy.policyCode} - ${policy.customerName}`;
					policySelect.append(`<option value="${policy.policyCode}">${optionText}</option>`);
				});
			}
		},
		error: function() {
			alert("Failed to load policies.");
		}
	});

	$.ajax({
		url: "api/Policymangment/getApprovedRDFromFullMaturity",
		type: "GET",
		contentType: "application/json",
		success: function(response) {
			if (response.status === "OK") {
				var tbody = $("#policyTableBody");
				tbody.empty();
				$.each(response.data, function(index, item) {
					var row = `
		                    <tr style="font-family: 'Poppins', sans-serif;">
		                        <td>${index + 1}</td>
		                        <td>${item.policyCode || ''}</td>
		                        <td>${item.customerName || ''}</td>
		                        <td>${item.paymentDate || ''}</td>
								<td>${item.policyAmount || ''}</td>
		                        <td>${item.planCode || ''}</td>
		                        <td>${item.maturityDate || ''}</td>
		                        <td>${item.maturityAmount || ''}</td>
		                        <td>${item.duration || ''}</td>
		                        <td>${item.branchName || ''}</td>
		                        <td>${item.modeofPayment || ''}</td>
								<td>
								   <a href="#" class="print-btn" data-policy='${JSON.stringify(item)}' style="color: green;">
								   <i class="bi bi-printer-fill"></i>
								   </a>
								</td>
		                    </tr>`;
					tbody.append(row);
				});

				// ✅ Bind print button event
				$(".print-btn").off().on("click", function(e) {
					e.preventDefault();
					const policyData = $(this).data("policy");

					$("#certificateTemplate").show();
					printCertificate(policyData); // 🔹 यह आपकी पहले से बनी हुई function call है
				});

			} else {
				$("#policyTableBody").html(
					`<tr><td colspan="15" class="text-center">No data available</td></tr>`
				);
			}
		},
		error: function(xhr, status, error) {
			console.error("❌ Error fetching policies:", error);
			alert("Failed to load policy data.");
		}
	});

	$("#findBtn").click(function() {
		const policyCode = $("#policyCode").val();
		if (!policyCode) {
			$('#policyTableBody').empty();
			return;
		}

		$.ajax({
			url: 'api/Policymangment/getApprovedRDFromFullMaturity',
			method: 'GET',
			data: { policyCode: policyCode },
			dataType: 'json',
			success: function(response) {
				console.log("✅ Response:", response);

				if (response.status === "OK" && response.data) {
					const data = response.data;
					$('#policyTableBody').empty();

					// If response.data is an array (multiple records)
					const policies = Array.isArray(data) ? data : [data];

					policies.forEach((item, index) => {
						const newRow = `
						<tr style="font-family: 'Poppins', sans-serif;">
								                        <td>${index + 1}</td>
								                        <td>${item.policyCode || ''}</td>
								                        <td>${item.customerName || ''}</td>
								                        <td>${item.paymentDate || ''}</td>
														<td>${item.policyAmount || ''}</td>
								                        <td>${item.planCode || ''}</td>
								                        <td>${item.maturityDate || ''}</td>
								                        <td>${item.maturityAmount || ''}</td>
								                        <td>${item.duration || ''}</td>
								                        <td>${item.branchName || ''}</td>
								                        <td>${item.modeofPayment || ''}</td>
														<td>
														   <a href="#" class="print-btn" data-policy='${JSON.stringify(item)}' style="color: green;">
														   <i class="bi bi-printer-fill"></i>
														   </a>
														</td>
								                    </tr>`;
						$('#policyTableBody').append(newRow);
					});

					// Bind print for all rows
					$(".print-btn").off().on("click", function(e) {
						e.preventDefault();
						const policyData = $(this).data("policy");
						printCertificate(policyData);
					});

					// Fill certificate preview with the first record
					const first = policies[0];
					$("#certClientName").text(first.clientName || first.customerName || '');
					$("#certPolicyCode").text(first.policyCode || '');
					$("#certPolicyAmount").text(first.policyAmount || '');
					$("#certMaturityAmount").text(first.maturityAmount || '');
					$("#certMaturityDate").text(first.maturityDate || '');
					$("#certContact").text(first.contactNo || '');
					$("#certNominee").text(first.suggestedNominee || '');
					$("#certAddress").text(first.address || '');

				} else {
					alert("No data found for the selected policy.");
					$('#policyTableBody').empty();
				}
			},
			error: function(xhr) {
				console.error("❌ Error:", xhr);
				alert("Error while fetching policy data.");
			}
		});
	});

});

function printCertificate(policyData) {
	// Fill receipt template with policy data
	$("#rPolicyCode").text(policyData.policyCode || '');
	$("#rCustomerName").text(policyData.customerName || '');
	$("#rPaymentDate").text(policyData.paymentDate || '');
	$("#rPolicyAmount").text(policyData.policyAmount || '');
	$("#rPlanCode").text(policyData.planCode || '');
	$("#rMaturityDate").text(policyData.maturityDate || '');
	$("#rMaturityAmount").text(policyData.maturityAmount || '');
	$("#rDuration").text(policyData.duration || '');
	$("#rBranchName").text(policyData.branchName || '');
	$("#rModeOfPayment").text(policyData.modeofPayment || '');

	// Get the filled receipt content
	const receiptContent = document.getElementById("receiptTemplate").innerHTML;

	// Open new window for printing with UTF-8
	const printWindow = window.open("", "_blank", "width=800,height=600");
	printWindow.document.write(`
        <!DOCTYPE html>
        <html lang="en">
        <head>
            <meta charset="UTF-8">
            <title>RD Receipt</title>
            <style>
                body { font-family: 'Poppins', sans-serif; margin: 20px; }
                h2 { text-align: center; margin-bottom: 15px; }
                p { font-size: 14px; line-height: 1.6; margin: 4px 0; }
                hr { margin: 10px 0; }
            </style>
        </head>
        <body>
            ${receiptContent}
            <script>
                window.onload = function() { 
                    window.print(); 
                    window.close(); 
                }
            </script>
        </body>
        </html>
    `);
	printWindow.document.close();
}
