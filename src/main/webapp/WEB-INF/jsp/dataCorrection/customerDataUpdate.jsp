
<div class="pagetitle">
	<h1>Data Correction</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-pencil-square"></i>
			</a></li>
			<li class="breadcrumb-item action">Customer Data Update</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action" id="editmember">Edit Member</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-5">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 20px;">
						<label for="customerCode" id="customerSelection">Customer
							Selection </label> <select id="customerCode" name="customerCode"
							class="form-control selectField" style="width: 100%;">
							<option value="">-- Search Customer Code --</option>
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
					<input type="hidden" id="id" name="id">
					<div class="d-flex flex-column formFields">
						<label for="">Sign-up Date</label> <input type="date"
							name="signupDate" id="signupDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="major">Authenticate For</label>
						<!-- <select
									id="major" name="major" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select</option>
									<option value="Mr.">Mr.</option>
									<option value="Ms.">Ms.</option>
									<option value="Other">Other</option>
								</select> -->
						<input type="text" name="authenticateFor" id="authenticateFor"
							required="required" placeholder="Enter Major"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Customer Name</label> <input type="text"
							name="customerName" id="customerName" required="required"
							placeholder="Enter Customer Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Family Member Name</label> <input type="text"
							name="familyMemberName" id="familyMemberName" required="required"
							placeholder="Enter Family Name"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Relation to Applicant</label>
						<!-- <select
									id="relationToApplicant" name="relationToApplicant"
									required="required" class="form-control selectField"
									style="height: 30px;"> -->
						<input type="text" name="relationToApplicant"
							id="relationToApplicant" required="required"
							placeholder="Enter Relation" style="text-transform: uppercase;" />
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Gender</label>
						<!-- <select id="customerGender"
									name="customerGender" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select Gender</option>
									<option value="Male">Male</option>
									<option value="Female">Female</option>
									<option value="Other">Other</option>
								</select> -->
						<input type="text" name="customerGender" id="customerGender"
							required="required" placeholder="Enter Gender" />

					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Date of Birth </label> <input type="date" name="dob"
							id="dob" required="required" placeholder="Enter Relative Name"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label for="">Age</label> <input type="text" name="customerAge"
							id="customerAge" required="required" placeholder="Enter Age" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Relationship Status</label>
						<!-- <select
									id="relationshipStatus" name="relationshipStatus"
									required="required" class="form-control selectField"
									style="height: 30px;">
									<option value="">Select Marital Status</option>
									<option value="Married">Married</option>
									<option value="Unmarried">Unmarried</option>
									<option value="Divorced">Divorced</option>
									<option value="Single">Single</option>
								</select> -->
						<input type="text" name="relationshipStatus"
							id="relationshipStatus" required="required"
							placeholder="Enter Relationship Status" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Address</label>
						<textarea name="customerAddress" id="customerAddress"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>District</label> <input type="text" name="district"
							id="district" required="required" placeholder="Enter District" />
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
						<label for="">Branch Name</label>
						<!-- <select id="branchName"
									name="branchName" required="required"
									class="form-control selectField" style="height: 30px;">

								</select> -->
						<input type="text" name="branchName" id="branchName"
							required="required" placeholder="Enter Branch" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Pin Code</label> <input type="text" name="pinCode"
							id="pinCode" required="required" placeholder="Enter Pincode" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Aadhar No</label> <input type="text" name="aadharNo"
							id="aadharNo" required="required" placeholder="Enter Aadhar No" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Pan No</label> <input type="text" name="panNo"
							id="panNo" required="required" placeholder="Enter Pan No" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Voter No</label> <input type="text" name="voterNo"
							id="voterNo" required="required" placeholder="Enter Voter No" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Contact No</label> <input type="text"
							name="contactNo" id="contactNo" required="required"
							placeholder="Enter Contact No" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Email ID</label> <input type="text" name="emailId"
							id="emailId" required="required" placeholder="Enter Email ID" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Profession</label> <input type="text"
							name="profession" id="profession" required="required"
							placeholder="Enter Profession" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="">Academic background</label> <input type="text"
							name="academicBackground" id="academicBackground"
							required="required" placeholder="Enter Academic background" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label>Referral Code</label> <input type="text"
							name="referralCode" id="referralCode" required="required"
							placeholder="Enter Intro Referral Code" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label>Referral Name</label> <input type="text"
							name="referralName" id="referralName" required="required"
							placeholder="Enter Intro Referral Name" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label>Is Minor</label>
						<!-- <select id="minor" name="minor"
									required="required" class="form-control selectField"
									style="height: 30px;">
									<option value="">Select Minor</option>
									<option value="Yes">Yes</option>
									<option value="No">No</option>

								</select> -->
						<input type="text" name="minor" id="minor" required="required"
							placeholder="Enter Minor" />
					</div>
				</div>

			</div>

			<div class="row mt-4">
				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
						Photo <span class="star">*</span>
					</label> <label for="customerPhoto" id="drop-area"> <input
						type="file" accept="image/*" name="customerPhoto"
						id="customerPhoto" hidden="hidden" onchange="photoUpload();"
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
					</label> <label for="customerSignature" id="drop-area"> <input
						type="file" accept="image/*" name="customerSignature"
						id="customerSignature" hidden="hidden"
						onchange="signatureUpload();"
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



			</div>

		</div>


		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Nominee Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Suggested Nominee </label> <input type="text"
							name="nomineeName" id="nomineeName" required="required"
							placeholder="Enter Nominee Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="relationToApplicant">Nominee Relation</label>
						<!-- <select
									id="nomineeRelationToApplicant"
									name="nomineeRelationToApplicant" required="required"
									class="form-control selectField" style="height: 30px;">

								</select> -->
						<input type="text" name="nomineeRelationToApplicant"
							id="nomineeRelationToApplicant" required="required"
							placeholder="Enter Nominee Relation"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Nominee Address</label> <input type="text"
							name="nomineeAddress" id="nomineeAddress" required="required"
							placeholder="Enter Nominee Address"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Nominee KYC ID </label> <input type="text"
							name="nomineeKycNo" id="nomineeKycNo" required="required"
							placeholder="Enter Nominee KYC" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Nominee Contact No. </label> <input type="text"
							name="nomineeMobileNo" id="nomineeMobileNo" required="required"
							placeholder="Enter Nominee No" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Age Of Nominee </label> <input type="text"
							name="nomineeAge" id="nomineeAge" required="required"
							placeholder="Enter Nominee Age" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Nominee Pan No. </label> <input type="text"
							name="nomineePanNo" id="nomineePanNo" required="required"
							placeholder="Enter Pan No" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Nominee KYC Type </label>
						<!-- <select
									id="nomineeKycType" name="nomineeKycType" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select</option>
									<option value="Saving">Saving</option>
									<option value="Current">Current</option>

								</select> -->
						<input type="text" name="nomineeKycType" id="nomineeKycType"
							required="required" placeholder="Enter Nominee KYC Type"
							style="text-transform: uppercase;" />
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
							<label style="margin-left: 20px;" class="mb-2">
								Membership Status</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-member-status"
										name="memberStatus" class="toggle__input"
										data-toggle-type="member-status"> <label
										for="toggle-member-status" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class=" h-100 d-flex justify-content-start align-items-center">
						<div
							class="d-flex justify-content-start align-items-center  formFields">
							<label style="margin-left: 20px;" class="mb-2">Mobile
								Bank Access</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-mobile-banking"
										name="memberBanking" class="toggle__input"
										data-toggle-type="mobile-banking"> <label
										for="toggle-mobile-banking" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class=" h-100 d-flex justify-content-start align-items-center">
						<div
							class="d-flex justify-content-start align-items-center  formFields">
							<label style="margin-left: 20px;" class="mb-2">Net
								Banking</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-net-banking"
										name="netBanking" class="toggle__input"
										data-toggle-type="net-banking"> <label
										for="toggle-net-banking" class="toggle__label"></label>
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
									<input type="checkbox" id="toggle-sms-send" name="smsSend"
										class="toggle__input" data-toggle-type="sms-send"> <label
										for="toggle-sms-send" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-12 text-center" style="margin-top: 30px;">
					<button id="printBtn" class="btn btn-warning">Print</button>
					<button id="updateBtn" class="btn btn-success">Update</button>
					<button id="deleteBtn" class="btn btn-danger">Delete</button>
				</div>
			</div>
		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/dataCorrection/customerDataUpdate.js"></script>
