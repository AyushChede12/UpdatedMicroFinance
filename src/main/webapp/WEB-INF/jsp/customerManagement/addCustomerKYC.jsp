
<style>
#img-view {
	width: 100%;
	height: 200px; /* adjust to your preferred box height */
	display: flex;
	align-items: center;
	justify-content: center;
	border: 1px dashed #ccc; /* optional: border like upload box */
	border-radius: 10px;
	overflow: hidden; /* ensures image stays inside box */
	background: #f9f9f9; /* optional light background */
}

#photoPreview, #signaturePreview {
	max-width: 100%;
	max-height: 100%;
	object-fit: contain; /* keeps whole image visible */
}
</style>

<div class="pagetitle">
	<h1>CUSTOMER MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-people-fill"></i>
			</a></li>
			<li class="breadcrumb-item action">ADD CUSTOMER KYC</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">SEARCH DETAILS</li>
				</ol>
			</nav>

			<div class="row">
				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="customerCode" id="customerSelection">Customer
							Selection </label> <select id="selectByCode" name="selectByCode"
							class="form-control selectField" style="width: 100%;">
							<option value="">-- Search Customer Code --</option>
						</select>
					</div>
				</div>


				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="">KYC Authenticate By</label> <label>0</label>
					</div>
				</div>
			</div>

			<div class="row">
				<div class="col-lg-12">
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action mt-3">Customer Details</li>
						</ol>
					</nav>
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
						<label for="">Customer Code</label> <input type="text"
							name="memberCode" id="memberCode" required="required"
							placeholder="Enter Customer Code" disabled />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Contact No.</label> <input type="text"
							name="contactNo" id="contactNo" required="required"
							placeholder="Enter Contact No" disabled />
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
					<div class="d-flex flex-column formFields">
						<label for="">Voter No.</label> <input type="text" name="voterNo"
							id="voterNo" required="required" placeholder="Enter Voter No."
							disabled />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Driving License No.</label> <input type="text"
							name="drivingLicenceNo" id="drivingLicenceNo" required="required"
							placeholder="Enter Driving License No." disabled />
					</div>
				</div>
			</div>
			<div class="row mt-3">


				<div class="col-3 text-center">
					<button type="button" id="saveBtn"
						style="background-color: red; border: none; outline: none; color: #fff; font-weight: bold; border-radius: 5px; padding: 8px 15px; cursor: pointer;"
						onclick="verifyFetchedData();">Click Here to Authenticate
						Complete</button>
				</div>
			</div>

			<div class="row mt-4">
				<!-- Customer Photo -->
				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">
						Customer Photo <span class="star">*</span>
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

				<!-- Signature -->
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

						</div>
					</label> <small id="chksignature" style="color: red;"></small>
				</div>


			</div>
		</div>


		<!-- <div class="mt-5">
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action">Bank Details</li>
						</ol>
					</nav>
					<div class="row">
						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Bank Name </label> <input type="text"
									name="bankName" id="bankName" required="required"
									placeholder="Enter Location" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Bank Branch </label> <input type="text"
									name="bankBranch" id="bankBranch" required="required"
									placeholder="Enter Location" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Account No. </label> <input type="text"
									name="acountNo" id="acountNo" required="required"
									placeholder="Enter Location" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">IFSC Code </label> <input type="text"
									name="ifscCode" id="ifscCode" required="required"
									placeholder="Enter Location" />
							</div>
						</div>
					</div>

				</div>

				<div class="row">
					<div class="col-12 text-right mt-3">
						<button id="saveBtN" class="btnStyle"
							style="background-color: #FFA500;">Save</button>
					</div>
				</div> -->
	</form>

</div>


<script>
$(document).ready(function () {
	$.ajax({
	    url: "api/customermanagement/approved",
	    method: "GET",
	    success: function(response) {
		alert("success");
	        if (response.status === "OK") {

	            let dropdown = $("#selectByCode");
	            dropdown.empty(); // Clear old options
	            dropdown.append(`<option value="">-- Select Customer --</option>`);

	            response.data.forEach(function(item) {
	            	alert(item.memberCode);
	                let fullName = [
	                    item.firstName,
	                    item.middleName,
	                    item.lastName
	                ].filter(Boolean).join(" ");
	                
					alert(fullName);
	                let optionHtml = `
	                    <option value="${item.memberCode}">
	                        ${item.memberCode} - ${fullName}
	                    </option>
	                `;

	                dropdown.append(optionHtml);
	            });
	        } else {
	            console.warn("Unexpected response:", response);
	        }
	    },
	    error: function(err) {
	        console.error("Error fetching customers:", err);
	    }
	});
});
</script>
<script
	src="${pageContext.request.contextPath}/js/customerManagement/addCustomer.js"></script>