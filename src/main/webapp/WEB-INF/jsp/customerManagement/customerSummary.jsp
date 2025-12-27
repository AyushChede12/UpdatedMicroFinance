
<div class="pagetitle">
	<h1>CUSTOMER MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-people-fill"></i>
			</a></li>
			<li class="breadcrumb-item action">CUSTOMER SUMMARY</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<div class="row">
				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="selectMember" id="customerSelection">Customer
							Selection </label> <select id="selectMember" name="selectMember"
							class="form-control selectField" style="width: 100%;">
							<option value="">-- Search Customer Code --</option>
						</select>
					</div>
				</div>
				<div class="col-lg-12">
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action mt-3">Client Details</li>
						</ol>
					</nav>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Code</label> <input type="text"
							name="customerCode" id="customerCode" required="required"
							placeholder="Enter Customer Code" disabled />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Name</label> <input type="text"
							name="customerName" id="customerName" required="required"
							placeholder="Enter Customer Name" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Sign-up Date</label> <input type="date"
							name="singupDate" id="singupDate" required="required"
							placeholder="Enter Sign-up Date" disabled />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Relative Name</label> <input type="text"
							name="guardianName" id="guardianName" required="required"
							placeholder="Enter Relative Name" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Address</label> <input type="text"
							name="customerAddress" id="customerAddress" required="required"
							placeholder="Enter Address" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for=""> PinCode</label> <input type="text" name="pinCode"
							id="pinCode" required="required" placeholder="Enter pincode"
							disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">State</label> <input type="text" name="state"
							id="state" required="required" placeholder="Enter State" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Mobile No.</label> <input type="text"
							name="contactNo" id="contactNo" required="required"
							placeholder="Enter mobileno" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Aadhar No.</label> <input type="text"
							name="aadharNo" id="aadharNo" required="required"
							placeholder="Enter Aadhar No" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">PAN</label> <input type="text" name="pan" id="pan"
							required="required" placeholder="Enter PAN" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Nominee Name</label> <input type="text"
							name="nomineeName" id="nomineeName" required="required"
							placeholder="Enter Nominee Name" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Email ID</label> <input type="text" name="emailId"
							id="emailId" required="required" placeholder="Enter Email ID"
							disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">DOB</label> <input type="text" name="dob" id="dob"
							required="required" placeholder="Enter DOB" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Age</label> <input type="text" name="customerAge"
							id="customerAge" required="required" placeholder="Enter Age"
							disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Branch Code</label> <input type="text"
							name="branchName" id="branchName" required="required"
							placeholder="Enter Branch Code" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Gender</label> <input type="text"
							name="customerGender" id="customerGender" required="required"
							placeholder="Enter gender" disabled />
					</div>
				</div>






			</div>

			<div class="row mt-4">
				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">UPLOAD
						CUSTOMER PHOTO <span class="star">*</span>
					</label> <label for="signature" id="drop-area"> <input type="file"
						accept="image/*" name="photo" id="photo" hidden="hidden"
						onchange="photoUpload();"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="photoPreview" /><input type="hidden" name="photoHidden"
								id="photoHidden">

						</div>
					</label> <small id="chksignature" style="color: red;"></small>
				</div>

			</div>
		</div>
	</form>



</div>
<script
	src="${pageContext.request.contextPath}/js/customerManagement/customerSummary.js"></script>