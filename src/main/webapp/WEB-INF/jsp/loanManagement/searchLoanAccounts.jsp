
<style>
.table tbody td {
	white-space: nowrap;
	font-size: 14px;
	padding: 8px;
}
</style>

<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-house-door"></i>
			</a></li>
			<li class="breadcrumb-item action">Search Loan Accounts</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div class="row">


			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Find By Loan Id</label> <select id="loanId"
						name="loanId" required="required" class="form-control selectField"
						style="height: 30px;">
						<option value="">Select Loan Id</option>

					</select>
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="loanName"> Beginning Date</label> <input type="date"
						name="DateofLoan" id="DateofLoan" required="required"
						placeholder="" style="text-transform: uppercase;" />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="loanName">Final Date</label> <input type="date"
						name="finaldate" id="finaldate" required="required" placeholder=""
						style="text-transform: uppercase;" />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Member Name: </label> <input type="text"
						name="memberName" id="memberName" required="required"
						placeholder="Enter Application Name" />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Member ID: </label> <input type="text"
						name="memberId" id="memberId" required="required"
						placeholder="Enter Member Code" />
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
						required="required" placeholder="Enter Advisor/Collector Name"
						style="text-transform: uppercase;" />
				</div>
			</div>
		</div>
	</form>
	<div class="row">
		<div class="col-12 text-center">

			<button id="searchButton" class="btnStyle"
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
								<th scope="col">Member Id</th>
								<th scope="col">Member Name</th>
								<th scope="col">DOB</th>
								<th scope="col">Age</th>
								<th scope="col">Phone no.</th>
								<th scope="col">Address</th>
								<th scope="col">Loan Plan Name</th>
								<th scope="col">Loan Date</th>
								<th scope="col">Loan Amount</th>
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

<script src="./js/LoanManagment/SearchLoans.js"></script>
<script
	src="${pageContext.request.contextPath}/js/LoanManagment/EarlyLoanClosure.js"></script>
