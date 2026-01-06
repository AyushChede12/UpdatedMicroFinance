

<div class="pagetitle">
	<h1>SAVING / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">SAVINGS ACCOUNT INQUIRY</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">SERACH BOX</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="">BRANCH NAME</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT BRANCH</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">FROM DATE</label> <input type="date"
							name="fromDate" id="fromDate" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">TO DATE</label> <input type="date"
							name="toDate" id="toDate" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">CUSTOMER NAME</label> <input type="text"
							name="customerName" id="customerName" required="required"
							placeholder="MEMBER CODE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">ACCOUNT NUMBER</label> <select id="accountNumber"
							name="accountNumber" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">CUSTOMER CODE</label> <input type="text"
							name="customerCode" id="customerCode" required="required"
							placeholder="ENTER CUSTOMER CODE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">FINANCIAL CONSULTANT CODE</label> <input type="text"
							name="financialConsultantCode" id="financialConsultantCode"
							required="required" placeholder="ENTER FINANCIAL CONSULTANT CODE" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">PLAN NAME</label> <select id="schemename"
							name="schemename" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT</option>
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
							SEARCH RESULT <span>|TODAY</span>
						</h5>

						<table class="table table-borderless datatable overflow-scroll">
							<thead class="table-light">
								<tr style="font-family: 'Poppins', sans-serif;">
									<th scope="col">SR NO</th>
									<th scope="col">ACCOUNT NUMBER</th>
									<th scope="col">ACCOUNT TYPE</th>
									<th scope="col">CUSTOMER CODE</th>
									<th scope="col">CUSTOMER NAME</th>
									<th scope="col">MOBILE</th>
									<th scope="col">BRANCH NAME</th>
									<th scope="col">ADDRESS</th>
									<th scope="col">CITY</th>
									<th scope="col">STATE</th>
									<th scope="col">OPENING DATE</th>
									<th scope="col">FINANCIAL CONSULTANT CODE</th>
									<th scope="col">PLAN NAME</th>
									<th scope="col">APPROVE STATUS</th>
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