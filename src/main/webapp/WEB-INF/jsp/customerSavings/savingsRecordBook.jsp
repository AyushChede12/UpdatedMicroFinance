
<style>
@media print {
	body * {
		visibility: hidden !important;
	}
	#passbookSection, #TransactionSection {
		visibility: visible !important;
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
	}

	/* Hide sidebar, navbar, buttons during print */
	.sidebar, .navbar, .print-button, .download-button, .footer, .header,
		.btn, .action-buttons {
		display: none !important;
	}

	/* Optional: Remove page margins */
	@page {
		margin: 20mm;
	}
}
</style>
<div class="pagetitle">
	<h1>SAVING / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">SAVINGS RECORD BOOK</li>
		</ol>
	</nav>
</div>


<div>
	<nav>
		<ol class="breadcrumb breadcrumb-title">
			<li class="breadcrumb-item action">SEARCH DETAILS</li>
		</ol>
	</nav>
	<div class="row">
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">ACCOUNT TYPE</label> <select id="accountType"
					class="form-control selectField" style="height: 30px;">
					<option value="">--SELECT ACCOUNT TYPE--</option>
					<option value="savingaccount">SAVING ACCOUNT</option>
					<option value="currentaccount">CURRENT ACCOUNT</option>

				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">ACCOUNT NO</label> <select id=accountNumber
					class="form-control selectField" style="height: 30px;">
					<option value="">--SELECT ACCOUNT NO--</option>

				</select>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12 text-center">
			<button id="btnSearchTransactionData" class="btn btn-success"
				onclick="displayTransactionDataList()">
				<span class="fa fa-search"></span> SEARCH
			</button>
			<button id="btnFrontPageOnSavingPassbook" class="btn btn-success"
				onclick="displaySavingfrontPage()">FRONT PAGE</button>
			<button id="btnTransactionPageOnSavingPassbook"
				class="btn btn-success" onclick="displaySavingTransaction()">TRANSACTION</button>
			<button id="btnHeadingOnSavingPassbook" onclick="displayHeadingSA()"
				class="btn btn-success">HEADING</button>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-12" id="tableSection" style="display: none;">
		<div class="card recent-sales">
			<div class="card-body table-responsive">
				<h5 class="card-title">ACCOUNT HOLDER DETAILS</h5>

				<table class="table table-bordered">
					<thead class="table-light">
						<tr>
							<th style="white-space: nowrap;">SR NO</th>
							<th style="white-space: nowrap;">BRANCH NAME</th>
							<th style="white-space: nowrap;">ACCOUNT NO</th>
							<th style="white-space: nowrap;">CUSTOMER NAME</th>
							<th style="white-space: nowrap;">CUSTOMER CODE</th>
							<th style="white-space: nowrap;">MOBILE NO</th>
							<th style="white-space: nowrap;">ADDRESS</th>
							<th style="white-space: nowrap;">OPENING DATE</th>
							<th style="white-space: nowrap;">OPENING BALANCE</th>
						</tr>
					</thead>
					<tbody id="customerDetails">
						<!-- Rows will be appended dynamically or statically here
 -->
					</tbody>
				</table>

			</div>
		</div>
	</div>
</div>

<div class="row mt-4">
	<div class="col-12 d-flex justify-content-end"
		id="printbtnSection" style="display: none;">
		<button type="button" class="btn btn-success"
			id="printBtn" onclick="printTransactionSection1()">
			<i class="fa-solid fa-print"></i>
		</button>
	</div>
</div>


<!-- ===== PASSBOOK SECTION ===== -->
<div class="row mt-5" id="passbookId">
	<div class="col-12">
		<div id="passbookSection" class="passbookSection card recent-sales"
			style="display: none;">
			<div class="card-body table-responsive" style="width: 100%; margin: auto;">

				<h1 style="margin-top: 35px; text-align: center;">
					SAMITHA URBAN NIDHI LTD.
				</h1>
				<p style="text-align: center;">
					ADDRESS : NAGPUR(440024) - MAHARASHTRA
				</p>
				<hr />

				<!-- ROW 1 -->
				<div class="row mb-2">
					<div class="col-6">
						<strong>CUSTOMER NO. :</strong>
						<span id="customerNo"></span>
					</div>
					<div class="col-6">
						<strong>ACCOUNT NO. :</strong>
						<span id="accountNo"></span>
					</div>
				</div>

				<!-- ROW 2 -->
				<div class="row mb-2">
					<div class="col-6">
						<strong>ACCOUNT HOLDER NAME :</strong>
						<span id="customerName"></span>
					</div>
					<div class="col-6">
						<strong>S/D/W/H/O :</strong>
						<span id="familyDetails"></span>
					</div>
				</div>

				<!-- ROW 3 -->
				<div class="row mb-2">
					<div class="col-6">
						<strong>DATE OF BIRTH :</strong>
						<span id="dateOfBirth"></span>
					</div>
					<div class="col-6">
						<strong>CONTACT NO. :</strong>
						<span id="contactNo"></span>
					</div>
				</div>

				<!-- ROW 4 -->
				<div class="row mb-2">
					<div class="col-6">
						<strong>EMAIL ID :</strong>
						<span id="emailId"></span>
					</div>
					<div class="col-6">
						<strong>MODE OF OPERATION :</strong>
						<span id="operationType"></span>
					</div>
				</div>

				<!-- ROW 5 -->
				<div class="row mb-2">
					<div class="col-6">
						<strong>AADHAR NO. :</strong>
						<span id="aadharNo"></span>
					</div>
					<div class="col-6">
						<strong>ADDRESS :</strong>
						<span id="address"></span>
					</div>
				</div>

				<!-- ROW 6 -->
				<div class="row mb-2">
					<div class="col-6">
						<strong>ACCOUNT TYPE :</strong>
						<span id="typeofaccount"></span>
					</div>
					<div class="col-6">
						<strong>DATE OF ISSUE :</strong>
						<span id="dateOfIssue"></span>
					</div>
				</div>

				<!-- ROW 7 -->
				<div class="row mb-4">
					<div class="col-6">
						<strong>BRANCH :</strong>
						<span id="branchName"></span>
					</div>
					<div class="col-6">
						<strong>UPI :</strong>
						<span id="upi"></span>
					</div>
				</div>

				<!-- SIGNATURE -->
				<div class="row mt-5">
					<div class="col-12 text-end">
						<hr style="border-color: black; width: 20vw; margin-left: auto;">
						<p>AUTHORIZED SIGNATURE</p>
					</div>
				</div>

			</div>
		</div>
	</div>
</div>


<!-- ===== HEADING SECTION ===== -->
<div class="row mt-4" id="headingSection" style="display: none;">
	<div class="col-12">
		<div class="card shadow-sm border recent-sales" id="headingId">
			<div class="card-body p-4 table-responsive">
				<h5 class="fw-bold mb-3" style="color: #b02a37;">PASSBOOK PRINT HEADER</h5>
				<table class="table table-bordered align-middle" id="heading-tabl">
					<thead class="table-dark text-nowrap" style="font-size: 13px;">
						<tr>
							<th style="text-align: center; width: 60px;">SR NO</th>
							<th style="text-align: center; width: 110px;">TXN DATE</th>
							<th style="text-align: left;">PARTICULARS / NARRATION</th>
							<th style="text-align: center; width: 110px;">PAY MODE</th>
							<th style="text-align: right; width: 140px;">DEPOSIT / CR (₹)</th>
							<th style="text-align: right; width: 140px;">WITHDRAWAL / DR (₹)</th>
							<th style="text-align: right; width: 150px;">BALANCE (₹)</th>
						</tr>
					</thead>
					<tbody></tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<!-- ===== TRANSACTION TABLE ===== -->
<div class="row mt-4" id="TransactionSection" style="display: none;">
	<div class="col-12">
		<div class="card shadow-sm border recent-sales" id="transactionId">
			<div class="card-body p-4 table-responsive">

				<!-- Bank & Account Header for View & Print -->
				<div class="border-bottom pb-3 mb-3" id="txnCustomerHeader">
					<div class="d-flex justify-content-between align-items-center flex-wrap">
						<div>
							<h4 class="fw-bold mb-1" style="color: #b02a37;">SAMITHA URBAN NIDHI LTD.</h4>
							<p class="text-muted small mb-0">CUSTOMER SAVINGS PASSBOOK / TRANSACTION LEDGER</p>
						</div>
						<div class="text-end">
							<span class="badge bg-primary fs-6 px-3 py-2" id="txnHdrAccountNo">A/C: -</span>
						</div>
					</div>
					<div class="row g-2 mt-2 pt-2 bg-light rounded p-2 text-dark small" id="txnCustDetailsGrid">
						<div class="col-md-4 col-sm-6">
							<strong>CUSTOMER NAME:</strong> <span id="txnHdrCustName">-</span>
						</div>
						<div class="col-md-4 col-sm-6">
							<strong>MEMBER CODE:</strong> <span id="txnHdrMemberCode">-</span>
						</div>
						<div class="col-md-4 col-sm-6">
							<strong>BRANCH:</strong> <span id="txnHdrBranch">-</span>
						</div>
						<div class="col-md-4 col-sm-6">
							<strong>MOBILE NO:</strong> <span id="txnHdrMobile">-</span>
						</div>
						<div class="col-md-4 col-sm-6">
							<strong>ACCOUNT TYPE:</strong> <span id="txnHdrAccType">SAVINGS</span>
						</div>
						<div class="col-md-4 col-sm-6">
							<strong>CURRENT BALANCE:</strong> <span id="txnHdrCurrentBal" class="fw-bold text-success">₹ 0.00</span>
						</div>
					</div>
				</div>

				<table class="table table-bordered table-hover align-middle" id="transaction-tabl">
					<thead class="table-dark text-nowrap" style="font-size: 13px;">
						<tr>
							<th style="text-align: center; width: 60px;">SR NO</th>
							<th style="text-align: center; width: 110px;">TXN DATE</th>
							<th style="text-align: left;">PARTICULARS / NARRATION</th>
							<th style="text-align: center; width: 110px;">PAY MODE</th>
							<th style="text-align: right; width: 140px;">DEPOSIT / CR (₹)</th>
							<th style="text-align: right; width: 140px;">WITHDRAWAL / DR (₹)</th>
							<th style="text-align: right; width: 150px;">BALANCE (₹)</th>
						</tr>
					</thead>
					<tbody id="tableBody1" style="font-size: 13px;"></tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/customerSavings/passbook.js"></script>

