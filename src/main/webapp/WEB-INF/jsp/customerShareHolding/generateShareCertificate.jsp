
<div class="pagetitle">
	<h1>CUSTOMER SHAREHOLDING </h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-building-fill-down"></i>
			</a></li>
			<li class="breadcrumb-item action">GENERATE SHARE CERTIFICATE </li>
		</ol>
	</nav>
</div>
<div>
	<nav>
		<ol class="breadcrumb breadcrumb-title">
			<li class="breadcrumb-item action">CUSTOMER DETAILS</li>
		</ol>
	</nav>
	<div class="row">
		<div class="col-lg-6">
			<div class="d-flex flex-column formFields">
				<label for="">REFERRAL CODE ENTRY :</label> <select
					id="referralCodeEntry" name="referralCodeEntry" required="required"
					class="form-control selectField mb-4" style="height: 30px;">
					<option value="">SELECT CUSTOMER</option>
				</select>
			</div>
		</div>
	</div>

	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">
				<div class="card-body table-responsive">
					<div class="d-flex justify-content-between align-items-center">
						<h5 class="card-title">
							SEARCH RESULT <span>| SHARE DATA LIST</span>
						</h5>
					</div>
					<table class="table table-borderless datatable overflow-scroll">
						<thead class="table-light">
							<tr style="font-family: 'Poppins', sans-serif;">
								<th scope="col">SELECT</th>
								<th scope="col">SR.NO</th>
								<th scope="col">CUSTOMER CODE</th>
								<th scope="col">CUSTOMER NAME</th>
								<th scope="col">SHARE AMOUNT</th>
								<th scope="col">NO. OF SHARE</th>
								<th scope="col">CERTIFICATE NO.</th>
							</tr>
						</thead>
						<tbody id="shareholdingTableBody">
						</tbody>
					</table>
				</div>
			</div>
			<button type="button" class="btn btn-warning mt-3"
				id="printCertificateBtn" style="float: right;">
				<i class="fa-solid fa-certificate"></i> VIEW CERTIFICATE
			</button>
		</div>
	</div>

	<div class="row mt-4">
		<div id="certificateSection" style="display: none; width: 100%;">
			<div class="col-12 d-flex justify-content-end gap-2 mb-3">
				<button type="button" class="btn btn-success" id="printBtn">
					<i class="fa-solid fa-print"></i> PRINT
				</button>
				<button type="button" class="btn btn-primary" id="downloadBtn">
					<i class="fa-solid fa-download"></i> DOWNLOAD
				</button>
			</div>
			<div class="row">
				<div class="col-12">
					<div class="card recent-sales" id="cetificateId" style="border: 2px solid #28a745; background-color: #fcfcfc;">
						<div class="card-body table-responsive">
							<!-- Certificate Form Starts Here -->
							<div class="p-4">
								<h3 class="text-center mb-2" style="color: #1b5e20; font-weight: bold;">
									SAMITHA URBAN NIDHI LTD.
								</h3>
								<h5 class="text-center text-muted mb-4">SHARE CERTIFICATE</h5>

								<!-- Applicant Information -->
								<div class="row mb-3" style="font-size: 14px;">
									<div class="col-md-6">
										<strong>CUSTOMER: </strong> <span id="customeridandName"></span>
									</div>
									<div class="col-md-6 text-md-end">
										<strong>CERTIFICATE NO.: </strong> <span id="certificateno" style="font-weight: bold; color: #0d6efd;"></span>
									</div>
								</div>

								<!-- Policy Details Section -->
								<h6 class="mt-4 border-bottom pb-2" style="font-size: 16px; font-weight: bold;">
									SHARE DETAILS
								</h6>
								<div class="row p-3 bg-light rounded border">
									<div class="col-md-6">
										<p style="font-size: 13px;">
											<strong>NUMBER OF SHARES :</strong> <span id="numberofshare"></span>
										</p>
										<p style="font-size: 13px;">
											<strong>AMOUNT TRANSFERRED :</strong> <span id="amounttransferred"></span>
										</p>
										<p style="font-size: 13px;">
											<strong>BRANCH :</strong> <span id="branchname"></span>
										</p>
										<p style="font-size: 13px;">
											<strong>START DATE :</strong> <span id="startdate"></span>
										</p>
									</div>
									<div class="col-md-6">
										<p style="font-size: 13px;">
											<strong>BALANCE SHARES :</strong> <span id="balanceshare"></span>
										</p>
										<p style="font-size: 13px;">
											<strong>SHARE ISSUED BY :</strong> <span id="shareissuedby"></span>
										</p>
										<p style="font-size: 13px;">
											<strong>DATE OF TRANSFER :</strong> <span id="dataoftransfer"></span>
										</p>
										<p style="font-size: 13px;">
											<strong>MODE OF PAYMENT :</strong> <span id="modeofpayement"></span>
										</p>
									</div>
								</div>

								<div class="row mt-5">
									<div class="col-6 text-center">
										<p class="border-top pt-2" style="width: 200px; margin: 0 auto; font-size: 13px;">Authorized Signatory</p>
									</div>
									<div class="col-6 text-center">
										<p class="border-top pt-2" style="width: 200px; margin: 0 auto; font-size: 13px;">Director / Manager</p>
									</div>
								</div>
							</div>
							<!-- Certificate Form Ends Here -->
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script
	src="${pageContext.request.contextPath}/js/CustomerShareHolding/GenerateShareCertificate.js"></script>