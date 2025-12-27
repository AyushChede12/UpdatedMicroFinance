
<div class="pagetitle">
	<h1>Request Approvals</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-check-circle"></i>
			</a></li>
			<li class="breadcrumb-item action">Approve New Client Request</li>
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
				<!-- <div class="col-lg-4">
							<div class="d-flex flex-column formFields">
								<label for="">Branch Name</label> <select id="branchName" name="branchName"
									required="required" class="form-control selectField"
									style="height: 30px;">


									<option value="">Select Branch</option>
									

								</select>
							</div>
						</div> -->

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Branch Name</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>

				</div>
				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Date From</label> <input type="date"
							name="fromDate" id="fromDate" required="required"
							placeholder="Enter From Date" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Date To</label> <input type="date"
							name="toDate" id="toDate" required="required"
							placeholder="Enter To Date" style="text-transform: uppercase;" />
					</div>
				</div>
			</div>
		</div>
</div>

<div class="row">
	<div class="col-12 text-center mt-3">
		<button id="findBtn" class="btnStyle"
			style="background-color: #FFA500;">FIND</button>
	</div>
</div>
</form>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">Search result</h5>

				<div style="overflow-x: auto; white-space: nowrap;">
					<table class="table table-borderless datatable">
						<thead class="table-light">

							<tr style="font-family: 'Poppins', sans-serif;">
								<th scope="col"></th>
								<th scope="col">Sr No.</th>
								<th scope="col">Member Name</th>
								<th scope="col">Member Code</th>
								<th scope="col">Branch Name</th>
								<th scope="col">Date of Birth</th>
								<th scope="col">Age</th>
								<th scope="col">Gender</th>
								<th scope="col">Address</th>
								<th scope="col">Academic background</th>
								<th scope="col">Contact No</th>
								<th scope="col">Email Id</th>

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
<div class="row">
	<div class="col-12 text-center mt-3">
		<button id="approvedBtn" class="btnStyle"
			style="background-color: #FFA500;">Approved</button>
	</div>
</div>


</div>

<!-- <script src="js/chartScript.js"></script> -->
<script src="./js/adminscript.js"></script>
<script src="./js/RequestApproval/ApprovalNewClientRequest.js"></script>
<script>
	$(document).ready(function() {

		// Get today's date in YYYY-MM-DD format
		const today = new Date().toISOString().split('T')[0];
		$('#applicationDate').val(today);
		$('#fromDate').val(today);
		$('#toDate').val(today);
		$('#approvalDate').val(today);
		$('#openingDate').val(today);

	});
</script>
