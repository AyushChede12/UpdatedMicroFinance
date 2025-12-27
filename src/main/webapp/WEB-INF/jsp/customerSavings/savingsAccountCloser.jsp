
<div class="pagetitle">
	<h1>SAVING / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action"> SAVING ACCOUNT CLOSER</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Saving Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Select Account Number</label> <select
							id="accountNumber" name="accountNumber" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Code </label> <input type="text"
							name="customerCode" id="customerCode" required="required"
							placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Name </label> <input type="text"
							name="customerName" id="customerName" required="required"
							placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Contact Number</label> <input type="text"
							name="contactNumber" id="contactNumber" required="required"
							placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Opening Branch</label> <input type="text"
							name="branchName" id="branchName" required="required"
							placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Opening Date</label> <input type="text"
							name="openingDate" id="openingDate" required="required"
							placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Current Balace</label> <input type="text"
							name="currentBalance" id="currentBalance" required="required"
							placeholder="" />
					</div>
				</div>

				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Interest Disbursement</label> <input type="text"
									name="interestDisbursement" id="interestDisbursement" required="required" placeholder="" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Outstanding Interest</label> <input type="text"
									name="outstandingInterest" id="outstandingInterest" required="required" placeholder="" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Net Balance</label> <input type="text" name="netBalance"
									id="netBalance" required="required" placeholder="" />
							</div>
						</div> -->

			</div>
		</div>

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Payment Details</li>
				</ol>
			</nav>
			<div class="row">


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Closing Branch</label> <select
							id="closingbranchName" name="closingbranchName"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Branch</option>

						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Closing Date</label> <input type="date"
							name="closingDate" id="closingDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Pay By</label> <select id="payBy" name="payBy"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select</option>
							<option value="Blue">Cash</option>
						</select>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Comments</label> <input type="text" name="comments"
							id="comments" required="required" placeholder="Enter Location" />
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-12 text-center">
					<button id="saveAccountCloseBtn" class="btnStyle"
						style="background-color: #FFA500; margin-left: 80%;">Close
						Account</button>
				</div>
			</div>

			<div class="row mt-4">
				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
						Photo <span class="star">*</span>
					</label> <label for="photo" id="drop-area"> <img id="photo"
						src="../images/upload/upload.png" alt="Photo Preview"
						style="width: 250px; height: 200px"> <input type="hidden"
						id="photoHidden" name="photo" value="">
					</label> <small id="chkphoto" style="color: red;"></small>
				</div>

				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
						Signature <span class="star">*</span>
					</label> <label for="signature" id="drop-area"> <img id="signature"
						src="../images/upload/upload.png" alt="signature Preview"
						style="width: 250px; height: 200px"> <input type="hidden"
						id="signatureHidden" name="photo" value="">
					</label> <small id="chksignature" style="color: red;"></small>
				</div>

			</div>
		</div>
	</form>

</div>
<script
	src="${pageContext.request.contextPath}/js/customerSavings/savingsAccountCloser.js"></script>
