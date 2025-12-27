
	<script type="text/javascript">
   function calculateAge() {
	   const dob = new Date(document.getElementById("dateOfBirth").value); // get DOB from the date input field
	   const age = Math.floor((Date.now() - dob) / (365.25 * 24 * 60 * 60 * 1000)); // calculate age
	   document.getElementById("age").value = age; // set the calculated age in the age input field
	 }
</script>

		<div class="pagetitle">
			<h1>Team Management</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="openDashboard"> <i
							class="bi bi-person-workspace"></i>
					</a></li>
					<li class="breadcrumb-item action">Add Team Member</li>
				</ol>
			</nav>
		</div>

		<div>
			<form id="formid">
				<div>
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action">Team Member Details</li>
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
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px;">
								<label for="">Team Member CODE</label> <input type="text"
									id="teamMemberCode" name="teamMemberCode"
									value="${teamMemberUniqueNo}" required="required"
									placeholder="Enter Team Member Code">
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="joiningDate">Sign-Up Date</label> <input type="date"
									name="signUpDate" id="signUpDate" required="required"
									placeholder="Enter Sign-Up Date"
									style="text-transform: uppercase;" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Branch Name </label> <select id="branchName"
									name="branchName" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select Branch Name</option>
								</select>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Team Member Name </label> <input type="text"
									name="teamMemberName" id="teamMemberName" required="required"
									placeholder="Enter Team Member Name" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px;">
								<label for="dob">Date Of Birth</label> <input type="date"
									name="dateOfBirth" onchange="calculateAge()" id="dateOfBirth"
									required="required" placeholder="Enter DateOfBirth"
									style="text-transform: uppercase;" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Age</label> <input type="text" name="age" id="age"
									required="required" placeholder="Enter Age" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Family Member Name </label> <input type="text"
									name="familyMemberName" id="familyMemberName"
									required="required" placeholder="Enter Family Member Name" />
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Relation to Applicant </label> <select
									id="relationToApplicant" name="relationToApplicant"
									required="required" class="form-control selectField"
									style="height: 30px;">
									<option value="">Select Relation to Applicant</option>
								</select>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px;">
								<label for="">Contact No</label> <input type="text"
									name="contactNo" id="contactNo" required="required"
									placeholder="Enter Contact No" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Nominee Name</label> <input type="text"
									name="nomineeName" id="nomineeName" required="required"
									placeholder="Enter Nominee Name" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Nominee Age</label> <input type="text"
									name="nomineeAge" id="nomineeAge" required="required"
									placeholder="Enter Nominee Age" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Relation with Nominee</label> <select
									id="relationWithNominee" name="relationWithNominee"
									required="required" class="form-control selectField"
									style="height: 30px;">
									<option value="">Select Relation</option>
								</select>
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px;">
								<label for="">Address</label>
								<textarea name="address" id="address"
									style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">PAN</label> <input type="text" name="pan" id="pan"
									required="required" placeholder="Enter PAN" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Bank A/C</label> <input type="text" name="bankAC"
									id="bankAC" required="required" placeholder="Enter Bank A/C" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">IFSC Code</label> <input type="text"
									name="ifscCode" id="ifscCode" required="required"
									placeholder="Enter IFSC Code" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Exp. Details</label> <input type="text"
									name="expDetails" id="expDetails" required="required"
									placeholder="Enter Exp. Details" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Educational Background</label> <input type="text"
									name="educationalBackground" id="educationalBackground"
									required="required" placeholder="Enter Educational Background" />
							</div>
						</div>


					</div>
				</div>







				<div class="mt-5">
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action">Designation Details</li>
						</ol>
					</nav>
					<div class="row">
						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Designation </label> <select id="designation"
									name="designation" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select</option>
								</select>
							</div>
						</div>



						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Department </label> <select id="department"
									name="department" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select</option>
								</select>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Salary </label> <input type="text" name="salary"
									id="salary" required="required" placeholder="Enter Salary" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Saving Account No. </label> <input type="text"
									name="savingAccNo" id="savingAccNo" required="required"
									placeholder="Enter SB Account No." />
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
								<label for="">Fees(if any) </label> <input type="text"
									name="fees" id="fees" required="required"
									placeholder="Enter Fees" />
							</div>
						</div>



						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Mode of Payment </label> <select
									id="modeofpayment" name="modeofpayment" required="required"
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
							<div class="d-flex flex-column formFields">
								<label for="">Comments </label> <input type="text"
									name="comments" id="comments" required="required"
									placeholder="Enter Remarks" />
							</div>
						</div>

						<div class="col-lg-3">
							<div
								class=" h-100 d-flex justify-content-start align-items-center">
								<div
									class="d-flex justify-content-start align-items-center formFields">
									<label style="margin-left: 20px;" class="mb-2">Customer
										Status</label>
									<div class="cont">
										<div class="toggle">
											<input type="checkbox" id="customerStatus"
												name="customerStatus" class="toggle__input"
												data-toggle-type="member-status"> <label
												for="customerStatus" class="toggle__label"></label>


										</div>
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
						</div>
						<div class="row">
							<div class="col-lg-3">
								<div class="d-flex flex-column formFields">
									<label for="">Cheque Date </label> <input type="Date"
										name="chequeDate" id="chequeDate" required="required"
										placeholder="Enter Cheque Date" />
								</div>
							</div>
						</div>
						<div class="row">
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
						</div>
						<div class="row">
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
						</div>
						<div class="row">
							<div class="col-lg-3">
								<div class="d-flex flex-column formFields">
									<label for="">Ref Number </label> <input type="text"
										name="refNumber2" id="refNumber2" required="required"
										placeholder="Enter Deposite Ref No." />
								</div>
							</div>
						</div>
					</div>

				</div>


				<div class="row">
					<div class="col-12">
						<button id="TeamMemberSaveBtn" class="btnStyle bg-success">Save</button>
						<button id="newBtn" class="btnStyle"
							style="background-color: #FFA500;">New</button>
					</div>
				</div>
			</form>
		</div>

	<script>
	$(document).ready(function() {
		DesignationDropdown();
		DepartmentDropdown();
		BranchNameDropdown();
		RelationDropdown();
	});
	</script>

	<script>
document.addEventListener('DOMContentLoaded', function () {
	
	const toggles = document.querySelectorAll('.toggle__input');	
	toggles.forEach((toggle) => {
		updateToggleColor(toggle);

		toggle.addEventListener('change', () => {
			updateToggleColor(toggle);
			//console.log(${toggle.dataset.toggleType} is now ${toggle.checked});
			console.log(`${toggle.dataset.toggleType} is now ${toggle.checked}`);

		});
	});

	function updateToggleColor(input) {
		const label = input.nextElementSibling;
		if (label) {
			label.style.backgroundColor = input.checked ? '#2830a7' : '#ccc';
		}
	}
});
</script>

	<script>
    
document.getElementById('modeofpayment').addEventListener('change', function () {
    // Get the selected payment mode
    let mode = this.value;

    // Define all input field sections
    const chequeInputs = document.getElementById('chequeInputs');
    const onlineInputs = document.getElementById('onlineInputs');
    const neftInputs = document.getElementById('neftInputs');

    // Reset the display of all sections
    chequeInputs.style.display = 'none';
    onlineInputs.style.display = 'none';
    neftInputs.style.display = 'none';

    // Show the section corresponding to the selected payment mode
    if (mode === 'Cheque') {
        chequeInputs.style.display = 'block';
    } else if (mode === 'Online') {
        onlineInputs.style.display = 'block';
    } else if (mode === 'NEFT') {
        neftInputs.style.display = 'block';
    }
});
</script>
<script
	src="${pageContext.request.contextPath}/js/teamManagement/addTeamMember.js"></script>
	