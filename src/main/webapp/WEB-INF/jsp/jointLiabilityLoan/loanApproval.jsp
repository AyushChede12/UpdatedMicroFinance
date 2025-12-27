
<div class="pagetitle">
	<h1>Joint Liability Loan</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-person-bounding-box"></i>
			</a></li>
			<li class="breadcrumb-item action">Loan Approval</li>
		</ol>
	</nav>
</div>


<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Data Search Panel</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields">
						<label for="groupCode">Find by Group Code*</label> <select
							id="groupcode" name="groupcode" required
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Customer Name</option>
						</select>
					</div>

				</div>



			</div>


		</div>


		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Loan Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="openingDate">Opening Date*</label> <input type="date"
							name="openingDate" id="openingDate" required
							placeholder="Enter Opening Date"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="communityName">Community Name*</label> <input
							type="text" name="communityName" id="communityName" required
							placeholder="Enter Community Name" />
					</div>
				</div>

				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="allocatedStaff">Allocated Staff*</label> <input
							type="text" name="allocatedStaff" id="allocatedStaff" required
							placeholder="Enter Allocated Staff" />
					</div>
				</div>


				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Branch Name* </label> <input type="text"
							name="branchName" id="branchName" required="required"
							placeholder="Enter  Branch Name" />
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Collection Schedule* </label> <input type="text"
							name="collectionDays" id="collectionDays" required="required"
							placeholder="Enter Location" />
					</div>
				</div>

				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Contact Number* </label> <input type="text"
							name="contactNumber" id="contactNumber" required="required"
							placeholder="Enter Location" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for=""> Purpose of Loan* </label> <input type="text"
							name="purposeOfLoan" id="purposeOfLoan" required="required"
							placeholder="Enter Location" />
					</div>
				</div>



			</div>
		</div>

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Loan Approval Info</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Date of Approval*</label> <input
							type="date" name="approvalDate" id="approvalDate"
							required="required" placeholder="Enter Vehicle No"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Approval Status</label> <input type="text"
							id="approvalStatus" name="approvalStatus" class="form-control"
							readonly
							style="font-size: 12px; font-weight: bold; text-transform: uppercase;" />
					</div>
				</div>



			</div>
			<div class="row">
				<div class="col-12 text-center">
					<button type="button" id="approveBtn" class="btnStyle bg-success"
						style="margin-left: 80%">Approve</button>

				</div>
			</div>
		</div>


	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/Joinlibiliy/LoanApproval.js"></script>
