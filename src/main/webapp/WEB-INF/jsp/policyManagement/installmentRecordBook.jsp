
<style>
/* ===== Installment Record Book – on-screen display styles ===== */
.irb-report-wrapper {
    font-family: 'Segoe UI', Arial, sans-serif;
    background: #fff;
    border: 1px solid #dee2e6;
    border-radius: 6px;
    padding: 28px 32px;
    margin-top: 20px;
    box-shadow: 0 2px 8px rgba(0,0,0,0.07);
}

.irb-header-box {
    text-align: center;
    border-bottom: 2.5px solid #0d6efd;
    padding-bottom: 10px;
    margin-bottom: 16px;
}
.irb-header-box h2 {
    margin: 0 0 4px 0;
    color: #0d6efd;
    text-transform: uppercase;
    font-size: 20px;
    font-weight: 700;
    letter-spacing: 0.5px;
}
.irb-header-box p {
    margin: 2px 0;
    font-size: 12px;
    color: #555;
}

.irb-title-bar {
    background: #0d6efd;
    color: #fff;
    padding: 6px 12px;
    font-weight: 700;
    font-size: 13px;
    text-transform: uppercase;
    display: flex;
    justify-content: space-between;
    border-radius: 3px;
    margin-bottom: 14px;
}

.irb-section-heading {
    background: #e9ecef;
    color: #0d6efd;
    font-size: 12px;
    font-weight: 700;
    padding: 4px 10px;
    border-left: 4px solid #0d6efd;
    margin-top: 14px;
    margin-bottom: 6px;
    text-transform: uppercase;
}

.irb-meta-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 4px;
    font-size: 13px;
}
.irb-meta-table th {
    background: #f1f4f9;
    text-align: left;
    padding: 6px 10px;
    font-size: 12px;
    width: 22%;
    border: 1px solid #ced4da;
    color: #222;
    font-weight: 600;
    vertical-align: middle;
}
.irb-meta-table td {
    padding: 6px 10px;
    font-size: 12.5px;
    border: 1px solid #ced4da;
    vertical-align: middle;
    color: #333;
}

.irb-footer {
    text-align: center;
    margin-top: 18px;
    font-size: 10px;
    color: #888;
    border-top: 1px dashed #bbb;
    padding-top: 8px;
}

.irb-auth-signature {
    display: flex;
    justify-content: flex-end;
    align-items: center;
    margin-top: 30px;
    gap: 16px;
}
.irb-auth-signature hr {
    border-color: #333;
    width: 180px;
    margin: 0;
}
.irb-auth-signature span {
    font-size: 11px;
    font-weight: 600;
    color: #444;
    text-transform: uppercase;
    white-space: nowrap;
}

/* Print button area spacing */
.irb-print-actions {
    display: flex;
    justify-content: flex-end;
    gap: 8px;
    margin-top: 14px;
}
</style>

<div class="pagetitle">
	<h1>POLICY MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"><i
					class="bi bi-piggy-bank"></i></a></li>
			<li class="breadcrumb-item active">INSTALLMENT RECORD BOOK</li>
		</ol>
	</nav>
</div>

<!-- Main Form -->
<form id="formid">
	<div>
		<nav>
			<ol class="breadcrumb breadcrumb-title">
				<li class="breadcrumb-item active">PRINT SEARCH RESULT</li>
			</ol>
		</nav>

		<!-- Combined Row with Dropdown and Buttons -->
		<div class="row align-items-center mb-4">
			<!-- Dropdown -->
			<div class="col-md-6 d-flex align-items-center">
				<label class="mr-2 mb-0">FIND BY POLICY CODE*</label> <select
					id="findByPolicyNumber" name="findByPolicyNumber"
					class="form-control w-50">
					<option value="">SLECT POLICY CODE</option>
				</select>
			</div>

			<!-- Buttons -->
			<!-- <div class="col-md-6 text-right"> -->
			<div class="col-md-6 d-flex justify-content-center">

				<button type="button" class="btn btn-dark mr-2"
					onclick="toggleTransaction()">TRANSCATION</button>

				<button type="button" class="btn btn-dark"
					onclick="printTransactionSection()">
					<i class="bi bi-download"></i>
				</button>

			</div>
		</div>
	</div>
</form>

<!-- Transaction Section (Initially Hidden) -->
<div id="transactionSection" class="transaction-section" style="display: none;">

	<!-- Hidden data-carrier spans (read by JS – do NOT remove) -->
	<span id="branchCodeSpan"    style="display:none;"></span>
	<span id="docSpan"           style="display:none;"></span>
	<span id="policyNoSpan"      style="display:none;"></span>
	<span id="memberCodeSpan"    style="display:none;"></span>
	<span id="applicantNameSpan" style="display:none;"></span>
	<span id="fatherNameSpan"    style="display:none;"></span>
	<span id="nomineeNameSpan"   style="display:none;"></span>
	<span id="addressSpan"       style="display:none;"></span>
	<span id="schemeSpan"        style="display:none;"></span>
	<span id="planSpan"          style="display:none;"></span>
	<span id="relationshipSpan"  style="display:none;"></span>
	<span id="roiSpan"           style="display:none;"></span>
	<span id="modeSpan"          style="display:none;"></span>
	<span id="maturitySpan"      style="display:none;"></span>
	<span id="renewalAmountSpan" style="display:none;"></span>
	<span id="totalValueSpan"    style="display:none;"></span>
	<span id="termSpan"          style="display:none;"></span>
	<span id="maturityDateSpan"  style="display:none;"></span>
	<span id="mobileSpan"        style="display:none;"></span>
	<span id="collectorSpan"     style="display:none;"></span>

	<!-- ===== Styled Report Card ===== -->
	<div class="irb-report-wrapper">

		<!-- Header -->
		<div class="irb-header-box">
			<h2>SAMITHA URBAN NIDHI LTD.</h2>
			<p>ADDRESS : NAGPUR (440024) - MAHARASHTRA</p>
		</div>

		<!-- Title bar -->
		<div class="irb-title-bar">
			<span>SAMITHA URBAN NIDHI LTD. — INSTALLMENT RECORD BOOK</span>
			<span id="irb-print-date"></span>
		</div>

		<!-- Section 1: Policy Identification -->
		<div class="irb-section-heading">Policy Identification</div>
		<table class="irb-meta-table">
			<tr>
				<th>BRANCH &amp; CODE</th>
				<td id="disp-branchCode"></td>
				<th>DOC / START DATE</th>
				<td id="disp-doc"></td>
			</tr>
			<tr>
				<th>POLICY NO.</th>
				<td id="disp-policyNo"></td>
				<th>MEMBER CODE</th>
				<td id="disp-memberCode"></td>
			</tr>
		</table>

		<!-- Section 2: Applicant Details -->
		<div class="irb-section-heading">Applicant Details</div>
		<table class="irb-meta-table">
			<tr>
				<th>APPLICANT NAME</th>
				<td colspan="3" id="disp-applicantName"></td>
			</tr>
			<tr>
				<th>FATHER / HUSBAND NAME</th>
				<td id="disp-fatherName"></td>
				<th>NOMINEE NAME</th>
				<td id="disp-nomineeName"></td>
			</tr>
			<tr>
				<th>ADDRESS</th>
				<td colspan="3" id="disp-address"></td>
			</tr>
			<tr>
				<th>MOBILE NO.</th>
				<td id="disp-mobile"></td>
				<th>RELATIONSHIP</th>
				<td id="disp-relationship"></td>
			</tr>
		</table>

		<!-- Section 3: Scheme & Plan Details -->
		<div class="irb-section-heading">Scheme &amp; Plan Details</div>
		<table class="irb-meta-table">
			<tr>
				<th>SCHEME</th>
				<td id="disp-scheme"></td>
				<th>PLAN</th>
				<td id="disp-plan"></td>
			</tr>
			<tr>
				<th>ROI (%)</th>
				<td id="disp-roi"></td>
				<th>MODE</th>
				<td id="disp-mode"></td>
			</tr>
			<tr>
				<th>TERM</th>
				<td id="disp-term"></td>
				<th>MATURITY DATE</th>
				<td id="disp-maturityDate"></td>
			</tr>
		</table>

		<!-- Section 4: Financial Summary -->
		<div class="irb-section-heading">Financial Summary</div>
		<table class="irb-meta-table">
			<tr>
				<th>RENEWAL AMOUNT</th>
				<td id="disp-renewalAmount"></td>
				<th>TOTAL VALUE</th>
				<td id="disp-totalValue"></td>
			</tr>
			<tr>
				<th>MATURITY AMOUNT</th>
				<td id="disp-maturity"></td>
				<th>COLLECTOR NAME</th>
				<td id="disp-collector"></td>
			</tr>
		</table>

		<!-- Authorized Signature -->
		<div class="irb-auth-signature">
			<span>AUTHORIZED SIGNATURE</span>
			<hr />
		</div>

		<!-- Footer -->
		<div class="irb-footer">
			This is a system-generated record. Generated on <span id="irb-footer-date"></span>.
		</div>

	</div><!-- /.irb-report-wrapper -->

	<!-- Print Actions -->
	<div class="irb-print-actions">
		<button type="button" class="btn btn-primary btn-sm" onclick="printTransactionSection()">
			<i class="bi bi-printer"></i> Print
		</button>
		<button type="button" class="btn btn-success btn-sm" onclick="downloadTransactionRecord()">
			<i class="bi bi-download"></i> Download Record
		</button>
	</div>

</div><!-- /#transactionSection -->

<!-- Toggle Script -->
<script>
	function onFrontPageClick() {
		const selectedPolicyCode = $("#policyCodeDropdown").val();
		fetchPolicyData(selectedPolicyCode);
	}
</script>

<script
	src="${pageContext.request.contextPath}/js/PolicyManagment/policyReport.js"></script>