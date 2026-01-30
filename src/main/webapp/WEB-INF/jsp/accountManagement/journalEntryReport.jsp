
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">Journal Entry Report</li>
		</ol>
	</nav>
</div>

<form id="formid">
<div>
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Information</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<label>Branch Name</label> <select id="branchName"
						name="branchName" required class="form-control selectField"
						style="height: 30px;">
						<option value="">Select Branch</option>
					</select>
				</div>

				<div class="col-lg-3">
					<label>Voucher Type</label> <select id="voucherType"
						name="voucherType" required class="form-control selectField"
						style="height: 30px;">
						<option value="">Select Type</option>
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
		</div>
</div>

</form>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">Search Result</h5>

				<table class="table table-borderless datatable overflow-scroll">
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
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/account-management/journalEntryReport.js"></script>
