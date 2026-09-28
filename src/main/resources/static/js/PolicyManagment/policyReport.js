$(document).ready(function () {
	const $policyDropdown = $('#findByPolicyNumber');

	// Clear and set default option
	$policyDropdown.empty().append('<option value="">Select Policy Code</option>');

	// Fetch approved policy data
	fetchApprovedPolicies();

	function fetchApprovedPolicies() {
		$.ajax({
			url: 'api/Policymangment/getApprovedPolicies',
			method: 'GET',
			success: function (response) {
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
			error: function (xhr, status, error) {
				console.error('Error fetching approved policies:', error);
			}
		});
	}
});


// ── Helper: populate all hidden spans from a full policy object (AddnewinvestmentPM shape) ──
function _populateSpansFromPolicy(policy) {
	var set = function (id, val) {
		var el = document.getElementById(id);
		if (el) el.textContent = val || '';
	};
	set('branchCodeSpan', policy.branchName || '');
	set('docSpan', policy.policyStartDate || '');
	set('policyNoSpan', policy.policyCode || '');
	set('memberCodeSpan', policy.memberSelection || '');
	set('applicantNameSpan', policy.customerName || '');
	// Issue 2 fix: these fields exist in AddnewinvestmentPM but were never mapped in row-click path
	set('fatherNameSpan', policy.relationDetails || '');
	set('nomineeNameSpan', policy.suggestedNominee || '');
	set('addressSpan', policy.address || '');
	set('schemeSpan', policy.schemeType || '');
	// Issue 1 fix: use schemeName (plan name like "Life Access") not schemeCode (plan code like "MIS001")
	set('planSpan', policy.schemeName || policy.schemeCode || '');
	set('relationshipSpan', policy.relation || '');
	set('roiSpan', policy.roi || '');
	set('modeSpan', policy.schemeMode || '');
	set('maturitySpan', policy.maturityAmount || '');
	set('renewalAmountSpan', policy.paidAmount || '');
	set('totalValueSpan', policy.depositAmount || '');
	set('termSpan', policy.schemeTerm || '');
	set('maturityDateSpan', policy.maturityDate || '');
	set('mobileSpan', policy.contactNo || '');
	// Issue 6 fix: Collector Name must show customer name, not agent/collector code (e.g. FC0000)
	set('collectorSpan', policy.customerName || '');
}

function toggleTransaction() {
	const policyCode = (document.getElementById("findByPolicyNumber").value || "").trim();

	if (!policyCode) {
		alert("Please select a Policy Code first.");
		return;
	}

	// Use context path from meta tag so the URL works in deployment (e.g. /MicrofinanceDemo)
	var ctxPath = (document.querySelector('meta[name="baseUrl"]') || {}).content || '';
	fetch(ctxPath + '/api/Policymangment/getPolicyByPolicyCode?policyCode=' + encodeURIComponent(policyCode))
		.then(function(response) {
			if (!response.ok) throw new Error("Policy not found");
			return response.json();
		})
		.then(function(data) {
			_populateSpansFromPolicy(data.data);
			var now = new Date();
			var el1 = document.getElementById("irb-print-date");
			if (el1) el1.textContent = "DATE: " + now.toLocaleDateString('en-GB');
			var el2 = document.getElementById("irb-footer-date");
			if (el2) el2.textContent = now.toLocaleString();
			// Show the transaction section (it starts as display:none)
			var section = document.getElementById('transactionSection');
			if (section) section.style.display = 'block';
		})
		.catch(function(error) {
			alert("Error fetching policy data: " + error.message);
			console.error("Error:", error);
		});
}

// ── Helper: builds the styled print HTML for Installment Record Book ──
function _buildIrbPrintHtml(autoPrint) {
	var f = function (id) { var el = document.getElementById(id); return el ? el.textContent.trim() : ""; };

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
	var printHtml = _buildIrbPrintHtml(true);
	// Embed window.onload=print() inside the HTML so it auto-prints when the tab loads.
	// This avoids relying on printWindow.print() from the opener which browsers may block.
	printHtml = printHtml.replace('</body>', '<script>window.onload=function(){window.focus();window.print();}<\/script></body>');
	var printWindow = window.open('', '_blank');
	if (printWindow) {
		printWindow.document.open();
		printWindow.document.write(printHtml);
		printWindow.document.close();
	} else {
		alert('Pop-up blocked. Please allow pop-ups for this site to print.');
	}
}

function downloadTransactionRecord() {
	var downloadHtml = _buildIrbPrintHtml(false);
	var printWindow = window.open('', '_blank');
	if (printWindow) {
		printWindow.document.open();
		printWindow.document.write(downloadHtml);
		printWindow.document.close();
	} else {
		alert('Pop-up blocked. Please allow pop-ups for this site.');
	}
}


$(document).ready(function () {
	const $policyDropdown = $('#findPolicyNumber');

	// Clear and set default option
	$policyDropdown.empty().append('<option value="">Select Policy Code</option>');

	// Fetch approved policy data
	fetchApprovedPolicies();

	function fetchApprovedPolicies() {
		$.ajax({
			url: 'api/Policymangment/getApprovedPolicies',
			method: 'GET',
			success: function (response) {
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
			error: function (xhr, status, error) {
				console.error('Error fetching approved policies:', error);
			}
		});
	}
});

$(document).ready(function () {
	// Issue 4 fix: row print-btn fetches full detail from API so all fields (address, ROI, etc.) are populated
	$('#policyTableBody').on('click', '.print-btn', function (e) {
		e.preventDefault();

		const $row = $(this).closest('tr');
		const policyCode = ($row.find('td:eq(0)').text() || '').trim();

		if (!policyCode) {
			alert('Cannot determine policy code for this row.');
			return;
		}

		// Issue 2 fix: read the row's cumulative net payout (col 2) and actual maturity (col 5) before fetch,
		// because these are specific to this row and not available from the API's single-policy response.
		const rowCumulativePayout = ($row.find('td:eq(2)').text() || '').trim();
		const rowMaturityAmount = ($row.find('td:eq(5)').text() || '').trim();
		const rowPolicyType = ($row.find('td:eq(4)').text() || '').trim();
		const isMisRow = rowPolicyType.toUpperCase() === 'MIS';

		// Open the print window IMMEDIATELY inside the click handler (synchronous user gesture)
		// so the browser does not block it as a popup. Write content after fetch completes.
		const printWindow = window.open('', '_blank');
		if (!printWindow) {
			alert('Pop-up blocked. Please allow pop-ups for this site to print.');
			return;
		}

		// Fetch full detail so address, ROI, nominee, plan name etc. are all populated
		fetch('api/Policymangment/getPolicyByPolicyCode?policyCode=' + encodeURIComponent(policyCode))
			.then(function (r) { return r.json(); })
			.then(function (data) {
				if (data && data.data) {
					_populateSpansFromPolicy(data.data);
					// Issue 2 fix: for MIS, override renewalAmountSpan with this row's cumulative net payout
					// and maturitySpan with the actual backend-computed maturity amount (from the table row).
					// policy.paidAmount = monthly gross payout (e.g. ₹60), not cumulative net (e.g. ₹54, ₹108…)
					if (isMisRow) {
						var elR = document.getElementById('renewalAmountSpan');
						if (elR && rowCumulativePayout) elR.textContent = rowCumulativePayout;
						var elM = document.getElementById('maturitySpan');
						if (elM && rowMaturityAmount) elM.textContent = rowMaturityAmount;
					}
				} else {
					// Fallback: populate only table-visible fields
					_populateSpansFromTableRow($row);
				}
				var printHtml = _buildIrbPrintHtml(true);
				printWindow.document.open();
				printWindow.document.write(printHtml);
				printWindow.document.close();
				setTimeout(function () {
					printWindow.focus();
					printWindow.print();
				}, 400);
			})
			.catch(function () {
				// Fallback on network error
				_populateSpansFromTableRow($row);
				var printHtml = _buildIrbPrintHtml(true);
				printWindow.document.open();
				printWindow.document.write(printHtml);
				printWindow.document.close();
				setTimeout(function () {
					printWindow.focus();
					printWindow.print();
				}, 400);
			});
	});
});

// Fallback: populate spans from table row columns only (used if API call fails)
function _populateSpansFromTableRow($row) {
	var set = function (id, val) {
		var el = document.getElementById(id);
		if (el) el.textContent = val || '';
	};
	const policyCode = ($row.find('td:eq(0)').text() || '').trim();
	const customerName = ($row.find('td:eq(1)').text() || '').trim();
	const policyAmount = ($row.find('td:eq(2)').text() || '').trim();
	const policyDate = ($row.find('td:eq(7)').text() || '').trim();
	const policyType = ($row.find('td:eq(4)').text() || '').trim();
	const maturityAmount = ($row.find('td:eq(5)').text() || '').trim();
	const totalDeposit = ($row.find('td:eq(12)').text() || '').trim();
	const policyTerm = ($row.find('td:eq(8)').text() || '').trim();
	const maturityDate = ($row.find('td:eq(9)').text() || '').trim();
	const customerCode = ($row.find('td:eq(10)').text() || '').trim();
	const contactNo = ($row.find('td:eq(11)').text() || '').trim();
	const branchname = ($row.find('td:eq(16)').text() || '').trim();
	const paymentDue = ($row.find('td:eq(13)').text() || '').trim();
	const isApproved = ($row.find('td:eq(15)').text() || '').trim();
	const noOfInstPaid = ($row.find('td:eq(14)').text() || '').trim();
	set('policyNoSpan', policyCode);
	set('applicantNameSpan', customerName);
	set('renewalAmountSpan', policyAmount);
	set('docSpan', policyDate);
	set('schemeSpan', policyType);
	// Issue 1: for fallback path we cannot know schemeName, so show policyType as scheme and leave plan blank
	set('planSpan', '');
	set('maturitySpan', maturityAmount);
	set('totalValueSpan', totalDeposit);
	set('termSpan', policyTerm);
	set('maturityDateSpan', maturityDate);
	set('memberCodeSpan', customerCode);
	set('mobileSpan', contactNo);
	set('branchCodeSpan', branchname);
	set('paymentDueSpan', paymentDue);
	set('approvedSpan', isApproved);
	set('installmentsPaidSpan', noOfInstPaid);
}

$("#findBtn").click(function () {
	const policyCode = ($("#findPolicyNumber").val() || "").trim();

	if (!policyCode) {
		$('#policyTableBody').empty();
		return;
	}

	$.ajax({
		url: 'api/Policymangment/findPolicyData',
		method: 'GET',
		data: { policyCode: policyCode },
		dataType: 'json',
		success: function (response) {
			if (response.status === "OK" && Array.isArray(response.data) && response.data.length > 0) {
				const dataList = response.data;
				$('#policyTableBody').empty();

				// Issue 3 & 5 fix: detect MIS type and compute cumulative net payout per row
				const isMis = dataList.length > 0 && (dataList[0].policyType || '').toUpperCase() === 'MIS';
				const principal = isMis ? parseFloat(dataList[0].policyAmount || 0) : 0;
				// MIS monthly net payout = principal * roi/1200 * (1 - tds%/100)
				// We read ROI from the data; if not available we'll show policyAmount as fallback
				// The actual monthly interest is stored in policyRenewal rows — for display purposes
				// we calculate: monthlyInterest = principal * roi / 1200
				// TDS applies if annual interest > threshold; for 6000 @ 12%: 60/month * 12 = 720 < 5000 threshold → no TDS
				// We use monthlyPayoutAmount if available, otherwise compute from principal & roi

				dataList.forEach(function (data, index) {
					let displayAmount;
					if (isMis) {
						// Issue 3 fix: for MIS rows show cumulative net payout, not principal
						// Monthly net payout comes from maturityAmount context:
						// backend sets totalDeposit=principal but the per-row amount shown should be cumulative net payout
						// Monthly payout = principal * roi / 1200  (from AddnewinvestmentPM.roi or MisPolicy.interestRate)
						// We approximate from the stored maturityAmount: (maturity - principal) / totalMonths = total net interest / months
						const totalMonths = dataList.length;
						const maturity = parseFloat(data.maturityAmount || 0);
						const monthlyNetPayout = totalMonths > 0 ? (maturity - principal) / totalMonths : 0;
						const cumulativePayout = monthlyNetPayout * (index + 1);
						displayAmount = cumulativePayout.toFixed(2);
					} else {
						displayAmount = data.policyAmount || '';
					}

					const newRow = `
                        <tr>
                            <td>${data.policyCode || ''}</td>
                            <td>${data.clientName || data.customerName || ''}</td>
                            <td>${displayAmount}</td>
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
                            <td>${data.approved == true ? 'Yes' : 'No'}</td>
                            <td>${data.branchname || ''}</td>
                            <td><button class="btn btn-primary print-btn">Print</button></td>
                        </tr>`;
					$('#policyTableBody').append(newRow);
				});

				// Issue 5 fix: bottom Print button — auto-load full policy detail so it works immediately after Find
				// without requiring user to click a row Print button first
				fetch('api/Policymangment/getPolicyByPolicyCode?policyCode=' + encodeURIComponent(policyCode))
					.then(function (r) { return r.json(); })
					.then(function (detailRes) {
						if (detailRes && detailRes.data) {
							_populateSpansFromPolicy(detailRes.data);
							// Issue 3 fix: for MIS bottom print, override renewalAmountSpan with the TOTAL
							// cumulative net payout (all months combined) and maturitySpan with actual maturity.
							// _populateSpansFromPolicy sets renewalAmountSpan = paidAmount (monthly gross, e.g. ₹60),
							// but bottom print needs total net payout (e.g. ₹270 for 5 months @ net ₹54/month).
							if (isMis && dataList.length > 0) {
								// The last row's cumulative value in column 2 = total cumulative net payout
								var lastRow = $('#policyTableBody tr:last');
								var totalNetPayout = (lastRow.find('td:eq(2)').text() || '').trim();
								var overallMaturity = (dataList[0].maturityAmount || '').toString().trim();
								var elR = document.getElementById('renewalAmountSpan');
								if (elR && totalNetPayout) elR.textContent = totalNetPayout;
								var elM = document.getElementById('maturitySpan');
								if (elM && overallMaturity) elM.textContent = overallMaturity;
							}
						}
					})
					.catch(function (err) {
						console.warn('Could not pre-load policy detail for bottom Print:', err);
					});

			} else {
				alert("No data found for the selected policy.");
				$('#policyTableBody').empty();
			}
		},
		error: function (xhr) {
			console.error("\u274c Error:", xhr);
			alert("Error while fetching policy data.");
		}
	});
});



