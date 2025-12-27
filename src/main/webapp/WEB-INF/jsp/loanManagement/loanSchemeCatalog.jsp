
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Loan Scheme Catalog</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Loan Management Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">


					<input type="hidden" id="loanSchemeCode" name="loanSchemeCode"
						value="${loanSchemeCode}" />

					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Loan Plan Name</label> <input type="text"
							name="loanPlaneName" id="loanPlaneName" required="required"
							placeholder="Enter Loan Plan Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Type Of Loan</label> <select id="typeLoan"
							name="typeLoan" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Type Of Loan</option>
							<option value="Business Loan">Business Loan</option>
							<option value="Vehicle Loan">Vehicle Loan</option>
							<option value="Home Loan">Home Loan</option>
							<option value="personal Loan">personal Loan</option>
						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Age</label> <input type="text" name="age"
							id="age" required="required" placeholder="Enter Your Age"
							style="text-transform: uppercase;" /> <span id="message"></span>
					</div>

				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for=""> Interest Type</label> <select id="typeIntrest"
							name="typeIntrest" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select ROI Type</option>
							<option value="Flat Interest">Flat Interest</option>
							<option value="Reducing Interest">Reducing Interest</option>
							<option value="Rule 78">Rule 78</option>

						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Loan Term </label> <input type="text"
							name="loanTerm" id="loanTerm" onblur="validateLoanDuration()"
							required="required" placeholder="Enter Min Loan Duration" /><span
							id="durationMsg"></span>
					</div>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="loanName">Loan Amount</label> <input type="text"
							name="loanAmount" id="loanAmount" required="required"
							placeholder="Enter Minimum Loan Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Mode</label> <select id="loanMode"
							name="loanMode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Loan Mode</option>
							<option value="Daily">Daily</option>
							<option value="Weekly">Weekly</option>
							<option value="Fortnightly">Fortnightly</option>
							<option value="Monthly">Monthly</option>
							<option value="Quarterly">Quarterly</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Rate Interest Type(%p.a.)</label> <input type="text"
							name="rateIntrestType" id="rateIntrestType" required="required"
							placeholder="Enter Rate Interest Type" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Security Type</label> <select id="typesecurity"
							name="typesecurity" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Security</option>
							<option value="Pledge">Pledge</option>
							<option value="Mortgage">Mortgage</option>
							<option value="Property">Property</option>
							<option value="Gold">Gold</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Emi Type</label> <select id="emiType" name="emiType"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Emi Type</option>
							<option value="Regular">Regular</option>
							<option value="Irregular">Irregular</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="h-100 d-flex justify-content-start align-items-center">
						<div
							class="d-flex justify-content-start align-items-center formFields">
							<label for="planStatus" style="margin-left: 20px;" class="mb-2">Plan
								Status</label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="planStatus" name="planStatus"
										class="toggle__input" data-toggle-type="member-status">
									<label for="planStatus" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>
		</div>

		<!-- Payment Deductions Section -->
		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Payment Deductions</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Processing Fee(%) </label> <input type="text"
							name="feeProcessing" id="feeProcessing" required="required"
							placeholder="Enter Processing Fee" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for=""> Legal Charges(%)</label> <input type="text"
							name="chargesLegal" id="chargesLegal" required="required"
							placeholder="Enter Legal Charges" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">GST(%)</label> <input type="text" name="gst"
							id="gst" required="required" placeholder="Enter GST" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Insurence Fee(%)</label> <input type="text"
							name="feeInsurence" id="feeInsurence" required="required"
							placeholder="Enter Insurance Fee" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Valuation Fee(%) </label> <input type="text"
							name="feeValuation" id="feeValuation" required="required"
							placeholder="Enter Valuation Fee" />
					</div>
				</div>

			</div>
		</div>

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Late Fine Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Late Allowance Days</label> <input type="text"
							name="lateAllowanceday" id="lateAllowanceday" required="required"
							placeholder="Enter Late Allowance Days" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">penalty mode</label> <select id="modePanalty"
							name="modePanalty" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Penalty Type</option>
							<option value="Percentage">Percentage</option>
							<option value="Amount">Amount</option>
						</select>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for=""> Monthly Penalty </label> <input type="numbtexter"
							name="pennaltyMonthly" id="pennaltyMonthly" required="required"
							placeholder="" />
					</div>
				</div>
			</div>


		</div>
		<input type="hidden" id="loanId" value="" />
		<div class="row">
			<div class="col-12 text-center">
				<button id="saveBtn" class="btnStyle bg-success">Save</button>


				<button id="updateBtn" class="btnStyle"
					style="background-color: #FFA500;">Update</button>

			</div>
		</div>
	</form>

	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">

				<div class="card-body table-responsive">
					<h5 class="card-title">
						Recent Sales <span>| Today</span>
					</h5>

					<table class="table table-borderless datatable overflow-scroll"
						onclick="loadLoanTable()" id="loanTableWrapper">
						<thead class="table-light">
							<tr style="font-family: 'Poppins', sans-serif;">
								<th scope="col">ID</th>
								<th>Loan Plan Name</th>

								<th>Type Of Loan</th>
								<th>Age</th>
								<th>Loan Term</th>
								<th>EMI Type</th>
								<th>Edit</th>
								<th>Delete</th>
								<td>
							</tr>
						</thead>
						<tbody id="loanTableBody">

						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</div>

<script>
document.addEventListener('DOMContentLoaded', function () {
	const toggles = document.querySelectorAll('.toggle__input');
	
	toggles.forEach((toggle) => {
		updateToggleColor(toggle);

		toggle.addEventListener('change', () => {
			updateToggleColor(toggle);
			console.log(`${toggle.dataset.toggleType} is now ${toggle.checked}`);
		});
	});

	function updateToggleColor(input) {
		const label = input.nextElementSibling;
		if (label) {
			label.style.backgroundColor = input.checked ? '#28a745' : '#ccc';
		}
	}
});
</script>
<script
	src="${pageContext.request.contextPath}/js/LoanManagment/LoanSchemCatalog.js"></script>
