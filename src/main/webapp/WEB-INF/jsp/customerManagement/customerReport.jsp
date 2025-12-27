
<style>
.bank-report table th, .bank-report table td {
	vertical-align: middle;
}

.bank-report table thead th {
	background-color: #0d6efd !important;
	color: white;
}
</style>

		<div class="pagetitle">
			<h1>Customer Management</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="openDashboard"> <i
							class="bi bi-people-fill"></i>
					</a></li>
					<li class="breadcrumb-item action">Customer Report</li>
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
								<label for="">Branch</label> <select id="branchName"
									name="branchName" required="required"
									class="form-control selectField">
									<option value="">Select Branch</option>
								</select>
							</div>
						</div>

						<div class="col-lg-4">
							<div class="d-flex flex-column formFields">
								<label for="vehicalNo">Date From</label> <input type="date"
									name="fromDate" id="fromDate" required="required"
									placeholder="Enter From Date"
									style="text-transform: uppercase;" />
							</div>
						</div>

						<div class="col-lg-4">
							<div class="d-flex flex-column formFields">
								<label for="vehicalNo">Date To</label> <input type="date"
									name="toDate" id="toDate" required="required"
									placeholder="Enter To Date" style="text-transform: uppercase;" />
							</div>
						</div>
					</div>
				</div>
			</form>
		</div>

		<div class="row">
			<div class="col-12 text-center mt-3">
				<button id="searchBtn" class="btnStyle"
					style="background-color: #FFA500;">Search</button>
			</div>
		</div>
		</form>

		<div class="row mt-5">
			<div class="col-12">
				<div class="card recent-sales">

					<div class="card-body table-responsive">
						<h5 class="card-title">SEARCH RESULT</h5>


						<div style="overflow-x: auto; white-space: nowrap;">
							<table class="table table-borderless datatable">
								<thead class="table-light">
									<tr style="font-family: 'Poppins', sans-serif;">
										<th scope="col">SL NO</th>
										<th scope="col">CUSTOMER CODE</th>
										<th scope="col">CUSTOMER NAME</th>
										<th scope="col">BRANCH NAME</th>
										<th scope="col">DATE OF BIRTH</th>
										<th scope="col">FAMILY MEMBER NAME</th>
										<th scope="col">ADDRESS</th>
										<th scope="col">CONTACT NO</th>
										<th scope="col">AADHAR NO</th>
										<th scope="col">PAN</th>
										<th scope="col">REGISTRATION DATE</th>
										<th scope="col">APPROVAL STATUS</th>
										<th scope="col">PRINT</th>
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- Customer Account Modal -->
		<div class="modal fade" id="bankReportModal" tabindex="-1"
			aria-hidden="true">
			<div class="modal-dialog modal-lg modal-dialog-scrollable">
				<div class="modal-content">

					<!-- Header -->
					<div class="modal-header bg-primary text-white">
						<h5 class="modal-title">CUSTOMER REPORT</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"></button>
					</div>

					<!-- Body -->
					<div class="modal-body" id="bankReportContent">
						<div class="p-4"
							style="font-family: Arial, sans-serif; background-color: #f8f9fa;">

							<!-- Bank Header -->
							<div
								class="d-flex justify-content-between align-items-center border-bottom pb-2 mb-3">
								<div class="d-flex align-items-center">
									<img id="bankLogo" src="https://i.ibb.co/zFSWbkC/banklogo.png"
										style="height: 50px; margin-right: 10px;">
									<div>
										<h4 class="fw-bold text-primary mb-0" id="bankName"></h4>
										<small class="text-secondary" id="reportTitle"> </small>
									</div>
								</div>

								<div class="text-end">
									<p class="mb-0">
										<strong>CUSTOMER CODE:</strong> <span id="customerCode"></span>
									</p>
									<p class="mb-0">
										<strong>JOINED ON:</strong> <span id="signupDate"></span>
									</p>
								</div>
							</div>

							<!-- Customer Info -->
							<div class="border p-3 bg-white rounded shadow-sm mb-3">
								<h6 class="fw-bold text-primary mb-3">CUSTOMER INFORMATION</h6>
								<table class="table table-bordered">
									<tr>
										<th>NAME</th>
										<td id="customerName"></td>
									</tr>
									<tr>
										<th>GENDER</th>
										<td id="gender"></td>
									</tr>
									<tr>
										<th>DATE OF BIRTH</th>
										<td id="dob"></td>
									</tr>
									<tr>
										<th>AGE</th>
										<td id="age"></td>
									</tr>
									<tr>
										<th>MARITAL STATUS</th>
										<td id="maritalStatus"></td>
									</tr>
								</table>
							</div>

							<!-- Contact Info -->
							<div class="border p-3 bg-white rounded shadow-sm mb-3">
								<h6 class="fw-bold text-primary mb-3">CONTACT INFORMATION</h6>
								<table class="table table-bordered">
									<tr>
										<th>MOBILE</th>
										<td id="contactNo"></td>
									</tr>
									<tr>
										<th>EMAIL</th>
										<td id="email"></td>
									</tr>
									<tr>
										<th>ADDRESS</th>
										<td id="address"></td>
									</tr>
									<tr>
										<th>STATE</th>
										<td id="state"></td>
									</tr>
									<tr>
										<th>DISTRICT</th>
										<td id="district"></td>
									</tr>
									<tr>
										<th>PINCODE</th>
										<td id="pincode"></td>
									</tr>
								</table>
							</div>

							<!-- KYC Info -->
							<div class="border p-3 bg-white rounded shadow-sm mb-3">
								<h6 class="fw-bold text-primary mb-3">KYC DETAILS</h6>
								<table class="table table-bordered">
									<tr>
										<th>AADHAR</th>
										<td id="aadhar"></td>
									</tr>
									<tr>
										<th>PAN</th>
										<td id="pan"></td>
									</tr>
									<tr>
										<th>VOTER ID</th>
										<td id="voter"></td>
									</tr>
									<tr>
										<th>DRIVING LICENSE</th>
										<td id="driving"></td>
									</tr>
								</table>
							</div>

							<!-- Photo & Signature -->
							<div class="row">
								<div class="col-md-6 text-center">
									<h6 class="text-primary fw-bold">PHOTO</h6>
									<img id="photoPreview"
										src="https://via.placeholder.com/120x120"
										class="img-thumbnail mt-2" style="height: 120px;">
								</div>
								<div class="col-md-6 text-center">
									<h6 class="text-primary fw-bold">SIGNATURE</h6>
									<img id="signaturePreview"
										src="https://via.placeholder.com/120x60"
										class="img-thumbnail mt-2" style="height: 60px;">
								</div>
							</div>

						</div>
					</div>

					<!-- Footer -->
					<div class="modal-footer">
						<div class="dropdown">
							<button class="btn btn-success dropdown-toggle" type="button"
								data-bs-toggle="dropdown" aria-expanded="false">
								Download As</button>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#" id="downloadPDF">PDF</a></li>
								<li><a class="dropdown-item" href="#" id="downloadWord">Word</a></li>
								<li><a class="dropdown-item" href="#" id="downloadExcel">Excel</a></li>
							</ul>
						</div>
						<button type="button" class="btn btn-secondary"
							data-bs-dismiss="modal">Close</button>
					</div>

				</div>
			</div>
		</div>

	<!-- Add libraries at bottom of page -->
	<!-- <script
		src="https://cdnjs.cloudflare.com/ajax/libs/jspdf/2.5.1/jspdf.umd.min.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/xlsx/0.18.5/xlsx.full.min.js"></script> -->
<script
	src="${pageContext.request.contextPath}/js/customerManagement/customerReport.js"></script>