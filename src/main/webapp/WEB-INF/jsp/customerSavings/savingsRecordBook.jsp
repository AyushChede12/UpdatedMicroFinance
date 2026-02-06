
<style>
@media print {
	body * {
		visibility: hidden !important;
	}
	#passbookSection, #TransactionSection {
		visibility: visible !important;
		position: absolute;
		left: 0;
		top: 0;
		width: 100%;
	}

	/* Hide sidebar, navbar, buttons during print */
	.sidebar, .navbar, .print-button, .download-button, .footer, .header,
		.btn, .action-buttons {
		display: none !important;
	}

	/* Optional: Remove page margins */
	@page {
		margin: 20mm;
	}
}
</style>
<div class="pagetitle">
	<h1>SAVING / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">SAVINGS RECORD BOOK</li>
		</ol>
	</nav>
</div>


<div>
	<nav>
		<ol class="breadcrumb breadcrumb-title">
			<li class="breadcrumb-item action">SEARCH DETAILS</li>
		</ol>
	</nav>
	<div class="row">
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">SELECT ACCOUNT TYPE</label> <select id="accountType"
					class="form-control selectField" style="height: 30px;">
					<option value="">--SELECT ACCOUNT--</option>
					<option value="savingaccount">SAVING ACCOUNT</option>
					<option value="currentaccount">CURRENT ACCOUNT</option>

				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">--SELECT ACCOUNT NO--</label> <select id=accountNumber
					class="form-control selectField" style="height: 30px;">
					<option value="">SELECT ACCOUNT</option>

				</select>
			</div>
		</div>
	</div>
	<div class="row"">
		<div class="col-12 text-center">
			<button id="btnSearchTransactionData" class="btn btn-success"
				onclick="displayTransactionDataList()">
				<span class="fa fa-search"></span> SEARCH
			</button>
			<button id="btnFrontPageOnSavingPassbook" class="btn btn-success"
				onclick="displaySavingfrontPage()">FRONT PAGE</button>
			<button id="btnTransactionPageOnSavingPassbook"
				class="btn btn-success" onclick="displaySavingTransaction()">TRANSACTION</button>
			<button id="btnHeadingOnSavingPassbook" onclick="displayHeadingSA()"
				class="btn btn-success">HEADING</button>
		</div>
	</div>
</div>

<div class="row mt-5">
	<div class="col-12" id="tableSection" style="display: none;">
		<div class="card recent-sales">
			<div class="card-body table-responsive">
				<h5 class="card-title">ACCOUNT HOLDER DETAILS</h5>

				<table class="table table-bordered">
					<thead class="table-light">
						<tr>
							<th>ID</th>
							<th>BRACH NAME</th>
							<th>ACCOUNT NO</th>
							<th>CUSTOMER NAME</th>
							<th>CUSTOMER CODE</th>
							<th>MOBILE NO</th>
							<th>ADDRESS</th>
							<th>OPENING DATE</th>
							<th>OPENING BALANCE</th>
						</tr>
					</thead>
					<tbody id="customerDetails">
						<!-- Rows will be appended dynamically or statically here
 -->
					</tbody>
				</table>

			</div>
		</div>
	</div>
</div>

<div class="mt-4">
	<div id="printbtnSection" style="display: none;">
		<div class="col-12 d-flex justify-content-end gap-2">
			<button type="button" class="btn btn-success" id="printBtn"
				onclick="printTransactionSection1()">
				<i class="fa-solid fa-print"></i>
			</button>
		</div>
	</div>
	<div class="row mt-5" id="passbookId">
		<!-- <div class="col-12" id="passbookSection"  style="display: none;">
						<div class="card recent-sales" >
							<div class="card-body table-responsive">
								Certificate Form Starts Here
								<div class="p-3">
									<h5 class="text-center mb-3" style="font-size: 20px;">
										<strong>Microfinance Pvt. Ltd</strong>
									</h5>

									Applicant Information
									
									<div class="row border">
										<div class="col-md-6" style="padding-top: 15px;">
											<p style="font-size: 13px;">
												<strong>Customer No. :</strong> <span id="customerNo"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Account No. :</strong> <span id="accountNo"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Account Holder Name :</strong> <span id="customerName"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>S/D/W/H/O :</strong> <span id="familyDetails"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Date Of Birth :</strong> <span id="dateOfBirth"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Contact No. :</strong> <span id="contactNo"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Email ID :</strong> <span id="emailId"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Mode Of Operation :</strong> <span id="operationType"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Aadhar No. :</strong> <span id="aadharNo"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Address :</strong> <span id="address"></span>
											</p>
										</div>
										<div class="col-md-6" style="padding-top: 15px;">
											<p style="font-size: 13px;">
												<strong>opening Date :</strong> <span id="openingDate"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Account Type :</strong> <span id="typeofaccount"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>IFSC Code :</strong> <span
													id="IFSCCode"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Date Of Issue :</strong> <span id="dateOfIssue"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Nomination Registered :</strong> <span id="nominationStatus"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Nomination Name :</strong> <span id="nominationName"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>Branch and Code :</strong> <span id="branch"></span>
											</p>
											<p style="font-size: 13px;">
												<strong>UPI :</strong> <span id="upi"></span>
											</p>
										</div>
									</div>

									
								</div>
								Certificate Form Ends Here

							</div>
						</div>
					</div> -->
		<div id="passbookSection" class="passbookSection"
			style="display: none;">
			<div style="width: 100%; margin: auto">
				<h1>MICROFINANCE SERVICES</h1>
				<p>ADDRESS : NAGPUR(440024) - MAHARASHTRA</p>
				<hr />
				<div class="d-flex justify-content-between">
					<p>
						CUSTOMER NO. <span id="customerNo"
							style="width: 12vw; display: inline-block;"></span>
					</p>
					<p>
						ACCOUNT NO.: <span id="accountNo"
							style="width: 20vw; display: inline-block;"></span>
					</p>
				</div>
				<div class="d-flex justify-content-between">
					<p>
						ACCOUNT HOLDER NAME: <span id="customerName"
							style="width: 12vw; display: inline-block;"></span>
					</p>
					<p>
						S/D/W/H/O : <span id="familyDetails"
							style="width: 20vw; display: inline-block;"></span>
					</p>
				</div>
				<div class="d-flex justify-content-between">
					<p>
						DATE OF BIRTH: <span id="dateOfBirth"
							style="width: 12vw; display: inline-block;"></span>
					</p>
					<p>
						CONTACT NO.: <span id="contactNo"
							style="width: 20vw; display: inline-block;"></span>
					</p>
				</div>
				<div class="d-flex justify-content-between">
					<p>
						EMAIL ID: <span id="emailId"
							style="width: 12vw; display: inline-block;"></span>
					</p>
					<p>
						MODE OF OPERATION: <span id="operationType"
							style="width: 17vw; display: inline-block;"></span>
					</p>
				</div>
				<div class="d-flex justify-content-between">
					<p>
						AADHAR NO.: <span id="aadharNo"
							style="width: 12vw; display: inline-block;"></span>
					</p>
					<p>
						ADDRESS: <span id="address"
							style="width: 22vw; display: inline-block;"></span>
					</p>
				</div>
				<div class="d-flex justify-content-between">

					<p>
						ACCOUNT TYPE: <span id="typeofaccount"
							style="width: 20vw; display: inline-block;"></span>
					</p>
					<p>
						DATE OF ISSUE: <span id="dateOfIssue"
							style="width: 20vw; display: inline-block;"></span>
					</p>
				</div>
				<!-- <div class="d-flex justify-content-between">
					<p>
						IFSC Code: <span id="IFSCCode"
							style="width: 12vw; display: inline-block;"></span>
					</p>					
				</div> -->

				<div class="d-flex justify-content-between">
					<p>
						BRANCH: <span id="branchName"
							style="width: 12vw; display: inline-block;"></span>
					</p>
					<p>
						UPI: <span id="upi" style="width: 25vw; display: inline-block;"></span>
					</p>
				</div>





				<div class="d-flex justify-content-end">
					<hr style="border-color: black; width: 20vw;">
					<p style="position: relative; top: 23px; right: 17rem">AUTHORIZED
						SIGNATURE</p>
				</div>
			</div>
		</div>
	</div>

	<div class="row mt-5">
		<div class="col-12" id="headingSection" style="display: none;">
			<div class="card recent-sales" id="headingId">
				<div class="card-body table-responsive">
					<!-- Certificate Form Starts Here -->
					<table id="heading-tabl">
						<thead>
							<tr style="color: Black;">
								<th scope="col"
									style="text-align: center; width: 100px; font-weight: 400;">TXN
									DATE</th>
								<th scope="col"
									style="text-align: center; width: 160px; font-weight: 400;">PARTICULARS</th>
								<th scope="col"
									style="text-align: center; width: 160px; font-weight: 400;">TRANSACTION
									TYPE</th>
								<th scope="col"
									style="text-align: center; width: 160px; font-weight: 400;">DEBIT/CREDIT</th>
								<th scope="col"
									style="text-align: center; width: 160px; font-weight: 400;">BALANCE</th>
							</tr>
						</thead>

						<tbody>
							<tr>
								<td><div
										style="width: 100%; height: 1px; background-color: black; margin-top: 5px;"></div></td>
								<td><div
										style="width: 100%; height: 1px; background-color: black; margin-top: 5px;"></div></td>
								<td><div
										style="width: 100%; height: 1px; background-color: black; margin-top: 5px;"></div></td>
								<td><div
										style="width: 100%; height: 1px; background-color: black; margin-top: 5px;"></div></td>
								<td><div
										style="width: 100%; height: 1px; background-color: black; margin-top: 5px;"></div></td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

	<div class="row mt-5">
		<div class="col-12" id="TransactionSection" style="display: none;">
			<div class="card recent-sales" id="transactionId">
				<div class="card-body table-responsive">
					<!-- Certificate Form Starts Here -->
					<table class="table " id="transaction-tabl">
						<thead>
							<tr style="color: White; background-color: #008385;">
								<th scope="col" style="text-align: center; width: 100px"></th>
								<th scope="col" style="text-align: center; width: 100px"></th>
								<th scope="col" style="text-align: center; width: 100px"></th>
								<th scope="col" style="text-align: center; width: 100px"></th>
								<th scope="col" style="text-align: center; width: 100px"></th>
							</tr>
						</thead>
						<tbody id="tableBody1">

						</tbody>

					</table>
				</div>
			</div>
		</div>
	</div>



</div>
<script
	src="${pageContext.request.contextPath}/js/customerSavings/passbook.js"></script>

