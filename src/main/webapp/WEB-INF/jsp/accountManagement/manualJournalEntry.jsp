
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">Manual Journal Entry</li>
		</ol>
	</nav>
</div>


<form id="searchForm">
	<nav>
		<ol class="breadcrumb breadcrumb-title">
			<li class="breadcrumb-item action">Search Box</li>
		</ol>
	</nav>
	<div class="row">
		<div class="col-lg-4">
			<div class="d-flex flex-column formFields">
				<label for=""> Branch Name <span class="star">*</span></label> <select
					id="searchBranchName" name="searchBranchName" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Branch</option>
				</select>
			</div>
		</div>

		<div class="col-lg-4">
			<div class="d-flex flex-column formFields">
				<label for="vehicalNo">Start Date <span class="star">*</span></label>
				<input type="date" name="startDate" id="startDate"
					required="required" placeholder="Enter From Date"
					style="text-transform: uppercase;" />
			</div>
		</div>

		<div class="col-lg-4">
			<div class="d-flex flex-column formFields">
				<label for="vehicalNo">End Date <span class="star">*</span></label>
				<input type="date" name="endDate" id="endDate" required="required"
					placeholder="Enter To Date" style="text-transform: uppercase;" />
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-12 text-center mt-3">
			<button id="searchBtn" class="btnStyle"
				style="background-color: #FFA500;">Search</button>
		</div>
	</div>
</form>

<form id="formid">

	<div class="row">
		<div class="col-lg-12">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action mt-3">Entry Details</li>
				</ol>
			</nav>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="">Branch Name <span class="star">*</span></label> <select
					id="entryBranchName" name="entryBranchName" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Branch</option>
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Voucher ID <span class="star">*</span></label> <input
					type="text" name="voucherID" id="voucherID" required="required"
					placeholder="Enter voucher no." disabled />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Date of Entry <span class="star">*</span></label> <input
					type="date" name="dateOfEntry" id="dateOfEntry" required="required"
					placeholder="Enter Registration Date" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="">Credit Ledger (Source) <span class="star">*</span></label>
				<select id="creditLedger" name="creditLedger" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Credit Ledger</option>
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="">Debit Ledger (Destination) <span class="star">*</span></label>
				<select id="debitLedger" name="debitLedger" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">--Select Debit Ledger--</option>
				</select>
			</div>
		</div>


		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Transaction Amount <span class="star">*</span></label>
				<input type="text" name="transactionAmount" id="transactionAmount"
					required="required" placeholder="Enter Amount" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="">Remarks</label>
				<textarea name="remarks" id="remarks"
					style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-12 text-center mt-3">
			<button id="saveBtn" class="btnStyle"
				style="background-color: #FFA500;">Save</button>
			<button type="button" id="toggleBtn" class="btnStyle bg-primary"
				onclick="showTableData()">Show</button>
		</div>
	</div>

</form>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">Search result</h5>

				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">ID.</th>
							<th scope="col">Branch</th>
							<th scope="col">Voucher ID</th>
							<th scope="col">Date</th>
							<th scope="col">Credit Ledger</th>
							<th scope="col">debit Ledger</th>
							<th scope="col">Amount</th>
							<th scope="col">Remarks</th>
							<th scope="col">View</th>

						</tr>
					</thead>
					<tbody id="tableBody">
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/account-management/manualJournalEntry.js"></script>
<script>
	$(document).ready(function() {
		BranchNameDropdown();
		LedgerDropdown()
	});
</script>
