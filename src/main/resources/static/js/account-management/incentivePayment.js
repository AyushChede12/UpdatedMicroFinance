$(document).ready(function() {

	// 🔹 Month name → month number
	const monthMap = {
		january: 1,
		february: 2,
		march: 3,
		april: 4,
		may: 5,
		june: 6,
		july: 7,
		august: 8,
		september: 9,
		october: 10,
		november: 11,
		december: 12
	};

	$("#searchBtn").on("click", function() {

		const agentCode = $("#agentCode").val().trim().toUpperCase();
		const incentiveMonthName = $("#incentiveMonth").val(); // january, august...

		if (agentCode === "") {
			alert("Please Enter Agent Code");
			return;
		}

		if (incentiveMonthName === "") {
			alert("Please Select Incentive Month");
			return;
		}

		// 🔹 Convert month name → number
		const month = monthMap[incentiveMonthName];
		const year = new Date().getFullYear(); // current year

		if (!month) {
			alert("Invalid Incentive Month");
			return;
		}

		// ================= TEAM MEMBER =================
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

					if (!response || response.length === 0) {
						alert("No Team Member Found");
						return;
					}

					const data = response[0];
					$("#fullName").val(data.teamMemberName);
					$("#designation").val(data.designation);

					// 🔥 Fetch Personal Sales
					fetchPersonalSalesAmount(agentCode, month, year);
				},
				error: function() {
					alert("Error fetching Team Member data");
				}
			});
		}

		// ================= FINANCIAL CONSULTANT =================
		else {

			$.ajax({
				type: "GET",
				url: "api/customersavings/fetchfinancialcode?financialCode=" + encodeURIComponent(agentCode),
				success: function(response) {

					if (response.status === "FOUND") {
						let customer = response.data[0];
						$("#fullName").val(customer.financialName);
						$("#designation").val("Financial Consultant");
						$("#personalSales").val("NA");
					} else {
						alert("No Financial Consultant Found");
					}
				},
				error: function() {
					alert("Error fetching Financial Consultant");
				}
			});
		}
	});
});


// ================= PERSONAL SALES API =================
$(document).ready(function() {

	// 🔹 Month name → month number
	const monthMap = {
		january: 1,
		february: 2,
		march: 3,
		april: 4,
		may: 5,
		june: 6,
		july: 7,
		august: 8,
		september: 9,
		october: 10,
		november: 11,
		december: 12
	};

	$("#searchBtn").on("click", function() {

		const agentCode = $("#agentCode").val().trim().toUpperCase();
		const incentiveMonthName = $("#incentiveMonth").val(); // january, august...

		if (agentCode === "") {
			alert("Please Enter Agent Code");
			return;
		}

		if (incentiveMonthName === "") {
			alert("Please Select Incentive Month");
			return;
		}

		// 🔹 Convert month name → number
		const month = monthMap[incentiveMonthName];
		const year = new Date().getFullYear(); // current year

		if (!month) {
			alert("Invalid Incentive Month");
			return;
		}

		// ================= TEAM MEMBER =================
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

					if (!response || response.length === 0) {
						alert("No Team Member Found");
						return;
					}

					const data = response[0];
					$("#fullName").val(data.teamMemberName);
					$("#designation").val(data.designation);

					// 🔥 Fetch Personal Sales
					var pSale=fetchPersonalSalesAmount(agentCode, month, year);

					var gSale=fetchGroupSalesAmount(agentCode, month, year);
					var oSale = pSale + gSale;
					$("#overallSales").val(oSale);
				},
				error: function() {
					alert("Error fetching Team Member data");
				}
			});
		}

		/*// ================= FINANCIAL CONSULTANT =================
		else {

			$.ajax({
				type: "GET",
				url: "api/customersavings/fetchfinancialcode?financialCode=" + encodeURIComponent(agentCode),
				success: function(response) {

					if (response.status === "FOUND") {
						let customer = response.data[0];
						$("#fullName").val(customer.financialName);
						$("#designation").val("Financial Consultant");
						$("#personalSales").val("NA");
					} else {
						alert("No Financial Consultant Found");
					}
				},
				error: function() {
					alert("Error fetching Financial Consultant");
				}
			});
		}*/
	});
});


// ================= PERSONAL SALES API =================
function fetchPersonalSalesAmount(teamMemberCode, month, year) {

	$.ajax({
		type: "POST",
		url: "accountManagement/personal-sales-amount",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify({
			teamMemberCode: teamMemberCode,
			month: month,
			year: year
		}),
		success: function(response) {

			if (response && response.personalSalesAmount !== undefined) {
				$("#personalSales").val(response.personalSalesAmount);
			} else {
				$("#personalSales").val(0);
			}
		},
		error: function() {
			$("#personalSales").val(0);
			alert("Error fetching Personal Sales");
		}
	});
}

function fetchGroupSalesAmount(teamMemberCode, month, year) {

	$.ajax({
		type: "POST",
		url: "accountManagement/group-sales",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify({
			teamMemberCode: teamMemberCode,
			month: month,
			year: year
		}),
		success: function(response) {
			if (response && response.groupSalesAmount !== undefined) {
				$("#groupSales").val(response.groupSalesAmount);
			} else {
				$("#groupSales").val(0);
			}
		},
		error: function() {
			$("#groupSales").val(0);
			alert("Error fetching Personal Sales");
		}
	});
}

