//js for populating the loan id's in the dropdown(Vaibhav)
$(document).ready(function() {
	populateLoanIdDropdown();
});

//js for populating the loan id's in the dropdown(Vaibhav) 
function populateLoanIdDropdown() {
	$.ajax({
		url: "api/loanmanegment/getStatementLoanId",
		type: "GET",
		dataType: "json",
		success: function(response) {
			console.log("Loan ID response:", response); // for debugging

			if (response.status === "OK" && Array.isArray(response.data)) {
				const $dropdown = $("#loanStatementID"); // Make sure this matches your HTML ID exactly
				$dropdown.empty(); // Clear existing options

				// ✅ Wrap your <option> in quotes!
				$dropdown.append('<option value="" disabled selected>Select Loan ID</option>');

				response.data.forEach(function(id) {
					$dropdown.append(`<option value="${id}">${id}</option>`);
				});
			} else {
				console.warn("No Loan IDs found in response.");
			}
		},
		error: function(xhr, status, error) {
			console.error("Error fetching Loan IDs:", error);
		}
	});
}

//Js for printing andbindng the loan Statement(Vaibhav)
$(document).ready(function() {

	$("#searchLoanStatement").click(function(e) {
		e.preventDefault();

		var loanId = $("#loanStatementID").val().trim();
		if (!loanId) {
			alert("Please enter a Loan ID");
			return;
		}

		$.ajax({
			url: "api/loanmanegment/fetchLoanStatement?loanId=" + loanId,
			method: "GET",
			success: function(response) {
				console.log("Response:", response);  // ✅ Debugging

				if (response.data && response.data.length > 0) {
					var first = response.data[0];

					var detailsHtml = `
    <div style="border:1px dashed #333; padding:15px; border-radius:10px;">
        <!-- Header with Loan Statement + Print Button -->
        <div style="display:flex; justify-content:space-between; align-items:center;">
            <h4 style="margin:0;">Loan Statement</h4>
            <button onclick="loanStatement()"  
                style="padding:6px 12px; border:none; background:#007bff; color:#fff; border-radius:6px; cursor:pointer;">
                Print
            </button>
        </div>

        <!-- Customer Name and Loan Type in same row -->
        <div style="display:flex; justify-content:space-between; margin-top:10px;">
            <p><b>Customer Name:</b> ${first.memberName}</p>
            <p><b>Interest Type:</b> ${first.interestType}</p>
        </div>

        <div style="display:flex; justify-content:space-between; margin-top:10px;">
           <p><b>Loan ID:</b> ${first.loanId}</p>
           <p style="margin-left:5px;"><b>Plan Name:</b> ${first.loanPlanName}</p>
        </div>
        <hr/>

        <h5>Payments</h5>
        <div style="display:grid; grid-template-columns: 1fr 1fr 1fr 1fr 1fr; font-weight:bold; border-bottom:2px solid #000; padding:6px 0;">
            <div>Payment Date</div>
			<div>Installment No.</div>
            <div>Amount Paid</div>
            <div>Amount Due</div>
            <div>Payment Status</div>
        </div>
   
                    `;

					// Add data rows
					response.data.forEach(function(txn) {
    detailsHtml += `
        <div style="display:grid; grid-template-columns: 1fr 1fr 1fr 1fr 1fr; border-bottom:1px solid #ccc; padding:5px 0;">
            <div>${txn.paymentDate}</div>
            <div>${txn.remarks}</div>
            <div>${txn.emiPayment}</div>
            <div>${Number(txn.amountDue).toFixed(2)}</div>
            <div style="padding-left:50px;">${txn.paymentStatus}</div>
        </div>
    `;
});

					detailsHtml += "</div>";
					$(".recent-sales").html(detailsHtml);

				} else {
					$(".recent-sales").html("<p style='color:red;'>No data found for this Loan ID</p>");
				}
			},
			error: function(xhr, status, error) {
				$(".recent-sales").html("<p style='color:red;'>Error fetching data</p>");
			}
		});
	});

});

function loanStatement() {
	var printContents = document.getElementById("receiptArea").innerHTML;
	var printWindow = window.open('', '', 'height=600,width=800');
	printWindow.document.write(printContents);
	printWindow.document.write('</body></html>');
	printWindow.document.close();
	printWindow.print();
}
