
<div class="pagetitle">
	<h1>Joint Liability Loan</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-person-bounding-box"></i>
			</a></li>
			<li class="breadcrumb-item action">Group Loan Payment</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Loan Search Details</li>
				</ol>
			</nav>

			<div class="col-lg-3" style="margin-left: -15px;">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Select BY GroupID*</label> <select id="groupid"
						name="groupid" required="required"
						class="form-control selectField" style="height: 30px;">
						<option value="">Select Group ID</option>

					</select>
				</div>
			</div>
		</div>


		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Loan Info</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo"> Opening Date</label> <input type="date"
							name="openingDate" id="openingDate" required="required"
							readonly="readonly" placeholder="Enter Vehicle No"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for="">Community Name*</label> <input type="text"
							readonly="readonly" name="communityName" id="communityName"
							required="required" placeholder="Enter Location" />
					</div>
				</div>

				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for="">Branch Name*</label> <input type="text"
							readonly="readonly" name="branchname" id="branchname"
							required="required" placeholder="Enter Location" />
					</div>
				</div>

				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for="">Loan Scheme Name*</label> <input type="text"
							readonly="readonly" name="loanSchemeName" id="loanSchemeName"
							required="required" placeholder="Enter Location" />
					</div>
				</div>

				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for="">Community Address* </label> <input type="text"
							readonly="readonly" name="communityAddress" id="communityAddress"
							required="required" placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for="">Contact Number,* </label> <input type="text"
							readonly="readonly" name="contactNumber" id="contactNumber"
							required="required" placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Loan Purpose* </label> <input type="text"
							name="loanpurpose" id="loanpurpose" required="required"
							placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> EMI Mode* </label> <input type="text"
							readonly="readonly" name="emiType" id="emiType"
							required="required" placeholder="Enter Location" />
					</div>
				</div>

				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Term* </label> <input type="text" name="term"
							readonly="readonly" id="term" required="required"
							placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Rate of Interest(%)* </label> <input type="text"
							readonly="readonly" name="rateOfInterest" id="rateOfInterest"
							required="required" placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Interest Type* </label> <input type="text"
							readonly="readonly" name="interestType" id="interestType"
							required="required" placeholder="Enter Location" />
					</div>
				</div>

				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label style="color: red; font-weight: bold;">Loan Amount*</label>
						<input type="text" id="loanAmount" name="loanAmount"
							required="required" placeholder="Enter Loan Amount"
							style="color: red; font-weight: bold; font-size: 12px; text-transform: uppercase;" />
					</div>
				</div>



				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> EMI Amount* </label> <input type="text"
							readonly="readonly" name="loanEmi" id="loanEmi"
							required="required" placeholder="Emi" />
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

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Deduction Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Processing Charges* </label> <input type="text"
							readonly="readonly" name="processingFee" id="processingFee"
							required="required" placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> GST Value* </label> <input type="text"
							readonly="readonly" name="gstPercentage" id="gstPercentage"
							required="required" placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Legal Charges* </label> <input type="text"
							readonly="readonly" name="legalCharges" id="legalCharges"
							required="required" placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Insurence Amount* </label> <input type="text"
							readonly="readonly" name="insuranceFee" id="insuranceFee"
							required="required" placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  ">
					<div class="d-flex flex-column formFields">
						<label for=""> Valuation Charges* </label> <input type="text"
							readonly="readonly" name="valuationFee" id="valuationFee"
							required="required" placeholder="Enter Location" />
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
							name="financialConsultantName" readonly="readonly"
							id="financialConsultantName" required="required" placeholder=""
							style="text-transform: uppercase;" />
					</div>
				</div>



			</div>




			<div class="mt-5">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">Payment Detalis</li>
					</ol>
				</nav>
				<div class="row">
					<div class="col-lg-3">

						<div class="d-flex flex-column formFields mb-4">
							<label for="loanName"> Date Of Payment </label> <input
								type="date" name="paymentDate" id="paymentDate"
								required="required" style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mb-4">
							<label for="loanName">Payment Status</label> <input type="text"
								value="" name="paymentStatus" id="paymentStatus"
								style="color: red; font-weight: bold; font-size: 12px; text-transform: uppercase;"
								required="required" />


						</div>
					</div>
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="referenceCode">Mode of Payment <span
								id="star">*</span></label> <select id="paymentMode" name="paymentMode"
								required="required" class="form-control selectField"
								style="height: 30px;">
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
								type="date" name="chequeDate" id="chequeDate"
								required="required" placeholder="Enter Cheque Date"
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
								name=charges required="required"
								class="form-control selectField" style="height: 30px;">
								<option value="">Select Yes/No</option>
								<option value="YES">Yes</option>
								<option value="NO">No</option>
							</select>
						</div>
					</div>
				</div>

			</div>

			<div class="row">
				<div class="col-12 text-center">
					<button id="groupPaymentBtn" class="btnStyle bg-success"
						style="margin-left: 80%">Payment</button>

				</div>
			</div>
		</div>
	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/Joinlibiliy/GroupLoanPayment.js"></script>
