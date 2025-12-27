
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Loan Document Print</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div class="">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details For Print</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Find By Loan Id</label> <select id="loanId"
							name="loanId" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Loan Id</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Select loan Document</label> <select
							id="loanDocument" name="loanDocument" required="required"
							class="form-control selectField" style="height: 30px;">
							<option>Select Document</option>
							<option value="applicantForm">Applicant Form</option>
							<option value="sanctionLetter">Sanction Letter</option>
							<option value="loanAgreement">Loan Agreement</option>

						</select> <span id="docTypeError"
							style="color: red; font-size: 13px; display: none;">
							Please select a document type To Print </span>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="col-12 text-center mb-4 mt-3">
						<button class="btnStyle bg-warning" id="generateDoc">Generate
							DOC</button>

					</div>
				</div>



			</div>
		</div>
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Loan Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Date of Loan</label> <input type="date"
							readonly="readonly" name="loanDate" id="loanDate"
							required="required" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Plan Name</label> <input type="text"
							readonly="readonly" name="loanPlanName" id="loanPlanName"
							required="required" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Rate Of Interest</label> <input type="text"
							name="rateOfInterest" id="rateOfInterest" readonly="readonly"
							required="required" placeholder="Enter Family Member Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Member Id & Name</label> <input type="text"
							name="memberId" id="memberId" required="required"
							readonly="readonly" placeholder=""
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Loan Term </label> <input type="text"
							name="loanTerm" readonly="readonly" id="loanTerm"
							required="required" placeholder="" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Interest Type</label> <input type="text"
							name="interestType" id="interestType" required="required"
							placeholder="Enter Mobile Number" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Relative Details</label> <input type="text"
							readonly="readonly" name="relativeDetails" id="relativeDetails"
							required="required" placeholder=" messageStatus" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Loan Mode</label> <input type="text"
							readonly="readonly" name="loanMode" id="loanMode"
							required="required" placeholder=" Enter Loan Mode" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="loanName">EMI Payment</label> <input type="text"
							name="emiPayment" id="emiPayment" required="required"
							readonly="readonly" placeholder="Enter Pin Code"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Contact No.</label> <input type="text"
							readonly="readonly" name="contactNo" id="contactNo"
							required="required" placeholder="Enter Branch Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Amount</label> <input type="text"
							readonly="readonly" name="loanAmount" id="loanAmount"
							required="required" placeholder="Enter Loan Plan Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

			</div>
		</div>
	</form>

	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales" id="receiptArea"></div>
		</div>
	</div>

	<!-- Print Button (hidden by default) -->
	<div style="text-align: center; margin-top: 20px;">
		<button id="printBtn" onclick="printDocument()"
			style="display: none; padding: 8px 20px; font-size: 16px; font-weight: bold; background: #007bff; color: #fff; border: none; border-radius: 6px; cursor: pointer;">
			Print</button>
	</div>

</div>

<script
	src="${pageContext.request.contextPath}/js/LoanManagment/LoanDocumentPrint.js"></script>