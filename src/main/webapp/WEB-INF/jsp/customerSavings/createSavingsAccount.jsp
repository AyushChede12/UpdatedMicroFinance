
<div class="pagetitle">
	<h1>SAVING / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">CREATE SAVINGS ACCOUNT</li>
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

				<input type="hidden" name="accountNumber" id="accountNumber"
					placeholder="" value="${savingaccountnumber}" /> <input
					type="hidden" name="id" id="id" />

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Type Of Account</label> <select id="typeofaccount"
							name="typeofaccount" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="savingaccount">Saving Account</option>
							<option value="currentaccount">Current Account</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">Opening Date</label> <input type="date"
							name="openingDate" id="openingDate" required="required"
							placeholder="Opening Date" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Select By Customer</label> <select
							id="selectByCustomer" name="selectByCustomer" required
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>
							<!-- Add options here -->
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Enter Customer Name </label> <input type="text"
							name="enterCustomerName" id="enterCustomerName"
							required="required" placeholder="Enter Customer Name" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">Date Of Birth <span class="star">*</span></label>
						<input type="date" name="dateOfBirth" id="dateOfBirth"
							required="required" placeholder="Enter DateOfBirth"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Family Details</label> <input type="text"
							name="familyDetails" id="familyDetails" required="required"
							placeholder="Enter family Details" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Contact Number </label> <input type="text"
							name="contactNumber" id="contactNumber" required="required"
							placeholder="Enter contact Number" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Suggested Nominee Name </label> <input type="text"
							name="suggestedNomineeName" id="suggestedNomineeName"
							required="required" placeholder="Enter suggested Nominee Name" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Suggested Nominee Age </label> <input type="text"
							name="suggestedNomineeAge" id=suggestedNomineeAge
							required="required" placeholder="Enter suggested Nominee Age" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Suggested Nominee Relation</label> <input
							type="text" id="suggestedNomineeRelation"
							name="suggestedNomineeRelation" required="required"
							placeholder="" />
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
						<label for="">District</label> <input type="text" name="district"
							id="district" required="required" placeholder="Enter district" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Branch Name</label> <input type="text"
							id="branchName" name="branchName" required="required"
							placeholder="Enter district" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">State</label> <input type="text" name="state"
							id="state" required="required" placeholder="Enter state" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Pin Code</label> <input type="text" name="pinCode"
							id="pinCode" required="required" placeholder="Enter pinCode" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Operation Type</label> <select id="operationType"
							name="operationType" required="required"
							onchange="operationTypeFunc()" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select</option>
							<option value="Single">Single</option>
							<option value="Joint">Joint</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Joint Operation Code </label> <select
							id="jointOperationCode" name="jointOperationCode"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select</option>


						</select>
					</div>
				</div>

				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Joint Survivor Name</label> <input type="text"
									name="jointSurvivorCode" id="jointSurvivorCode"
									required="required" placeholder="Enter joint Survivor Code" />
							</div>
						</div> -->

				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Family Relation</label> <select
									id="familyRelation" name="familyRelation" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select</option>
								</select>
							</div>
						</div> -->

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Select Plan Name </label> <select id="selectPlan"
							name="selectPlan" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>

						</select>
					</div>
				</div>


				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Opening Amount</label> <input type="text"
									name="balance" id="balance" required="required"
									placeholder="Enter opening Amount" />
							</div>
						</div>
 -->
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Financial Consultant Code</label> <input type="text"
							name=financialConsultantCode id="financialConsultantCode"
							required="required" placeholder="Enter financial Consultant Code" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Financial Consultant Name</label> <input type="text"
							name="financialConsultantName" id="financialConsultantName"
							required="required" placeholder="Enter Financial Consultant Name" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Opening Fees (if any)</label> <input type="text"
							name="openingFees" id="openingFees" required="required"
							placeholder="Enter Opening Fees" />
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
			<li class="breadcrumb-item action">Payment Details</li>
		</ol>
	</nav>
	<div class="row">
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Authentication for</label> <select
					id="authenticateWith" name="authenticateWith" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Select</option>
					<option value="Aadhar">Aadhar</option>
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Mode of payment</label> <select id="modeOfPayment"
					name="modeOfPayment" required="required"
					class="form-control selectField" style="height: 30px;">
					<option selected="selected" value="">Select</option>
					<option value="Cash">Cash</option>
					<option value="Cheque">Cheque</option>
					<option value="Online">Online</option>
					<option value="NEFT">Neft</option>
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for=""> Comment</label>
				<textarea name="comment" id="comment"
					style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
			</div>
		</div>
		<div class="col-lg-3">
			<div class="h-100 d-flex justify-content-start align-items-center">
				<div
					class="d-flex justify-content-start align-items-center formFields">
					<label style="margin-left: 20px;" class="mb-2">Account
						Status</label>
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
					<label style="margin-left: 20px;" class="mb-2">Message Send</label>
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
					<label style="margin-left: 20px;" class="mb-2">Debit Card
						Issue</label>
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

		<div class="row">

			<div class="col-lg-6">
				<div class="d-flex align-items-center formFields" style="gap: 80px;">

					<!-- Check Locker -->
					<div class="d-flex align-items-center">
						<label class="mb-0 me-3">Check Locker</label>
						<div class="toggle">
							<input type="checkbox" id="toggle-check-locker"
								name="checkLocker" class="toggle__input"> <label
								for="toggle-check-locker" class="toggle__label"></label>
						</div>
					</div>

					<!-- Account Freeze -->
					<div class="d-flex align-items-center">
						<label class="mb-0 me-3">Account Freeze</label>
						<div class="toggle">
							<input type="checkbox" id="toggle-account-freeze"
								name="accountFreeze" class="toggle__input"> <label
								for="toggle-account-freeze" class="toggle__label"></label>
						</div>
					</div>

				</div>
			</div>

		</div>

		<!-- Cheque input fields -->
		<div id="chequeInputs" style="display: none;">
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Cheque No. </label> <input type="text"
							name="chequeNo" id="chequeNo" required="required"
							placeholder="Enter Cheque No." />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Cheque Date </label> <input type="Date"
							name="chequeDate" id="chequeDate" required="required"
							placeholder="Enter Cheque Date" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Deposit A/C </label> <input type="text"
							name="depositAcc1" id="depositAcc1" required="required"
							placeholder="Enter Deposite A/C No." />
					</div>
				</div>
			</div>
		</div>
		<!-- Online input fields -->
		<div id="onlineInputs" style="display: none;">
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Deposit A/C </label> <input type="text"
							name="depositAcc2" id="depositAcc2" required="required"
							placeholder="Enter Deposite A/C No." />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Ref Number </label> <input type="text"
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
						<label for="">Deposit A/C </label> <input type="text"
							name="depositAcc3" id="depositAcc3" required="required"
							placeholder="Enter Deposite A/C No." />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Ref Number </label> <input type="text"
							name="refNumber2" id="refNumber2" required="required"
							placeholder="Enter Deposite Ref No." />
					</div>
				</div>
			</div>
		</div>

		<div class="row mt-4">
			<div class="col-lg-3 mb-5">
				<label for=""
					style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Aadhar
					Card <span class="star">*</span>
				</label> <label for="photo" id="drop-area"> <img id="photo"
					src="../images/upload/upload.png" alt="Photo Preview"
					style="width: 250px; height: 200px"> <input type="hidden"
					id="photoHidden" name="photo" value="">
				</label> <small id="chkphoto" style="color: red;"></small>
			</div>
			<div class="col-lg-3 mb-5">
				<label for=""
					style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Pan
					Card <span class="star">*</span>
				</label> <label for="signature" id="drop-area"> <img id="signature"
					src="../images/upload/upload.png" alt="signature Preview"
					style="width: 250px; height: 200px"> <input type="hidden"
					id="signatureHidden" name="signatureHidden" value="">
				</label> <small id="chksignature" style="color: red;"></small>
			</div>
			<div class="col-lg-3 mb-5">
				<label
					style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
					Photo<span class="star">*</span>
				</label> <label for="newPhotoFile" id="drop-area"> <img
					id="newPhoto" src="../images/upload/upload.png" alt="Photo Preview"
					style="width: 250px; height: 200px; cursor: pointer;"> <input
					type="file" id="newPhotoFile" name="newPhoto" accept="image/*"
					style="display: none;">
				</label> <small id="chknewPhoto" style="color: red;"></small>
			</div>


			<div class="col-lg-3 mb-5">
				<label
					style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
					Signature<span class="star">*</span>
				</label> <label for="newSignatureFile" id="drop-area"> <img
					id="newSignature" src="../images/upload/upload.png"
					alt="Signature Preview"
					style="width: 250px; height: 200px; cursor: pointer;"> <input
					type="file" id="newSignatureFile" name="newSignature"
					accept="image/*" style="display: none;">
				</label> <small id="chknewSignature" style="color: red;"></small>
			</div>


			<div class="col-lg-3 mb-5" id="myJointPhoto">
				<label
					style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
					Joint Photo<span class="star">*</span>
				</label> <label for="jointPhotoFile" id="drop-area"> <img
					id="jointPhoto" src="../images/upload/upload.png"
					alt="Joint Photo Preview"
					style="width: 250px; height: 200px; cursor: pointer;"> <input
					type="file" id="jointPhotoFile" name="jointPhoto" accept="image/*"
					style="display: none;">
				</label> <small id="chkjointPhoto" style="color: red;"></small>
			</div>

		</div>

	</div>
	<!-- Cheque input fields -->
	<div id="chequeInputs" style="display: none;">
		<div class="row">
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">Cheque No. </label> <input type="text"
						name="chequeNo" id="chequeNo" required="required"
						placeholder="Enter Cheque No." />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">Cheque Date </label> <input type="Date"
						name="chequeDate" id="chequeDate" required="required"
						placeholder="Enter Cheque Date" />
				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">Deposit A/C </label> <input type="text"
						name="depositAcc1" id="depositAcc1" required="required"
						placeholder="Enter Deposite A/C No." />
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-12 text-center">
			<button id="saveBtn" class="btn btn-warning"
				style="margin-left: 80%;">Save</button>
			<button type="button" id="updateBtn" class="btnStyle bg-success">Update</button>
			<!-- onclick="updateSavingAccountData()" -->

		</div>
	</div>
	</form>

</div>
<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">
					Saving Account Data <span>| Table View</span>
				</h5>

				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">Sr No</th>
							<th scope="col">Account Number</th>
							<th scope="col">Account Type</th>
							<th scope="col">Customer Code</th>
							<th scope="col">Customer Name</th>
							<th scope="col">Mobile</th>
							<th scope="col">Branch Name</th>
							<th scope="col">Address</th>
							<th scope="col">City</th>
							<th scope="col">State</th>
							<th scope="col">Edit</th>
							<th scope="col">Delete</th>
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


