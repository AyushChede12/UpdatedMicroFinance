
<div class="pagetitle">
	<h1>Reports & Analytics</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-file-earmark-text"></i>
			</a></li>
			<li class="breadcrumb-item action">Loan Installment Pending
				Report</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Find Box</li>
				</ol>
			</nav>
			<div class="row">


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="branchName1">Branch </label> <select id="branchName1"
							name="branchName1" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="loanPlanName">Plan Name </label> <select
							id="loanPlanName" name="loanPlanName" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="financialCode">Financial Code</label> <input
							type="text" name="financialCode" id="financialCode"
							required="required" placeholder="Enter Financial Code"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="toDate">To Date</label> <input type="date"
							name="toDate" id="toDate" required="required"
							placeholder="Enter tDate" style="text-transform: uppercase;" />
					</div>
				</div>

			</div>

			<div class="row">
				<div class="col-4 text-start mt-3">
					<button type="button" id="findBtn" class="btn btn-dark">Find</button>
				</div>
			</div>

		</div>

	</form>

	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">

				<div class="card-body table-responsive">
					<h5 class="card-title">Loan Pending Report</h5>

					<h6 class="card-title" style="text-align: center; color: black;">
						Loan Installment Pending Report</h6>



					<div style="overflow-x: auto; white-space: nowrap;">
						<table class="table table-borderless datatable">
							<thead class="table-light">
								<tr style="font-family: 'Poppins', sans-serif;">
									<th scope="col">Sr No.</th>
									<th scope="col">Loan ID</th>
									<th scope="col">Branch Name</th>
									<th scope="col">Customer Name</th>
									<th scope="col">Financial Code</th>
									<th scope="col">Loan Amount</th>
									<th scope="col">Installment Amount</th>
									<th scope="col">Total Installments</th>
									<th scope="col">Paid Installments</th>
									<th scope="col">Pending Installments</th>
									<th scope="col">Outstanding Balance</th>
									<th scope="col">Last Payment Date</th>
									<th scope="col">Loan Status</th>
									<th scope="col">Remarks</th>
									<th scope="col">Print</th>
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
