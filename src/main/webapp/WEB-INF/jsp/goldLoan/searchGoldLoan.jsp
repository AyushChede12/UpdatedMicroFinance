
<style>
.table tbody td {
	white-space: nowrap;
	font-size: 14px;
	padding: 8px;
}
</style>

<div class="pagetitle">
	<h1>Secured Gold Loan</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-house-door"></i>
			</a></li>
			<li class="breadcrumb-item action">Search Gold Loan</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div class="row">


			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="findByGoldLoanId" id="goldSelection">Find By
						Gold Id </label> <select id="findByGoldLoanId" name="findByGoldLoanId"
						class="form-control selectField" style="width: 100%;">
						<option value="">-- Select Gold ID --</option>
					</select>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="fromDate"> Beginning Date</label> <input type="date"
						name="fromDate" id="fromDate" required="required" placeholder=""
						style="text-transform: uppercase;" />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="toDate">Final Date</label> <input type="date"
						name="toDate" id="toDate" required="required" placeholder=""
						style="text-transform: uppercase;" />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="customerName">Customer Name </label> <input type="text"
						name="customerName" id="customerName" required="required"
						placeholder="Enter Customer Name" />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="customerCode">Customer Code </label> <input type="text"
						name="customerCode" id="customerCode" required="required"
						placeholder="Enter Customer Code" />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Loan Plan Name: </label> <input type="text"
						name="loanPlanName" id="loanPlanName" required="required"
						placeholder="Enter Plan Name" />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4"
					style="margin-bottom: 30px">
					<label> Financial Consultant Id</label>
					<div class="d-flex flex-column formFields mb-4">
						<input type="text" name="financialConsultantId"
							id="financialConsultantId" required="required"
							placeholder="Enter Member ID" />
					</div>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Financial Consultant Name</label> <input type="text"
						name="financialConsultantName" id="financialConsultantName"
						required="required" placeholder="Enter Financial Name"
						style="text-transform: uppercase;" />
				</div>
			</div>
		</div>
	</form>
	<div class="row">
		<div class="col-12 text-center">

			<button type="button" id="searchButtonGold" class="btnStyle"
				style="background-color: #FFA500;">Search</button>
		</div>
	</div>
</div>


<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">Loan Records</h5>

				<div class="table-responsive">
					<table class="table table-borderless datatable">
						<thead class="table-light">
							<tr
								style="font-family: 'Poppins', sans-serif; white-space: nowrap;">
								<th scope="col">Sr No.</th>
								<th scope="col">Gold Id</th>
								<th scope="col">Customer Name</th>
								<th scope="col">Customer Code</th>
								<th scope="col">Contact No</th>
								<th scope="col">Address</th>
								<th scope="col">Branch</th>
								<th scope="col">Loan Plan Name</th>
								<th scope="col">Type of Loan</th>
								<th scope="col">Loan Mode</th>
								<th scope="col">Loan Date</th>
								<th scope="col">Duration</th>
								<th scope="col">Loan Amount</th>
								<th scope="col">EMI (Per Month)</th>
								<th scope="col">Customer Item</th>
								<th scope="col">Loan Purpose</th>
							</tr>
						</thead>
						<tbody>
							<!-- rows go here -->
						</tbody>
					</table>
				</div>

			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/SecuredGoldLoan/SearchGoldLoan.js"></script>
