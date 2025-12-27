
<div class="pagetitle">
	<h1>SAVING/CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">CREATE ACCOUNT</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">SAVING/CURRENT DETAILS</li>
				</ol>
			</nav>
			<div class="row">

				<input type="hidden" name="accountNumber" id="accountNumber"
					placeholder="" value="${savingaccountnumber}" /> <input
					type="hidden" name="id" id="id" />

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">TYPE OF ACCOUNT</label> <select id="typeofaccount"
							name="typeofaccount" required="required"
							class="form-control selectField" style="height: 45px;">
							<option value="savingaccount">SAVING ACCOUNT</option>
							<option value="currentaccount">CURRENT ACCOUNT</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">OPENING DATE</label> <input type="date"
							name="openingDate" id="openingDate" required="required"
							placeholder="Opening Date" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="selectByCustomer">SELECT BY CUSTOMER</label> <select
							id="selectByCustomer" name="selectByCustomer" required
							class="form-control selectField"
							style="height: 45px; font-size: 14px; padding: 5px;">
							<option value="">SELECT</option>
							<!-- Add options here -->
						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">ENTER CUSTOMER NAME </label> <input type="text"
							name="enterCustomerName" id="enterCustomerName"
							required="required" placeholder="ENTER CUSTOMER NAME " />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">DATE OF BIRTH <span class="star">*</span></label>
						<input type="date" name="dateOfBirth" id="dateOfBirth"
							required="required" placeholder="ENTER DATEOFBIRTH"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">FAMILY DETAILS</label> <input type="text"
							name="familyDetails" id="familyDetails" required="required"
							placeholder="ENTER FAMILY DETAILS" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">CONTACT NUMBER </label> <input type="text"
							name="contactNumber" id="contactNumber" required="required"
							placeholder="ENTER CONTACT NUMBER " />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">SUGGESTED NOMINEE NAME </label> <input type="text"
							name="suggestedNomineeName" id="suggestedNomineeName"
							required="required" placeholder="ENTER SUGGESTED NOMINEE NAME" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">SUGGESTED NOMINEE AGE </label> <input type="text"
							name="suggestedNomineeAge" id=suggestedNomineeAge
							required="required" placeholder="ENTER SUGGESTED NOMINEE AGE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">SUGGESTED NOMINEE RELATION</label> <input
							type="text" id="suggestedNomineeRelation"
							name="suggestedNomineeRelation" required="required"
							placeholder="ENTER SUGGESTED NOMINEE RELATION" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">ADDRESS</label>
						<textarea name="address" id="address" placeholder="ENTER ADDRESS"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">DISTRICT</label> <input type="text" name="district"
							id="district" required="required" placeholder="ENTER DISTRICT" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">BRANCH NAME</label> <input type="text"
							id="branchName" name="branchName" required="required"
							placeholder="ENTER BRANCH NAME" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">STATE</label> <input type="text" name="state"
							id="state" required="required" placeholder="ENTER STATE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">PTN CODE</label> <input type="text" name="pinCode"
							id="pinCode" required="required" placeholder="ENTER PTN CODE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">OPERATION TYPE</label> <select id="operationType"
							name="operationType" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT</option>
							<option value="Single">SINGLE</option>
							<option value="Joint">Joint</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3" id="jointOperationCodeDiv">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">JOINT OPERATION CODE </label> <select
							id="jointOperationCode" name="jointOperationCode"
							required="required" class="form-control selectField"
							style="height: 45px;">
							<option value="">SELECT</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">JOINT SURVIVOR NAME</label> <input type="text"
							name="jointSurvivorCode" id="jointSurvivorCode"
							required="required" placeholder="ENTER JOINT SURVIVOR NAME" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">FAMILY RELATION</label> <select id="familyRelation"
							name="familyRelation" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">SELECT PLAN NAME </label> <select id="selectPlan"
							name="selectPlan" required="required"
							class="form-control selectField" style="height: 45px;">
							<option value="">SELECT</option>

						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">FINANCIAL CONSULTANT CODE</label> <input type="text"
							name="financialConsultantCode" id="financialConsultantCode"
							required="required"
							placeholder="ENTER  FINANCIAL CONSULTANT CODE" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">FINANCIAL CONSULTANT NAME</label> <input type="text"
							name="financialConsultantName" id="financialConsultantName"
							required="required" placeholder="ENTER FINANCIAL CONSULTANT NAME" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="position: relative; margin-bottom: 1rem;">

						<label for="balance">OPENING FEES (IF ANY)</label> <input
							type="text" name="balance" id="balance" class="form-control mb-3"
							placeholder="Total Opening Fees" />

						<!-- POPUP TABLE (SMALL SIZE) -->
						<table id="openingFeesTable" class="table table-bordered"
							style="font-size: 10px; position: absolute; bottom: 40px; left: 0; width: 90%; display: none; background: #fff; box-shadow: 0 1px 3px rgba(0, 0, 0, 0.2); z-index: 1000; table-layout: fixed;">

							<thead>
								<tr style="height: 26px;">
									<th style="padding: 3px; width: 28%;">INPUT</th>
									<th style="padding: 3px; width: 34%;">QTY</th>
									<th style="padding: 3px; width: 38%;">RESULT</th>
								</tr>
							</thead>

							<tbody>

								<tr style="height: 26px;">
									<td style="padding: 4px 2px;">₹2000</td>
									<td><input type="number" id="qty2000" min="0" value="0"
										class="form-control" oninput="calcOpeningFees()"
										style="height: 22px; font-size: 10px; padding: 2px;">
									</td>
									<td style="padding: 4px 2px;">₹<span id="res2000">0</span></td>
								</tr>

								<tr style="height: 26px;">
									<td style="padding: 4px 2px;">₹500</td>
									<td><input type="number" id="qty500" min="0" value="0"
										class="form-control" oninput="calcOpeningFees()"
										style="height: 22px; font-size: 10px; padding: 2px;">
									</td>
									<td style="padding: 4px 2px;">₹<span id="res500">0</span></td>
								</tr>

								<tr style="height: 26px;">
									<td style="padding: 4px 2px;">₹200</td>
									<td><input type="number" id="qty200" min="0" value="0"
										class="form-control" oninput="calcOpeningFees()"
										style="height: 22px; font-size: 10px; padding: 2px;">
									</td>
									<td style="padding: 4px 2px;">₹<span id="res200">0</span></td>
								</tr>

								<tr style="height: 26px;">
									<td style="padding: 4px 2px;">₹100</td>
									<td><input type="number" id="qty100" min="0" value="0"
										class="form-control" oninput="calcOpeningFees()"
										style="height: 22px; font-size: 10px; padding: 2px;">
									</td>
									<td style="padding: 4px 2px;">₹<span id="res100">0</span></td>
								</tr>

								<tr style="height: 26px;">
									<td style="padding: 4px 2px;">₹50</td>
									<td><input type="number" id="qty50" min="0" value="0"
										class="form-control" oninput="calcOpeningFees()"
										style="height: 22px; font-size: 10px; padding: 2px;">
									</td>
									<td style="padding: 4px 2px;">₹<span id="res50">0</span></td>
								</tr>

								<tr style="height: 26px;">
									<td style="padding: 4px 2px;">₹20</td>
									<td><input type="number" id="qty20" min="0" value="0"
										class="form-control" oninput="calcOpeningFees()"
										style="height: 22px; font-size: 10px; padding: 2px;">
									</td>
									<td style="padding: 4px 2px;">₹<span id="res20">0</span></td>
								</tr>

								<tr style="height: 26px;">
									<td style="padding: 4px 2px;">₹10</td>
									<td><input type="number" id="qty10" min="0" value="0"
										class="form-control" oninput="calcOpeningFees()"
										style="height: 22px; font-size: 10px; padding: 2px;">
									</td>
									<td style="padding: 4px 2px;">₹<span id="res10">0</span></td>
								</tr>

								<tr style="height: 26px;">
									<td style="padding: 4px 2px;">₹5</td>
									<td><input type="number" id="qty5" min="0" value="0"
										class="form-control" oninput="calcOpeningFees()"
										style="height: 22px; font-size: 10px; padding: 2px;">
									</td>
									<td style="padding: 4px 2px;">₹<span id="res5">0</span></td>
								</tr>

								<tr style="height: 30px;">
									<th colspan="2" style="padding: 4px 2px;">TOTAL OPENING
										FEES</th>
									<th style="padding: 4px 2px;">₹<span id="totalOpening">0</span></th>
								</tr>

							</tbody>
						</table>

					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="emailId"> </label> <input type="hidden" name="emailId"
							id="emailId" required="required"
							placeholder="Enter contact Number" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="aadharNo"> </label> <input type="hidden"
							name="aadharNo" id="aadharNo" required="required"
							placeholder="Enter contact Number" />
					</div>
				</div>
			</div>

		</div>
</div>


<div class="mt-5">
	<nav>
		<ol class="breadcrumb breadcrumb-title">
			<li class="breadcrumb-item action">PAYMENT DETAILS</li>
		</ol>
	</nav>
	<div class="row">
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">AUTHENTICATION fOR</label> <select
					id="authenticateWith" name="authenticateWith" required="required"
					class="form-control selectField" style="height: 45px;">
					<option value="">SELECT</option>
					<option value="Aadhar">AADHAR</option>
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">MODE OF PAYMENT</label> <select id="modeOfPayment"
					name="modeOfPayment" required="required"
					class="form-control selectField" style="height: 45px;">
					<option selected="selected" value="">SELECT</option>
					<option value="Cash">CASH</option>
					<option value="Cheque">CHEQUE</option>
					<option value="Online">ONLINE</option>
					<option value="NEFT">NEFT</option>
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for=""> COMMENT</label>
				<textarea name="comment" id="comment"
					style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
			</div>
		</div>
		<div class="col-lg-3">
			<div class="h-100 d-flex justify-content-start align-items-center">
				<div
					class="d-flex justify-content-start align-items-center formFields">
					<label style="margin-left: 20px;" class="mb-2">ACCOUNT
						STATUS</label>
					<div class="cont">
						<div class="toggle">
							<input type="checkbox" id="toggle-member-status"
								name="toggle-member-status" class="toggle__input"
								data-toggle-type="member-status"> <label
								for="toggle-member-status" class="toggle__label"></label>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="h-100 d-flex justify-content-start align-items-center">
				<div
					class="d-flex justify-content-start align-items-center formFields">
					<label style="margin-left: 20px;" class="mb-2">MESSAGE SEND</label>
					<div class="cont">
						<div class="toggle">
							<input type="checkbox" id="toggle-member-status1"
								name="toggle-member-status1" class="toggle__input"
								data-toggle-type="member-status"> <label
								for="toggle-member-status1" class="toggle__label"></label>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="h-100 d-flex justify-content-start align-items-center">
				<div
					class="d-flex justify-content-start align-items-center formFields">
					<label style="margin-left: 20px;" class="mb-2">DEBIT CARD
						ISSUE</label>
					<div class="cont">
						<div class="toggle">
							<input type="checkbox" id="toggle-member-status2"
								name="toggle-member-status2" class="toggle__input"
								data-toggle-type="member-status"> <label
								for="toggle-member-status2" class="toggle__label"></label>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="h-100 d-flex justify-content-start align-items-center">
				<div
					class="d-flex justify-content-start align-items-center formFields">
					<label style="margin-left: 20px;" class="mb-2">CHECK LOCKER</label>
					<div class="cont">
						<div class="toggle">
							<input type="checkbox" id="toggle-member-status3"
								name="toggle-member-status3" class="toggle__input"
								data-toggle-type="member-status"> <label
								for="toggle-member-status3" class="toggle__label"></label>
						</div>
					</div>
				</div>
			</div>
		</div>

	</div>
	<!-- Cheque input fields -->
	<div id="chequeInputs1" style="display: none;">
		<div class="row">
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">CHEQUE NO. </label> <input type="text"
						name="chequeNo" id="chequeNo" required="required"
						placeholder="Enter Cheque No." />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">CHEQUE DATE </label> <input type="Date"
						name="chequeDate" id="chequeDate" required="required"
						placeholder="Enter Cheque Date" />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">DEPOSIT A/C </label> <input type="text"
						name="depositAcc1" id="depositAcc1" required="required"
						placeholder="Enter Deposite A/C No." />
				</div>
			</div>
		</div>
	</div>
	<!-- Online input fields -->
	<div id="chequeInputs" style="display: none;">
		<div class="row">
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">DEPOSIT A/C </label> <input type="text"
						name="depositAcc2" id="depositAcc2" required="required"
						placeholder="Enter Deposite A/C No." />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">REF NUMBER </label> <input type="text"
						name="refNumber1" id="refNumber1" required="required"
						placeholder="Enter Deposite Ref No." />
				</div>
			</div>
		</div>
	</div>
	<!-- NEFT input fields -->
	<div id="neftInputs" style="display: none;">
		<div class="row">
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">DEPOSIT A/C </label> <input type="text"
						name="depositAcc3" id="depositAcc3" required="required"
						placeholder="Enter Deposite A/C No." />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">REF NUMBER </label> <input type="text"
						name="refNumber2" id="refNumber2" required="required"
						placeholder="Enter Deposite Ref No." />
				</div>
			</div>
		</div>
	</div>

	<div class="row mt-4">
		<div class="col-lg-3 mb-5">
			<label for=""
				style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">UPLOAD
				PHOTO <span class="star">*</span>
			</label> <label for="photo" id="drop-area"> <img id="photo"
				src="../images/upload/upload.png" alt="Photo Preview"
				style="width: 250px; height: 200px"> <input type="hidden"
				id="photoHidden" name="photo" value="">
			</label> <small id="chkphoto" style="color: red;"></small>
		</div>

		<div class="col-lg-3 mb-5">
			<label for=""
				style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">UPLOAD
				SIGNATURE <span class="star">*</span>
			</label> <label for="signature" id="drop-area"> <img id="signature"
				src="../images/upload/upload.png" alt="signature Preview"
				style="width: 250px; height: 200px"> <input type="hidden"
				id="signatureHidden" name="photo" value="">
			</label> <small id="chksignature" style="color: red;"></small>
		</div>

		<div class="col-lg-3 mb-5" id="jointPhotoDiv">
			<label for=""
				style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
				UPLOAD JOINT PHOTO <span class="star">*</span>
			</label> <label for="jointPhoto" id="drop-area"> <img id="jointPhoto"
				src="../images/upload/upload.png" alt="jointPhoto Preview"
				style="width: 250px; height: 200px"> <input type="hidden"
				id="jointPhotoHidden" name="jointPhoto" value="">
			</label> <small id="chkjointPhoto" style="color: red;"></small>
		</div>





	</div>
	<!-- Cheque input fields -->
	<div id="chequeInputs2" style="display: none;">
		<div class="row">
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">CHEQUE NO. </label> <input type="text"
						name="chequeNo" id="chequeNo" required="required"
						placeholder="Enter Cheque No." />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">CHEQUE DATE </label> <input type="Date"
						name="chequeDate" id="chequeDate" required="required"
						placeholder="Enter Cheque Date" />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">DEPOSIT A/C </label> <input type="text"
						name="depositAcc1" id="depositAcc1" required="required"
						placeholder="Enter Deposite A/C No." />
				</div>
			</div>
		</div>
	</div>


	<div class="row">
		<div class="col-12 text-center">

			<!-- SAVE -->
			<button type="button" id="saveBtn" class="btn btn-warning">SAVE</button>

			<!-- PRINT -->
			<button type="button" id="printBtn" class="btn btn-primary"
				style="margin-left: 10px;">
				<i class="fa fa-print"></i> PRINT
			</button>

			<!-- UPDATE -->
			<button type="button" id="updateBtn" class="btnStyle bg-success"
				style="margin-left: 10px;">UPDATE</button>

		</div>
	</div>

	</form>

</div>
<div class="row mt-5" style="margin-bottom: 50px;">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">
					SAVING ACCOUNT DATA <span>| TABLE VIEW</span>
				</h5>

				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">SR NO</th>
							<th scope="col">ACCOUNT NUMBER</th>
							<th scope="col">ACCOUNT TYPE</th>
							<th scope="col">CUSTOMER CODE</th>
							<th scope="col">CUSTOMER NAME</th>
							<th scope="col">MOBILE</th>
							<th scope="col">Branch Name</th>
							<th scope="col">ADDRESS</th>
							<th scope="col">CITY</th>
							<th scope="col">STATE</th>
							<th scope="col">EDIT</th>
							<th scope="col">DELETE</th>
						</tr>
					</thead>
					<tbody id="tbody">

					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
<script>
	 function updateToggleColor(input) {
		const label = input.nextElementSibling;
		if (label) {
			label.style.backgroundColor = input.checked ? '#28a745' : '#ccc';
		}
	} 
	
 document.addEventListener('DOMContentLoaded', function () {
	const toggles = document.querySelectorAll('.toggle__input');
	
	toggles.forEach((toggle) => {
		updateToggleColor(toggle);

		toggle.addEventListener('change', () => {
			updateToggleColor(toggle);
			console.log(`${toggle.dataset.toggleType} is now ${toggle.checked}`);
		});
	});
	
}); 


<script>    
document.addEventListener('DOMContentLoaded', function () {

    const modeSelect = document.getElementById('modeOfPayment');
    if (!modeSelect) return;

    modeSelect.addEventListener('change', function () {

        const chequeInputs = document.getElementById('chequeInputs');
        const onlineInputs = document.getElementById('onlineInputs');
        const neftInputs = document.getElementById('neftInputs');

        if (chequeInputs) chequeInputs.style.display = 'none';
        if (onlineInputs) onlineInputs.style.display = 'none';
        if (neftInputs) neftInputs.style.display = 'none';

        if (this.value === 'Cheque' && chequeInputs) {
            chequeInputs.style.display = 'block';
        }
        if (this.value === 'Online' && onlineInputs) {
            onlineInputs.style.display = 'block';
        }
        if (this.value === 'NEFT' && neftInputs) {
            neftInputs.style.display = 'block';
        }
    });
});

</script>
<script
	src="${pageContext.request.contextPath}/js/customerSavings/CreateSavingAccount.js"></script>


