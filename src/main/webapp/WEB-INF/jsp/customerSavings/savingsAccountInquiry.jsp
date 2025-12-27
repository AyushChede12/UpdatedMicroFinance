

<div class="pagetitle">
	<h1>Customer Saving</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">Search Saving Account</li>
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
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="">Branch Name</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Branch</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">From Date</label> <input type="date"
							name="fromDate" id="fromDate" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">To Date</label> <input type="date"
							name="toDate" id="toDate" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Name</label> <input type="text"
							name="customerName" id="customerName" required="required"
							placeholder="Member Code" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Account Number</label> <select id="accountNumber"
							name="accountNumber" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Code</label> <input type="text"
							name="customerCode" id="customerCode" required="required"
							placeholder="Enter Customer Code" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Financial Consultant Code</label> <input type="text"
							name="financialConsultantCode" id="financialConsultantCode"
							required="required" placeholder="Enter Financial Consultant Code" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Plan name</label> <select id="schemename"
							name="schemename" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>
						</select>
					</div>
				</div>
			</div>
			<!-- <div class="row">
                        <div class="col-12 text-center">
                            <button id="saveBtn" class="btn btn-warning" style="margin-left: 80%;">Search</button>
                            <button id="saveBtn" class="btn btn-warning" style="background-color: orangered;">Print</button>
                        </div>
                    </div> -->
		</div>

		<div class="row mt-5">
			<div class="col-12">
				<div class="card recent-sales">

					<div class="card-body table-responsive">
						<h5 class="card-title">
							Search Result <span>| Today</span>
						</h5>

						<table class="table table-borderless datatable overflow-scroll">
							<thead class="table-light">
								<tr style="font-family: 'Poppins', sans-serif;">
									<th scope="col">Sr No</th>
									<th scope="col">Account Number</th>
									<th scope="col">Account Type</th>
									<th scope="col">Customer Code</th>
									<th scope="col">Customer Name</th>
									<th scope="col">Mobile</th>
									<th scope="col">Branch Name</th>
									<th scope="col">Address</th>
									<th scope="col">City</th>
									<th scope="col">State</th>
									<th scope="col">Opening Date</th>
									<th scope="col">Financial Consultant Code</th>
									<th scope="col">Plan Name</th>
									<th scope="col">Approve Status</th>
								</tr>
							</thead>
							<tbody id="tableSavingAcc">

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</form>

</div>
<script>
	$(document).ready(function() {
		searchInTheSavingAcc();
		AccNoDropdown();
		schemeNameDropdown();
	});
</script>
<script
	src="${pageContext.request.contextPath}/js/customerSavings/savingsAccountEnquiry.js"></script>