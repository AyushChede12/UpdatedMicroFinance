
<div class="pagetitle">
	<h1>Reports & Analytics</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-file-earmark-text"></i>
			</a></li>
			<li class="breadcrumb-item action">Cheque Transaction Report</li>
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
						<label for="">Type </label> <select id="type" name="type"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">All Type</option>
							<option value="RD">Cheque Issued</option>
							<option value="RD">Cheque Received</option>
							<option value="RD">Cleared Cheque</option>
							<option value="RD">Bounced Cheque</option>
							<option value="RD">Pending Cheque</option>
							<option value="RD">Cancelled Cheque</option>
							<option value="RD">Transferred Cheque</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="branchName">Branch </label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">From Date :</label> <input type="date" name="fDate"
							id="fDate" required="required" placeholder="Enter fDate"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">TO Date :</label> <input type="date" name="tDate"
							id="tDate" required="required" placeholder="Enter tDate"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="">Check Number.</label> <input type="text"
							id="chequeNo" name="chequeNo" required="required"
							style="height: 30px;" placeholder="Enter Cheque No.">

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
					<h5 class="card-title">Cheque Details</h5>

					<div style="overflow-x: auto; white-space: nowrap;">
						<table class="table table-borderless datatable"
							style="text-align: center;">
							<thead class="table-light">
								<tr style="font-family: 'Poppins', sans-serif;">
									<th scope="col">Sr. No</th>
									<th scope="col">Account Holder Name</th>
									<th scope="col">Txn Date</th>
									<th scope="col">Cheque No.</th>
									<th scope="col">Payment Status</th>
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
