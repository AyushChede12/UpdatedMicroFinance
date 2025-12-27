
<div class="pagetitle">
	<h1>Secured Gold Loan</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Gold Loan Document</li>
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
						<label for="findByGoldLoanId" id="goldSelection">Gold ID </label>
						<select id="findByGoldLoanId" name="findByGoldLoanId"
							class="form-control selectField" style="width: 100%;">
							<option value="">-- Search Gold ID --</option>
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
					<li class="breadcrumb-item action">Gold Loan Details</li>
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
						<label for="customerCode">Customer Code</label> <input type="text"
							name="customerCode" id="customerCode" required="required"
							readonly="readonly" placeholder="Enter Customer Code"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="customerName">Customer Name</label> <input type="text"
							name="customerName" id="customerName" required="required"
							readonly="readonly" placeholder="Enter Customer Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Plan Name</label> <input type="text"
							readonly="readonly" name="loanPlanName" id="loanPlanName"
							placeholder="Enter Plan Name" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Rate Of Interest</label> <input type="text"
							name="rateOfInterest" id="rateOfInterest" readonly="readonly"
							required="required" placeholder="Enter Rate Of Interest"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Loan Term </label> <input type="text"
							name="loanTerm" readonly="readonly" id="loanTerm"
							required="required" placeholder="Enter Loan Term" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Interest Type</label> <input type="text"
							name="interestType" id="interestType" required="required"
							placeholder="Enter Interest Type" />
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
							readonly="readonly" placeholder="Enter EMI Payment"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Contact No.</label> <input type="text"
							readonly="readonly" name="contactNo" id="contactNo"
							required="required" placeholder="Enter Contact No"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Amount</label> <input type="text"
							readonly="readonly" name="loanAmount" id="loanAmount"
							required="required" placeholder="Enter Loan Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Item Name</label> <input type="text"
							readonly="readonly" name="itemName" id="itemName"
							required="required" placeholder="Enter Item Name"
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
	src="${pageContext.request.contextPath}/js/SecuredGoldLoan/goldLoanDocument.js"></script>