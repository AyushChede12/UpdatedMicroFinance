
<div class="pagetitle">
	<h1>Request Approval</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-check-circle"></i>
			</a></li>
			<li class="breadcrumb-item action">Approve Saving Transactions</li>
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
				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="">Branch Name</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Branch Name</option>
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
		<button id="findsavingTransactionBtn" class="btnStyle"
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
								<th></th>
								<th scope="col">Sr No.</th>
								<th scope="col">Account Number</th>
								<th scope="col">Customer Name</th>
								<th scope="col">Opening Date</th>
								<th scope="col">Phone No.</th>
								<th scope="col">Customer Code</th>
								<th scope="col">Branch Name</th>
								<th scope="col">Opening Amount</th>
								<th scope="col">Mode Of Payment</th>
							</tr>
						</thead>
						<tbody id="searchSavingTransaction">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<div class="row">
	<div class="col-12 text-center mt-3" style="justify-content: end">
		<button id="approveSavingTransactionBtn" class="btnStyle"
			style="background-color: #FFA500;">Approve</button>
	</div>
</div>
</div>

<!-- <script src="js/chartScript.js"></script> -->
<script src="./js/adminscript.js"></script>
<script src="./js/RequestApproval/ApproveSavingTransaction.js"></script>
<script>
	$(document).ready(function() {
		searchInTheSavingTransaction();
		branchNameDropdown();

		// Button click filter
		$('#findsavingTransactionBtn').on('click', function(e) {
			e.preventDefault(); // Prevent form submission
			filterByBranchName();
		});

		// Button click Approve
		$('#approveSavingTransactionBtn').on('click', function(e) {
			e.preventDefault(); // Prevent form submission

			// Get all checked checkboxes
			$('.member-checkbox:checked').each(function() {
				const id = $(this).val();
				updateSavingTransactionApprovalStatus(id, true);
			});
		});

	});
</script>
