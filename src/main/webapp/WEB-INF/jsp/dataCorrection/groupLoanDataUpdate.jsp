
<div class="pagetitle">
	<h1>Data Correction</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"><i
					class="bi bi-person-bounding-box"></i></a></li>
			<li class="breadcrumb-item action">Joint Liability Update</li>
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
				<div class="col-lg-5">
					<input type="hidden" name="id" id="id">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 20px;">
						<label for="groupCode">Find By Group Code</label> <select
							id="groupCode" name="groupCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-- Search Group Code --</option>
						</select>
					</div>
				</div>

			</div>
		</div>

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Group Profile</li>
				</ol>
			</nav>
			<div class="col-lg-3" style="display: none;">
				<div class="d-flex flex-column formFields">
					<label>Selected Member*</label> <input type="hidden"
						id="selectedMember" name="selectedMember" class="form-control"
						required />
				</div>
			</div>

			<div class="col-lg-3" style="display: none;">
				<div class="d-flex flex-column formFields">
					<label>Customer Name*</label> <input type="hidden"
						id="customerName" name="customerName" class="form-control"
						required />
				</div>
			</div>

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
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="allocatedStaff">Allocated Staff*</label> <input
							type="text" name="allocatedStaff" id="allocatedStaff" required
							placeholder="Enter Allocated Staff" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="branchName">Branch Name*</label> <select
							id="branchName" name="branchName" required
							class="form-control selectField" style="height: 30px;"></select>
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="collectionDays">Scheduled Collection Days*</label> <input
							type="text" name="collectionDays" id="collectionDays" required
							placeholder="Enter Collection Days" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="communityLeader">Community Leader*</label> <input
							type="text" name="communityLeader" id="communityLeader" required
							placeholder="Enter Community Leader" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for="contactNumber">Contact Number*</label> <input
							type="text" name="contactNumber" id="contactNumber" required
							placeholder="Enter Contact Number" />
					</div>
				</div>
				<div class="col-lg-3  mb-4">
					<div class="d-flex flex-column formFields">
						<label for="loanPurpose">Purpose of Loan*</label> <input
							type="text" name="loanPurpose" id="loanPurpose" required
							placeholder="Enter Loan Purpose" />
					</div>
				</div>
			</div>
		</div>

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Financial Deductions</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3 ">
					<div class="d-flex flex-column formFields">
						<label for="planCode">Fetch by Plan Code*</label> <select
							id="planCode" name="planCode" required
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Plan Code</option>
						</select>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="communityLeader">loan Scheme Name*</label> <input
							type="text" name="loanSchemeName" id="loanSchemeName" required
							placeholder="Enter Community Leader" />
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="processingFee">Processing Fee (%)*</label> <input
							type="text" name="processingFee" id="processingFee" required
							placeholder="Enter Processing Fee" />
					</div>
				</div>
				<div class="col-lg-3" style="display: none;">
					<div class="d-flex flex-column formFields">
						<label>Plan ID*</label> <input type="hidden" id="planCode"
							name="planCode" class="form-control" required />
					</div>
				</div>


				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="legalCharges">Legal Charges (%)*</label> <input
							type="text" name="legalCharges" id="legalCharges" required
							placeholder="Enter Legal Charges" />
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="gstPercentage">GST(%)*</label> <input type="text"
							name="gstPercentage" id="gstPercentage" required
							placeholder="Enter GST" />
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="insuranceFee">Insurence.Fee(%)*</label> <input
							type="text" name="insuranceFee" id="insuranceFee" required
							placeholder="Enter Insurance Fee" />
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="valuationFee">Valuation Fee (%)*</label> <input
							type="text" name="valuationFee" id="valuationFee" required
							placeholder="Enter Valuation Fee" />
					</div>
				</div>

				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="penaltyMode">Penalty Mode*</label> <input type="text"
							name="penaltyMode" id="penaltyMode" required
							placeholder="Enter Penalty Mode" />
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="monthlyPenalty">Monthly Penalty*</label> <input
							type="text" name="monthlyPenalty" id="monthlyPenalty" required
							placeholder="Enter Monthly Penalty" />
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="emiFrequency">EMI Frequency*</label> <input
							type="text" name="emiFrequency" id="emiFrequency" required
							placeholder="Enter EMI Frequency" />
					</div>
				</div>
				<div class="col-lg-3 mb-4">
					<div class="d-flex flex-column formFields">
						<label for="rateOfInterest">Rate of Interest (% p.a.)*</label> <input
							type="text" name="rateOfInterest" id="rateOfInterest" required
							placeholder="Enter Rate of Interest" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="minLoanDurationMonths">Term * </label> <input
							type="text" name="Term" id="Term" required
							placeholder="Enter Term" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="minLoanDurationMonths">Total Amount* </label> <input
							type="text" name="totalAmount" id="totalAmount" required
							placeholder="Enter Term" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="interestType">Interest Type*</label> <select
							name="interestType" id="interestType" required
							class="form-control selectField" style="height: 30px;">

							<option value="">-- Select Interest Type --</option>
							<option value="flatInterest">Flat Interest</option>
							<option value="reducingInterest">Reducing Interest</option>
							<option value="Rule78">Rule 78</option>

						</select>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="emiType">EMI mode*</label><select name="emiType"
							id="emiType" required class="form-control selectField">
							<option value="">-- Select EMI Mode --</option>
							<option value="daily">Daily</option>
							<option value="weekly">Weekly</option>
							<option value="monthly">Monthly</option>
							<option value="fortnightly">Fortnightly</option>
							<option value="quarterly">Quarterly</option>
						</select>

					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Date of Approval*</label> <input
							type="date" name="approvalDate" id="approvalDate"
							required="required" placeholder="Enter Vehicle No"
							style="text-transform: uppercase;" />
					</div>
				</div>
			</div>

			<div class="mt-5">
				<div class="row">
					<div class="col-12 text-center" style="margin-top: 30px;">
						<button type="button" id="updateBtn" class="btnStyle bg-warning">Update</button>
						<button type="button" id="newBtn" class="btnStyle bg-primary"
							style="background-color: #FFA500;">New</button>
						<button type="button" id="deleteBtn" class="btnStyle bg-danger">Delete</button>
					</div>
				</div>
			</div>
		</div>
	</form>
</div>

<script
	src="${pageContext.request.contextPath}/js/dataCorrection/jointLiabiliyUpdate.js"></script>
