
<div class="pagetitle">
	<h1>SAVING / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">SAVING ACCOUNT ACTIVITY</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">ACCOUNT DETAILS</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">SAVING TRANSACTION ID</label> <input type="text"
							name="selectSavingTransactionId" id="selectSavingTransactionId"
							required="required" value="${transactionCode}" placeholder=" " />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">TRANSACTION DATE</label> <input type="date"
							name="transactionDate" id="transactionDate" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">ACCOUNT NUMBER</label> <input type="text"
							name="accountNumber" id="accountNumber" required="required"
							placeholder="ENTER ACCOUNT NUMBER" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">SELECT BRANCH NAME</label> <input type="text"
							name="selectBranchName" id="selectBranchName" required="required"
							placeholder="ENTER BRANCH NAME" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">CUSTOMER CODE</label> <input type="text"
							name="customerCode" id="customerCode" required="required"
							placeholder=" ENTER MEMBER CODE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">CUSTOMER NAME</label> <input type="text"
							name="customerName" id="customerName" required="required"
							placeholder="ENTER CUSTOMER NAME" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">CONTACT NUMBER</label> <input type="text"
							name="contactNumber" id="contactNumber" required="required"
							placeholder="ENTER CONTACT NUMBER" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">JOINT HOLDEE NAME</label> <input type="text"
							name="jointHolderName" id="jointHolderName" required="required"
							placeholder="ENTER JOINT HOLDEE NAME" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">SAVING PLAN NAME</label> <input type="text"
							name="savingPlanName" id="savingPlanName" required="required"
							placeholder="ENTER SAVING PLAN NAME" />
					</div>
				</div>

			</div>
		</div>


		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">PAYMET DETAILS</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">AVERAGE BALANCE</label> <input type="text"
							name="averageBalance" id="averageBalance" required="required"
							placeholder="ENTER AVERAGE BALANCE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">TRANSACTION FOR</label> <input type="text"
							name="transactionFor" id="transactionFor" required="required"
							placeholder="ENTER AVERAGE BALANCE" />
					</div>
				</div>



				<div class="col-lg-3">

					<div class="d-flex flex-column formFields mb-4">
						<label for="">TRANSACTION TYPE</label> <select
							id="transactionType" name="transactionType" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-SELECT-</option>
							<option value="Deposit">DEPOSIT</option>
							<option value="Withdraw">WITHDRAW</option>

						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">COMMENTS</label> <input type="text" name="comments"
							id="comments" required="required" placeholder="ENTER COMMENTS" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">TRANSACTION AMOUNT</label> <input type="text"
							name="transactionAmount" id="transactionAmount"
							required="required" placeholder="ENTER TRANSACTION AMOUNT" />
					</div>
				</div>

				<div class="col-lg-3">

					<div class="d-flex flex-column formFields mb-4">
						<label for="">PAY BY</label> <select id="payBy" name="payBy"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option selected="selected" value="">SELECT</option>
							<option value="Cash">CASH</option>
							<option value="Cheque">CHEQUE</option>
							<option value="Online">ONLINE</option>
							<option value="NEFT">NEFT</option>
						</select>
					</div>
				</div>
			</div>
			<!-- Cheque input fields -->
			<div id="chequeInputs" style="display: none;">
				<div class="row">
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">CHEQUE NO. </label> <input type="text"
								name="chequeNo" id="chequeNo" required="required"
								placeholder="Enter Cheque No." />
						</div>
					</div>
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">CHEQUE DATE </label> <input type="Date"
								name="chequeDate" id="chequeDate" required="required"
								placeholder="Enter Cheque Date" />
						</div>
					</div>
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">DEPOSIT A/C </label> <input type="text"
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
							<label for="">DEPOSIT A/C </label> <input type="text"
								name="depositAcc2" id="depositAcc2" required="required"
								placeholder="Enter Deposite A/C No." />
						</div>
					</div>
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
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">REF NUMBER </label> <input type="text"
								name="refNumber2" id="refNumber2" required="required"
								placeholder="Enter Deposite Ref No." />
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-12 text-center">
				<button id="saveBtn" class="btn btn-warning"
					style="margin-left: 80%;">Save</button>
			</div>
		</div>
	</form>

</div>
<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">
					SAVING ACCOUNT DATA <span>| TABLE VIEW</span>
				</h5>

				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">SR NO</th>
							<th scope="col">BRANCH NAME</th>
							<th scope="col">OPENING DATE</th>
							<th scope="col">ACCOUNT NUMBER</th>
							<th scope="col">TRANSACTION TYPE</th>
							<th scope="col">CREDIT/DEBIT</th>
							<th scope="col">BALANCE</th>
							<th scope="col">PAY MODE</th>
							<th scope="col">REMARKS</th>
							<th scope="col">TXN ID</th>
							<th scope="col">USER ID</th>
						</tr>
					</thead>
					<tbody id="tbody">

					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script src="./js/customerSavings/SavingAccountActivity.js"></script>
<script>
	document.getElementById('payBy').addEventListener('change', function() {
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
	src="${pageContext.request.contextPath}/js/customerSavings/SavingAccountActivity.js"></script>
