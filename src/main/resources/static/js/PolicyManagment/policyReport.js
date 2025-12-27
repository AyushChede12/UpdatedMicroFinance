$(document).ready(function() {
	const $policyDropdown = $('#findByPolicyNumber');

	// Clear and set default option
	$policyDropdown.empty().append('<option value="">Select Policy Code</option>');

	// Fetch approved policy data
	fetchApprovedPolicies();

	function fetchApprovedPolicies() {
		$.ajax({
			url: 'api/Policymangment/getApprovedPolicies',
			method: 'GET',
			success: function(response) {
				if (response.status === 'OK' && Array.isArray(response.data)) {
					response.data.forEach(item => {
						const policyNumber = (item.policyCode || item.policyNumber || '').trim();
						const clientName = (item.clientName || item.customerName || 'Unknown').trim();


						if (policyNumber) {
							$policyDropdown.append(
								`<option value="${policyNumber}">
                                    ${policyNumber} - ${clientName}
                                </option>`
							);
						}
					});
				} else {
					console.warn('No approved policies found.');
				}
			},
			error: function(xhr, status, error) {
				console.error('Error fetching approved policies:', error);
			}
		});
	}
});


function toggleTransaction() {
	const policyCode = document.getElementById("findByPolicyNumber").value;

	if (!policyCode) {
		alert("Please select a Policy Code first.");
		return;
	}

	fetch(`api/Policymangment/getPolicyByPolicyCode?policyCode=${policyCode}`)
		.then(response => {
			if (!response.ok) {
				throw new Error("Policy not found");
			}
			return response.json();
		})
		.then(data => {
			const policy = data.data;

			// Fill all the spans with policy data
			document.getElementById("branchCodeSpan").textContent = policy.branchName || "";
			document.getElementById("docSpan").textContent = policy.policyStartDate || "";
			document.getElementById("policyNoSpan").textContent = policy.policyCode || "";
			document.getElementById("memberCodeSpan").textContent = policy.memberSelection || "";
			document.getElementById("applicantNameSpan").textContent = policy.customerName || "";
			document.getElementById("fatherNameSpan").textContent = policy.relationDetails || "";
			document.getElementById("nomineeNameSpan").textContent = policy.suggestedNominee || "";
			document.getElementById("addressSpan").textContent = policy.address || "";
			document.getElementById("schemeSpan").textContent = policy.schemeType || "";
			document.getElementById("planSpan").textContent = policy.schemeCode || "";
			document.getElementById("relationshipSpan").textContent = policy.relation || "";
			document.getElementById("roiSpan").textContent = policy.roi || "";
			document.getElementById("modeSpan").textContent = policy.schemeMode || "";
			document.getElementById("maturitySpan").textContent = policy.maturityAmount || "";
			document.getElementById("renewalAmountSpan").textContent = policy.paidAmount || "";
			document.getElementById("totalValueSpan").textContent = policy.depositAmount || "";
			document.getElementById("termSpan").textContent = policy.schemeTerm || "";
			document.getElementById("maturityDateSpan").textContent = policy.maturityDate || "";
			document.getElementById("mobileSpan").textContent = policy.contactNo || "";
			document.getElementById("collectorSpan").textContent = policy.agent || "";

			// Show the transaction section
			document.getElementById("transactionSection").style.display = "block";
		})
		.catch(error => {
			alert("Error fetching policy data: " + error.message);
			console.error("Error:", error);
		});
}



function printTransactionSection() {
	const content = document.getElementById("transactionSection").innerHTML;

	const printWindow = window.open('', '', 'height=800,width=1000');
	printWindow.document.write('<html><head><title>Transaction Receipt</title>');

	// Optional styling for print
	printWindow.document.write(`
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            p {
                margin: 5px 0;
            }
            h1 {
                text-align: center;
            }
            hr {
                margin: 10px 0;
                border: 1px solid black;
            }
            .d-flex {
                display: flex;
                justify-content: space-between;
            }
        </style>
    `);

	printWindow.document.write('</head><body>');
	printWindow.document.write(content);
	printWindow.document.write('</body></html>');

	printWindow.document.close();
	printWindow.focus();

	printWindow.onload = function() {
		printWindow.print();
		printWindow.close();
	};
}


$(document).ready(function() {
	const $policyDropdown = $('#findPolicyNumber');

	// Clear and set default option
	$policyDropdown.empty().append('<option value="">Select Policy Code</option>');

	// Fetch approved policy data
	fetchApprovedPolicies();

	function fetchApprovedPolicies() {
		$.ajax({
			url: 'api/Policymangment/getApprovedPolicies',
			method: 'GET',
			success: function(response) {
				if (response.status === 'OK' && Array.isArray(response.data)) {
					response.data.forEach(item => {
						const policyNumber = (item.policyCode || item.policyNumber || '').trim();
						const clientName = (item.clientName || item.customerName || 'Unknown').trim();


						if (policyNumber) {
							$policyDropdown.append(
								`<option value="${policyNumber}">
                                    ${policyNumber} - ${clientName}
                                </option>`
							);
						}
					});
				} else {
					console.warn('No approved policies found.');
				}
			},
			error: function(xhr, status, error) {
				console.error('Error fetching approved policies:', error);
			}
		});
	}
});

$(document).ready(function() {
	$('#policyTableBody').on('click', '.print-btn', function(e) {
		e.preventDefault(); // ✅ Prevent page reload

		const $row = $(this).closest('tr');

		const policyCode = $row.find('td:eq(0)').text();
		const customerName = $row.find('td:eq(1)').text();
		const policyAmount = $row.find('td:eq(2)').text();
		const renewalDate = $row.find('td:eq(3)').text();
		const policyType = $row.find('td:eq(4)').text();
		const maturityAmount = $row.find('td:eq(5)').text();
		const depositAmount = $row.find('td:eq(6)').text();
		const policyDate = $row.find('td:eq(7)').text();
		const policyTerm = $row.find('td:eq(8)').text();
		const maturityDate = $row.find('td:eq(9)').text();
		const customerCode = $row.find('td:eq(10)').text();
		const contactNo = $row.find('td:eq(11)').text();
		const totalDeposit = $row.find('td:eq(12)').text();
		const paymentDue = $row.find('td:eq(13)').text();
		const noOfInstPaid = $row.find('td:eq(14)').text();
		const isApproved = $row.find('td:eq(15)').text();
		const branchname = $row.find('td:eq(16)').text();

		// Populate spans
		$('#policyNoSpan').text(policyCode);
		$('#applicantNameSpan').text(customerName);
		$('#renewalAmountSpan').text(policyAmount);
		$('#docSpan').text(policyDate);
		$('#planSpan').text(policyType);
		$('#maturitySpan').text(maturityAmount);
		$('#totalValueSpan').text(totalDeposit);
		$('#termSpan').text(policyTerm);
		$('#maturityDateSpan').text(maturityDate);
		$('#memberCodeSpan').text(customerCode);
		$('#mobileSpan').text(contactNo);
		$('#branchCodeSpan').text(branchname);
		$('#paymentDueSpan').text(paymentDue);
		$('#approvedSpan').text(isApproved);
		$('#installmentsPaidSpan').text(noOfInstPaid);
		// lastPaymentDate, dueDate, modeOfPayment, fees are missing from your table

		// Scroll to transaction section
		$('html, body').animate({
			scrollTop: $('#transactionSection').offset().top
		}, 500);
	});
});

$("#findBtn").click(function() {
    const policyCode = $("#findPolicyNumber").val();

    if (!policyCode) {
        $('#policyTableBody').empty();
        return;
    }

    $.ajax({
        url: 'api/Policymangment/findPolicyData',  // ✅ endpoint
        method: 'GET',
        data: { policyCode: policyCode },          // ✅ pass as query param
        dataType: 'json',                          // ✅ specify dataType
        success: function(response) {
            if (response.status === "OK" && Array.isArray(response.data) && response.data.length > 0) {
                const dataList = response.data;

                $('#policyTableBody').empty();

                dataList.forEach(function(data) {

                    const newRow = `
                        <tr>
                            <td>${data.policyCode || ''}</td>
                            <td>${data.clientName || data.customerName || ''}</td>
                            <td>${data.policyAmount || ''}</td>
                            <td>${data.renewalDate || ''}</td>
                            <td>${data.policyType || ''}</td>
                            <td>${data.maturityAmount || ''}</td>
                            <td>${data.totalDeposit || ''}</td>
                            <td>${data.policyDate || ''}</td>
                            <td>${data.policyTerm || ''}</td>
                            <td>${data.maturityDate || ''}</td>
                            <td>${data.customerCode || ''}</td>
                            <td>${data.contactNo || ''}</td>
                            <td>${data.totalDeposit || ''}</td>
                            <td>${data.paymentDue || ''}</td>
                            <td>${data.noOfInstPaid || ''}</td>
                            <td>${data.approved==true ? 'Yes' : 'No'}</td>
                            <td>${data.branchname || ''}</td>
                            <td><button class="btn btn-primary print-btn">Print</button></td>
                        </tr>`;
                    $('#policyTableBody').append(newRow);
                });
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



