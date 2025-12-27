$(document).ready(function() {
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