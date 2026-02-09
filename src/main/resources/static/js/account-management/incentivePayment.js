$(document).ready(function(){
	$("#searchBtn").on("click", function () {

	    const agentCode = $("#agentCode").val().trim().toUpperCase();

	    if (agentCode === "") {
	        alert("Please Enter Code");
	        return;
	    }

	    $.ajax({
	        type: "POST",
	        url: "api/teammember/fetchTeamMemberDataByCode",
	        contentType: "application/json",
	        dataType: "json",
	        data: JSON.stringify({
	            teamMemberCode: agentCode
	        }),
	        success: function (response) {

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
	        error: function (xhr, status, error) {
	            console.error("Error:", error);
	            alert("Something went wrong while fetching data");
	        }
	    });

	});

});