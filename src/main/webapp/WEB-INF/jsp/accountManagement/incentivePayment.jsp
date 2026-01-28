
<div class="pagetitle">
	<h1>ACCOUNT MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">INCENTIVE PAYMENT</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">SEARCH BOX</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">INCENTIVE MONTH</label> <select id="incentiveMonth"
							name="incentiveMonth" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT MONTH NAME</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">AGENT CODE</label> <input type="text"
							name="agentCode" id="agentCode" required="required"
							placeholder="ENTER CODE" />
					</div>
				</div>

				<div class="col-3 text-left mt-3">
					<button id="searchBtn" class="btnStyle"
						style="background-color: #FFA500;">SEARCH</button>
				</div>
			</div>
		</div>
	</form>
</div>

<div class="row">
	<div class="col-lg-12">
		<nav>
			<ol class="breadcrumb breadcrumb-title">
				<li class="breadcrumb-item action mt-3">INCENTIVE DETAILS</li>
			</ol>
		</nav>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">FULL NAME</label> <input type="text" name="fullName"
				id="fullName" required="required" placeholder="Enter Name" />
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">DESIGNATION</label> <input type="text"
				name="designation" id="designation" required="required"
				placeholder="ENTER DESIGNATION" />
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">PERSONAL SALES</label> <input type="text"
				name="personalSales" id="personalSales" required="required"
				placeholder="Enter Self Business" />
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for=""> GROUP Sales</label> <input type="text"
				name="groupSales" id="groupSales" required="required"
				placeholder="Enter Team Business" />
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">Overall Sales</label> <input type="text"
				name="overallSales" id="overallSales" required="required"
				placeholder="Enter Total Business" />
		</div>
	</div>


	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">Total Earnings</label> <input type="text"
				name="totalEarnings" id="totalEarnings" required="required"
				placeholder="Enter Total Incentive" />
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">Tax Deducted</label> <input type="text"
				name="taxDeducted" id="taxDeducted" required="required"
				placeholder="Enter TDS" />
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">Service Deduction</label> <input type="text"
				name="serviceDeduction" id="serviceDeduction" required="required"
				placeholder="Enter Service Charge" />
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">Extra Allowance</label> <input type="text"
				name="extraAllowance" id="extraAllowance" required="required"
				placeholder="Enter Allowance" />
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">Final Payout</label> <input type="FinalPayout"
				name="finalPayout" id="finalPayout" required="required"
				placeholder="Enter Net Payable" />
		</div>
	</div>
</div>
<div class="row">
	<div class="col-lg-12">
		<nav>
			<ol class="breadcrumb breadcrumb-title">
				<li class="breadcrumb-item action mt-3">Payment Details</li>
			</ol>
		</nav>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields">
			<label for=""> Branch of Payment</label> <select id="branchOfPayment"
				name="branchOfPayment" required="required"
				class="form-control selectField" style="height: 30px;">
				<option value="">Select Pay Branch</option>
				<option value="Blue">Blue</option>
			</select>
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for=""> Date of Payment</label> <input type="date"
				name="dateOfPayment" id="dateOfPayment" required="required" />
		</div>
	</div>

	<div class="col-lg-3">
		<div class="d-flex flex-column formFields">
			<label for="">Mode of Payment</label> <select id="modeOfPayment"
				name="modeOfPayment" required="required"
				class="form-control selectField" style="height: 30px;">
				<option value="">Select</option>
				<option value="Blue">Cash</option>
				<option value="Blue">Online</option>
				<option value="Blue">Cheque</option>
				<option value="Blue">Neft</option>
			</select>
		</div>
	</div>

</div>
<div class="row">
	<div class="col-12 text-right mt-3">
		<button id="payBtn" class="btnStyle"
			style="background-color: #FFA500;">Pay</button>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/account-management/incentivePayment.js"></script>

