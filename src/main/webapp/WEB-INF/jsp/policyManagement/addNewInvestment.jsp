
<div class="pagetitle">
	<h1>Policy Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-piggy-bank"></i>
			</a></li>
			<li class="breadcrumb-item action">Add New Investment</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Customer Details</li>
				</ol>
			</nav>
			<div class="row">
				<input type="hidden" name="hiddenSchemeCode" id="hiddenSchemeCode">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<input name="policyCode" id="policyCode" class="form-control"
							type="hidden" required /> <label for="">Policy start
							date <span class="star">*</span>
						</label> <input type="date" name="policyStartDate" id="policyStartDate"
							required="required" placeholder="Enter Vehicle No"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="branchName">Customer Selection <span
							class="star">*</span></label> <select id="selectCustomer"
							name="selectCustomer" required class="form-control selectField"
							style="height: 30px;">
							<!-- Add options here -->
						</select>
					</div>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Customer Name <span class="star">*</span></label> <input
							type="text" name="customerName" id="customerName"
							required="required" placeholder="Enter Customer Name" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Date of Birth <span class="star">*</span></label> <input
							type="date" name="dateofBirth" id="dateofBirth"
							required="required" style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Relation Details <span class="star">*</span></label>
						<input type="text" name="relationDetails" id="relationDetails"
							required="required" placeholder="Enter Relative Name" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Contact No <span class="star">*</span></label> <input
							type="text" name="contactNo" id="contactNo" required="required"
							placeholder="Enter Contact No." />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Suggested Nominee <span class="star">*</span></label>
						<input type="text" name="suggestedNominee" id="suggestedNominee"
							required="required" placeholder="Enter Nominee Name" />
					</div>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Age of Nominee <span class="star">*</span></label> <input
							type="text" name="ageOfNominee" id="ageOfNominee"
							required="ageOfNominee" placeholder="Enter Nominee Age" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Relation <span class="star">*</span></label> <input
							type="text" name="relation" id="relation" required="relation"
							placeholder="Enter Relation" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Address <span class="star">*</span></label>
						<textarea name="address" id="address"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">District <span class="star">*</span></label> <input
							type="text" name="district" id="district" required="required"
							placeholder="Enter District" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">State <span class="star">*</span></label> <input
							type="text" name="state" id="state" required="required"
							placeholder="Enter State" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Pin Code <span class="star">*</span></label> <input
							type="text" name="pinCode" id="pinCode" required="required"
							placeholder="Enter Pin Code" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="branchName">Branch Name <span class="star">*</span></label>
						<select id="branchName" name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
						</select> <small id="chkbranchname" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">TDS <span class="star">*</span></label> <input
							type="text" name="tds" id="tds" required="required"
							placeholder="Enter TDS" />
					</div>
				</div>


				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Mode of Operation <span class="star">*</span></label>
						<select id="ModeOfOperation" name="ModeOfOperation"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="joint">Joint</option>
							<option value="single">Single</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Policy Joint Name <span class="star">*</span></label>
						<input type="text" name="jointName" id="jointName"
							required="required" placeholder="Enter Policy Joint Name" />
					</div>
				</div>


				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Scheme Type <span class="star">*</span></label> <select
							id="schemeType" name="schemeType" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Scheme Type</option>
							<option value="DRD">DRD</option>
							<option value="RD">RD</option>
							<option value="FD">FD</option>
							<option value="MIS">MIS</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Scheme Name <span class="star">*</span></label> <select
							id="schemeName" name="schemeName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Scheme Name</option>

						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Scheme Term <span class="star">*</span></label> <input
							type="text" name="schemeTerm" id="schemeTerm" required="required"
							placeholder="Enter Scheme Term" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Rate Of Interest <span class="star">*</span></label>
						<input type="text" name="roi" id="roi" required="required"
							placeholder="Enter Interest Rate" />
					</div>
				</div>

				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Scheme Mode <span class="star">*</span></label> <select
							id="schemeMode" name="schemeMode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Scheme Mode</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Maturity Date <span class="star">*</span></label> <input
							type="date" name="maturityDate" id="maturityDate"
							required="required" style="text-transform: uppercase;" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Policy Amount <span class="star">*</span></label> <input
							type="text" name="policyAmount" id="policyAmount"
							required="required" placeholder="Enter Policy Amount" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Deposit Amount <span class="star">*</span></label> <input
							type="text" name="depositAmount" id="depositAmount"
							required="required" placeholder="Enter Deposit Amount" />
					</div>
				</div>

				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="Agent">Agent <span class="star">*</span></label> <select
							id="Agent" name="Agent" required class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Agent</option>
						</select>
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Maturity Amount <span class="star">*</span></label>
						<input type="text" name="maturityAmount" id="maturityAmount"
							required="required" placeholder="Enter Maturity Amount" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">MIS Interest <span class="star">*</span></label> <input
							type="text" name="MISInterest" id="MISInterest"
							required="required" placeholder="Enter MIS Interest" />
					</div>
				</div>






			</div>
			<div class="row mt-4">
				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
						Photo</label> <label for="image1" id="drop-area"> <input
						accept="image/*" name="image1" id="image1" hidden="hidden"
						onchange="photopreview();"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="photoPreview" /><input type="hidden" name="photoHidden"
								id="photoHidden">

						</div>
					</label>
				</div>

				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
						Signature</label> <label for="image2" id="drop-area"> <input
						accept="image/*" name="image2" id="image2" hidden="hidden"
						onchange="signpreview();"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="signaturePreview" /><input type="hidden"
								name="signatureHidden" id="signatureHidden">

						</div>
					</label>
				</div>

			</div>

			<div class="mt-5">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">Payment Information</li>
					</ol>
				</nav>

				<div class="row">
					<!-- Payment By -->
					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="branchName">Payment By <span class="star">*</span></label>
							<select id="paymentBy" name="paymentBy" required
								class="form-control selectField" style="height: 30px;">
								<option value="">Select Payment By</option>
								<option value="cash">Cash</option>
								<option value="online">Online</option>

								<!-- Add options here -->
							</select>
						</div>
					</div>

					<!-- Remark -->
					<div class="col-lg-3 mb-4">
						<div class="d-flex flex-column formFields">
							<label for="remark">Remark <span class="star">*</span></label>
							<textarea id="remark" name="remark" required
								style="border: 1px solid #e0e0e0; border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
						</div>
					</div>

					<div class="col-lg-3">
						<div
							class=" h-100 d-flex justify-content-start align-items-center"
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
			</div>


		</div>

		<div class="row">
			<div class="col-12 text-center">
				<button id="saveBtn" class="btn btn-info" style="margin-left: 80%;">Save</button>

			</div>
		</div>
	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/PolicyManagment/addInvestment.js"></script>
