
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Settle Loan Records</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div class="">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Find By Loan Id</label> <select id="closedLoanIds"
							name="closedLoanIds" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Loan Id</option>

						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12 text-center">
				<button id="searchBtn" class="btnStyle"
					style="background-color: #FFA500;">Search</button>
			</div>
		</div>

	</form>
	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">
				<div class="table-responsive">
					<table class="table table-borderless datatable">
						<thead class="table-light">
							<tr
								style="font-family: 'Poppins', sans-serif; white-space: nowrap;">
								<th scope="col">Sr No.</th>
								<th scope="col">Loan ID</th>
								<th scope="col">Loan Date</th>
								<th scope="col">Member ID</th>
								<th scope="col">Member Name</th>
								<th scope="col">Contact No.</th>
								<th scope="col">Address</th>
								<th scope="col">Branch Name</th>
								<th scope="col">Loan Plan Name</th>
								<th scope="col">Type of Loan</th>
								<th scope="col">Loan Mode</th>
								<th scope="col">Loan Term</th>
								<th scope="col">Rate of Interest</th>
								<th scope="col">Loan Amount</th>
								<th scope="col">Interest Type</th>
								<th scope="col">EMI Payment</th>
								<th scope="col">Total Interest of Loan</th>
								<th scope="col">Sanctioned Amount</th>
								<th scope="col">Total Payable of Loan</th>
								<th scope="col">Interest Due</th>
								<th scope="col">Principal Due</th>
								<th scope="col">Amount Paid</th>
								<th scope="col">Balance Loan Amount</th>
								<th scope="col">No of Installments</th>
								<th scope="col">Payment Date</th>
								<th scope="col">Financial Consultant Name</th>
								<th scope="col">Loan Status</th>
							</tr>
						</thead>
						<tbody id="loanClosureTableBody">
							<!-- Data rows will be dynamically inserted here -->
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>

</div>
<script
	src="${pageContext.request.contextPath}/js/LoanManagment/SettledLoanRecord.js"></script>