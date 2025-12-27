
<div class="pagetitle">
	<h1>Policy Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"><i
					class="bi bi-piggy-bank"></i></a></li>
			<li class="breadcrumb-item active">Installment Record Book</li>
		</ol>
	</nav>
</div>

<!-- Main Form -->
<form id="formid">
	<div>
		<nav>
			<ol class="breadcrumb breadcrumb-title">
				<li class="breadcrumb-item active">Print Search Results</li>
			</ol>
		</nav>

		<!-- Combined Row with Dropdown and Buttons -->
		<div class="row align-items-center mb-4">
			<!-- Dropdown -->
			<div class="col-md-6 d-flex align-items-center">
				<label class="mr-2 mb-0">Find by Policy Code*</label> <select
					id="findByPolicyNumber" name="findByPolicyNumber"
					class="form-control w-50">
					<option value="">Select Policy Code</option>
				</select>
			</div>

			<!-- Buttons -->
			<!-- <div class="col-md-6 text-right"> -->
			<div class="col-md-6 d-flex justify-content-center">


				<button type="button" class="btn btn-dark mr-2"
					onclick="toggleTransaction()">Transaction</button>

				<button type="button" class="btn btn-dark"
					onclick="printTransactionSection()">
					<i class="bi bi-download"></i>
				</button>

			</div>
		</div>
	</div>
</form>

<!-- Transaction Section (Initially Hidden) -->
<div id="transactionSection" class="transaction-section"
	style="display: none;">
	<div style="width: 70%; margin: auto">
		<h1>Microfinance Services</h1>
		<p>Address : Nagpur(440024) - Maharashtra</p>
		<hr />
		<div class="d-flex justify-content-between">
			<p>
				Branch and Code: <span id="branchCodeSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
			<p>
				DOC: <span id="docSpan" style="width: 15vw; display: inline-block;"></span>
			</p>
		</div>
		<div class="d-flex justify-content-between">
			<p>
				Policy No.: <span id="policyNoSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
			<p>
				Member Code: <span id="memberCodeSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
		</div>
		<p>
			Applicant Name: <span id="applicantNameSpan"
				style="width: 12vw; display: inline-block;"></span>
		</p>
		<p>
			Father/Husband Name: <span id="fatherNameSpan"
				style="width: 12vw; display: inline-block;"></span>
		</p>
		<p>
			Nominee Name: <span id="nomineeNameSpan"
				style="width: 12vw; display: inline-block;"></span>
		</p>
		<p>
			Address: <span id="addressSpan"
				style="width: 12vw; display: inline-block;"></span>
		</p>

		<div class="d-flex justify-content-between">
			<p>
				Scheme: <span id="schemeSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
			<p>
				Plan: <span id="planSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
			<p>
				Relationship: <span id="relationshipSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
		</div>

		<div class="d-flex justify-content-between">
			<p>
				ROI: <span id="roiSpan" style="width: 12vw; display: inline-block;"></span>
			</p>
			<p>
				Mode: <span id="modeSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
			<p>
				Maturity: <span id="maturitySpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
		</div>

		<div class="d-flex justify-content-between">
			<p>
				Renewal Amount: <span id="renewalAmountSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
			<p>
				Total Value: <span id="totalValueSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
			<p>
				Term: <span id="termSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
		</div>

		<div class="d-flex justify-content-between">
			<p>
				Maturity Date: <span id="maturityDateSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
			<p>
				Mobile No: <span id="mobileSpan"
					style="width: 12vw; display: inline-block;"></span>
			</p>
		</div>

		<p>
			Collector Name: <span id="collectorSpan"
				style="width: 12vw; display: inline-block;"></span>
		</p>



		<div class="d-flex justify-content-end">
			<hr style="border-color: black; width: 20vw;">
			<p style="position: relative; top: 23px; right: 17rem">Authorized
				Signature</p>
		</div>
	</div>
</div>

<!-- Toggle Script -->


<script>
	function onFrontPageClick() {
		const selectedPolicyCode = $("#policyCodeDropdown").val();
		fetchPolicyData(selectedPolicyCode);
	}
</script>


<script
	src="${pageContext.request.contextPath}/js/PolicyManagment/policyReport.js"></script>