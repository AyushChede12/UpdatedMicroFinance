
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">Daily Transaction Book</li>
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
					<div class="d-flex flex-column formFields">
						<label for="">branch Name</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Branch</option>
							<option value="Blue">Blue</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Choose Ledger</label> <select id="chooseLedger"
							name="chooseLedger" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Ledger</option>
							<option value="Blue">Blue</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Start Date</label> <input type="date"
							name="startDate" id="startDate" required="required"
							placeholder="Enter From Date" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
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
			<button id="serachBtn" class="btnStyle"
				style="background-color: #FFA500;">Search</button>
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
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">ID</th>
							<th scope="col">Branch Type</th>
							<th scope="col">Ledger</th>
							<th scope="col">Date</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

