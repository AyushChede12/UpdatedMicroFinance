
<div class="pagetitle">
	<h1>Data Correction</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-pencil-square"></i>
			</a></li>
			<li class="breadcrumb-item action">Saving Account Correction</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-5">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 20px;">
						<label for="accountNumber">Select By Account No</label> <select
							id="accountNumber" name="accountNumber" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-- Search Account No --</option>
						</select>
					</div>
				</div>

			</div>
			<hr>
			<div class="row">
				<div class="col-lg-3">
					<!-- <div class="d-flex flex-column formFields" style="margin-bottom: 30px">
                <label>Verify With</label>
                <div class="position-relative">
                  <div class="select-btn1" style="cursor: pointer;">
                    <span name="cityName" id="cityNameId" style="font-size: 12px;">Select</span> <i
                      class="fa-solid fa-angle-down"></i>
                  </div>
                  <div class="content" id="contentCityName" style="display: none;">
                    <div class="search">
                      <input type="text" id="city-search" class="m-0" placeholder="Search City" />
                    </div>
                    <ul class="options" id="city-options">
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                    </ul>
                  </div>
                </div>
              </div> -->
					<input type="hidden" name="id" id="id">
					<div class="d-flex flex-column formFields">
						<label for="">Opening Date</label> <input type="date"
							name="openingDate" id="openingDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Select By Customer</label> <select
							id="selectByCustomer" name="selectByCustomer" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Customer Name</label> <input type="text"
							name="enterCustomerName" id="enterCustomerName"
							required="required" placeholder="Enter Customer Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Date of Birth</label> <input type="date"
							name="dateOfBirth" id="dateOfBirth" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Age</label> <input type="text" name="customerAge"
							id="customerAge" required="required"
							placeholder="Enter Age
									style=" text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Relative Details</label> <input type="text"
							name="familyDetails" id="familyDetails" required="required"
							placeholder="Enter Relative Name & Relation"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Contact No</label> <input type="text" name="contactNumber"
							id="contactNumber" required="required"
							placeholder="Enter Contact No" style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label for="">Nominee Name</label> <input type="text"
							name="suggestedNomineeName" id="suggestedNomineeName"
							required="required" placeholder="Enter Nominee Name" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Age of Nominee </label><input type="text"
							name="suggestedNomineeAge" id="suggestedNomineeAge"
							required="required" placeholder="Enter :Age of Nominee " />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Nominee Relation</label> <select
							id="relationToApplicant" name="suggestedNomineeRelation"
							required="required" class="form-control selectField"
							style="height: 30px;">
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Address</label>
						<textarea name="address" id="address"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">District</label> <input type="text" name="district"
							id="district" required="required" placeholder="Enter District" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Branch Name</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">State</label> <input type="text" name="state"
							id="state" required="required" placeholder="Enter State" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Pin Code</label> <input type="text" name="pinCode"
							id="pinCode" required="required" placeholder="Enter Pincode" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Mode Of Operation</label> <select id="operationType"
							name="operationType" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Mode</option>
							<option value="Single">Single</option>
							<option value="Joint">Joint</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Joint Operation Code</label> <input type="text"
							name="jointOperationCode" id="jointOperationCode"
							required="required" placeholder="Enter Joint Operation Code" />

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Survivor Status Name</label> <input type="text"
							name="price" id="price" required="required"
							placeholder="Survivor Status Name" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Relation</label> <select id="familyRelation"
							name="familyRelation" required="required"
							class="form-control selectField" style="height: 30px;">

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Policy </label> <input type="text" name="selectPlan"
							id="selectPlan" required="required" placeholder="Enter Policy" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Opening Amount</label> <input type="text"
							name="openingAmount" id="openingAmount" required="required"
							placeholder="Enter Opening Amount" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Financial Code </label> <select
							id="financialConsultantCode" name="financialConsultantCode"
							required="required" class="form-control selectField"
							onchange="fetchByFinancialCode()" style="height: 30px;">

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Financial Name</label> <input type="text"
							name="financialConsultantName" id="financialConsultantName"
							required="required" placeholder="Enter Advisor Name" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="">Opening Charges(if any)</label> <input type="text"
							name="openingFees" id="openingFees" required="required"
							placeholder="Enter Opening Charges" />
					</div>
				</div>







			</div>

			<div class="row mt-4">
				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
						Photo <span class="star">*</span>
					</label> <label for="photo" id="drop-area"> <input accept="image/*"
						name="photo" id="photo" hidden="hidden"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="photoPreview" /><input type="hidden" name="photoHidden"
								id="photoHidden">

							<!-- <p id="upload-text"
                    style="font-size: 12px; margin-top: 15px"
                    class="text-muted"
                  >
                    Drag and drop or Choose File to upload the image
                  </p> -->
						</div>
					</label> <small id="chkphoto" style="color: red;"></small>
				</div>

				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
						Signature <span class="star">*</span>
					</label> <label for="signature" id="drop-area"> <input
						accept="image/*" name="signature" id="signature" hidden="hidden"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="signaturePreview" /><input type="hidden"
								name="signatureHidden" id="signatureHidden">
							<!-- <p
                    style="font-size: 12px; margin-top: 15px"
                    class="text-muted"
                  >
                    Drag and drop or Choose File to upload the image
                  </p> -->
						</div>
					</label> <small id="chksignature" style="color: red;"></small>
				</div>

				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Joint
						Photo <span class="star">*</span>
					</label> <label for="jointPhoto" id="drop-area"> <input
						accept="image/*" name="jointPhoto" id="jointPhoto" hidden="hidden"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="jointPhotoPreview" /><input type="hidden"
								name="jointPhotoHidden" id="jointPhotoHidden">
							<!-- <p
                    style="font-size: 12px; margin-top: 15px"
                    class="text-muted"
                  >
                    Drag and drop or Choose File to upload the image
                  </p> -->
						</div>
					</label> <small id="chkjointphoto" style="color: red;"></small>
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
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Mode of Payment </label> <select id="modeOfPayment"
							name="modeOfPayment" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>
							<option value="Cash">Cash</option>
							<option value="Online">Online</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Comments</label>
						<textarea name="comment" id="comment" placeholder="Enter Comments"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

			</div>

		</div>



		<div class="mt-5">

			<div class="row">
				<div class="col-lg-3">
					<div class=" h-100 d-flex justify-content-start align-items-center">
						<div
							class="d-flex justify-content-start align-items-center  formFields">
							<label style="margin-left: 20px;" class="mb-2">Account
								Status</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-account-status"
										name="accountStatus" class="toggle__input"
										data-toggle-type="account-status"> <label
										for="toggle-account-status" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class=" h-100 d-flex justify-content-start align-items-center"
						style="margin-bottom: 30px;">
						<div
							class="d-flex justify-content-start align-items-center  formFields">
							<label style="margin-left: 20px;" class="mb-2">SMS Send</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-sms-send" name="messageSend"
										class="toggle__input" data-toggle-type="sms-send"> <label
										for="toggle-sms-send" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class=" h-100 d-flex justify-content-start align-items-center">
						<div
							class="d-flex justify-content-start align-items-center  formFields">
							<label style="margin-left: 20px;" class="mb-2">Debit Card
								Issue</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-debit-card"
										name="debitCardIssue" class="toggle__input"
										data-toggle-type="debit-card"> <label
										for="toggle-debit-card" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>

			<div class="row">
				<div class="col-12 text-center" style="margin-top: 30px;">
					<button type="button" id="updateBtn" class="btnStyle bg-success">Update</button>
					<button type="button" id="newBtn" class="btnStyle"
						style="background-color: #FFA500;">New</button>
					<button type="button" id="deleteBtn" class="btnStyle bg-primary">Delete</button>
				</div>
			</div>
		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/dataCorrection/savingAccountUpdate.js"></script>
