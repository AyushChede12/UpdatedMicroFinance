
<style>
.bank-report table th, .bank-report table td {
	vertical-align: middle;
}

.bank-report table thead th {
	background-color: #0d6efd !important;
	color: white;
}
</style>

<div class="pagetitle">
	<h1>REPORTS & ANALYTICS</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-file-earmark-text"></i>
			</a></li>
			<li class="breadcrumb-item action">INVESTMENT TRANSACTION REPORT </li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Box</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">BRANCH NAME </label> <select id="branchName1"
							name="branchName" required="required"
							class="form-control selectField">
							<option value="">SELECT</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="fromDate">FROM DATE :</label> <input type="date"
							name="fromDate" id="fromDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="toDate">TO DATE :</label> <input type="date"
							name="toDate" id="toDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>





			</div>

			<div class="row">
				<div class="col-4 text-start mt-3">
					<button id="findBtn" class="btn btn-dark">Find</button>
				</div>
			</div>

		</div>

	</form>

	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">

				<div class="card-body table-responsive">
					<h5 class="card-title">SEARCH RESULT </h5>

					<h6 class="card-title" style="text-align: center; color: black;">
						INVESTMENT REPORT</h6>


					<div style="overflow-x: auto; white-space: nowrap;">
						<table class="table table-borderless datatable">
							<thead class="table-light">
								<tr style="font-family: 'Poppins', sans-serif;">
									<th scope="col">SR NO.</th>
									<th scope="col">POLICY CODE</th>
									<th scope="col">CUSTOMER NAME</th>
									<th scope="col">POLICY NAME</th>
									<th scope="col">POLICY DATE</th>
									<th scope="col">POLICY AMOUNT</th>
									<th scope="col">CONTACT NUMBER</th>
									<th scope="col">BRANCH </th>
									<th scope="col">APPROVED </th>
									<th scope="col">PRINT</th>

								</tr>
							</thead>
							<tbody>
							</tbody>

						</table>
					</div>
				</div>
			</div>
		</div>
	</div>

</div>
<!-- Bank Report Modal -->
<div class="modal fade" id="bankReportModal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog modal-xl modal-dialog-scrollable">
		<div class="modal-content">
			<!-- Header -->
			<div class="modal-header bg-primary text-white">
				<h5 class="modal-title">Microfinance Transaction Report</h5>
				<button type="button" class="btn-close" data-bs-dismiss="modal"
					aria-label="Close"></button>
			</div>

			<!-- Body -->
			<div class="modal-body" id="bankReportContent">
				<div class="bank-report p-4"
					style="font-family: Arial, sans-serif; background-color: #f8f9fa;">

					<!-- Bank Header -->
					<div
						class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
						<div class="d-flex align-items-center">
							<img id="bankLogo" src="" alt="Logo"
								style="height: 50px; margin-right: 10px;">
							<div>
								<h4 id="bankName" class="mb-0 fw-bold text-primary"></h4>
								<small id="reportTitle" class="text-secondary"></small>
							</div>
						</div>
						<div>
							<p class="mb-0">
								<strong>Customer Code:</strong> <span id="accountNumber"></span>
							</p>
							<p class="mb-0">
								<strong>PERIOD COVERED:</strong> <span id="periodCovered"></span>
							</p>
						</div>
					</div>

					<!-- Customer & Summary -->
					<div class="row mb-3">
						<div class="col-md-6">
							<div class="border p-3 bg-white rounded shadow-sm">
								<h6 class="fw-bold mb-2 text-primary">CUSTOMER</h6>
								<p id="customerName" class="mb-0 fw-bold"></p>
								<p id="customerAddress1" class="mb-0"></p>
								<p id="customerAddress2" class="mb-0"></p>
							</div>
						</div>
						<div class="col-md-6">
							<div class="border p-3 bg-white rounded shadow-sm">
								<h6 class="fw-bold mb-2 text-primary">SUMMARY</h6>
								<table class="w-100">
									<tr>
										<td>Starting Balance:</td>
										<td id="startingBalance" class="text-end fw-bold"></td>
									</tr>
									<tr>
										<td>Income:</td>
										<td id="incomeAmount" class="text-end fw-bold text-success"></td>
									</tr>
									<tr>
										<td>Expenses:</td>
										<td id="expensesAmount" class="text-end fw-bold text-danger"></td>
									</tr>
									<tr class="border-top">
										<td><strong>Closing Balance:</strong></td>
										<td id="closingBalance" class="text-end fw-bold text-primary"></td>
									</tr>
								</table>
							</div>
						</div>
					</div>

					<!-- Transactions Table -->
					<div class="mt-4">
						<h6 class="fw-bold text-primary mb-3">TRANSACTIONS:</h6>
						<table
							class="table table-bordered table-striped align-middle text-center">
							<thead class="table-primary">
								<tr>
									<th>Policy Code</th>
									<th>Policy Date</th>
									<th>Policy Amount</th>
									<th>Policy Type</th>
									<th>Policy Mode</th>
								</tr>
							</thead>
							<tbody id="transactionTableBody">
								<!-- Dynamic rows will be appended here via JavaScript -->
							</tbody>
						</table>
					</div>
				</div>
			</div>

			<!-- Footer -->
			<div class="modal-footer">
				<button id="printBankReportBtn" class="btn btn-success">
					<i class="bi bi-printer"></i> Print
				</button>
				<button type="button" class="btn btn-secondary"
					data-bs-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>
