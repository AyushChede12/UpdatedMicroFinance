
<div class="pagetitle">
	<h1>Maturity Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-calendar-check"></i>
			</a></li>
			<li class="breadcrumb-item action">Approve Status</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Serach box</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Branch <span id="star"> *</span></label> <select
							id="branchName" name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">All Branch</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">From Date <span id="star"> *</span>
							:
						</label> <input type="date" name="fromDate" id="fromDate"
							required="required" placeholder="Enter Member Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>To Date <span id="star"> *</span>:
						</label> <input type="date" name="toDate" id="toDate" required="required"
							placeholder="" style="text-transform: uppercase;" />
					</div>
				</div>


			</div>
			<div class="row">
				<div class="col-12 text-center">
					<button id="saveBtn" class="btn btn-dark"color:black">Search</button>

				</div>
			</div>
		</div>






		<div class="row mt-5">
			<div class="col-12">
				<div class="card recent-sales">

					<div class="card-body table-responsive">
						<h5 class="card-title">
							<center>Marurity Approval Report</center>
							<span>|</span>
						</h5>

						<table class="table table-borderless datatable overflow-scroll">
							<thead class="table-light">
								<tr style="font-family: 'Poppins', sans-serif;">
									<th scope="col">srno.</th>
									<th scope="col">Application Name</th>
									<th scope="col">Approval Branch</th>
									<th scope="col">Application Date</th>
									<th scope="col">Approval Date</th>
									<th scope="col">App User</th>
									<th scope="col">App.Remark</th>
									<th scope="col">Net Pay</th>
								</tr>
							</thead>
							<tbody>

							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/MaturityManagement/approvedStatus.js"></script>