
<div class="pagetitle">
	<h1>Request Approval</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-check-circle"></i>
			</a></li>
			<li class="breadcrumb-item action">Approve RD</li>
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
				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="branchName">Branch Name</label> <select
							id="branchName" name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Branch</option>

						</select>
					</div>
				</div>

				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="fromDate">Date From</label> <input type="date"
							name="fromDate" id="fromDate" required="required"
							placeholder="Enter From Date" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="toDate">Date To</label> <input type="date"
							name="toDate" id="toDate" required="required"
							placeholder="Enter To Date" style="text-transform: uppercase;" />
					</div>
				</div>
			</div>
		</div>
</div>

<div class="row">
	<div class="col-12 text-center mt-3">
		<button id="saveBtn" class="btnStyle"
			style="background-color: #FFA500;">FIND</button>
	</div>
</div>
</form>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">Search result</h5>

				<table class="table table-borderless datatable style="white-space:nowrap;">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col"></th>
							<th scope="col" style="white-space: nowrap;">Sr.No</th>
							<th scope="col" style="white-space: nowrap;">Policy Code</th>
							<th scope="col" style="white-space: nowrap;">Policy Date</th>
							<th scope="col" style="white-space: nowrap;">customer Code</th>
							<th scope="col" style="white-space: nowrap;">policy Amount</th>
							<th scope="col" style="white-space: nowrap;">maturity Date</th>
							<th scope="col" style="white-space: nowrap;">client Name</th>
							<th scope="col" style="white-space: nowrap;">contac tNo</th>
							<th scope="col" style="white-space: nowrap;">renewalDate</th>
							<th scope="col" style="white-space: nowrap;">Branch Name</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
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


<!-- <script src="js/chartScript.js"></script> -->
<script src="./js/adminscript.js"></script>
<script src="./js/RequestApproval/ApprovalRD.js"></script>
