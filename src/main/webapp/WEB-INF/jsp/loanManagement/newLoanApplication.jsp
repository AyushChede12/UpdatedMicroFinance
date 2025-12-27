
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">New Loan Application</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">New Loan Details</li>
				</ol>
			</nav>
			<div class="row">
				<input type="hidden" id="loanId" name="loanId" value="${loanCode}">
				<input type="hidden" id="memberName" name="memberName">

				<div class="col-lg-3">

					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Loan Date</label> <input type="date"
							name="loanDate" id="loanDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Find Members</label> <select id="memberId" name="memberId"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select member name</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Relative Details</label> <input type="text"
							name="relativeDetails" id="relativeDetails" required="required"
							placeholder="Enter Relative Deatils"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Date of Birth </label> <input type="date"
							name="dateOfBirth" id="dateOfBirth" required="required"
							placeholder="" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Age </label> <input type="text" name="age" id="age"
							required="required" placeholder="Age" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Contact No.</label> <input type="text"
							name="contactNo" id="contactNo" required="required"
							placeholder="Enter Contact No." />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Address</label>
						<textarea name="address" id="address"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Pin Code</label> <input type="number"
							name="pinCode" id="pinCode" required="required"
							placeholder="Enter Pin Code" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Branch Name </label> <input type="text"
							name="branchName" id="branchName" required="required"
							placeholder="Branch Name" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Loan Plan Name</label> <select id="loanPlanName"
							name="loanPlanName" required="required"
							onchange="calculateCharges()" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Loan Plan</option>

						</select>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Type of Loan</label> <input type="text"
							name="typeOfLoan" id="typeOfLoan" required="required"
							placeholder="Type of Loan" style="text-transform: uppercase;" />

					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Mode</label> <input type="text" name="loanMode"
							id="loanMode" required="required"
							placeholder="Enter Loan Category"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Term</label> <input type="text" name="loanTerm"
							id="loanTerm" required="required" placeholder="Plan Duration"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Rate Of Interest(%)</label> <input type="text"
							name="rateOfInterest" id="rateOfInterest" required="required"
							placeholder="Enter Rate Of Interest"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Amount Of Loan </label> <input type="text"
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
							onclick="calculateEMI()" name="emiPayment" id="emiPayment"
							required="required" placeholder="Enter EMI Payment"
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

				<div class="col-lg-3">
					<div class="h-100 d-flex justify-content-start align-items-center">
						<div
							class="d-flex justify-content-start align-items-center formFields">
							<label for="messageStatus" style="margin-left: 20px;"
								class="mb-2">Message Status</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="messageStatus" name="messageStatus"
										class="toggle__input" data-toggle-type="member-status">
									<label for="messageStatus" class="toggle__label"></label>
								</div>
							</div>
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
							<img src="../images/upload/upload.png" alt="upload_icon"
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
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="signaturePreview" /> <input type="hidden"
								id="signatureHidden" name="signatureHidden">

						</div>
					</label>
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
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label> Member ID </label>
						<div class="position-relative">
							<select id="guarantorMemberId" name="guarantorMemberId"
								required="required" class="form-control selectField"
								style="height: 30px;">
								<option value="">Select member Code</option>

							</select>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Guarantor Identity</label> <select
							id="guarantorIdentity" name="guarantorIdentity"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">-Select-</option>
							<option value="Aadhar">Aadhar</option>
							<option value="Pan Card">Pan Card</option>
						</select>
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
						<label for="">Guarantor Contact No.</label> <input type="text"
							name="guarantorContactNo" id="guarantorContactNo"
							required="required" placeholder="Enter  Guarantor Contact No." />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Security Type</label> <select
							id="guarantorSecurityType" name="guarantorSecurityType"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Security</option>
							<option value="Pledge">Pledge</option>
							<option value="Mortgage">Mortgage</option>
							<option value="Property">Property</option>
							<option value="Gold">Gold</option>
						</select>
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
						<label> Member ID </label>
						<div class="position-relative">
							<select id="coApplicantMemberId" name="coApplicantMemberId"
								required="required" class="form-control selectField"
								style="height: 30px;">
								<option value="">Select member Code</option>

							</select>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Co-Applicant Identity</label> <select
							id="coApplicantIdentity" name="coApplicantIdentity"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">-Select-</option>
							<option value="Aadhar">Aadhar</option>
							<option value="Pan Card">Pan Card</option>
						</select>
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
						<label for="">Co-Applicant Contact No.</label> <input type="text"
							name="coApplicantContactNo" id="coApplicantContactNo"
							required="required" placeholder="Enter Gurantor Contact No." />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Security Type</label> <select
							id="coApplicantSecurityType" name="coApplicantSecurityType"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Security</option>
							<option value="Pledge">Pledge</option>
							<option value="Mortgage">Mortgage</option>
							<option value="Property">Property</option>
							<option value="Gold">Gold</option>
						</select>
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
						<label for="loanName">Processing Fee </label> <input type="text"
							name="processingFee" id="processingFee" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Legal Charges </label> <input type="text"
							name="legalCharges" id="legalCharges" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">GST</label> <input type="text" name="gst"
							id="gst" required="required" placeholder="Enter Stamp Duty Fee"
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
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Valuation Fees</label> <input type="text"
							name="valuationFees" id="valuationFees" required="required"
							placeholder="Enter Interest Charge"
							style="text-transform: uppercase;" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Stationary Charges Fee</label> <input type="text"
							name="stationaryFee" id="stationaryFee" required="required"
							placeholder="Enter Stationary Number Fee" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4"
						style="margin-bottom: 30px">
						<label> Financial Consultant Id</label>
						<div class="position-relative">
							<select id="financialConsultantId" name="financialConsultantId"
								required="required" class="form-control selectField"
								style="height: 30px;">
								<option value=""></option>

							</select>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Financial Consultant Name</label> <input type="text"
							name="financialConsultantName" id="financialConsultantName"
							required="required" placeholder=""
							style="text-transform: uppercase;" />
					</div>
				</div>



			</div>
		</div>

		<div class="row">
			<div class="col-12 text-center">
				<button id="saveBtn" class="btnStyle bg-success">Save</button>
				<!-- <button id="saveBtn" class="btnStyle" style="background-color: #FFA500;">Update</button>
                        <button id="saveBtn" class="btnStyle bg-primary">Print</button> -->
			</div>
		</div>
	</form>
</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
	const toggles = document.querySelectorAll('.toggle__input');
	
	toggles.forEach((toggle) => {
		updateToggleColor(toggle);

		toggle.addEventListener('change', () => {
			updateToggleColor(toggle);
			console.log(`${toggle.dataset.toggleType} is now ${toggle.checked}`);
		});
	});

	function updateToggleColor(input) {
		const label = input.nextElementSibling;
		if (label) {
			label.style.backgroundColor = input.checked ? '#28a745' : '#ccc';
		}
	}
});
</script>
<script
	src="${pageContext.request.contextPath}/js/LoanManagment/NewLoanApplicationjs.js"></script>