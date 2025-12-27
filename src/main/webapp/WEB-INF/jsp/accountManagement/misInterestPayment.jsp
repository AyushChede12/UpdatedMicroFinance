
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">MIS Interest Payment</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div class="row">
			<div class="col-lg-12">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action mt-3">MIS Policy Details</li>
					</ol>
				</nav>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Policy ID</label> <input type="text" name="policyID"
						id="policyID" required="required" placeholder="Enter Policy No." />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Policy Holder</label> <input type="text"
						name="policyHolder" id="policyHolder" required="required"
						placeholder="Enter Applicant Name" disabled />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for=""> Issue Date</label> <input type="date"
						name="issueDate" id="issueDate" required="required" placeholder="" />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Insured Amount</label> <input type="text"
						name="insuredAmount" id="insuredAmount" required="required"
						placeholder="Enter Insured amt" disabled />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Accrued Interest</label> <input type="text"
						name="accruedInterest" id="accruedInterest" required="required"
						placeholder="Enter Accrued Amount" disabled />
				</div>
			</div>


			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Scheme Title</label> <input type="schemeTitle"
						name="schemeTitle" id="age" required="required"
						placeholder="Enter Scheme Title" disabled />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Branch Name </label> <input type="text"
						name="branchName" id="branchName" required="required"
						placeholder="Enter policy branch" disabled />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Client Code </label> <input type="text"
						name="clientCode" id="clientCode" required="required"
						placeholder="Enter Client Code" disabled />
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-lg-12">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action mt-3">MIS Payment Details</li>
					</ol>
				</nav>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Pay Amount</label> <input type="text"
						name="payAmount" id="age" required="required"
						placeholder="Enter Pay Amount" disabled />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">Paying Branch</label> <select id="payingBranch"
						name="payingBranch" required="required"
						class="form-control selectField" style="height: 30px;">
						<option value="">Select Pay Branch</option>
						<option value="Blue">Blue</option>
					</select>
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Date of Payment</label> <input type="date"
						name="dateOfPayment" id="dateOfPayment" required="required"
						placeholder="Enter Pay Date" />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="">Payment Mode </label> <select id="paymentMode"
						name="paymentMode" required="required"
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
	</form>

</div>
<script
	src="${pageContext.request.contextPath}/js/account-management/misInterestPayment.js"></script>