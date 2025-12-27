

<div class="pagetitle">
	<h1>SAVING / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">SAVINGS ACCOUNT FUND TRANSFER</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Debit Account Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Select Account Number</label> <select
							id="debitAccountNumber" name="debitAccountNumber"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Code</label> <input type="text"
							name="debitCustomerCode" id="debitCustomerCode"
							required="required" placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Account Branch</label> <input type="text"
							name="debitAccountBranch" id="debitAccountBranch"
							required="required" placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Average Balance</label> <input type="text"
							name="debitAverageBalance" id="debitAverageBalance"
							required="required" placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Contact Number</label> <input type="text"
							name="debitContactNumber" id="debitContactNumber"
							required="required" placeholder="" />
					</div>
				</div>
			</div>

		</div>


		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Credit Account Details</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Select Account Number</label> <select
							id="creditAccountNumber" name="creditAccountNumber"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Code</label> <input type="text"
							name="creditCustomerCode" id="creditCustomerCode"
							required="required" placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Account Branch</label> <input type="text"
							name="creditAccountBranch" id="creditAccountBranch"
							required="required" placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Average Balance</label> <input type="text"
							name="creditAverageBalance" id="creditAverageBalance"
							required="required" placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Contact Number</label> <input type="text"
							name="creditContactNumber" id="creditContactNumber"
							required="required" placeholder="" />
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
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Transfer Date</label> <input type="date"
							name="transferDate" id="transferDate" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Amount</label> <input type="text" name="amount"
							id="amount" required="required" placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Comments</label>
						<textarea name="comment" id="comment"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
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
<script
		src="${pageContext.request.contextPath}/js/customerSavings/SavingAccountFundTransfer.js"></script>