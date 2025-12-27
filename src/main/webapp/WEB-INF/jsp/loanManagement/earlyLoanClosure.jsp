
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Early Loan Closure</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div class="">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Find By Loan Id</label> <select
							id="earlyLoanclosureId" name="earlyLoanclosureId"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Loan Id</option>

						</select>
					</div>
				</div>



			</div>


		</div>
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Loan Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Date of Loan</label> <input type="date"
							name="dateofLoan" id="dateofLoan" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Id & Name</label> <input type="text"
							name="memberId" id="memberId" required="required"
							placeholder="Enter Id & Name" style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Family Member Name</label> <input
							type="text" name="relativeDetails" id="relativeDetails"
							required="required" placeholder="Enter Family Member Name
"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Contact No.</label> <input type="text"
							name="contactNo" id="contactNo" required="required"
							placeholder="Enter Contact No."
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Branch Address</label> <input type="text"
							name="branchName" id="branchName" required="required"
							placeholder="Enter Branch Address"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Plan Name </label> <input type="text"
							name="loanPlanName" id="loanPlanName" required="required"
							placeholder="Enter Plan Name" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Term</label> <input type="text" name="loanTerm"
							id="loanTerm" required="required" placeholder="Enter Duration" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Mode</label> <input type="text" name="loanMode"
							id="loanMode" required="required"
							placeholder="Enter Loan Category" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Amount Of Loan</label> <input type="text"
							name="loanAmount" id="loanAmount" required="required"
							placeholder="Enter Amount Of Loan" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Rate of Interest(%) </label> <input
							type="text" name="rateOfInterest" id="rateOfInterest"
							required="required" placeholder="Enter Loan ROI Of Loan"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Interest Type</label> <input type="text"
							name="interestType" id="interestType" required="required"
							placeholder="Enter Interest Type"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">EMI Payment</label> <input type="text"
							name="emiPayment" id="emiPayment" required="required"
							placeholder="Enter EMI Amount" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Total Interest Of Loan</label> <input
							type="text" name="totalinterestofLoan" id="totalinterestofLoan"
							required="required" placeholder="Enter Total Interest Of Loan"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<input type="hidden" id="memberName" name="memberName">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Sanctioned Amount</label> <input type="text"
							name="sanctionedAmount" id="sanctionedAmount" required="required"
							placeholder="Enter Total Principal Of Loan"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Total Payable Of Loan</label> <input type="text"
							name="totalPayableofLoan" id="totalPayableofLoan"
							required="required" placeholder="Enter Total Payable Of Loan"
							style="text-transform: uppercase;" />
					</div>
				</div>


			</div>

		</div>
	</form>
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
				<label for="">No of Inst Paid</label><input type="text"
					name="noOfInst" id="noOfInst" required="required"
					placeholder="Enter Interset Due" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Interset Due</label> <input type="text"
					name="interestDue" id="interestDue" required="required"
					placeholder="Enter Interset Due" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Principal Due</label> <input type="text"
					name="principaldue" id="principaldue" required="required"
					placeholder="Enter Total Principal Due" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Amount Paid Till Date</label> <input type="text"
					name="amountPaid" id="amountPaid" required="required"
					placeholder="Enter Total Due Amount" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Loan Balance Amount</label> <input type="text"
					name="balanceLoanAmount" id="balanceLoanAmount" required="required"
					placeholder="Enter Total Due Amount" />
			</div>
		</div>


		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Due Date</label> <input type="date" name="dueDate"
					id="dueDate" required="required" placeholder="" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Payment Branch</label> <input type="text"
					name="paymentBranch" id="paymentBranch" required="required"
					placeholder="" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Payment Date</label> <input type="date"
					name="paymentDate" id="paymentDate" placeholder="" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Deduct Fine</label> <select id="deductfine"
					name="deductfine" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">No</option>
					<option value="Blue">Yes</option>
				</select>
			</div>
		</div>
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Deduct Fien Amount</label> <input type="text"
					name="deeductfienamount" id="deeductfienamount" required="required"
					Value="0" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Payment Amount</label> <input type="text"
					name="paymentamount" id="paymentamount" required="required"
					placeholder="Enter Payable Amount" />
			</div>
		</div>
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Net Amount</label> <input type="text" name="netamount"
					id="netamount" required="required"
					placeholder="Enter Total Payable Amount" />
			</div>
		</div>

		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="referenceCode">Mode of Payment <span id="star">*</span></label>
				<select id="paymentMode" name="paymentMode" required="required"
					class="form-control selectField" style="height: 30px;">
					<option value="">Enter Mode of Payment</option>
					<option value="Cash">CASH</option>
					<option value="Online">Online</option>
					<option value="Cheque">Cheque</option>
					<option value="NEFT">NEFT</option>


				</select>
			</div>
		</div>


		<div class="col-lg-3" id="displayCheque">
			<div class="d-flex flex-column formFields"
				style="margin-bottom: 30px">
				<label>Cheque Number <span id="star">*</span></label> <input
					type="text" name="chequeNo" id="chequeNo" required="required"
					placeholder="Enter Cheque No" style="text-transform: uppercase;" />
			</div>
		</div>

		<div class="col-lg-3" id="displaycheqdate">
			<div class="d-flex flex-column formFields"
				style="margin-bottom: 30px">
				<label>Cheque Date <span id="star">*</span></label> <input
					type="date" name="chequeDate" id="chequeDate" required="required"
					placeholder="Enter Cheque Date" style="text-transform: uppercase;" />
			</div>
		</div>


		<div class="col-lg-3" id="displaydeposit">
			<div class="d-flex flex-column formFields"
				style="margin-bottom: 30px">
				<label>Deposit Account <span id="star">*</span></label> <input
					type="text" name="depositAccount" id="depositAccount"
					required="required" placeholder="Enter Deposit Account"
					style="text-transform: uppercase;" />
			</div>
		</div>


		<div class="col-lg-3" id="displayRef">
			<div class="d-flex flex-column formFields">
				<label for="">Ref Number/UPI ID</label> <input type="text"
					name="refNo" id="refNo" required="required"
					placeholder="Enter Deposit Account"
					style="text-transform: uppercase;" />
			</div>
		</div>


		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4"
				style="margin-bottom: 30px">
				<label> Financial Consultant Id</label>
				<div class="d-flex flex-column formFields mb-4">
					<input type="text" name="financialConsultantId"
						id="financialConsultantId" required="required"
						placeholder="Enter Member ID" />
				</div>
			</div>
		</div>
		<div class="col-lg-3">
			<div class="d-flex flex-column formFields mb-4">
				<label for="">Financial Consultant Name</label> <input type="text"
					name="financialConsultantName" id="financialConsultantName"
					required="required" placeholder="Enter Advisor/Collector Name"
					style="text-transform: uppercase;" />
			</div>
		</div>


		<div class="col-lg-3">
			<div class="d-flex flex-column formFields">
				<label for="">Remarks Section</label>
				<textarea name="remark" id="remark"
					style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"
					placeholder="Enter Remarks if any"></textarea>
			</div>
		</div>

		<div class="col-12 text-center">
			<button id="closeLoanBtn" class="btnStyle"
				style="background-color: #FFA500;">Close Loan</button>

		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/LoanManagment/EarlyLoanClosure.js"></script>
