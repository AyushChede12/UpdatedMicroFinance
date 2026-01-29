
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">Trail Balance Report</li>
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
				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Branch Name</label> <select id=" branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Branch Name</option>
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
			<button id="viewBtn" class="btnStyle"
				style="background-color: #FFA500;">View</button>
		</div>
	</div>
</form>

<div class="row mt-5">
	<div class="col-12">
		<label for="vehicalNo"><b><u>Trail Balance</u></b></label><br> <label
			for="vehicalNo"><b>Branch :</b></label><br> <label
			for="vehicalNo"><b>Date :</b></label> Between
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title"></h5>

				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">Ledger Name</th>
							<th scope="col">Opening</th>
							<th scope="col">Debit</th>
							<th scope="col">Credit</th>
							<th scope="col">Closing</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
