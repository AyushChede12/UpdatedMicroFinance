
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Loan Payment</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div class="">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-5">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Find Loan By ID</label> <select id="findByLoanId"
							name="findByLoanId" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Loan ID</option>
						</select>
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
							name="loanPaymentDate" id="loanPaymentDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Member Search</label> <input type="text"
							name="memberId" id="memberId" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<input type="hidden" id="memberName" name="memberName">


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Family Member Name</label> <input
							type="text" name="relativeDetails" id="relativeDetails"
							required="required" placeholder="Enter Family Member Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Date Of Birth</label> <input type="date"
							name="dateOfBirth" id="dateOfBirth" required="required"
							placeholder="" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Age </label> <input type="text" name="age" id="age"
							required="required" placeholder="" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Contact No.</label> <input type="text"
							name="contactNo" id="contactNo" required="required"
							placeholder="Enter Contact No." />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Message Status</label> <input type="text"
							name="messageStatus" id="messageStatus" required="required"
							placeholder="SMS Notification" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Address</label>
						<textarea name="address" id="address"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="loanName">Pin Code</label> <input type="text"
							name="pinCode" id="pinCode" required="required"
							placeholder="Enter Pin Code" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Branch Address</label> <input type="text"
							name="branchName" id="branchName" required="required"
							placeholder="Enter Branch Name"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Plan Name</label> <input type="text"
							name="loanPlanName" id="loanPlanName" required="required"
							placeholder="Enter Loan Plan Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Type Of Loan</label> <input type="text"
							name="typeOfLoan" id="typeOfLoan" required="required"
							placeholder="Enter Type of Loan "
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Term</label> <input type="text" name="loanTerm"
							id="loanTerm" required="required"
							placeholder="Enter Plan Duration"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Mode</label> <input type="text" name="loanMode"
							id="loanMode" required="required" placeholder="Loan Category"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Rate of Interest (%pa.)</label> <input type="text"
							name="rateOfInterest" id="rateOfInterest" required="required"
							placeholder="Enter Loan Rate of Interest"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Amount Of Loan</label> <input type="text"
							name="loanAmount" id="loanAmount" required="required"
							placeholder="Enter Amount Of Loan"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Interest Type</label> <input type="text"
							name="interestType" id="interestType" required="required"
							placeholder="Enter Interest Type"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">EMI Payment</label> <input type="text"
							name="emiPayment" id="emiPayment" required="required"
							placeholder="Enter EMI Payment"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Purpose of Loan </label> <input type="text"
							name="purposeOfLoan" id="purposeOfLoan" required="required"
							placeholder="Enter Purpose of Loan"
							style="text-transform: uppercase;" />
					</div>
				</div>

			</div>
		</div>


		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Gurantor Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Member Id</label> <input type="text"
							name="guarantorMemberId" id="guarantorMemberId"
							required="required" placeholder="Enter Guranntor Id" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Gurantor Identity</label> <input type="text"
							name="guarantorIdentity" id="guarantorIdentity"
							required="required" placeholder="Enter Guranntor Identity" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Address</label>
						<textarea name="guarantorAddress" id="guarantorAddress"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Pin Code</label> <input type="text"
							name="guarantorPinCode" id="guarantorPinCode" required="required"
							placeholder="Enter Pin Code" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Grantor Contact No.</label> <input type="text"
							name="guarantorContactNo" id="guarantorContactNo"
							required="required" placeholder="Enter Gurantor Contact No." />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Security Type</label> <input type="text"
							name="guarantorSecurityType" id="guarantorSecurityType"
							required="required" placeholder="Enter  Security Type" />
					</div>
				</div>






			</div>


		</div>

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Co-Applicant Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Member Id</label> <input type="text"
							name="coApplicantMemberId" id="coApplicantMemberId"
							required="required" placeholder="Enter Gurantor Id" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Gurantor Identity </label> <input type="text"
							name="coApplicantIdentity" id="coApplicantIdentity"
							required="required" placeholder="Enter Gurantor Identity" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Address</label>
						<textarea name="coApplicantAddress" id="coApplicantAddress"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Pin Code</label> <input type="text"
							name="coApplicantPinCode" id="coApplicantPinCode"
							required="required" placeholder="Enter Pin Code" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Gurantor Contact No.</label> <input type="text"
							name="coApplicantContactNo" id="coApplicantContactNo"
							required="required" placeholder="Enter Gurantor Contact No." />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Security Type</label> <input type="text"
							name="coApplicantSecurityType" id="coApplicantSecurityType"
							required="required" placeholder="Enter  Security Type" />
					</div>
				</div>






			</div>



		</div>

		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Deduction Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Processing Fee(%)</label> <input type="text"
							name="processingFee" id="processingFee" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Legal Charges(%)</label> <input type="text"
							name="legalCharges" id="legalCharges" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="loanName">Insurence Fee(%)</label> <input type="text"
							name="insuranceFee" id="insuranceFee" required="required"
							placeholder="Enter insurence fees"
							style="text-transform: uppercase;" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4"
						style="margin-bottom: 30px">
						<label> Financial Consultant Id</label>
						<div class="d-flex flex-column formFields mb-4">
							<input type="text" name="financialConsultantId"
								id="financialConsultantId" required="required"
								placeholder="Enter Member ID" />
						</div>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Financial Consultant Name</label> <input type="text"
							name="financialConsultantName" id="financialConsultantName"
							required="required" placeholder="Enter Advisor/Collector Name"
							style="text-transform: uppercase;" />
					</div>
				</div>




			</div>
		</div>
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Payment Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName"> Date Of Payment </label> <input type="date"
							name="paymentDate" id="paymentDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Payment Status</label> <input type="text"
							value="Paid" name="paymentStatus" id="paymentStatus" readonly
							style="color: red; font-weight: bold; font-size: 12px; text-transform: uppercase;"
							required="required" />


					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="referenceCode">Mode of Payment <span id="star">*</span></label>
						<select id="paymentMode" name="paymentMode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Enter Mode of Payment</option>
							<option value="Cash">CASH</option>
							<option value="Online">Online</option>
							<option value="Cheque">Cheque</option>
							<option value="NEFT">NEFT</option>


						</select>
					</div>
				</div>


				<div class="col-lg-3" id="displayCheque">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Cheque Number <span id="star">*</span></label> <input
							type="text" name="chequeNo" id="chequeNo" required="required"
							placeholder="Enter Cheque No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3" id="displaycheqdate">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Cheque Date <span id="star">*</span></label> <input
							type="date" name="chequeDate" id="chequeDate" required="required"
							placeholder="Enter Cheque Date"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3" id="displaydeposit">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Deposit Account <span id="star">*</span></label> <input
							type="text" name="accountNo" id="accountNo" required="required"
							placeholder="Enter Deposit Account"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<input type="hidden" id="noOfInst" name="noOfInst">

				<div class="col-lg-3" id="displayRef">
					<div class="d-flex flex-column formFields">
						<label for="">Ref Number/UPI ID</label> <input type="text"
							name="ref_UpiId" id="ref_UpiId" required="required"
							placeholder="Enter Deposit Account"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Chrg. Deduct Cash</label> <select id="charges"
							name="charges" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Yes/No</option>
							<option value="YES">Yes</option>
							<option value="NO">No</option>
						</select>
					</div>
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="loanName">Remarks</label> <input type="text"
						name="remarks" id="remarks" required="required"
						style="text-transform: uppercase;" />
				</div>
			</div>

			<div class="col-12 text-center">
				<button id="paymentBtn" class="btnStyle"
					style="background-color: #FFA500;">Payment</button>

			</div>

		</div>
	</form>
</div>
<script
	src="${pageContext.request.contextPath}/js/LoanManagment/LoanPayment.js"></script>