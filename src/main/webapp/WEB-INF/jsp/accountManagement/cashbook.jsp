
<div class="pagetitle">
	<h1>ACCOUNT MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">CASH BOOK</li>
		</ol>
	</nav>
</div>

<form id="formid">
	<div>
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">SEARCH INFORMATION</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="">BRANCH NAME</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">--SELECT BRANCH--</option>
						</select>
					</div>
				</div>

				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">START DATE</label> <input type="date"
							name="startDate" id="startDate" required="required" />
					</div>
				</div>

				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">END DATE</label> <input type="date"
							name="endDate" id="endDate" required="required" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-12 text-center mt-3">
			<button type="button" onclick="getCashBook()" id="showDetilsBtn"
				class="btnStyle" style="background-color: #ff8400;">SHOW
				DETAILS</button>
		</div>
	</div>
</form>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<div
					class="card-header d-flex justify-content-between align-items-center">
					<h5 class="mb-0">SEARCH RESULT</h5>

					<div>
						<button class="btn btn-success btn-sm" onclick="exportToExcel()">Export</button>

						<button class="btn btn-primary btn-sm" onclick="printReport()">Print</button>
					</div>
				</div>


				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th style="white-space: nowrap;">SR NO.</th>
							<th style="white-space: nowrap;">DATE</th>
							<th style="white-space: nowrap;">TRANSACTION ID</th>
							<th style="white-space: nowrap;">ACCOUNT NO</th>
							<th style="white-space: nowrap;">DESCRIPTION</th>
							<th style="white-space: nowrap;">DEBIT (CASH IN)</th>
							<th style="white-space: nowrap;">CREDIT (CASH OUT)</th>
							<th style="white-space: nowrap;">BALANCE</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>

				<div class="text-end mt-3">
					<strong>Total Debit:</strong> <span id="totalDebit">0.00</span> | <strong>Total
						Credit:</strong> <span id="totalCredit">0.00</span> | <strong>Closing
						Balance:</strong> <span id="closingBalance">0.00</span>
				</div>
			</div>
		</div>
	</div>
</div>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script>
<script
	src="${pageContext.request.contextPath}/js/account-management/cashBook.js"></script>
