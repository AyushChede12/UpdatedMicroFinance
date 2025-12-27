$(document).ready(function() {
	$("#certificateTemplate").hide();

	// ✅ Utility function: fill & print certificate
	function printCertificate(data) {
		// Fill certificate template
		$("#certClientName").text(data.clientName || data.customerName || '');
		$("#certPolicyCode").text(data.policyCode || '');
		$("#certPolicyAmount").text(data.policyAmount || '');
		$("#certMaturityAmount").text(data.maturityAmount || '');
		$("#certMaturityDate").text(data.maturityDate || '');
		$("#certContact").text(data.contactNo || '');
		$("#certNominee").text(data.suggestedNominee || '');
		$("#certAddress").text(data.address || '');

		// Clone template into new window
		const certificateHTML = $("#certificateTemplate").html();
		const printWindow = window.open('', '', 'width=900,height=650');
		printWindow.document.write(`
            <html>
              <head>
                <title>Policy Certificate</title>
                <style>
                  body { font-family: Arial, sans-serif; margin: 20px; }
                </style>
              </head>
              <body>
                ${certificateHTML}
              </body>
            </html>
        `);
		printWindow.document.close();
		printWindow.print();
	}

	// ✅ Load dropdown with approved policies
	$.ajax({
		url: "api/Policymangment/getApprovedPolicies",
		type: "GET",
		dataType: "json",
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

	// ✅ Find button → fetch policy by code & show certificate + single row in table
	$("#findBtn").click(function() {
		$("#certificateTemplate").show();
		const policyCode = $("#policyCode").val();
		if (!policyCode) {
			$('#policyTableBody').empty();
			return;
		}

		$.ajax({
			url: 'api/Policymangment/getPolicyByPolicyCode',
			method: 'GET',
			data: { policyCode: policyCode },
			dataType: 'json',
			success: function(response) {
				console.log("✅ Response:", response);

				if (response.status === "OK" && response.data) {
					const data = response.data;
					$('#policyTableBody').empty();

					const newRow = `
                        <tr>
                          <td>${data.policyCode || ''}</td>
                          <td>${data.clientName || data.customerName || ''}</td>
                          <td>${data.policyAmount || ''}</td>
                          <td>${data.maturityDate || ''}</td>
                          <td>${data.maturityAmount || ''}</td>
                          <td>${data.contactNo || ''}</td>
                          <td>${data.suggestedNominee || ''}</td>
                          <td>${data.address || ''}</td>
                          <td>
                              <a href="#" class="print-btn" data-policy='${JSON.stringify(data)}' style="color: green;">
                                <i class="bi bi-printer-fill"></i>
                              </a>
                          </td>
                        </tr>`;
					$('#policyTableBody').append(newRow);

					// Bind print for this row
					$(".print-btn").off().on("click", function(e) {
						e.preventDefault();
						const policyData = $(this).data("policy");
						printCertificate(policyData);
					});

					// Fill certificate preview also
					$("#certClientName").text(data.clientName || data.customerName || '');
					$("#certPolicyCode").text(data.policyCode || '');
					$("#certPolicyAmount").text(data.policyAmount || '');
					$("#certMaturityAmount").text(data.maturityAmount || '');
					$("#certMaturityDate").text(data.maturityDate || '');
					$("#certContact").text(data.contactNo || '');
					$("#certNominee").text(data.suggestedNominee || '');
					$("#certAddress").text(data.address || '');

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

	// ✅ Load table with all approved policies
	$.ajax({
		url: "api/Policymangment/getApprovedPolicies",
		type: "GET",
		contentType: "application/json",
		success: function(response) {
			if (response.status === "OK") {
				var tbody = $("#policyTableBody");
				tbody.empty();
				$.each(response.data, function(index, item) {
					var row = `
                        <tr style="font-family: 'Poppins', sans-serif;">
                            <td>${item.policyCode || ''}</td>
                            <td>${item.customerName || ''}</td>
                            <td>${item.policyAmount || ''}</td>
                            <td>${item.maturityDate || ''}</td>
                            <td>${item.maturityAmount || ''}</td>
                            <td>${item.contactNo || ''}</td>
                            <td>${item.suggestedNominee || ''}</td>
                            <td>${item.address || ''}</td>
                            <td>
                                <a href="#" class="print-btn" data-policy='${JSON.stringify(item)}' style="color: green;">
                                    <i class="bi bi-printer-fill"></i>
                                </a>
                            </td>
                        </tr>`;
					tbody.append(row);
				});

				// ✅ Bind print-btn for all rows
				$(".print-btn").off().on("click", function(e) {
					e.preventDefault();
					const policyData = $(this).data("policy");
					$("#certificateTemplate").show();
					printCertificate(policyData);
				});

			} else {
				$(".datatable tbody").html(`<tr><td colspan="11" class="text-center">No data available</td></tr>`);
			}
		},
		error: function(xhr, status, error) {
			console.error("Error fetching policies:", error);
			alert("Failed to load financial consultant data.");
		}
	});
});
