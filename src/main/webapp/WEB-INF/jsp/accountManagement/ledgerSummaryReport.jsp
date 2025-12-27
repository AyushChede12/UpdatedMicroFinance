
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">Ledger Summary Report</li>
		</ol>
	</nav>
</div>

<div>
	<form id="ledgerSummaryForm">

		<nav>
			<ol class="breadcrumb breadcrumb-title">
				<li class="breadcrumb-item action">Search Information</li>
			</ol>
		</nav>
		<div class="row">
			<div class="col-lg-3">
				<label>Branch Name</label> <select id="branchName" name="branchName"
					required class="form-control selectField" style="height: 30px;">
					<option value="">Select Branch</option>
				</select>
			</div>

			<div class="col-lg-3">
				<label>Ledger Name</label> <select id="ledgerName" name="ledgerName"
					required class="form-control selectField" style="height: 30px;">
					<option value="">Select Ledger</option>
				</select>
			</div>

			<div class="col-lg-3">
				<label>Start Date</label> <input type="date" name="startDate"
					id="startDate" class="form-control" required />
			</div>

			<div class="col-lg-3">
				<label>End Date</label> <input type="date" name="endDate"
					id="endDate" class="form-control" required />
			</div>
		</div>

		<div class="row mt-3">
			<div class="col text-center">
				<button type="submit" id="viewBtn"
					class="btn btn-warning text-white px-4">View</button>
			</div>
		</div>
	</form>
</div>
<!-- Ledger Summary Table -->
<div class="row mt-5">
	<div class="col-12">
		<div id="summaryInfo" class="mb-3"></div>

		<div class="card recent-sales">
			<div class="card-body table-responsive">
				<table class="table table-borderless datatable">
					<thead class="table-light">
						<tr>
							<th>Date</th>
							<th>Voucher ID</th>
							<th>Remarks</th>
							<th>Account Code</th>
							<th>Debit</th>
							<th>Credit</th>
						</tr>
					</thead>
					<tbody id="ledgerSummaryBody">
						<!-- Data rows will be inserted here -->
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
	src="${pageContext.request.contextPath}/js/account-management/ledgerSummaryReport.js"></script>
