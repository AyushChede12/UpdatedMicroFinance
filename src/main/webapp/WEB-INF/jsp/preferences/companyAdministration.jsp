
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
	<h1>Preferences</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-gear"></i>
			</a></li>
			<li class="breadcrumb-item action">Company Administration</li>
		</ol>
	</nav>

</div>

<div class="row">
	<div class="col-12 d-flex justify-content-end">
		<button type="button" id="editBtn" class="btn btn-outline-secondary"
			data-bs-toggle="tooltip" data-bs-placement="top" title="Edit">
			<i class="bi bi-pen-fill"></i>
		</button>
	</div>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Company Details</li>
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
						<label for="">Company Name <span class="star">*</span></label> <input
							type="text" readonly="readonly" name="companyName"
							id="companyName" required="required"
							placeholder="Enter Company Name"
							style="text-transform: uppercase;" /> <small id="chkcompanyname"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Short Name <span class="star">*</span></label> <input
							type="Text" name="shortName" readonly="readonly" id="shortName"
							required="required" placeholder="Enter Short Name"
							style="text-transform: uppercase;" /> <small id="chkshortname"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>INC Date/Regd Date <span class="star">*</span></label> <input
							type="Date" readonly="readonly" name="signUpDate" id="signUpDate"
							required="required" placeholder="Enter Sign-Up Date"
							style="text-transform: uppercase;" /> <small id="chksignupdate"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>CIN No/Regd No<span class="star">*</span></label> <input
							type="Text" name="cinNo" readonly="readonly" id="cinNo"
							required="required" placeholder="Enter CIN No"
							style="text-transform: uppercase;" /> <small id="chkcinno"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>PAN <span class="star">*</span></label> <input type="Text"
							name="pan" id="pan" readonly="readonly" required="required"
							placeholder="Enter Pan No" style="text-transform: uppercase;" />
						<small id="chkpan" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>TAN <span class="star">*</span></label> <input type="text"
							name="tan" id="tan" readonly="readonly" required="required"
							placeholder="Enter Tan No" style="text-transform: uppercase;" />
						<small id="chktan" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>GSTIN <span class="star">*</span></label> <input
							type="Text" name="gstin" id="gstin" readonly="readonly"
							required="required" placeholder="Enter GSTIN"
							style="text-transform: uppercase;" /> <small id="chkgstin"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Declared Value <span class="star">*</span></label> <input
							type="Text" name="declaredValue" id="declaredValue"
							required="required" readonly="readonly"
							placeholder="Enter Declared Value "
							style="text-transform: uppercase;" /> <small
							id="chkdeclaredvalue" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Address <span class="star">*</span></label>
						<textarea name="address" id="address" readonly="readonly"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
						<small id="chkaddress" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">State <span class="star">*</span></label> <input
							type="text" readonly="readonly" name="state" id="state"
							required="required" placeholder="Enter State "
							style="text-transform: uppercase;" /> <small id="chkstate"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">City <span class="star">*</span></label> <input
							type="text" readonly="readonly" name="city" id="city"
							required="required" placeholder="Enter City "
							style="text-transform: uppercase;" /> <small id="chkcity"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Pin Code <span class="star">*</span></label> <input
							type="text" name="pinCode" readonly="readonly" id="pinCode"
							required="required" placeholder="Enter Pin Code"
							style="text-transform: uppercase;" /> <small id="chkpincode"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Email ID <span class="star">*</span></label> <input
							type="text" name="emailId" readonly="readonly" id="emailId"
							required="required" placeholder="Enter Email ID"
							style="text-transform: uppercase;" /> <small id="chkemailid"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Authorized Share Capital <span class="star">*</span></label>
						<input type="text" readonly="readonly"
							name="authorizedShareCapital" id="authorizedShareCapital"
							required="required" placeholder="Authorized Share Capital"
							style="text-transform: uppercase;" /> <small
							id="chkauthorizedsharecapital" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Paid Up Capital <span class="star">*</span></label> <input
							type="text" readonly="readonly" name="paidUpCapital"
							id="paidUpCapital" required="required"
							placeholder="Enter Paid Up Capital"
							style="text-transform: uppercase;" /> <small
							id="chkpaidupcapital" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>No Of Share <span class="star">*</span></label> <input
							type="text" name="nof" id="nof" readonly="readonly"
							required="required" placeholder="Enter No Of Share "
							style="text-transform: uppercase;" /> <small id="chknof"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>HelpLine No <span class="star">*</span></label> <input
							type="text" name="helpLine No" readonly="readonly"
							id="helplineNo" required="required"
							placeholder="Enter HelpLine No"
							style="text-transform: uppercase;" /> <small id="chkhelplineno"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>TDS (With PAN) <span class="star">*</span></label> <input
							type="text" readonly="readonly" name="tdsWithPan" id="tdsWithPan"
							required="required" placeholder="Enter TDS"
							style="text-transform: uppercase;" /> <small id="chktdswithpan"
							style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>TDS (Without PAN) <span class="star">*</span></label> <input
							type="text" readonly="readonly" name="tdsWithoutPan"
							id="tdsWithoutPan" required="required" placeholder="Enter TDS"
							style="text-transform: uppercase;" /> <small
							id="chktdswithoutpan" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Tax Deduction <span class="star">*</span></label> <input
							type="text" readonly="readonly" name="taxDeduction"
							id="taxDeduction" required="required"
							placeholder="Enter Tax Deduction"
							style="text-transform: uppercase;" /> <small
							id="chktaxdeduction" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Branch Manager Contact No <span class="star">*</span></label>
						<input type="text" readonly="readonly"
							name="branchManagerContactNo" id="branchManagerContactNo"
							required="required" placeholder="Enter Branch Manager Contact No"
							style="text-transform: uppercase;" /> <small
							id="chkbranchManagerContactNo" style="color: red;"></small>
					</div>
				</div>


			</div>

			<!-- relevant HTML: keep your container as you posted -->
			<div class="container mt-4">
				<div class="row">
					<div class="col-lg-12">
						<h4>Company Image Upload</h4>
						<div id="fieldContainer">
							<div class="textUploadSet mb-4">
								<input type="text" class="form-control nameField"
									placeholder="Enter Image Name...">
								<div class="uploadContainer"></div>
							</div>
						</div>

						<button id="addFieldBtn" class="btn btn-primary mt-2">Add
							+</button>
						<button id="uploadAllBtn" class="btn btn-success mt-2">Upload
							All</button>
						<button id="reloadDataBtn" class="btn btn-info mt-2">Reload</button>

						<div id="storedImages" class="mt-4"></div>
					</div>
				</div>
			</div>





			<!-- <div class="mt-4">
						<div class="row mt-4">

							Company Logo
							<div class="col-lg-3 mb-5 imageField" id="companyLogoField">
								<label>Company Logo <span class="star">*</span></label> <label
									for="photo" id="drop-area"> <input type="file"
									accept="image/*" name="photo" id="photo" hidden="hidden"
									onchange="bike1Preview();" />
									<div id="img-view">
										<img src="../images/upload/upload.png" alt="upload_icon"
											id="bike1imagePreview" />
									</div>
								</label> <small id="chkphoto" style="color: red;"></small>
							</div>

							Registration Certificate
							<div class="col-lg-3 mb-5 imageField" id="regnCertField">
								<label>Regn Certificate <span class="star">*</span></label> <label
									for="signature" id="drop-area"> <input type="file"
									accept="image/*" name="signature" id="signature"
									hidden="hidden" onchange="bike2Preview();" />
									<div id="img-view">
										<img src="../images/upload/upload.png" alt="upload_icon"
											id="bike2imagePreview" />
									</div>
								</label> <small id="chksignature" style="color: red;"></small>
							</div>

							Pan Card
							<div class="col-lg-3 mb-5 imageField" id="panCardField">
								<label>Pan Card <span class="star">*</span></label> <label
									for="panphoto" id="drop-area"> <input type="file"
									accept="image/*" name="panphoto" id="panphoto" hidden="hidden"
									onchange="bike1Preview();" />
									<div id="img-view">
										<img src="../images/upload/upload.png" alt="upload_icon"
											id="bike1imagePreview2" />
									</div>
								</label> <small id="chkphoto2" style="color: red;"></small>
							</div>

							GST Certificate
							<div class="col-lg-3 mb-5 imageField" id="gstCertField">
								<label>GST Certificate <span class="star">*</span></label> <label
									for="gstphoto" id="drop-area"> <input type="file"
									accept="image/*" name="gstphoto" id="gstphoto" hidden="hidden"
									onchange="bike1Preview();" />
									<div id="img-view">
										<img src="../images/upload/upload.png" alt="upload_icon"
											id="bike1imagePreview3" />
									</div>
								</label> <small id="chkphoto3" style="color: red;"></small>
							</div>

						</div>
					</div> -->

		</div>

		<div class="row" style="margin-top: 30px;">
			<div class="col-12 text-center">
				<button type="button" id="updateBtn" class="btn btn-success"
					disabled>Update</button>
			</div>
		</div>
	</form>



</div>
<script src="${pageContext.request.contextPath}/js/preferences/companyAdministration.js"></script>
