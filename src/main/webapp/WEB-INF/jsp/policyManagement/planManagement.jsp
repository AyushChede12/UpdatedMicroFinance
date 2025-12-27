

<style>
table {
	width: 100%;
	border-collapse: collapse;
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	font-size: 14px;
	margin-top: 20px;
}

th, td {
	border: 1px solid #dee2e6;
	padding: 10px 12px;
	text-align: center;
	vertical-align: middle;
}

th {
	background-color: #f8f9fa;
	font-weight: bold;
	color: #343a40;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

tr:hover {
	background-color: #e9ecef;
	cursor: pointer;
}

.table-wrapper {
	overflow-x: auto;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
	margin-bottom: 30px;
}

table thead {
	position: sticky;
	top: 0;
	z-index: 1;
}

<
style>.table-wrapper {
	width: 100%;
	overflow-x: auto;
	border-radius: 8px;
	box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
	margin-top: 20px;
}

table {
	width: 100%;
	border-collapse: collapse;
	font-family: 'Segoe UI', sans-serif;
	font-size: 14px;
	min-width: 1200px; /* Force minimum width so columns look even */
}

thead {
	background: linear-gradient(to right, #7b2ff7, #f107a3);
	color: white;
	text-align: center;
}

th, td {
	border: 1px solid #dee2e6;
	padding: 10px 14px;
	text-align: center;
}

tbody tr:nth-child(even) {
	background-color: #f8f9fa;
}

tbody tr:hover {
	background-color: #e2e6ea;
	cursor: default;
}

th {
	font-weight: 600;
	text-transform: uppercase;
	letter-spacing: 0.5px;
}

td {
	color: #333;
	white-space: nowrap;
}
</style>

<div class="pagetitle">
	<h1>Policy Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-piggy-bank"></i>
			</a></li>
			<li class="breadcrumb-item action">Plan Management</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Daily Deposit</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<input type="hidden" value="DRD" name="drd" id="drd"
						required="required" />

					<div class="d-flex flex-column formFields mb-4">
						<label for="">Plan Code <span class="star">*</span></label> <input
							type="text" name="planCodeDD" id="planCodeDD" required="required"
							placeholder="Enter Plan Code" value="${memberCodeDD}"
							readonly="readonly" style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3 ">
					<div class="d-flex flex-column formFields  mb-4 ">
						<label for="vehicalNo">Plan Name <span class="star">*</span></label>
						<input type="text" name="planNameDD" id="planNameDD"
							required="required" placeholder="Enter Plan Name" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields  mb-4">
						<label for="vehicalNo">Minimum Deposit <span class="star">*</span></label>
						<input type="text" name="minimumDeposit" id="minimumDeposit"
							required="required" placeholder="Enter Minimum Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields  mb-4">
						<label for="vehicalNo">Rate of Interest (%) <span
							class="star">*</span></label> <input type="text" name="rateOfInterest"
							id="rateOfInterest" required="required"
							placeholder="Enter Interest Rate"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Installment Type <span class="star">*</span></label>
						<select id="installmentType" name="installmentType"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Installment Type</option>
							<option value="Cash">Cash</option>
							<option value="Cheque">Cheque</option>
							<option value="Online">Online</option>
							<option value="UPI">UPI</option>

						</select>
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Term <span class="star">*</span></label> <input
							type="text" name="ddterm" id="ddterm" required="required"
							placeholder="Enter Term" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Commission on New <span class="star">*</span></label>
						<input type="text" name="commissionOnNew" id="commissionOnNew"
							required="required" placeholder="Enter Commission on New" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Renewal Commission (%) <span class="star">*</span></label>
						<input type="text" name="renewalCommission" id="renewalCommission"
							required="required" placeholder="Enter Renewal Commission" />
					</div>
				</div>

				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Interest Interval <span class="star">*</span></label>
						<select id="interestInterval" name="interestInterval"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Interest Interval</option>
							<option value="Daily">Daily</option>
							<option value="Monthly">Monthly</option>
							<option value="Quarterly">Quarterly</option>
							<option value="Half-Yearly">Half-Yearly</option>
							<option value="Yearly">Yearly</option>
							<option value="On Maturity">On Maturity</option>

						</select>
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Total Paid <span class="star">*</span></label> <input
							type="text" name="totalPaid" id="totalPaid" required="required"
							readonly="readonly" placeholder="Enter Total Paid" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Maturity Amount <span class="star">*</span></label>
						<input type="text" name="maturityAmount" id="maturityAmount"
							readonly="readonly" required="required"
							placeholder="Enter Maturity Amount" />
					</div>
				</div>

				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Is Flexible Plan? <span class="star">*</span></label>
						<select id="flexiblePlan" name="flexiblePlan" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Flexible Plan</option>
							<option value="Yes">Yes</option>
							<option value="No">No</option>

						</select>
					</div>
				</div>





				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Grace Days <span class="star">*</span></label> <input
							type="text" name="graceDays" id="graceDays" required="required"
							placeholder="Enter Grace Days" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Penalty Rate (%) <span class="star">*</span></label>
						<input type="text" name="penaltyRate" id="penaltyRate"
							required="required" placeholder="Enter Penalty Rate" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class=" h-100 d-flex justify-content-start align-items-center"
						style="margin-bottom: 30px;">
						<div
							class="d-flex justify-content-start align-items-center  formFields">
							<label style="margin-left: 20px;" class="mb-2">Status
								Plan</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-status-planDD"
										name="statusOfPlan" class="toggle__input"
										data-toggle-type="status-plan"> <label
										for="toggle-status-planDD" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>

			<div class="row" style="margin-left: 80%;">
				<div class="col-12 text-center">
					<button id="saveBtn" class="btnStyle bg-warning ">Save</button>
					<button id="updateBtn" class="btnStyle bg-warning style="display:none;">Update</button>

				</div>
			</div>

			<div class="row mt-5">
				<div class="col-12">
					<div class="card recent-sales">
						<div class="card-body table-responsive">
							<h5 class="card-title">
								Daily Deposit <span>| Table View</span>
							</h5>

							<table class="table table-bordered">
								<thead class="table-light">
									<tr>
										<th style="white-space: nowrap;">Sr. No</th>
										<th style="white-space: nowrap;">Plan Code</th>
										<th style="white-space: nowrap;">Plan Name</th>
										<th style="white-space: nowrap;">Minimum Deposit</th>
										<th style="white-space: nowrap;">Rate of Interest</th>
										<th style="white-space: nowrap;">Installment Type</th>
										<th style="white-space: nowrap;">Term (Duration)</th>
										<th style="white-space: nowrap;">Maturity Amount</th>
										<th style="white-space: nowrap;">Status (Active/Inactive)</th>
										<th style="white-space: nowrap;">Action</th>
									</tr>
								</thead>
								<tbody id="depositTableBody">
									<!-- Dynamic rows will be injected here -->
								</tbody>
							</table>

						</div>
					</div>
					<div class="mt-2 text-center">
						<button id="prevBtnDD" class="btn btn-sm btn-primary">
							<i class="bi bi-chevron-double-left"></i>
						</button>
						<span id="pageInfoDD" class="mx-2"></span>
						<button id="nextBtnDD" class="btn btn-sm btn-primary">
							<i class="bi bi-chevron-double-right"></i>
						</button>
					</div>
				</div>
			</div>
	</form>
</div>
<br>
<br>


<div>
	<form id="recurringformid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Recurring Deposit</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<input type="hidden" name="rd" id="rd" value="RD"
						required="required" style="text-transform: uppercase;" />

					<div class="d-flex flex-column formFields">
						<label for="">Plan Code <span class="star">*</span></label> <input
							type="text" name="planCodeRD" id="planCodeRD" required="required"
							placeholder="Enter Plan Code" value="${memberCodeRD}"
							readonly="readonly" style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3 ">
					<div class="d-flex flex-column formFields  mb-4 ">
						<label for="vehicalNo">Plan Name <span class="star">*</span></label>
						<input type="text" name="planNameRD" id="planNameRD"
							required="required" placeholder="Enter Minimum Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Minimum Amount <span class="star">*</span></label>
						<input type="text" name="minimumAmountRD" id="minimumAmountRD"
							required="required" placeholder="Enter Minimum Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Interest Rate(%) <span class="star">*</span></label>
						<input type="text" name="rateOfInterestRD" id="rateOfInterestRD"
							required="required" placeholder="Enter Interest Rate"
							style="text-transform: uppercase;" />
					</div>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Term <span class="star">*</span></label> <input
							type="text" name="rdterm" id="rdterm" required="required"
							placeholder="Enter Term" />
					</div>
				</div>
				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Installment Type <span class="star">*</span></label>
						<select id="installmentTypeRD" name="installmentTypeRD"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Installment Type</option>
							<option value="Cash">Cash</option>
							<option value="Cheque">Cheque</option>
							<option value="Online">Online</option>
							<option value="UPI">UPI</option>

						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">new Commission(%) <span class="star">*</span></label>
						<input type="text" name="commissionOnNewRD" id="commissionOnNewRD"
							required="required" placeholder="Enter Comm.New(%)" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Renewal Commission(%) <span class="star">*</span></label>
						<input type="text" name="renewalCommissionRD"
							id="renewalCommissionRD" required="required"
							placeholder="Enter Comm.Renew(%)" />
					</div>
				</div>

				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Interest Interval <span class="star">*</span></label>
						<select id="componentIntervalRD" name="componentIntervalRD"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Compound Interval</option>
							<option value="Monthly">Monthly</option>
							<option value="Quarterly">Quarterly</option>
							<option value="Half-Yearly">Half-Yearly</option>
							<option value="Yearly">Yearly</option>
							<option value="On Maturity">On Maturity</option>
						</select>
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Total Deposit <span class="star">*</span></label> <input
							type="text" name="totalPaidRD" id="totalPaidRD"
							readonly="readonly" required="required"
							placeholder="Enter Total Deposit" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Maturity Amount <span class="star">*</span></label>
						<input type="text" name="maturityAmountRD" id="maturityAmountRD"
							readonly="readonly" required="required"
							placeholder="Enter Maturity Amount" />
					</div>
				</div>

				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Is Flexible Plan? <span class="star">*</span></label>
						<select id="flexiblePlanRD" name="flexiblePlanRD"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Flexible Plan</option>
							<option value="Yes">Yes</option>
							<option value="No">No</option>

						</select>
					</div>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Grace Period <span class="star">*</span></label> <input
							type="text" name="graceDaysRD" id="graceDaysRD"
							required="required" placeholder="Enter Grace Period" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Penalty Fine(%) <span class="star">*</span></label>
						<input type="text" name="penaltyfineRD" id="penaltyfineRD"
							required="required" placeholder="Enter Penalty Fine" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class=" h-100 d-flex justify-content-start align-items-center"
						style="margin-bottom: 30px;">
						<div
							class="d-flex justify-content-start align-items-center  formFields">
							<label style="margin-left: 20px;" class="mb-2">Status
								Plan</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-status-planRD"
										name="statusOfPlanRD" class="toggle__input"
										data-toggle-type="status-plan"> <label
										for="toggle-status-planRD" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>

			<div class="row" style="margin-left: 80%;">
				<div class="col-12 text-center">
					<button id="ReccuringsaveBtn" class="btnStyle bg-warning ">Save</button>
					<button id="ReccuringupdateBtn" class="btnStyle bg-warning style="display:none;">Update</button>

				</div>
			</div>

			<div class="row mt-5">
				<div class="col-12">
					<div class="card recent-sales">
						<div class="card-body table-responsive">
							<h5 class="card-title">
								Recurring Deposit <span>| Table View</span>
							</h5>

							<table class="table table-bordered">
								<thead class="table-light">
									<tr>
										<th style="white-space: nowrap;">Sr. No</th>
										<th style="white-space: nowrap;">Plan Code</th>
										<th style="white-space: nowrap;">Plan Name</th>
										<th style="white-space: nowrap;">Minimum Deposit</th>
										<th style="white-space: nowrap;">Rate of Interest</th>
										<th style="white-space: nowrap;">Installment Type</th>
										<th style="white-space: nowrap;">Term (Duration)</th>
										<th style="white-space: nowrap;">Maturity Amount</th>
										<th style="white-space: nowrap;">Status (Active/Inactive)</th>
										<th style="white-space: nowrap;">Action</th>
									</tr>
								</thead>
								<tbody id="recurringTableBody">
									<!-- Dynamic rows will be injected here -->
								</tbody>
							</table>

						</div>
					</div>
					<div class="mt-2 text-center">
						<button id="prevBtnRD" class="btn btn-sm btn-primary">
							<i class="bi bi-chevron-double-left"></i>
						</button>
						<span id="pageInfoRD" class="mx-2"></span>
						<button id="nextBtnRD" class="btn btn-sm btn-primary">
							<i class="bi bi-chevron-double-right"></i>
						</button>
					</div>
				</div>
			</div>
	</form>
</div>
<br>
<br>


<div>
	<form id="fixedformid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Fixed Deposit</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<input type="hidden" name="fd" id="fd" value="FD"
						required="required" style="text-transform: uppercase;" />

					<div class="d-flex flex-column formFields">
						<label for="">Plan Code <span class="star">*</span></label> <input
							type="text" name="planCodeFD" id="planCodeFD" required="required"
							value="${memberCodeFD}" readonly="readonly"
							placeholder="Enter Plan Code" style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3 ">
					<div class="d-flex flex-column formFields  mb-4 ">
						<label for="vehicalNo">Plan Name <span class="star">*</span></label>
						<input type="text" name="planNameFD" id="planNameFD"
							required="required" placeholder="Enter Minimum Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Minimum Amount <span class="star">*</span></label>
						<input type="text" name="minimumAmountFD" id="minimumAmountFD"
							required="required" placeholder="Enter Minimum Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Interest Rate(%) <span class="star">*</span></label>
						<input type="text" name="rateOfInterestFD" id="rateOfInterestFD"
							required="required" placeholder="Enter Interest Rate"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Installment Type <span class="star">*</span></label>
						<select id="installmentTypeFD" name="installmentTypeFD"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Installment Type</option>
							<option value="Cash">Cash</option>
							<option value="Cheque">Cheque</option>
							<option value="Online">Online</option>
							<option value="UPI">UPI</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Term <span class="star">*</span></label> <input
							type="text" name="fdterm" id="fdterm" required="required"
							placeholder="Enter Term" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Renewal Commission(%) <span class="star">*</span></label>
						<input type="text" name="renewalCommissionFD"
							id="renewalCommissionFD" required="required"
							placeholder="Enter Comm.Renew(%)" />
					</div>
				</div>

				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Interest Interval <span class="star">*</span></label>
						<select id="componentIntervalFD" name="componentIntervalFD"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Compound Interval</option>
							<option value="Monthly">Monthly</option>
							<option value="Quarterly">Quarterly</option>
							<option value="Half-Yearly">Half-Yearly</option>
							<option value="Yearly">Yearly</option>
							<option value="On Maturity">On Maturity</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Total Deposit <span class="star">*</span></label> <input
							type="text" name="totalPaidFD" id="totalPaidFD"
							readonly="readonly" required="required"
							placeholder="Enter Total Deposit" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Maturity Amount <span class="star">*</span></label>
						<input type="text" name="maturityAmountFD" id="maturityAmountFD"
							readonly="readonly" required="required"
							placeholder="Enter maturityAmountFD" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="">Interest Earned <span class="star">*</span></label>
						<input type="text" name="interestEarnedFD" id="interestEarnedFD"
							readonly="readonly" required="required"
							placeholder="Interest Earned" />
					</div>
				</div>

				<!-- New field: Interest Per Interval -->
				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Interest Per Interval <span class="star">*</span></label>
								<input type="text" name="interestPerIntervalFD"
									id="interestPerIntervalFD" readonly="readonly"
									required="required" placeholder="Interest Per Interval" />
							</div>
						</div> -->

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">New Commission(%) <span class="star">*</span></label>
						<input type="text" name="commissionOnNewFD" id="commissionOnNewFD"
							required="required" placeholder="Enter Comm.New(%)" />
					</div>
				</div>
				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Is Flexible Plan? <span class="star">*</span></label>
						<select id="flexiblePlanFD" name="flexiblePlanFD"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Flexible Plan</option>
							<option value="Yes">Yes</option>
							<option value="No">No</option>

						</select>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Grace Period <span class="star">*</span></label> <input
							type="text" name="graceDaysFD" id="graceDaysFD"
							required="required" placeholder="Enter Grace Period" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Penalty Fine(%) <span class="star">*</span></label>
						<input type="text" name="penltyfineFD" id="penltyfineFD"
							required="required" placeholder="Enter Penalty Fine" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class=" h-100 d-flex justify-content-start align-items-center"
						style="margin-bottom: 30px;">
						<div
							class="d-flex justify-content-start align-items-center  formFields">
							<label style="margin-left: 20px;" class="mb-2">Status
								Plan</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-status-planFD"
										name="statusOfPlanFD" class="toggle__input"
										data-toggle-type="status-plan"> <label
										for="toggle-status-planFD" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>


		</div>

		<div class="row" style="margin-left: 80%;">
			<div class="col-12 text-center">
				<button id="FixedsaveBtn" class="btnStyle bg-warning ">Save</button>
				<button id="FixedupdateBtn" class="btnStyle bg-warning style="display:none;">Update</button>
			</div>
		</div>

		<div class="row mt-5">
			<div class="col-12">
				<div class="card recent-sales">
					<div class="card-body table-responsive">
						<h5 class="card-title">
							Fixed Deposit <span>| Table View</span>
						</h5>

						<table class="table table-bordered">
							<thead class="table-light">
								<tr>
									<th style="white-space: nowrap;">Sr. No</th>
									<th style="white-space: nowrap;">Plan Code</th>
									<th style="white-space: nowrap;">Plan Name</th>
									<th style="white-space: nowrap;">Minimum Deposit</th>
									<th style="white-space: nowrap;">Rate of Interest</th>
									<th style="white-space: nowrap;">Installment Type</th>
									<th style="white-space: nowrap;">Term (Duration)</th>
									<th style="white-space: nowrap;">Maturity Amount</th>
									<th style="white-space: nowrap;">Status (Active/Inactive)</th>
									<th style="white-space: nowrap;">Action</th>
								</tr>
							</thead>
							<tbody id="fixedTableBody">
								<!-- Dynamic rows will be injected here -->
							</tbody>
						</table>

					</div>
				</div>
				<div class="mt-2 text-center">
					<button id="prevBtnFD" class="btn btn-sm btn-primary">
						<i class="bi bi-chevron-double-left"></i>
					</button>
					<span id="pageInfoFD" class="mx-2"></span>
					<button id="nextBtnFD" class="btn btn-sm btn-primary">
						<i class="bi bi-chevron-double-right"></i>
					</button>
				</div>
			</div>
		</div>
	</form>
</div>
<br>
<br>


<div>
	<form id="misdepositeid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">MIS Deposit</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<input type="hidden" name="mis" id="mis" value="MIS"
						required="required" style="text-transform: uppercase;" />

					<div class="d-flex flex-column formFields">
						<label for="">Plan Code <span class="star">*</span></label> <input
							type="text" name="planCodeMD" id="planCodeMD" required="required"
							placeholder="Enter Plan Code" value="${memberCodeMD}"
							readonly="readonly" style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3 ">
					<div class="d-flex flex-column formFields  mb-4 ">
						<label for="vehicalNo">Plan Name <span class="star">*</span></label>
						<input type="text" name="planNameMD" id="planNameMD"
							required="required" placeholder="Enter Minimum Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Minimum Amount <span class="star">*</span></label>
						<input type="text" name="minimumAmountMD" id="minimumAmountMD"
							required="required" placeholder="Enter Minimum Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Interest Rate(%) <span class="star">*</span></label>
						<input type="text" name="rateOfInterestMD" id="rateOfInterestMD"
							required="required" placeholder="Enter Interest Rate"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Installment Type <span class="star">*</span></label>
						<select id="installmentTypeMD" name="installmentTypeMD"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Installment Type</option>
							<option value="Cash">Cash</option>
							<option value="Cheque">Cheque</option>
							<option value="Online">Online</option>
							<option value="UPI">UPI</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Term <span class="star">*</span></label> <input
							type="text" name="misTerm" id="misTerm" required="required"
							placeholder="Enter Term" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Total Deposit <span class="star">*</span></label> <input
							type="text" name="totalPaidMD" id="totalPaidMD"
							readonly="readonly" required="required"
							placeholder="Enter Total Deposit" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Maturity Amount <span class="star">*</span></label>
						<input type="text" name="maturityAmountMD" id="maturityAmountMD"
							readonly="readonly" required="required"
							placeholder="Enter Maturity Amount" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px;">
						<label for="">Interest Earned <span class="star">*</span></label>
						<input type="text" name="interestEarnedMD" id="interestEarnedMD"
							readonly="readonly" required="required"
							placeholder="Interest Earned" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">New Commission(%) <span class="star">*</span></label>
						<input type="text" name="commissionOnNewMD" id="commissionOnNewMD"
							required="required" placeholder="Enter Comm.New(%)" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Renewal Commission(%) <span class="star">*</span></label>
						<input type="text" name="renewalCommissionMD"
							id="renewalCommissionMD" required="required"
							placeholder="Enter Comm.Renew(%)" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Grace Period <span class="star">*</span></label> <input
							type="text" name="graceDaysMD" id="graceDaysMD"
							required="required" placeholder="Enter Grace Period" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Penalty Fine(%) <span class="star">*</span></label>
						<input type="text" name="penltyfineMD" id="penltyfineMD"
							required="required" placeholder="Enter Penalty Fine" />
					</div>
				</div>

				<div class="col-lg-3 mb-4 ">
					<div class="d-flex flex-column formFields">
						<label for="">Is Flexible Plan? <span class="star">*</span></label>
						<select id="flexiblePlanMD" name="flexiblePlanMD"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Flexible Plan</option>
							<option value="Yes">Yes</option>
							<option value="No">No</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class=" h-100 d-flex justify-content-start align-items-center"
						style="margin-bottom: 30px;">
						<div
							class="d-flex justify-content-start align-items-center  formFields">
							<label style="margin-left: 20px;" class="mb-2">Status
								Plan</label>
							<div class="cont">
								<div class="toggle">
									<input type="checkbox" id="toggle-status-planMIS"
										name="statusOfPlanMDRD2" class="toggle__input"
										data-toggle-type="status-plan"> <label
										for="toggle-status-planMIS" class="toggle__label"></label>
								</div>
							</div>
						</div>
					</div>
				</div>

			</div>
		</div>

		<div class="row" style="margin-left: 80%;">
			<div class="col-12 text-center">
				<button id="missaveBtn" class="btnStyle bg-warning ">Save</button>
				<button id="misdupdateBtn" class="btnStyle bg-warning style="display:none;">Update</button>
			</div>
		</div>

		<div class="row mt-5">
			<div class="col-12">
				<div class="card recent-sales">
					<div class="card-body table-responsive">
						<h5 class="card-title">
							MIS Deposit <span>| Table View</span>
						</h5>

						<table class="table table-bordered">
							<thead class="table-light">
								<tr>
									<th style="white-space: nowrap;">Sr. No</th>
									<th style="white-space: nowrap;">Plan Code</th>
									<th style="white-space: nowrap;">Plan Name</th>
									<th style="white-space: nowrap;">Minimum Deposit</th>
									<th style="white-space: nowrap;">Rate of Interest</th>
									<th style="white-space: nowrap;">Installment Type</th>
									<th style="white-space: nowrap;">Term (Duration)</th>
									<th style="white-space: nowrap;">Maturity Amount</th>
									<th style="white-space: nowrap;">Status (Active/Inactive)</th>
									<th style="white-space: nowrap;">Action</th>
								</tr>
							</thead>
							<tbody id="misdepositeTableBody">
								<!-- Dynamic rows will be injected here -->
							</tbody>
						</table>

					</div>
				</div>
				<div class="mt-2 text-center">
					<button id="prevBtnMIS" class="btn btn-sm btn-primary">
						<i class="bi bi-chevron-double-left"></i>
					</button>
					<span id="pageInfoMIS" class="mx-2"></span>
					<button id="nextBtnMIS" class="btn btn-sm btn-primary">
						<i class="bi bi-chevron-double-right"></i>
					</button>
				</div>
			</div>
		</div>
	</form>
</div>
<%--  <button class="btn btn-sm btn-primary" onclick="editPlan(${item.id})">
	                    <i class="fa fa-edit"></i>
	                  </button>
 --%>

<script
	src="${pageContext.request.contextPath}/js/PolicyManagment/PlanMangement.js"></script>
