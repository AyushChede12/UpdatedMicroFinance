<div class="pagetitle">
	<h1>SAVINGS / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"><i
					class="bi bi-bank text-blue"></i></a></li>
			<li class="breadcrumb-item action">SAVINGS SCHEME CATALOG</li>
		</ol>
	</nav>
</div>


<!-- ************** FORM START ************** -->
<form id="savingForm">

	<!-- 🔥 Hidden ID (FIXED) -->
	<input type="hidden" id="savingAccountId" />

	<nav>
		<ol class="breadcrumb breadcrumb-title">
			<li class="breadcrumb-item action">SAVING PLAN DETAILS</li>
		</ol>
	</nav>

	<div class="row">

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>PLAN NAME</label> <input type="text" id="policyName"
					placeholder="ENTER PLAN NAME" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>YEARLY ROI(%)</label> <input type="text" id="yearlyROI"
					placeholder="ENTER YEARLY ROI" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>CUSTOMER NAME</label> <input type="text" id="customerName"
					placeholder="ENTER CUSTOMER NAME" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>INITIAL DEPOSITE</label> <input type="text"
					id="initialDeposite" placeholder="ENTER INITIAL DEPOSITE" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>MINIMUM OPENING BALANCE</label> <input type="text"
					id="monthlyMinimumBalance"
					placeholder="ENTER MINIMUM OPENING BALANCE" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>RESERVED FUNDS</label> <input type="text" id="reservedFunds"
					placeholder="ENTER RESERVED FUNDS" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>MESSAGING FEES</label> <select id="messagingFees"
					class="form-control">
					<option value="">SELECT</option>
					<option value="YES">Yes</option>
					<option value="NO">No</option>
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>MESSAGING INTERVAL</label> <select id="messagingInterval"
					class="form-control">
					<option value="">SELECT</option>
					<option value="Monthly">MONTHLY</option>
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>MONTHLY FREE IFSC</label> <input type="text"
					id="monthlyFreeIFSCTransactions"
					placeholder="ENTER MONTHLY FREE IFSC" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>FREE MONEY TRANSFERS</label> <input type="text"
					id="freeMoneyTransfers" placeholder="ENTER FREE MONEY TRANSFERS" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>LIMIT PER TRANSACTION</label> <input type="text"
					id="limitperTransaction" placeholder="ENTER LIMIT PER TRANSACTION" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>DAILY LIMIT</label> <input type="text" id="dailyLimit"
					placeholder="ENTER DAILY LIMIT" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>WEEKLY LIMIT</label> <input type="text" id="weeklyLimit"
					placeholder="ENTER WEEKLY LIMIT" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>MONTHLY LIMIT</label> <input type="text" id="monthlyLimit"
					placeholder="ENTER MONTHLY LIMIT" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>SERVICE FEE</label> <input type="text" id="serviceFee"
					placeholder="ENTER SERVICE FEE" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>BILLING CYCLE</label> <select id="billingCycle"
					class="form-control">
					<option value="">SELECT</option>
					<option value="Daily">DAILY</option>
					<option value="Weekly">WEEKLY</option>
					<option value="Monthly">MONTHLY</option>
					<option value="Yearly">YEARLY</option>
				</select>
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>CARD FEE</label> <input type="text" id="cardFee"
					placeholder="ENTER CARD FEE" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>MONTHLY CARD LIMIT</label> <input type="text"
					id="monthlyCardLimit" placeholder="MONTHLY CARD LIMIT" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label>YEARLY CARD LIMIT</label> <input type="text"
					id="yearlyCardLimit" placeholder="YEARLY CARD LIMIT" />
			</div>
		</div>

	</div>

	<div class="row mt-4">
		<div class="col-12 text-center">
			<button type="button" id="saveBtn" class="btn btn-warning">SAVE</button>
			<button type="button" id="updateBtn" class="btn btn-success ml-3">UPDATE</button>
		</div>
	</div>

</form>

<!-- ************** FORM END ************** -->


<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">
			<div class="card-body table-responsive">
				<h5 class="card-title">
					SAVING SCHEME CATALOG DATA <span>| TABLE VIEW</span>
				</h5>

				<table class="table table-borderless datatable">
					<thead class="table-light">
						<tr>
							<th>SR</th>
							<th>PLAN</th>
							<th>CUSTOMER</th>
							<th>INITIAL</th>
							<th>OPENING</th>
							<th>DAILY</th>
							<th>MONTHLY CARD</th>
							<th>YEARLY CARD</th>
							<th>EDIT</th>
							<th>DELETE</th>
						</tr>
					</thead>
					<tbody id="tbody"></tbody>
				</table>

			</div>
		</div>
	</div>
</div>
<script
	src="${pageContext.request.contextPath}/js/customerSavings/SavingScemeCatalog.js"></script>