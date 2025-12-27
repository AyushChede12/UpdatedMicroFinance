
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Loan Approval</li>
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
							name="loanDate" id="loanDate" required="required"
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
							placeholder="Enter Mobile Number" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Message Status</label> <input type="text"
							name="messageStatus" id="messageStatus" required="required"
							placeholder=" messageStatus" />
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
						<label for="">Rate of Interest (%pa.) </label> <input type="text"
							name="rateOfInterest" id="rateOfInterest" required="required"
							placeholder="Enter Loan ROI" style="text-transform: uppercase;" />
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
						<label for=""> Interest Type</label> <input type="text"
							name="interestType" id="interestType" required="required"
							placeholder="Enter  Interest Type"
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
						<label for="">Purpose of Loan</label> <input type="text"
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
							required="required" placeholder="Enter Member ID" />
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
						<label for="">Pin Code</label> <input type="number"
							name="guarantorPinCode" id="guarantorPinCode" required="required"
							placeholder="Enter Pin Code" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Gurantor Contact No.</label> <input type="text"
							name="guarantorContactNo" id="guarantorContactNo"
							required="required" placeholder="Enter  Gurantor Contact No." />
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
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">

						<div class="position-relative">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Member Id</label> <input type="text"
									name="coApplicantMemberId" id="coApplicantMemberId"
									required="required" placeholder="Enter Member ID" />
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Gurantor Identity</label> <input type="text"
							name="coApplicantIdentity" id="coApplicantIdentity"
							required="required" placeholder="Enter Guranntor Identity" />
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
							required="required" placeholder="Enter  Gurantor Contact No." />
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
						<label for="loanName">Processing Fee(%) </label> <input
							type="text" name="processingFee" id="processingFee"
							required="required" style="text-transform: uppercase;" />
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
						<label for="loanName">Insurence Fee</label> <input type="text"
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
		<div class="row mt-4">
			<div class="col-lg-3 mb-5">
				<label for=""
					style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
					Photo <span id="star">*</span>
				</label> <label for="Photo" id="drop-area"> <input type="file"
					accept="image/*" name="photo" id="photo" hidden="hidden"
					onchange=""
					style="background-size: cover; background-repeat: no-repeat" />
					<div id="img-view">
						<img src="../images/upload/upload.png" alt="photo"
							id="photoPreview" /> <input type="hidden" id="photoHidden"
							name="photoHidden">

					</div>
				</label>
			</div>


			<div class="col-lg-3 mb-5">
				<label for=""
					style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
					Signature <span id="star">*</span>
				</label> <label for="signature" id="drop-area"> <input type="file"
					accept="image/*" name="signature" id="signature" hidden="hidden"
					onchange="signatureUpload();"
					style="background-size: cover; background-repeat: no-repeat" />
					<div id="img-view">
						<img src="../images/upload/upload.png" alt="signature"
							id="signaturePreview" /> <input type="hidden"
							id="signatureHidden" name="signatureHidden">

					</div>
				</label>
			</div>

		</div>
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Approval Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Date Of Approval </label> <input type="date"
							name="approvalDate" id="approvalDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Approval Status</label> <input type="text"
							id="approvalStatus" name="approvalStatus" class="form-control"
							readonly
							style="font-size: 12px; font-weight: bold; text-transform: uppercase;" />

					</div>
				</div>

				<div class="col-12 text-center">
					<button id="approveBtn" class="btnStyle" name="approveBtn"
						style="background-color: #FFA500;">Approve It</button>
					<!-- <button id="saveBtn" class="btnStyle" style="background-color: #FFA500;">Update</button>
                            <button id="saveBtn" class="btnStyle bg-primary">Print</button> -->
				</div>

			</div>
		</div>

	</form>
</div>

<script
	src="${pageContext.request.contextPath}/js/LoanManagment/LoanApproval.js"></script>