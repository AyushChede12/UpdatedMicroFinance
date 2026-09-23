<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

	<style>
		.uploadField {
			margin-top: 10px;
		}

		.uploadField img {
			width: 100%;
			height: 150px;
			object-fit: contain;
			border: 1px solid #ccc;
			padding: 4px;
			border-radius: 8px;
		}

		.img-box {
			position: relative;
			display: inline-block;
		}

		.img-box .deleteImg {
			position: absolute;
			top: 5px;
			right: 5px;
			background: rgba(0, 0, 0, 0.6);
			color: white;
			border: none;
			border-radius: 50%;
			width: 24px;
			height: 24px;
			font-size: 16px;
			line-height: 22px;
			text-align: center;
			cursor: pointer;
			display: none;
		}

		.img-box:hover .deleteImg {
			display: block;
		}
	</style>

	<div class="pagetitle">
		<h1>CUSTOMER MANAGEMENT</h1>
		<nav>
			<ol class="breadcrumb">
				<li class="breadcrumb-item"><a href="openDashboard"> <i class="bi bi-people-fill"></i>
					</a></li>
				<li class="breadcrumb-item action">ADD CUSTOMER</li>
			</ol>
		</nav>
	</div>

	<div>
		<form id="formid">


			<div>
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">CUSTOMER DETAILS</li>
					</ol>
				</nav>
				<div class="row">

					<div class="col-lg-0">
						<div class="d-none flex-column formFields">
							<label for="">CUSTOMER CODE </label> <input name="memberCode" id="memberCode"
								value="${memberCode}" required="required" placeholder="Enter Customer Name" />
						</div>
					</div>
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="memberType">MEMBER TYPE <span class="star">*</span></label>
							<select id="memberType" name="memberType" required="required"
								class="form-control selectField" style="height: 30px;">
								<option value="">--SELECT MEMBER TYPE--</option>
								<option value="REGULAR">REGULAR MEMBER</option>
								<option value="SERVICE">SERVICE MEMBER</option>
								<option value="ORDINARY">ORDINARY MEMBER</option>
								<option value="ASSOCIATE">ASSOCIATE MEMBER</option>
							</select> <small id="chkmembertype" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="vehicalNo">SIGN-UP DATE <span class="star">*</span></label>
							<input type="date" style="text-transform: uppercase;" name="signupDate" id="signupDate" />
							<small id="chksignupdate" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3  mb-4">
						<div class="d-flex flex-column formFields">
							<label for="">(MR/MS) <span class="star">*</span></label> <select id="major" name="major"
								required="required" class="form-control selectField" style="height: 30px;">
								<option value="SELECT">SELECT</option>
								<option value="MR">MR</option>
								<option value="MS">MS</option>
							</select> <small id="chkmajor" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="firstName">FIRST NAME <span class="star">*</span></label>
							<input type="text" name="firstName" id="firstName" style="text-transform: uppercase;"
								placeholder="ENTER FIRST NAME" required /> <small id="chkfirstname"
								style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="middleName">MIDDLE NAME <span class="star">*</span></label>
							<input type="text" name="middleName" id="middleName" style="text-transform: uppercase;"
								placeholder="ENTER MIDDLE NAME" /> <small id="chkmiddlename"
								style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">

							<label for="lastName">LAST NAME <span class="star">*</span></label>
							<input type="text" name="lastName" id="lastName" style="text-transform: uppercase;"
								placeholder="ENTER LAST NAME" required /> <small id="chklastname"
								style="color: red;"></small>
						</div>
					</div>


					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="">DOB <span class="star">*</span></label> <input type="date" name="dob" id="dob"
								required="required" /> <small id="chkdob" style="color: red;"></small>

						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="">MINOR <span class="star">*</span></label> <select id="minor" name="minor"
								onchange="ifMinor()" required="required" class="form-control selectField"
								style="height: 30px;">
								<option value="">--SELECT MINOR--</option>
								<option value="Yes">YES(BELOW 18)</option>
								<option value="No">NO(ABOVE 18)</option>
							</select> <small id="chkminor" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-4" id="guardianDetails">
						<div class="d-flex flex-column formFields">
							<label for="guardianName">GUARDIAN NAME(IF MINOR) <span class="star">*</span></label>
							<select id="guardianName" name="guardianName" required="required"
								class="form-control selectField" style="height: 30px;">
								<option value="">SELECT GUARDIAN NAME</option>
							</select> <small id="chkguardianname" style="color: red;"></small>

						</div>
					</div>

					<div class="col-lg-3 mb-4" style="display: none;" id="guardianAccountNo">
						<div class="d-flex flex-column formFields">
							<label for="guardianAccNo">GUARDIAN ACCOUNT NO <span class="star">*</span></label> <input
								type="text" name="guardianAccountNo" id="guardianAccNo" readonly="readonly"
								required="required" placeholder="ENTER ACCOUNT NO" /> <small id="chkguardianaccno"
								style="color: red;"></small>
						</div>
					</div>



					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">GENDER <span class="star">*</span></label> <select id="customerGender"
								name="customerGender" required="required" class="form-control selectField"
								style="height: 30px;">
								<option value="">--SELECT GENDER--</option>
								<option value="MALE">MALE</option>
								<option value="FEMALE">FEMALE</option>

							</select> <small id="chkgender" style="color: red;"></small>
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">AGE <span class="star">*</span></label> <input type="text" name="customerAge"
								id="customerAge" required="required" placeholder="ENTER AGE" readonly="readonly" />
							<small id="chkage" style="color: red;"></small>
						</div>
					</div>



					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="">RELATIONSHIP STATUS <span class="star">*</span></label>
							<select id="relationshipStatus" name="relationshipStatus" required="required"
								class="form-control selectField" style="height: 30px;">
								<option value="">--- SELECT ---</option>
								<option value="SINGLE">SINGLE</option>
								<option value="MARRIED">MARRIED</option>
								<option value="DIVORCED">DIVORCED</option>


							</select> <small id="chkrelationshipstatus" style="color: red;"></small>
						</div>
					</div>



					<div class="col-lg-3" style="margin-bottom: 30px;">
						<div class="d-flex flex-column formFields">
							<label for="">ADDRESS <span class="star">*</span></label>
							<textarea name="customerAddress" id="customerAddress" style="text-transform: uppercase;"
								style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
							<small id="chkaddress" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-3">
						<div class="d-flex flex-column formFields">
							<label for="">CATEGORY <span class="star">*</span></label> <select id="category"
								name="category" required="required" class="form-control selectField"
								style="height: 30px;">
								<option value="">--SELECT CATEGORY--</option>

							</select> <small id="chkcategory" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-3">
						<div class="d-flex flex-column formFields">
							<label for="">CASTE <span class="star">*</span></label> <select id="caste" name="caste"
								required="required" class="form-control selectField" style="height: 30px;">
								<option value="">--SELECT CASTE--</option>

							</select> <small id="chkcaste" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-3">
						<div class="d-flex flex-column formFields" style="margin-bottom: 30px;">
							<label for="">STATE <span class="star">*</span></label> <select id="state" name="state"
								required="required" class="form-control selectField" style="height: 30px;">
								<option value="">--SELECT STATE--</option>

							</select> <small id="chkstate" style="color: red;"></small>
						</div>
					</div>


					<div class="col-lg-3 ">
						<div class="d-flex flex-column formFields">
							<label for="">DISTRICT <span class="star">*</span></label> <select id="district"
								name="district" required="required" class="form-control selectField"
								style="height: 30px;">
								<option value="">SELECT DISTRICT</option>

							</select> <small id="chkdistrict" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">PIN CODE <span class="star">*</span></label> <input type="text" name="pinCode"
								id="pinCode" required="required" placeholder="ENTER PINCODE" /> <small id="chkpincode"
								style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-4 ">
						<div class="d-flex flex-column formFields">
							<label for="">BRANCH NAME <span class="star">*</span></label> <select id="branchName"
								name="branchName" required="required" class="form-control selectField"
								style="height: 30px;">
								<option value="">SELECT BRANCH NAME</option>

							</select> <small id="chkbranch" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">CONTACT NO <span class="star">*</span></label> <input type="text"
								name="contactNo" id="contactNo" required="required" placeholder="ENTER CONTACT NO" />
							<small id="chkcontactno" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">EMAIL ID <span class="star">*</span></label> <input type="text" name="emailId"
								id="emailId" required="required" style="text-transform: uppercase;"
								placeholder="ENTER EMAIL ID" />
							<small id="chkemailid" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">AADHAR NO <span class="star">*</span></label> <input type="text"
								name="aadharNo" id="aadharNo" required="required" style="text-transform: uppercase;"
								placeholder="ENTER AADHAR NO" />
							<small id="chkaadharno" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">PAN NO <span class="star">*</span></label> <input type="text" name="panNo"
								id="panNo" required="required" style="text-transform: uppercase;"
								placeholder="ENTER PAN NO" />
							<small id="chkpanno" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields" style="margin-bottom: 30px;">
							<label for="">VOTER NO <span class="star">*</span></label> <input type="text" name="voterNo"
								id="voterNo" required="required" style="text-transform: uppercase;"
								placeholder="ENTER VOTER NO" />
							<small id="chkvoterno" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields" style="margin-bottom: 30px;">
							<label for="">DRIVING LICENSE NO <span class="star">*</span></label>
							<input type="text" name="drivingLicenceNo" id="drivingLicenceNo"
								style="text-transform: uppercase;" required="required" placeholder="ENTER LICENSE NO" />
							<small id="chkdrivinglicenseno" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="employeeCode">EMPLOYEE CODE</label>
							<select id="employeeCode" name="referralCode"
								class="form-control selectField" style="height: 30px;">
								<option value="">-- SELECT EMPLOYEE CODE --</option>
							</select>
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="employeeName">EMPLOYEE NAME</label>
							<input type="text" id="employeeName" name="referralName"
								style="text-transform: uppercase;" placeholder="AUTO FILLED"
								readonly="readonly" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="profession">PROFESSION</label> <input type="text" style="text-transform: uppercase;"
								name="profession" id="profession" placeholder="ENTER PROFESSION" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="occupation">OCCUPATION</label> <input type="text" style="text-transform: uppercase;"
								name="occupation" id="occupation" placeholder="ENTER OCCUPATION" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="education">EDUCATION</label> <input type="text" style="text-transform: uppercase;"
								name="education" id="education" placeholder="ENTER EDUCATION" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="monthlyIncome">MONTHLY INCOME</label> <input type="number" style="text-transform: uppercase;"
								name="monthlyIncome" id="monthlyIncome" placeholder="ENTER MONTHLY INCOME" min="0" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="shareValue">SHARE VALUE</label> <input type="text"
								style="text-transform: uppercase;" name="shareValue" id="shareValue" required="required"
								placeholder="ENTER SHARE VALUE" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="noOfShare">NO OF SHARE</label> <input type="text"
								style="text-transform: uppercase;" name="noOfShare" id="noOfShare" required="required"
								placeholder="ENTER NO OF SHARE" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="shareAmount">SHARE AMOUNT</label> <input type="text"
								style="text-transform: uppercase;" name="shareAmount" id="shareAmount"
								required="required" placeholder="ENTER SHARE AMOUNT" readonly />
						</div>
					</div>




					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="lightBill">LIGHT BILL</label> <input type="text"
								style="text-transform: uppercase;" name="lightBill" id="lightBill" required="required"
								placeholder="ENTER LIGHT BILL NO" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="taxBill">TAX BILL</label> <input type="text" style="text-transform: uppercase;"
								name="taxBill" id="taxBill" required="required" placeholder="ENTER TAX BILL NO" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="interestPercent">INTEREST PERCENT (%)</label> <input type="text"
								name="interestPercent" id="interestPercent" placeholder="ENTER INTEREST PERCENT" />
							<small id="chkinterestpercent" style="color: red;"></small>
						</div>
					</div>
				</div>

				<div class="row mt-4">
					<div class="col-lg-3 mb-5">
						<label for=""
							style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">AADHAR
							CARD <span class="star">*</span>
						</label> <label for="customerAadharImage" id="drop-area"> <input type="file" accept="image/*"
								name="customerAadharImage" id="customerAadharImage" hidden="hidden" onchange="photopreview();"
								style="background-size: cover; background-repeat: no-repeat" />
							<div id="img-view">
								<img src="Uploads/upload.png" alt="upload_icon" id="bike1imagePreview" />

							</div>
						</label> <small id="chkaadharimage" style="color: red;"></small>
					</div>

					<div class="col-lg-3 mb-5">
						<label for=""
							style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">PAN
							CARD <span class="star">*</span>
						</label> <label for="customerPanImage" id="drop-area"> <input type="file" accept="image/*"
								name="customerPanImage" id="customerPanImage" hidden="hidden"
								onchange="signpreview();"
								style="background-size: cover; background-repeat: no-repeat" />
							<div id="img-view">
								<img src="Uploads/upload.png" alt="upload_icon" id="bike2imagePreview" />

							</div>
						</label> <small id="chkpanimage" style="color: red;"></small>
					</div>

					<div class="col-lg-3 mb-5">
						<label for=""
							style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">VOTER
							ID <span class="star">*</span>
						</label> <label for="customerVoter" id="drop-area"> <input type="file" accept="image/*"
								name="customerVoter" id="customerVoter" hidden="hidden" onchange="voterpreview();"
								style="background-size: cover; background-repeat: no-repeat" />
							<div id="img-view">
								<img src="Uploads/upload.png" alt="upload_icon" id="bike3imagePreview" />

							</div>
						</label> <small id="chkvoterimage" style="color: red;"></small>
					</div>

					<div class="col-lg-3 mb-5">
						<label for=""
							style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">PHOTO <span class="star">*</span>
						</label> <label for="customerPhoto" id="drop-area"> <input type="file" accept="image/*"
								name="customerPhoto" id="customerPhoto" hidden="hidden" onchange="drivingpreview();"
								style="background-size: cover; background-repeat: no-repeat" />
							<div id="img-view">
								<img src="Uploads/upload.png" alt="upload_icon" id="bike4imagePreview" />

							</div>
						</label> <small id="chklicenseimage" style="color: red;"></small>
					</div>

					<div class="col-lg-3 mb-5">
						<label for=""
							style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">SIGNATURE <span class="star">*</span>
						</label> <label for="customerSignature" id="drop-area"> <input type="file" accept="image/*"
								name="customerSignature" id="customerSignature" hidden="hidden"
								onchange="newlyaddedpreview();"
								style="background-size: cover; background-repeat: no-repeat" />
							<div id="img-view">
								<img src="Uploads/upload.png" alt="upload_icon" id="customerSignaturePreview" />

							</div>
						</label> <small id="chknewlyaddedimage" style="color: red;"></small>
					</div>

				</div>




			</div>

			<!-- CUSTOMER EXTRA IMAGES UPLOAD SECTION -->
			<div class="container mt-4" id="customerImageUploadSection">
				<div class="row">
					<div class="col-lg-12">
						<h4 class="mt-4"
							style="font-size: 14px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 15px;">
							CUSTOMER EXTRA IMAGES UPLOAD</h4>
						<div id="fieldContainer">
							<div class="textUploadSet mb-4">
								<input type="text" class="form-control nameField" placeholder="ENTER IMAGE NAME..."
									style="text-transform: uppercase;">
								<div class="uploadContainer"></div>
							</div>
						</div>

						<button type="button" id="addFieldBtn" class="btn btn-primary mt-2">ADD +</button>
						<button type="button" id="uploadAllBtn" class="btn btn-success mt-2">UPLOAD ALL</button>
					</div>
				</div>
			</div>

			<div class="mt-5">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">NOMINEE DETAILS</li>
					</ol>
				</nav>
				<div class="row">



					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">NOMINEE NAME <span class="star">*</span></label> <input type="text"
								name="nomineeName" id="nomineeName" style="text-transform: uppercase;"
								required="required" placeholder="ENTER NOMINEE NAME" /> <small id="chknomineename"
								style="color: red;"></small>
						</div>
					</div>

					<!-- Nominee Relation to Applicant field removed as requested -->

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="nomineeDOB"> NOMINEE DOB <span class="star">*</span></label>
							<input type="date" name="nomineeDOB" id="nomineeDOB" required="required" /> <small
								id="chknomineedob" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for=""> NOMINEE AGE <span class="star">*</span></label> <input type="text"
								name="nomineeAge" id="nomineeAge" required="required" readonly="readonly"
								placeholder="ENTER AGE" /> <small id="chknomineeage" style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">NOMINEE MOBILE NO <span class="star">*</span></label>
							<input type="text" name="nomineeMobileNo" id="nomineeMobileNo" required="required"
								placeholder="ENTER MOBILE NO" /> <small id="chknomineemobileno"
								style="color: red;"></small>
						</div>
					</div>



					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">ADDRESS <span class="star">*</span></label>
							<textarea name="nomineeAddress" id="nomineeAddress" style="text-transform: uppercase;"
								style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
							<small id="chknomineeaddress" style="color: red;"></small>
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">PAN NO <span class="star">*</span></label> <input type="text"
								name="nomineePanNo" id="nomineePanNo" style="text-transform: uppercase;"
								required="required" placeholder="ENTER PAN NO" /> <small id="chknomineepan"
								style="color: red;"></small>
						</div>
					</div>


					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="">NOMINEE KYC NO <span class="star">*</span></label> <input type="text"
								name="nomineeKycNo" id="nomineeKycNo" style="text-transform: uppercase;"
								required="required" placeholder="ENTER KYC NO" /> <small id="chknomineekycno"
								style="color: red;"></small>
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="">NOMINEE KYC TYPE <span class="star">*</span></label>
							<select type="text" class="form-control selectField" name="nomineeKycType"
								id="nomineeKycType" required="required" style="height: 30px;">
								<option>SELECT TYPE</option>
								<option>AADHAR BASED EKYC</option>
							</select> <small id="chknoimneekyctype" style="color: red;"></small>
						</div>
					</div>


				</div>

				<!-- Nominee Signature Upload -->
				<div class="row mt-4">

					<!-- Nominee Aadhar Upload -->
					<div class="col-lg-3 mb-5">
						<label for=""
							style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
							NOMINEE AADHAR <span class="star">*</span>
						</label> <label for="nomineAadhar" id="drop-area"> <input type="file" accept="image/*"
								name="nomineAadhar" id="nomineAadhar" hidden="hidden"
								onchange="nomineeAadharPreview();" />

							<div id="img-view">
								<img src="Uploads/upload.png" alt="upload_icon" id="nomineeAadharImg" />
							</div>
						</label> <small id="chknomineeaadhar" style="color: red;"></small>
					</div>
					<div class="col-lg-3 mb-5">
						<label
							style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
							NOMINEE SIGNATURE <span class="star">*</span>
						</label> <label for="nomineSignature" id="drop-area"> <input type="file" accept="image/*"
								name="nomineSignature" id="nomineSignature" hidden="hidden"
								onchange="nomineeSignaturePreview();" />

							<div id="img-view">
								<img src="Uploads/upload.png" alt="upload_icon" id="nomineeSignatureImg" />
							</div>
						</label> <small id="chknomineesignature" style="color: red;"></small>
					</div>

				</div>

			</div>

			<div class="mt-5">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">FEES DETAILS</li>
					</ol>
				</nav>
				<!-- Always Visible Fields -->
				<!-- Always Visible Fields -->
				<div class="row">
					<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label>Member Fees</label> <input type="text" id="memberFees"
									name="memberFees" placeholder="Enter Fees" />
							</div>
						</div> -->

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="memberFees">MEMBER FEES</label>
							<input type="text" style="text-transform: uppercase;" name="memberFees" id="memberFees"
								class="form-control" placeholder="ENTER MEMBER FEES" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label>BUILDING FUND</label> <input type="text" id="buildingFund"
								style="text-transform: uppercase;" name="buildingFund"
								placeholder="ENTER BUILDING FUND" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label>ADMIN CHARGE</label> <input type="text" id="adminCharge"
								style="text-transform: uppercase;" name="adminCharge"
								placeholder="ENTER ADMIN CHARGE" />
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label>DOCUMENT CHARGE</label> <input type="text" style="text-transform: uppercase;"
								id="documentCharge" name="documentCharge" placeholder="ENTER DOCUMENT CHARGE" />
						</div>
					</div>



					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label>OTHER CHARGE</label> <input type="text" id="otherCharge"
								style="text-transform: uppercase;" name="otherCharge" placeholder="ENTER OTHER CHARGE"
								value="ADARSH UPAVIDHI" readonly="readonly" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label>PAYMENT BY</label> <select id="paymentBy" name="paymentBy"
								class="form-control selectField" style="height: 30px;">
								<option value="">SELECT</option>
								<option value="cash">CASH</option>
								<option value="cheque">CHEQUE</option>
								<option value="neft">NEFT</option>
								<option value="online">ONLINE</option>
							</select>
						</div>
					</div>

					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label>REMARKS</label> <input type="text" id="remarks" style="text-transform: uppercase;"
								name="remarks" placeholder="ENTER REMARKS" />
						</div>
					</div>
				</div>

				<!-- Conditionally Displayed Fields -->
				<div class="row">
					<!-- Cheque No -->
					<div class="col-lg-3" id="chequeNoDiv" style="display: none;">
						<div class="d-flex flex-column formFields">
							<label>CHEQUE NO</label> <input type="text" id="chequeNo" name="chequeNo"
								placeholder="ENTER CHEQUE NO" />
						</div>
					</div>

					<!-- Cheque Date -->
					<div class="col-lg-3" id="chequeDateDiv" style="display: none;">
						<div class="d-flex flex-column formFields">
							<label>CHEQUE DATE</label> <input type="date" id="chequeDate" name="chequeDate" />
						</div>
					</div>

					<!-- Deposit A/C -->
					<div class="col-lg-3" id="depositAccountDiv" style="display: none;">
						<div class="d-flex flex-column formFields" style="margin-bottom: 30px;">
							<label>DEPOSIT A/C</label> <select id="depositAccount" name="depositAcNo"
								class="form-control selectField" style="height: 30px;">
								<option value="">SELECT</option>
								<!-- options will be filled dynamically -->
							</select>
						</div>
					</div>

					<!-- Reference No -->
					<div class="col-lg-3 mb-4" id="refNoDiv" style="display: none;">
						<div class="d-flex flex-column formFields">
							<label>REFERENCE NO</label> <input type="text" id="referenceNo" name="referenceNo"
								placeholder="ENTER REFERENCE NO" />
						</div>
					</div>
				</div>


				<div class="row">



					<div class="col-lg-3">
						<div class=" h-100">
							<div class="formFields d-flex flex-column">
								<label>MEMBER STATUS</label>
								<div class="cont">
									<div class="toggle">
										<input type="checkbox" id="toggle-member-status" class="toggle__input"
											data-toggle-type="member-status">
										<label for="toggle-member-status" class="toggle__label"></label>
									</div>
								</div>
							</div>
						</div>
					</div>

					<div class="col-lg-3">
						<div class=" h-100">
							<div class="formFields d-flex flex-column">
								<label>SMS SEND</label>
								<div class="cont">
									<div class="toggle">
										<input type="checkbox" id="toggle-sms-status" class="toggle__input"
											data-toggle-type="member-status">
										<label for="toggle-sms-status" class="toggle__label"></label>
									</div>
								</div>
							</div>
						</div>
					</div>




				</div>


			</div>
			<br> <br>
			<div class="row">
				<div class="col-12 text-center">

					<button type="button" id="saveBtn" class="btnStyle bg-success">SAVE</button>

				</div>
			</div>
		</form>

		<!-- SAVE & UPDATE BUTTONS END -->

		<!-- ================== TABLE START ================== -->
		<!-- <div class="mt-5">
		<nav>
			<ol class="breadcrumb breadcrumb-title">
				<li class="breadcrumb-item action">CUSTOMER LIST</li>
			</ol>
		</nav>

		<table class="table table-bordered table-striped">
			<thead style="background: #f0f0f0;">
				<tr>
					<th>#</th>
					<th>CUSTOMER CODE</th>
					<th>NAME</th>
					<th>OPENING DATE</th>
					<th>MOBILE NO</th>
					<th>ADDRESS</th>
					<th>DISTRICT</th>
					<th>BRANCH NAME</th>
					<th>DOB</th>
					<th>DOB</th>
				</tr>
			</thead>
			<tbody id="customerTableBody">
				Dynamic rows will be added here
			</tbody>
		</table>
	</div> -->
		<!-- ================== TABLE END ================== -->

	</div>

	<script>
		document.getElementById("noOfShare").addEventListener("input", function () {
			let shareValue = parseFloat(document.getElementById("shareValue").value) || 0;
			let noOfShare = parseFloat(this.value) || 0;
			let shareAmount = shareValue * noOfShare;

			document.getElementById("shareAmount").value = shareAmount.toFixed(2); // show 2 decimals
		});
	</script>
	<script>

		document.addEventListener('DOMContentLoaded', () => {
			const toggles = document.querySelectorAll('.toggle__input');

			toggles.forEach((toggle) => {
				// Initialize colors
				updateToggleColor(toggle);

				// console.log("updated toggle" , toggle)

				// Add change event listener
				toggle.addEventListener('change', () => {
					updateToggleColor(toggle);
					// console.log(${ toggle.dataset.toggleType } is now ${ toggle.checked });
				});
			});

			function updateToggleColor(input) {
				const label = input.nextElementSibling;
				if (input.checked) {
					label.style.backgroundColor = '#28a745'; // Green ON
				} else {
					label.style.backgroundColor = '#ccc'; // Gray OFF
				}
			}
		});

	</script>
	<script src="${pageContext.request.contextPath}/js/customerManagement/addCustomer.js?v=<%=System.currentTimeMillis()%>"></script>