$(document).ready(function() {
	$.ajax({
		url: "api/datacorrection/fetchAllApprovedLoanApplications",
		type: "GET",
		success: function(response) {
			console.log("API response:", response);
			var dropdown1 = $('#typeOfloan');
			dropdown1.empty();
			dropdown1.append('<option value="">--SELECT LOAN TYPE--</option>');

			if (response.status === "OK" && response.data) {
				$.each(response.data, function(index, item) {
					dropdown1.append('<option value="' + item.typeOfLoan + '">' + item.typeOfLoan.toUpperCase() + '</option>');
				});
			} else {
				dropdown1.append('<option value="">No Loan Type found</option>');
			}
		},
		error: function() {
			alert("Failed to fetch Loan Type.");
		}
	});
});