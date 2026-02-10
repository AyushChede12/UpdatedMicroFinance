$(document).ready(function() {
	$("#searchBtn").on("click", function() {

		const agentCode = $("#agentCode").val().trim().toUpperCase();

		if (agentCode === "") {
			alert("Please Enter Code");
			return;
		}
		if (agentCode.startsWith("TM")) {

			$.ajax({
				type: "POST",
				url: "api/teammember/fetchTeamMemberDataByCode",
				contentType: "application/json",
				dataType: "json",
				data: JSON.stringify({
					teamMemberCode: agentCode
				}),
				success: function(response) {

					console.log("Response:", response);

					if (response.length === 0) {
						alert("No Team Member Found");
						return;
					}

					// Example: bind first record
					const data = response[0];

					$("#fullName").val(data.teamMemberName);
					$("#designation").val(data.designation);

				},
				error: function(xhr, status, error) {
					console.error("Error:", error);
					alert("Something went wrong while fetching data");
				}
			});
		}
		else {
			if (agentCode !== "") {
				$.ajax({
					url: 'api/customersavings/fetchfinancialcode?financialCode=' + encodeURIComponent(agentCode), // Pass as query param
					type: 'GET',
					success: function(response) {
						if (response.status === "FOUND") {
							let customer = response.data[0];
							$("#fullName").val(customer.financialName);
							$("#designation").val("NA");
						} else {
							alert('No data found!');
							$('#fullName').val('');
							$("#designation").val('');
						}
					},
					error: function() {
						alert('Error while fetching data!');
					}
				});
			} else {
				$('#financialConsultantName').val('');
			}

		}

	});


});