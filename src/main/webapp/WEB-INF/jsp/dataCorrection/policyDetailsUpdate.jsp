
<div class="pagetitle">
	<h1>Data Correction</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-pencil-square"></i>
			</a></li>
			<li class="breadcrumb-item action">Policy Details Update</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Edit Investment</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-5">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 20px;">
						<label for="policyCode">Select By Policy Code</label> <select
							id="policyCode" name="policyCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-- Search Policy Code --</option>
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
                  </div>:Member Selection        
                </div>
              </div> -->
					<input type="hidden" name="id" id="id">
					<div class="d-flex flex-column formFields">
						<label for="policyStartDate">Policy Date</label> <input
							type="date" name="policyStartDate" id="policyStartDate"
							required="required" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="memberSelection">Customer Selection </label> <select
							id="memberSelection" name="memberSelection" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label for="customerName">Customer Name</label> <input type="text"
							name="customerName" id="customerName" required="required"
							placeholder="Enter Customer Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="dateofBirth">Date of Birth </label> <input type="date"
							name="dateofBirth" id="dateofBirth" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Relative Details</label> <input type="text"
							name="relationDetails" id="relationDetails"
							placeholder="Enter Relative Name" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Contact No</label> <input type="text"
							name="contactNo" id="contactNo" required="required"
							placeholder="Enter Contact No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Suggested Nominee </label> <input type="text"
							name="suggestedNominee" id="suggestedNominee" required="required"
							placeholder="Enter Suggested Nominee            "
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label for="">Relation</label> <select id="relationToApplicant"
							name="relationToApplicant" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="address">Address</label>
						<textarea name="address" id="address"
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
						<label for="state">State</label> <input type="text" name="state"
							id="state" required="required" placeholder="Enter State" />
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
						<label for="branchName">Branch Name</label><select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="ModeOfOperation">Mode of Operation </label> <select
							id="ModeOfOperation" name="ModeOfOperation" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Mode</option>
							<option value="Single">Single</option>
							<option value="Joint">Joint</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="maturityDate">Payoff Date</label> <input type="date"
							name="maturityDate" id="maturityDate" required="required" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label> Policy Type </label> <select id="schemeType"
							name="schemeType" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>
							<option value="RD">RD</option>


						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="schemeTerm">Policy Term </label> <input type="text"
							name="schemeTerm" id="schemeTerm" required="required"
							placeholder="Enter Policy Term" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="schemeMode">Policy Mode</label> <select
							id="schemeMode" name="schemeMode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Mode</option>
							<option value="Daily">Daily</option>
							<option value="Monthly">Monthly</option>
							<option value="Quarterly">Quarterly</option>
							<option value="Yearly">Yearly</option>


						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="policyAmount">Policy Amount</label> <input type="text"
							name="policyAmount" id="policyAmount" required="required"
							placeholder="Enter Policy Amount" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label>Deposit Amount</label> <input type="text"
							name="depositAmount" id="depositAmount" required="required"
							placeholder="Enter Deposit Amount" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label>MAturity Amount</label> <input type="text"
							name="maturityAmount" id="maturityAmount" required="required"
							placeholder="Enter Maturity Amount" />
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
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Mode Of Payment </label> <select id="paymentBy"
							name="paymentBy" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>
							<option value="Cash">Cash</option>
							<option value="Online">Online</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="remark">Comments</label>
						<textarea name="remark" id="remark" placeholder="Enter Remarks"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
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
					<button type="button" id="printBtn" class="btnStyle bg-primary">Print</button>
					<button type="button" id="deleteBtn" class="btnStyle bg-danger"
						style="background-color: #FFA500;">Delete</button>
					<button type="button" id="updateBtn" class="btnStyle bg-warning">Update</button>
				</div>
			</div>

		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/dataCorrection/policyDetailsUpdate.js"></script>
