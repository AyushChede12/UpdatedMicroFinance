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
	const policyCode = (document.getElementById("findByPolicyNumber").value || "").trim();

	if (!policyCode) {
		alert("Please select a Policy Code first.");
		return;
	}

	fetch(`api/Policymangment/getPolicyByPolicyCode?policyCode=${encodeURIComponent(policyCode)}`)
		.then(response => {
			if (!response.ok) {
				throw new Error("Policy not found");
			}
			return response.json();
		})
		.then(data => {
			const policy = data.data;

			// Fill all the spans with policy data (existing logic – unchanged)
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

			// ── Styling update: mirror span values into the visible display cells ──
			var f = function(id) { var el = document.getElementById(id); return el ? el.textContent.trim() : ""; };
			document.getElementById("disp-branchCode").textContent    = f("branchCodeSpan");
			document.getElementById("disp-doc").textContent           = f("docSpan");
			document.getElementById("disp-policyNo").textContent      = f("policyNoSpan");
			document.getElementById("disp-memberCode").textContent    = f("memberCodeSpan");
			document.getElementById("disp-applicantName").textContent = f("applicantNameSpan");
			document.getElementById("disp-fatherName").textContent    = f("fatherNameSpan");
			document.getElementById("disp-nomineeName").textContent   = f("nomineeNameSpan");
			document.getElementById("disp-address").textContent       = f("addressSpan");
			document.getElementById("disp-mobile").textContent        = f("mobileSpan");
			document.getElementById("disp-relationship").textContent  = f("relationshipSpan");
			document.getElementById("disp-scheme").textContent        = f("schemeSpan");
			document.getElementById("disp-plan").textContent          = f("planSpan");
			document.getElementById("disp-roi").textContent           = f("roiSpan");
			document.getElementById("disp-mode").textContent          = f("modeSpan");
			document.getElementById("disp-term").textContent          = f("termSpan");
			document.getElementById("disp-maturityDate").textContent  = f("maturityDateSpan");
			document.getElementById("disp-renewalAmount").textContent = f("renewalAmountSpan");
			document.getElementById("disp-totalValue").textContent    = f("totalValueSpan");
			document.getElementById("disp-maturity").textContent      = f("maturitySpan");
			document.getElementById("disp-collector").textContent     = f("collectorSpan");

			// Set the on-screen date stamps
			var now = new Date();
			var dateStr = now.toLocaleDateString('en-GB');
			var el1 = document.getElementById("irb-print-date");
			if (el1) el1.textContent = "DATE: " + dateStr;
			var el2 = document.getElementById("irb-footer-date");
			if (el2) el2.textContent = now.toLocaleString();

			// Show the transaction section
			document.getElementById("transactionSection").style.display = "block";
		})
		.catch(error => {
			alert("Error fetching policy data: " + error.message);
			console.error("Error:", error);
		});
}

// ── Helper: builds the styled print HTML for Installment Record Book ──
function _buildIrbPrintHtml(autoPrint) {
	var f = function(id) { var el = document.getElementById(id); return el ? el.textContent.trim() : ""; };

	var now = new Date();
	var dateStr = now.toLocaleDateString('en-GB');

	return `<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>Installment Record Book</title>
	<style>
		@page {
			size: A4;
			margin: 12mm 15mm 12mm 15mm;
		}
		* {
			-webkit-print-color-adjust: exact !important;
			print-color-adjust: exact !important;
			color-adjust: exact !important;
			box-sizing: border-box;
		}
		body {
			font-family: 'Segoe UI', Arial, sans-serif;
			color: #222;
			line-height: 1.35;
			margin: 0;
			padding: 10px;
			background: #fff;
		}

		/* ── Header ── */
		.header-box {
			text-align: center;
			border-bottom: 2.5px solid #0d6efd;
			padding-bottom: 8px;
			margin-bottom: 12px;
		}
		.header-box h2 {
			margin: 0;
			color: #0d6efd;
			text-transform: uppercase;
			font-size: 20px;
			letter-spacing: 0.5px;
		}
		.header-box p {
			margin: 2px 0;
			font-size: 11px;
			color: #555;
		}

		/* ── Title bar ── */
		.report-title-bar {
			background: #0d6efd !important;
			color: #ffffff !important;
			padding: 5px 10px;
			font-weight: bold;
			font-size: 12px;
			text-transform: uppercase;
			margin-bottom: 10px;
			display: flex;
			justify-content: space-between;
			border-radius: 3px;
		}

		/* ── Section headings ── */
		.section-heading {
			background: #e9ecef !important;
			color: #0d6efd;
			font-size: 11.5px;
			font-weight: bold;
			padding: 3px 8px;
			border-left: 4px solid #0d6efd;
			margin-top: 10px;
			margin-bottom: 5px;
			text-transform: uppercase;
		}

		/* ── Data tables ── */
		.meta-table {
			width: 100%;
			border-collapse: collapse;
			margin-bottom: 4px;
		}
		.meta-table th {
			background: #f1f4f9 !important;
			text-align: left;
			padding: 5px 8px;
			font-size: 11px;
			width: 22%;
			border: 1px solid #ced4da;
			color: #222;
			font-weight: 600;
			vertical-align: middle;
		}
		.meta-table td {
			padding: 5px 8px;
			font-size: 11.5px;
			border: 1px solid #ced4da;
			vertical-align: middle;
			color: #333;
		}

		/* ── Authorized signature ── */
		.auth-row {
			display: flex;
			justify-content: flex-end;
			align-items: center;
			margin-top: 28px;
			gap: 14px;
		}
		.auth-row span {
			font-size: 10.5px;
			font-weight: 600;
			text-transform: uppercase;
			color: #444;
			white-space: nowrap;
		}
		.auth-row hr {
			border: none;
			border-top: 1px solid #333;
			width: 180px;
			margin: 0;
		}

		/* ── Footer ── */
		.footer-note {
			text-align: center;
			margin-top: 14px;
			font-size: 9.5px;
			color: #777;
			border-top: 1px dashed #bbb;
			padding-top: 6px;
		}

		/* Hide print/download buttons when printing */
		.irb-print-actions { display: none !important; }
	</style>
</head>
<body>

	<div class="header-box">
		<h2>SAMITHA URBAN NIDHI LTD.</h2>
		<p>ADDRESS : NAGPUR (440024) - MAHARASHTRA</p>
	</div>

	<div class="report-title-bar">
		<span>SAMITHA URBAN NIDHI LTD. — INSTALLMENT RECORD BOOK</span>
		<span>DATE: ${dateStr}</span>
	</div>

	<!-- Section 1: Policy Identification -->
	<div class="section-heading">Policy Identification</div>
	<table class="meta-table">
		<tr>
			<th>BRANCH &amp; CODE</th><td>${f("branchCodeSpan")}</td>
			<th>DOC / START DATE</th><td>${f("docSpan")}</td>
		</tr>
		<tr>
			<th>POLICY NO.</th><td>${f("policyNoSpan")}</td>
			<th>MEMBER CODE</th><td>${f("memberCodeSpan")}</td>
		</tr>
	</table>

	<!-- Section 2: Applicant Details -->
	<div class="section-heading">Applicant Details</div>
	<table class="meta-table">
		<tr>
			<th>APPLICANT NAME</th><td colspan="3">${f("applicantNameSpan")}</td>
		</tr>
		<tr>
			<th>FATHER / HUSBAND NAME</th><td>${f("fatherNameSpan")}</td>
			<th>NOMINEE NAME</th><td>${f("nomineeNameSpan")}</td>
		</tr>
		<tr>
			<th>ADDRESS</th><td colspan="3">${f("addressSpan")}</td>
		</tr>
		<tr>
			<th>MOBILE NO.</th><td>${f("mobileSpan")}</td>
			<th>RELATIONSHIP</th><td>${f("relationshipSpan")}</td>
		</tr>
	</table>

	<!-- Section 3: Scheme & Plan Details -->
	<div class="section-heading">Scheme &amp; Plan Details</div>
	<table class="meta-table">
		<tr>
			<th>SCHEME</th><td>${f("schemeSpan")}</td>
			<th>PLAN</th><td>${f("planSpan")}</td>
		</tr>
		<tr>
			<th>ROI (%)</th><td>${f("roiSpan")}</td>
			<th>MODE</th><td>${f("modeSpan")}</td>
		</tr>
		<tr>
			<th>TERM</th><td>${f("termSpan")}</td>
			<th>MATURITY DATE</th><td>${f("maturityDateSpan")}</td>
		</tr>
	</table>

	<!-- Section 4: Financial Summary -->
	<div class="section-heading">Financial Summary</div>
	<table class="meta-table">
		<tr>
			<th>RENEWAL AMOUNT</th><td>${f("renewalAmountSpan")}</td>
			<th>TOTAL VALUE</th><td>${f("totalValueSpan")}</td>
		</tr>
		<tr>
			<th>MATURITY AMOUNT</th><td>${f("maturitySpan")}</td>
			<th>COLLECTOR NAME</th><td>${f("collectorSpan")}</td>
		</tr>
	</table>

	<!-- Authorized Signature -->
	<div class="auth-row">
		<span>AUTHORIZED SIGNATURE</span>
		<hr />
	</div>

	<div class="footer-note">
		This is a system-generated Installment Record from Samitha Urban Microfinance Banking System.
		Generated on ${now.toLocaleString()}.
	</div>

</body>
</html>`;
}

function printTransactionSection() {
	if (document.getElementById("transactionSection").style.display === "none") {
		alert("Please click TRANSACTION first to load the policy data.");
		return;
	}

	const printHtml = _buildIrbPrintHtml(true);
	const printWindow = window.open("", "_blank");
	if (printWindow) {
		printWindow.document.open();
		printWindow.document.write(printHtml);
		printWindow.document.close();
		setTimeout(function() {
			printWindow.focus();
			printWindow.print();
		}, 400);
	} else {
		alert("Pop-up blocked. Please allow pop-ups for this site to print.");
	}
}

function downloadTransactionRecord() {
	if (document.getElementById("transactionSection").style.display === "none") {
		alert("Please click TRANSACTION first to load the policy data.");
		return;
	}

	const downloadHtml = _buildIrbPrintHtml(false);
	const printWindow = window.open("", "_blank");
	if (printWindow) {
		printWindow.document.open();
		printWindow.document.write(downloadHtml);
		printWindow.document.close();
	} else {
		alert("Pop-up blocked. Please allow pop-ups for this site.");
	}
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
    const policyCode = ($("#findPolicyNumber").val() || "").trim();

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

                // ── Render each entry in the existing table ──
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



