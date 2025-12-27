
<div class="pagetitle">
	<h1>Reports & Analytics</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-file-earmark-text"></i>
			</a></li>
			<li class="breadcrumb-item action">Loan Confirmation Document</li>
		</ol>
	</nav>
</div>
<div>
	<nav>
		<ol class="breadcrumb breadcrumb-title">
			<li class="breadcrumb-item action">Find Box</li>
		</ol>
	</nav>
	<div class="row">
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="loanPlanName">Plan Name</label> <select
					id="loanPlanName" name="loanPlanName" required="required"
					class="form-control selectField mb-4" style="height: 30px;">
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="financialCode">Financial Code</label> <input type="text"
					name="financialCode" id="financialCode" required="required"
					placeholder="Enter Financial Code" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="toDate">To Date</label> <input type="date" name="toDate"
					id="toDate" required="required" style="text-transform: uppercase;" />
			</div>
		</div>

	</div>
</div>
<div class="row">
	<div class="col-4 text-start mt-3">
		<button id="findBtn" class="btn btn-dark">Find</button>
	</div>
</div>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">
			<div class="card-body table-responsive">
				<div class="">
					<h5 class="card-title">
						Find Result <span></span>
					</h5>
					<div class="text-center col-lg-12">
						<label class="font-weight-bold">Collection Record</label>
					</div>

					<div>
						<label class="col-lg-3">Collector Code :</label> <label
							class="col-lg-6">Collector Name :</label>
					</div>
				</div>
				<div style="overflow-x: auto; white-space: nowrap;">
					<table class="table table-borderless datatable">
						<thead class="table-light">
							<tr style="font-family: 'Poppins', sans-serif;">
								<th scope="col">SR. NO</th>
								<th scope="col">LOAN ID</th>
								<th scope="col">APPLICANT NAME</th>
								<th scope="col">LOAN TYPE</th>
								<th scope="col">LOAN AMOUNT</th>
								<th scope="col">DISBURSED AMOUNT</th>
								<th scope="col">INTEREST RATE</th>
								<th scope="col">DURATION</th>
								<th scope="col">LOAN START DATE</th>
								<th scope="col">LOAN END DATE</th>
								<th scope="col">TOTAL PAID AMOUNT</th>
								<th scope="col">OUTSTANDING BALANCE</th>
								<th scope="col">CONFIRMATION STATUS</th>
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
