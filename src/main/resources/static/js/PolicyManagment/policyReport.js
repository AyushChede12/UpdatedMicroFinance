$(document).ready(function() {
	const $policyDropdown = $('#findByPolicyNumber');

	// Clear and set default option
	$policyDropdown.empty().append('<option value="">SELECT POLICY CODE</option>');

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
						const clientName = (item.clientName || item.customerName.toUpperCase() || 'Unknown').trim();


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
			document.getElementById("applicantNameSpan").textContent = policy.customerName ? policy.customerName.toUpperCase() : "";
			document.getElementById("fatherNameSpan").textContent = policy.relationDetails || "";
			document.getElementById("nomineeNameSpan").textContent = policy.suggestedNominee ? policy.suggestedNominee.toUpperCase() : "";
			document.getElementById("addressSpan").textContent = policy.address ? policy.address.toUpperCase() : "";
			document.getElementById("schemeSpan").textContent = policy.schemeType || "";
			document.getElementById("planSpan").textContent = policy.schemeCode || "";
			document.getElementById("relationshipSpan").textContent = policy.relation || "";
			document.getElementById("roiSpan").textContent = policy.roi || "";
			document.getElementById("modeSpan").textContent = policy.schemeMode ? policy.schemeMode.toUpperCase() : "";
			document.getElementById("maturitySpan").textContent = policy.maturityAmount || "";
			document.getElementById("renewalAmountSpan").textContent = policy.paidAmount || "";
			document.getElementById("totalValueSpan").textContent = policy.depositAmount || "";
			document.getElementById("termSpan").textContent = policy.schemeTerm || "";
			document.getElementById("maturityDateSpan").textContent = policy.maturityDate || "";
			document.getElementById("mobileSpan").textContent = policy.contactNo || "";
			document.getElementById("collectorSpan").textContent = policy.agent || "";

			// ------------------------------------------------
			// Fetch Company Details
			// ------------------------------------------------

			return fetch("api/preference/getCompanyDetails");

		})

		.then(response => {

			if (!response.ok) {

				throw new Error("Company details not found");
			}

			return response.json();
		})

		.then(company => {

			// Set Company Name
			document.querySelector("#transactionSection h1").textContent =
				company.companyName ? company.companyName.toUpperCase() : "MICROFINANCE SERVICES";

			// Set Company Address
			document.querySelector("#transactionSection h1 + p").textContent =
				company.address ? "ADDRESS : " + company.address.toUpperCase() : "";

			// Show the transaction section
			document.getElementById("transactionSection").style.display = "block";

		})

		.catch(error => {

			alert("Error fetching data: " + error.message);

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
	$policyDropdown.empty().append('<option value="">SELECT POLICY CODE</option>');

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
						const clientName = (item.customerName.toUpperCase() || 'Unknown').trim();


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

		e.preventDefault();

		const $button = $(this);
		const $row = $button.closest('tr');

		// Get Policy Code
		const policyCode = $.trim($row.find('td:eq(0)').text());


		if (!policyCode) {

			alert("Policy Code not found!");

			return;
		}


		// Disable button while loading
		$button
			.prop('disabled', true)
			.html('<i class="fa fa-spinner fa-spin"></i> Loading...');


		/*
		 * AJAX 1:
		 * Get Policy Details
		 */

		$.ajax({

			url: 'api/Policymangment/getPolicyByPolicyCode',

			method: 'GET',

			data: {
				policyCode: policyCode
			},

			dataType: 'json'


		}).done(function(policyResponse) {


			if (!policyResponse || !policyResponse.data) {

				alert("Policy data not found!");

				return;
			}


			const policy = policyResponse.data;


			/*
			 * AJAX 2:
			 * Get Company Details
			 */

			$.ajax({

				url: 'api/preference/getCompanyDetails',

				method: 'GET',

				dataType: 'json'


			}).done(function(company) {


				console.log("Company Details:", company);


				if (!company) {

					alert("Company details not found!");

					return;
				}


				/*
				 * COMPANY DETAILS
				 */

				const companyName =
					company.companyName || "COMPANY NAME";


				const companyAddressParts = [];


				if (company.address) {

					companyAddressParts.push(company.address);

				}


				if (company.city) {

					companyAddressParts.push(company.city);

				}


				if (company.state) {

					companyAddressParts.push(company.state);

				}


				if (company.pinCode) {

					companyAddressParts.push(company.pinCode);

				}


				const companyAddress =
					companyAddressParts.join(", ");


				const contactNumber =
					company.helplineNo || "-";


				const gstin =
					company.gstin || "-";


				/*
				 * OPEN PRINT WINDOW
				 */

				const printWindow = window.open(
					'',
					'_blank',
					'width=900,height=800'
				);


				if (!printWindow) {

					alert(
						"Please allow pop-ups for this website."
					);

					return;
				}


				/*
				 * PRINT SLIP
				 */

				const slip = `

<!DOCTYPE html>

<html>

<head>

    <title>INVESTMENT TRANSACTION SLIP</title>


    <style>

        * {
            box-sizing: border-box;
        }


        body {

            margin: 0;

            padding: 20px;

            font-family: Arial, Helvetica, sans-serif;

            background: #ffffff;

            color: #222;

        }


        .slip {

            width: 760px;

            margin: auto;

            border: 1px solid #222;

            padding: 25px;

            background: #fff;

        }


        /* =========================
           COMPANY HEADER
        ========================== */

        .company-header {

            text-align: center;

            padding-bottom: 15px;

            margin-bottom: 15px;

            border-bottom: 2px solid #222;

        }


        .company-name {

            font-size: 25px;

            font-weight: bold;

            text-transform: uppercase;

            letter-spacing: 0.5px;

            margin-bottom: 7px;

        }


        .company-address {

            font-size: 12px;

            color: #555;

            margin-bottom: 4px;

        }


        .company-contact {

            font-size: 12px;

            color: #555;

            margin-bottom: 4px;

        }


        .company-gstin {

            font-size: 12px;

            color: #555;

            font-weight: 500;

        }


        /* =========================
           SLIP TITLE
        ========================== */

        .slip-title {

            text-align: center;

            font-size: 19px;

            font-weight: bold;

            text-transform: uppercase;

            letter-spacing: 1px;

            margin: 18px 0;

        }


        /* =========================
           TRANSACTION INFO
        ========================== */

        .transaction-info {

            display: flex;

            justify-content: space-between;

            border: 1px solid #aaa;

            padding: 10px;

            margin-bottom: 18px;

            font-size: 13px;

        }


        /* =========================
           SECTION
        ========================== */

        .section-title {

            background: #343a40;

            color: white;

            padding: 8px 10px;

            font-size: 13px;

            font-weight: bold;

            text-transform: uppercase;

            margin-top: 15px;

        }


        /* =========================
           TABLE
        ========================== */

        table {

            width: 100%;

            border-collapse: collapse;

        }


        table td {

            border: 1px solid #ccc;

            padding: 9px 10px;

            font-size: 13px;

        }


        table td:first-child {

            width: 42%;

            font-weight: bold;

            background: #f5f5f5;

        }


        .amount {

            font-size: 16px;

            font-weight: bold;

        }


        /* =========================
           PAYMENT SUMMARY
        ========================== */

        .payment-box {

            margin-top: 18px;

            border: 1px solid #222;

            padding: 12px;

        }


        .payment-row {

            display: flex;

            justify-content: space-between;

            margin-bottom: 7px;

            font-size: 13px;

        }


        .payment-row:last-child {

            margin-bottom: 0;

        }


        /* =========================
           FOOTER
        ========================== */

        .footer {

            margin-top: 35px;

            display: flex;

            justify-content: space-between;

            font-size: 12px;

        }


        .signature {

            width: 180px;

            text-align: center;

            padding-top: 35px;

            border-top: 1px solid #222;

        }


        .thank-you {

            text-align: center;

            margin-top: 25px;

            font-size: 12px;

            font-weight: bold;

        }


        @media print {

            body {

                padding: 0;

            }


            .slip {

                width: 100%;

                border: 1px solid #222;

            }

        }

    </style>

</head>


<body>


<div class="slip">


    <!-- =========================
         COMPANY DETAILS
    ========================== -->

    <div class="company-header">


        <div class="company-name">

            ${companyName.toUpperCase()}

        </div>


        <div class="company-address">

            ${companyAddress.toUpperCase() || "-"}

        </div>


        <div class="company-contact">

            CONTACT: ${contactNumber}

        </div>


        <div class="company-gstin">

            GSTIN: ${gstin}

        </div>


    </div>



    <!-- =========================
         TITLE
    ========================== -->

    <div class="slip-title">

        INVESTMENT TRANSACTION SLIP

    </div>



    <!-- =========================
         TRANSACTION INFORMATION
    ========================== -->

    <div class="transaction-info">


        <div>

            <strong>POLICY CODE:</strong>

            ${policy.policyCode || "-"}

        </div>


        <div>

            <strong>DATE:</strong>

            ${policy.policyStartDate || "-"}

        </div>


    </div>



    <!-- =========================
         CUSTOMER DETAILS
    ========================== -->

    <div class="section-title">

        CUSTOMER DETAILS

    </div>


    <table>


        <tr>

            <td>CUSTOMER NAME</td>

            <td>

                ${(policy.customerName || "-").toUpperCase()}

            </td>

        </tr>


        <tr>

            <td>CUSTOMER CODE</td>

            <td>

                ${policy.memberSelection || "-"}

            </td>

        </tr>


        <tr>

            <td>CONTACT NUMBER</td>

            <td>

                ${policy.contactNo || "-"}

            </td>

        </tr>


        <tr>

            <td>ADDRESS</td>

            <td>

                ${(policy.address || "-").toUpperCase()}

            </td>

        </tr>


        <tr>

            <td>NOMINEE NAME</td>

            <td>

                ${(policy.suggestedNominee || "-").toUpperCase()}

            </td>

        </tr>


        <tr>

            <td>RELATIONSHIP</td>

            <td>

                ${policy.relation || "-"}

            </td>

        </tr>


    </table>



    <!-- =========================
         INVESTMENT DETAILS
    ========================== -->

    <div class="section-title">

        INVESTMENT DETAILS

    </div>


    <table>


        <tr>

            <td>POLICY CODE</td>

            <td>

                ${policy.policyCode || "-"}

            </td>

        </tr>


        <tr>

            <td>SCHEME TYPE</td>

            <td>

                ${policy.schemeType || "-"}

            </td>

        </tr>


        <tr>

            <td>SCHEME / PLAN</td>

            <td>

                ${policy.schemeCode || "-"}

            </td>

        </tr>


        <tr>

            <td>POLICY AMOUNT</td>

            <td class="amount">

                ₹ ${policy.paidAmount || "0"}

            </td>

        </tr>


        <tr>

            <td>DEPOSIT AMOUNT</td>

            <td class="amount">

                ₹ ${policy.depositAmount || "0"}

            </td>

        </tr>


        <tr>

            <td>RATE OF INTEREST</td>

            <td>

                ${policy.roi || "-"} %

            </td>

        </tr>


        <tr>

            <td>PAYMENT MODE</td>

            <td>

                ${(policy.schemeMode || "-").toUpperCase()}

            </td>

        </tr>


        <tr>

            <td>POLICY TERM</td>

            <td>

                ${policy.schemeTerm || "-"}

            </td>

        </tr>


        <tr>

            <td>START DATE</td>

            <td>

                ${policy.policyStartDate || "-"}

            </td>

        </tr>


        <tr>

            <td>MATURITY DATE</td>

            <td>

                ${policy.maturityDate || "-"}

            </td>

        </tr>


        <tr>

            <td>MATURITY AMOUNT</td>

            <td class="amount">

                ₹ ${policy.maturityAmount || "0"}

            </td>

        </tr>


    </table>



    <!-- =========================
         PAYMENT SUMMARY
    ========================== -->

    <div class="section-title">

        PAYMENT SUMMARY

    </div>


    <div class="payment-box">


        <div class="payment-row">

            <strong>TOTAL DEPOSIT</strong>

            <strong>

                ₹ ${policy.depositAmount || "0"}

            </strong>

        </div>


        <div class="payment-row">

            <span>RENEWAL AMOUNT</span>

            <span>

                ₹ ${policy.paidAmount || "0"}

            </span>

        </div>


        <div class="payment-row">

            <span>PAYMENT DUE</span>

            <span>

                ${policy.paymentDue || "-"}

            </span>

        </div>


    </div>



    <!-- =========================
         FOOTER
    ========================== -->

    <div class="footer">


        <div>

            <strong>BRANCH:</strong>

            ${policy.branchName || "-"}

            <br><br>


            <strong>AGENT / COLLECTOR:</strong>

            ${policy.agent || "-"}

        </div>


        <div class="signature">

            AUTHORIZED SIGNATURE

        </div>


    </div>



    <div class="thank-you">

        THANK YOU FOR YOUR INVESTMENT.

    </div>


</div>


<script>

    window.onload = function () {

        window.print();

    };

<\/script>


</body>

</html>

                `;


				printWindow.document.open();

				printWindow.document.write(slip);

				printWindow.document.close();


			}).fail(function(xhr) {

				console.error(
					"Company API Error:",
					xhr
				);

				alert(
					"Unable to fetch company details."
				);

			});


		}).fail(function(xhr) {

			console.error(
				"Policy API Error:",
				xhr
			);

			alert(
				"Unable to fetch policy details."
			);

		}).always(function() {

			$button
				.prop('disabled', false)
				.html(
					'<i class="fa fa-print"></i> Print'
				);

		});

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
                            <td>${data.clientName.toUpperCase() || ''}</td>
                            <td>${data.policyAmount || ''}</td>
                            <td>${data.renewalDate || ''}</td>
                            <td>${data.policyType.toUpperCase() || ''}</td>
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
                            <td>${data.isApproved == true ? 'YES' : 'NO'}</td>
                            <td>${data.branchname.toUpperCase() || ''}</td>
							<td>
							    <button type="button" class="btn btn-primary print-btn">
							        <i class="fa fa-print"></i> Print
							    </button>
							</td>
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



