
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">Outgoing Payment Entry</li>
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
				<label for="">Branch Name <span class="star">*</span></label> <select
					id="searchBranchName" name="searchBranchName"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Branch Name</option>
				</select>
			</div>

		</div>

		<div class="col-lg-4">
			<div class="d-flex flex-column formFields">
				<label for="vehicalNo">Start Date <span class="star">*</span></label>
				<input type="date" name="startDate" id="startDate"
					style="text-transform: uppercase;" />
			</div>
		</div>

		<div class="col-lg-4">
			<div class="d-flex flex-column formFields">
				<label for="vehicalNo"> End Date <span class="star">*</span></label>
				<input type="date" name="endDate" id="endDate"
					style="text-transform: uppercase;" />
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
					id="entryBranchName" name="entryBranchName"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Branch Name</option>
				</select>
			</div>

		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Voucher ID <span class="star">*</span>
				</label> <input type="text" name="voucherID" id="voucherID"
					placeholder="Enter voucherID." disabled />

			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Date of Entry <span class="star">*</span></label> <input
					type="date" name="dateOfEntry" id="dateOfEntry"
					placeholder="Enter Registration Date" />
			</div>
		</div>

		<!-- Credit Ledger (Cash/Bank only) -->
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="creditLedger">Credit Ledger (Source)<span
					class="star">*</span></label> <select id="creditLedger" name="creditLedger"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Credit Ledger</option>
					<!-- Populate only Cash/Bank accounts of branch -->
				</select>
			</div>
		</div>
		<!-- Debit Ledger (Destination) -->
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="debitLedger">Debit Ledger (Destination)<span
					class="star">*</span></label> <select id="debitLedger" name="debitLedger"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select Debit Ledger</option>
					<!-- Populate Liabilities, Expenses, Equity (no Income) -->
				</select>
			</div>
		</div>


		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="">Transfer Mode <span class="star">*</span></label> <select
					id="transferMode" name="transferMode"
					class="form-control selectField" style="height: 30px;"
					onchange="toggleTransferFields(this.value)">
					<option value="">Select Transfer Mode</option>
					<option value="Cash">Cash</option>
					<option value="Bank">Bank</option>
					<option value="UPI">UPI</option>
					<option value="Cheque">Cheque</option>
					<option value="Online Transfer">Online Transfer</option>
				</select>

			</div>
		</div>

		<!-- Cheque Fields (hidden by default) -->
		<div class="col-lg-3 chequeFields d-none">
			<div class="d-flex flex-column formFields">
				<label for="">Cheque No <span class="star">*</span></label> <input
					type="text" name="chequeNo" id="chequeNo"
					placeholder="Enter Cheque No" />
			</div>
		</div>

		<div class="col-lg-3 chequeFields d-none">
			<div class="d-flex flex-column formFields">
				<label for="">Cheque Date <span class="star">*</span></label> <input
					type="date" name="chequeDate" id="chequeDate" />
			</div>
		</div>

		<div class="col-lg-3 chequeFields d-none">
			<div class="d-flex flex-column formFields">
				<label for="">Bank Name <span class="star">*</span></label> <input
					type="text" name="bankName" id="bankName"
					placeholder="Enter Bank Name" />
			</div>
		</div>

		<!-- Online Transfer Field (hidden by default) -->
		<div class="col-lg-3 onlineFields d-none">
			<div class="d-flex flex-column formFields">
				<label for="">Transaction Ref No <span class="star">*</span></label>
				<input type="text" name="transactionRef" id="transactionRef"
					placeholder="Enter Transaction Reference No" />
			</div>
		</div>


		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Transaction Amount <span class="star">*</span></label>
				<input type="text" name="transactionAmount" id="transactionAmount"
					placeholder="Enter Amount" />

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
							<th>ID</th>
							<th scope="col">Branch</th>
							<th scope="col">Voucher ID</th>
							<th scope="col">Date</th>
							<th scope="col">Credit Ledger</th>
							<th scope="col">Debit Ledger</th>
							<th scope="col">Mode</th>
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


<script>
	$(document).ready(function() {
		BranchNameDropdown();
		LedgerDropdown()
	});
</script>
<script
	src="${pageContext.request.contextPath}/js/account-management/outgoingPaymentEntry.js"></script>