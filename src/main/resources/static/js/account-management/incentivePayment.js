$(document).ready(function() {

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
		const incentiveMonthName = $("#incentiveMonth").val();

		if (!agentCode) {
			alert("Please Enter Agent Code");
			return;
		}

		if (!incentiveMonthName) {
			alert("Please Select Incentive Month");
			return;
		}

		const month = monthMap[incentiveMonthName];
		const year = new Date().getFullYear();

		if (!month) {
			alert("Invalid Month");
			return;
		}

		if (agentCode.startsWith("TM")) {
			fetchCompleteIncentiveData(agentCode, month, year);
		} else {
			alert("Invalid Agent Code Format");
		}

	});
	
	$("#payBtn").click(function () {
		alert("Pay btn");

	    // ✅ Validation
	    if (!$("#incentiveMonth").val()) {
	        alert("Please Select Incentive Month");
	        return;
	    }

	    if (!$("#agentCode").val()) {
	        alert("Agent Code Missing");
	        return;
	    }

	    if (!$("#branchName").val()) {
	        alert("Please Select Branch");
	        return;
	    }

	    if (!$("#paymentDate").val()) {
	        alert("Please Select Payment Date");
	        return;
	    }

	    if (!$("#modeOfPayment").val()) {
	        alert("Please Select Payment Mode");
	        return;
	    }

	    // ✅ Prepare Data According to Entity Fields
	    let data = {

	        incentiveMonth: $("#incentiveMonth").val(),
	        teamMemberCode: $("#agentCode").val(),

	        fullName: $("#fullName").val(),
	        designation: $("#designation").val(),

	        personalSales: $("#personalSales").val(),
	        groupSales: $("#groupSales").val(),
	        overallSales: $("#overallSales").val(),

	        totalEarnings: $("#totalEarnings").val(),
	        taxDeducted: $("#taxDeducted").val(),
	        serviceDeduction: $("#serviceDeduction").val(),
	        extraAllowance: $("#extraAllowance").val(),
	        finalPayout: $("#finalPayout").val(),

	        branchName: $("#branchName").val(),
	        paymentDate: $("#paymentDate").val(),
	        modeOfPayment: $("#modeOfPayment").val()
	    };

	    console.log("Sending Data:", data); // 🔍 Debug

	    $.ajax({
	        type: "POST",
	        url: "accountManagement/save-incentive-payment",
	        contentType: "application/json",
	        data: JSON.stringify(data),

	        success: function (response) {

	            console.log("Response:", response);

	            if (response.message === "Incentive Already Paid For This Month") {
	                alert("⚠ Incentive Already Paid For This Month");
	                return;
	            }

	            alert("✅ Incentive Payment Saved Successfully");

	            // Optional: clear form after success
	            // $("form")[0].reset();
	        },

	        error: function (xhr) {
	            console.log(xhr);
	            alert("❌ Error While Saving Payment");
	        }
	    });

	});


});


function fetchCompleteIncentiveData(agentCode, month, year) {

	$.ajax({
		type: "POST",
		url: "accountManagement/incentive-full-details",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify({
			teamMemberCode: agentCode,
			month: month,
			year: year
		}),
		success: function(response) {

			if (!response) {
				alert("No Data Found");
				return;
			}
			let data = response.data;

			if (response.status == "FOUND") {
				$("#fullName").val(data.fullName);
				$("#designation").val(data.designation);
				$("#personalSales").val(data.personalSales);
				$("#groupSales").val(data.groupSales);
				$("#overallSales").val(data.overallSales);
				$("#totalEarnings").val(data.totalEarnings);
				$("#taxDeducted").val(data.taxDeducted);
				$("#serviceDeduction").val(data.serviceDeduction);
				$("#extraAllowance").val(data.extraAllowance);
				$("#finalPayout").val(data.finalPayout);
			}
		},
		error: function() {
			alert("Error fetching Incentive Details");
		}
	});

}
