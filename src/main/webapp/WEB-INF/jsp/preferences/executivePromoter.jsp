
<div class="pagetitle">
	<h1>Preferences</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-gear"></i>
			</a></li>
			<li class="breadcrumb-item action">Executive/Founder</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Executive/Founder Details</li>
				</ol>
			</nav>
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
						<label for="">Type <span class="star">*</span></label> <select
							id="type" name="type" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Type</option>
							<option value="Blue">Founder</option>
							<option value="Blue">Co-Founder</option>
							<option value="Blue">CEO</option>
							<option value="Blue">MD</option>
							<option value="Blue">Chairman</option>
						</select> <small id="chkexetype" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Branch Name <span class="star">*</span></label>
						<select id="branchName" name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
						</select> <small id="chkbranchname" style="color: red;"></small>
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Full Name <span class="star">*</span></label> <input
							type="text" name="fullName" id="fullName" required="required"
							placeholder="Enter Full Name" style="text-transform: uppercase;" />
						<small id="chkfullname" style="color: red;"></small>
					</div>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Date Of Birth <span class="star">*</span></label> <input
							type="date" name="dateOfBirth" id="dateOfBirth"
							required="required" /> <small id="chkdateofbirth"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3 mt-4">
					<div class="d-flex flex-column formFields">
						<label for="">DIN/Promoter No <span class="star">*</span></label>
						<input type="text" name="promoterNo" id="promoterNo"
							required="required" placeholder="Enter Promoter No"
							style="text-transform: uppercase;" /> <small id="chkpromoterno"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3 mt-4">
					<div class="d-flex flex-column formFields">
						<label for="">Appointment Date <span class="star">*</span></label>
						<input type="date" name="appointmentDate" id="appointmentDate"
							required="required" /> <small id="chkappointmentdate"
							style="color: red;"></small>
					</div>
				</div>


				<div class="col-lg-3 mt-4">
					<div class="d-flex flex-column formFields">
						<label for="">Nominee Name <span class="star">*</span></label> <input
							type="text" name="relationName" id="relationName"
							required="required" placeholder="Enter Relation Name"
							style="text-transform: uppercase;" /> <small
							id="chkrelationname" style="color: red;"></small>
					</div>
				</div>


				<div class="col-lg-3 mt-4">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Relation to Applicant <span class="star">*</span></label> <select
							id="relationToApplicant" name="relationToApplicant"
							required="required" class="form-control selectField"
							style="height: 30px;">
						</select> <small id="chkrelationtoapplicant" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3 ">
					<div class="d-flex flex-column formFields">
						<label for="">Address <span class="star">*</span></label>
						<textarea name="address" id="address"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px; text-transform: uppercase;'"></textarea>
						<small id="chkaddress" style="color: red;"></small>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">District <span class="star">*</span></label> <input
							type="text" name="district" id="district" required="required"
							placeholder="Enter District" style="text-transform: uppercase;" />
						<small id="chkdistrict" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>State <span class="star">*</span></label> <select
							id="state" name="state" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select State</option>
							<option value="Maharashtra">Maharashtra</option>
							<option value="Gujarat">Gujarat</option>
							<option value="Rajasthan">Rajasthan</option>
							<option value="Goa">Goa</option>
							<option value="Andhra Pradesh">Andhra Pradesh</option>
							<option value="Punjab">Punjab</option>
							<option value="Himachal Pradesh">Himachal Pradesh</option>
							<option value="Uttar Pradesh">Uttar Pradesh</option>
							<option value="Telangana">Telangana</option>
							<option value="Bihar">Bihar</option>
							<option value="Haryana">Haryana</option>
							<option value="Jharkhand">Jharkhand</option>
							<option value="Odissa">Odissa</option>
							<option value="Tamil Nadu">Tamil Nadu</option>
							<option value="Manipur">Manipur</option>
							<option value="Nagaland">Nagaland</option>
						</select> <small id="chkstate" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Pin Code <span class="star">*</span></label> <input
							type="text" name="pinCode" id="pinCode" required="required"
							placeholder="Enter Pincode" style="text-transform: uppercase;" />
						<small id="chkpincode" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Aadhar No <span class="star">*</span></label> <input
							type="text" name="aadharNo" id="aadharNo" required="required"
							placeholder="Enter Aadhar No" style="text-transform: uppercase;" />
						<small id="chkaadharno" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3 ">
					<div class="d-flex flex-column formFields">
						<label for="">PAN No <span class="star">*</span></label> <input
							type="text" name="panNo" id="panNo" required="required"
							placeholder="Enter PAN No" style="text-transform: uppercase;" />
						<small id="chkpanno" style="color: red;"></small>
					</div>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Contact No <span class="star">*</span></label> <input
							type="text" name="contactNo" id="contactNo" required="required"
							placeholder="Enter Contact No" style="text-transform: uppercase;" />
						<small id="chkcontactno" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3 ">
					<div class="d-flex flex-column formFields">
						<label for="">Email ID <span class="star">*</span></label> <input
							type="text" name="emailId" id="emailId" required="required"
							placeholder="Enter Email ID" style="text-transform: uppercase;" />
						<small id="chkemailid" style="color: red;"></small>
					</div>
				</div>



				<div class="col-lg-3 mt-4">
					<div class="d-flex flex-column formFields">
						<label for="">Base Value</label> <input type="text"
							name="baseValue" id="baseValue" required="required"
							placeholder="Enter Base Value" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3 mt-4">
					<div class="d-flex flex-column formFields">
						<label for="">Shares Count</label> <input type="text"
							name="shareCount" id="shareCount" required="required"
							placeholder="Enter Shares Count"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3 mt-4">
					<div class="d-flex flex-column formFields">
						<label for="">Share Amount</label> <input type="text"
							readonly="readonly" name="shareAmount" id="shareAmount"
							required="required" placeholder="Enter Share Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>




			</div>

			<div class="row mt-5">
				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
						Photo <span class="star">*</span>
					</label> <label for="photo" id="drop-area"> <input type="file"
						accept="image/*" name="photo" id="photo" hidden="hidden"
						onchange="photoUpload();"
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
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
						Signature <span class="star">*</span>
					</label> <label for="signature" id="drop-area"> <input type="file"
						accept="image/*" name="signature" id="signature" hidden="hidden"
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

				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
						Aadhar Card<span class="star">*</span>
					</label> <label for="aadharCard" id="drop-area"> <input type="file"
						accept="image/*" name="aadharCard" id="aadharCard" hidden="hidden"
						onchange="aadharUpload();"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="aadharPreview" /><input type="hidden" name="aadharHidden"
								id="aadharHidden">

							<!-- <p id="upload-text"
                    style="font-size: 12px; margin-top: 15px"
                    class="text-muted"
                  >
                    Drag and drop or Choose File to upload the image
                  </p> -->
						</div>
					</label> <small id="chkaadhar" style="color: red;"></small>
				</div>

				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
						Pan Card <span class="star">*</span>
					</label> <label for="panCard" id="drop-area"> <input type="file"
						accept="image/*" name="panCard" id="panCard" hidden="hidden"
						onchange="panUpload();"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="panPreview" /><input type="hidden" name="panHidden"
								id="panHidden">
							<!-- <p
                    style="font-size: 12px; margin-top: 15px"
                    class="text-muted"
                  >
                    Drag and drop or Choose File to upload the image
                  </p> -->
						</div>
					</label> <small id="chkpan" style="color: red;"></small>
				</div>

				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px; margin-top: 30px;">
						Cheque <span class="star">*</span>
					</label> <label for="cheque" id="drop-area"> <input type="file"
						accept="image/*" name="cheque" id="cheque" hidden="hidden"
						onchange="chequeUpload();"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="chequePreview" /><input type="hidden" name="chequeHidden"
								id="chequeHidden">
							<!-- <p
                    style="font-size: 12px; margin-top: 15px"
                    class="text-muted"
                  >
                    Drag and drop or Choose File to upload the image
                  </p> -->
						</div>
					</label> <small id="chkcheque" style="color: red;"></small>
				</div>

			</div>
		</div>


		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Bank Details</li>
				</ol>
			</nav>
			<div class="row">
				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px">
								<label>Deposit Acc <span class="star">*</span></label> <select
									id="depositAcc" name="depositAcc" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select Deposit Acc</option>
									<option value="Blue">9542512445211</option>
								</select> <small id="chkdepositacc" style="color: red;"></small>
							</div>
						</div> -->

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="bankName">Bank Name <span class="star">*</span></label>
						<input type="text" name="bankName" id="bankName"
							required="required" placeholder="Enter Bank Name"
							style="text-transform: uppercase;" /> <small id="chkbankname"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="ifscCode">IFSC Code <span class="star">*</span></label>
						<input type="text" name="ifscCode" id="ifscCode"
							required="required" placeholder="Enter IFSC Code"
							style="text-transform: uppercase;" /> <small id="chkifsccode"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3" style="margin-bottom: 30px;">
					<div class="d-flex flex-column formFields">
						<label for="micrCode">MICR Code <span class="star">*</span></label>
						<input type="text" name="micrCode" id="micrCode"
							required="required" placeholder="Enter MICR Code"
							style="text-transform: uppercase;" /> <small id="chkmicrcode"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="accountNo">Account Number <span class="star">*</span></label>
						<input type="text" name="accountNo" id="accountNo"
							required="required" placeholder="Enter Account Number"
							style="text-transform: uppercase;" /> <small id="chkaccountno"
							style="color: red;"></small>
					</div>
				</div>


			</div>
			<div class="row" style="margin-top: 30px;">
				<div class="col-12 text-center">
					<button type="button" id="showBtn" class="btnStyle bg-primary"
						onclick="showTableData()">Show</button>
					<button type="button" id="hideBtn" class="btnStyle bg-success"
						onclick="hideTableData()">Hide</button>
					<button type="button" id="saveBtn" class="btnStyle bg-warning">Save</button>
					<button type="button" id="updateBtn" class="btnStyle bg-success">Update</button>
				</div>
			</div>
	</form>


</div>
</div>

</div>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">
					Executive Founder Data <span>| Table View</span>
				</h5>

				<table
					class="table table-borderless table-hover align-middle text-center text-nowrap datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">SR NO</th>
							<th scope="col">NAME</th>
							<th scope="col">BRANCH NAME</th>
							<th scope="col">APPOINTMENT DATE</th>
							<th scope="col">ADDRESS</th>
							<th scope="col">EMAIL</th>
							<th scope="col">CONTACT</th>
							<th scope="col">EDIT</th>
							<th scope="col">DELETE</th>
						</tr>
					</thead>
					<tbody>

					</tbody>
				</table>
				<div class="mt-2 text-center">
					<button id="prevBtn" class="btn btn-sm btn-primary">
						<i class="bi bi-chevron-double-left"></i>
					</button>
					<span id="pageInfo" class="mx-2"></span>
					<button id="nextBtn" class="btn btn-sm btn-primary">
						<i class="bi bi-chevron-double-right"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/preferences/executivePromoter.js"></script>