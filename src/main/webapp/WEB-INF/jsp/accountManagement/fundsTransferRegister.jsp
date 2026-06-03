
<div class="pagetitle">
	<h1>ACCOUNT MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home"><i
					class="bi bi-wallet2"></i></a></li>
			<li class="breadcrumb-item action">FUND TRANSFER REGISTER</li>
		</ol>
	</nav>
</div>

<form id="formid">
	<nav>
		<ol class="breadcrumb breadcrumb-title">
			<li class="breadcrumb-item action">SEARCH INFORMATION</li>
		</ol>
	</nav>

	<div class="row">
		<div class="col-lg-4">
			<label>BRANCH NAME</label> <select id="branchName"
				class="form-control">
				<option value="">--SELECT BRANCH--</option>
			</select>
		</div>

		<div class="col-lg-4">
			<label>START DATE</label> <input type="date" id="startDate"
				class="form-control" />
		</div>

		<div class="col-lg-4">
			<label>END DATE</label> <input type="date" id="endDate"
				class="form-control" />
		</div>
	</div>

	<div class="text-center mt-3">
		<button type="button" id="showBtn" class="btn btn-warning">SHOW
			DETAILS</button>
	</div>
</form>

<div class="card mt-4">
	<div class="card-header d-flex justify-content-between">
		<h5>SEARCH RESULT</h5>

		<div>
			<button class="btn btn-success btn-sm" onclick="exportToExcel()">Export</button>
			<button class="btn btn-primary btn-sm" onclick="printReport()">Print</button>
		</div>
	</div>

	<div class="card-body table-responsive">

		<table class="table table-bordered datatable">
			<thead>
				<tr>
					<th>SR NO</th>
					<th>DATE</th>
					<th>TRANSACTION ID</th>
					<th>ACCOUNT NO</th>
					<th>DESCRIPTION</th>
					<th class="text-end">DEBIT</th>
					<th class="text-end">CREDIT</th>
					<th class="text-end">BALANCE</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td colspan="8" class="text-center">No Data</td>
				</tr>
			</tbody>
		</table>

		<div class="text-end mt-3">
			<strong>Total Debit:</strong> <span id="totalDebit">0.00</span> | <strong>Total
				Credit:</strong> <span id="totalCredit">0.00</span> | <strong>Closing
				Balance:</strong> <span id="closingBalance">0.00</span>
		</div>

	</div>
</div>

<!-- ✅ Excel Library -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>

<script
	src="${pageContext.request.contextPath}/js/account-management/fundsTransferRegister.js"></script>

<script
	src="${pageContext.request.contextPath}/js/account-management/fundsTransferRegister.js"></script>