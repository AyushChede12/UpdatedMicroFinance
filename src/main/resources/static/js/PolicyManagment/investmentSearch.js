$(document).ready(function() {
	$.ajax({
		url: 'api/Policymangment/getAllPolicyManagementData',
		type: 'GET',
		success: function(response) {
			// Check if response has data array inside `data`
			if (response && response.data && Array.isArray(response.data) && response.data.length > 0) {
				let policyOptions = response.data.map(function(item) {
					return {
						id: item.policyCode,
						text: item.policyCode + " - " + item.customerName
					};
				});

				$('#policyCode').select2({
					placeholder: '-- Search Policy Code or Name --',
					data: policyOptions,
					matcher: function(params, data) {
						if ($.trim(params.term) === '') return data;
						if (typeof data.text === 'undefined') return null;

						const term = params.term.toLowerCase();
						const text = data.text.toLowerCase();
						return text.includes(term) ? data : null;
					}
				});
			} else {
				alert("No Policy found.");
			}
		},
		error: function(xhr, status, error) {
			console.error("Error fetching Policies:", error);
			alert("Failed to load Policy codes.");
		}
	});

	$.ajax({
		url: "api/Policymangment/getAllPolicyManagementData",
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
	                        <td>${item.policyStartDate || ''}</td>
	                        <td>${item.contactNo || ''}</td>
	                        <td>${item.address || ''}</td>
	                        <td>${item.district || ''}</td>
	                        <td>${item.state || ''}</td>
	                        <td>${item.branchName || ''}</td>
	                        <td>${item.schemeType || ''}</td>
	                        <td>${item.policyAmount || ''}</td>
	                        <td>${item.maturityAmount || ''}</td>
	                        <td>${item.paymentBy || ''}</td>
	                        <td>${item.approved == true ? 'Approved' : 'Pending'}</td>
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
		                    <td>1</td>
		                    <td>${data.policyCode || ''}</td>
		                    <td>${data.customerName || ''}</td>
		                    <td>${data.policyStartDate || ''}</td>
		                    <td>${data.contactNo || ''}</td>
		                    <td>${data.address || ''}</td>
		                    <td>${data.district || ''}</td>
		                    <td>${data.state || ''}</td>
		                    <td>${data.branchName || ''}</td>
		                    <td>${data.schemeType || ''}</td>
		                    <td>${data.policyAmount || ''}</td>
		                    <td>${data.maturityAmount || ''}</td>
		                    <td>${data.paymentBy || ''}</td>
		                    <td>${(data.approved === true || data.approved === 'true' || data.approved === 1) ? 'Approved' : 'Pending'}</td>
		                </tr>`;
					$('#policyTableBody').append(newRow);

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