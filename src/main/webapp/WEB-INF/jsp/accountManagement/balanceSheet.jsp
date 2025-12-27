
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">Balance Sheet</li>
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
						<label for="">Branch Name</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Branch</option>
							<option value="Blue">Blue</option>
						</select>
					</div>
				</div>

				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Start Date</label> <input type="date"
							name="startDate" id="startDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">End Date</label> <input type="date"
							name="endDate" id="endDate" required="required"
							placeholder="Enter To Date" style="text-transform: uppercase;" />
					</div>
				</div>
			</div>
		</div>
</div>

<div class="row">
	<div class="col-12 text-center mt-3">
		<button id="search" class="btnStyle"
			style="background-color: #FFA500;">Search</button>
	</div>
</div>
</form>

<div class="row mt-5">
	<div class="col-12">
		<label for="vehicalNo"><b>Branch:</b></label><br> <label
			for="vehicalNo"><b>Start From:</b></label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<label for="vehicalNo"><b>End To:</b></label>
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">Search Result</h5>

				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">Liablities</th>
							<th scope="col">Amount</th>
							<th scope="col">Asset</th>
							<th scope="col">Amount</th>
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
	src="${pageContext.request.contextPath}/js/account-management/balanceSheet.js"></script>