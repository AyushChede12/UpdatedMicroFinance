
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Regular Installment Payment</li>
		</ol>
	</nav>
</div>

<div class="row">
	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="">Select Loan Id </label> <select id="loanID"
				name="loanID" required="required" class="form-control selectField"
				style="height: 30px;">
				<option value="">Select Loan Id</option>

			</select>
		</div>
	</div>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">Date of Loan</label> <input type="date"
							name="date" id="date" required="required"
							placeholder="Enter Date of Loan"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Code</label> <input type="text"
							name="customercode" id="customercode" required="required"
							placeholder="Enter ID & Full Name" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Plan Name </label> <input type="text"
							name="loanplanname" id="loanplanname" required="required"
							placeholder="Enter Plan Name" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Interest Type </label> <input type=""
							name="intesteType" id="intesteType" required="required"
							placeholder="Enter Interest Type " />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Mode</label> <input type="text" name="loanmode"
							id="loanmode" required="required"
							placeholder="Enter Loan Category" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Term</label> <input type="text" name="term"
							id="term" required="required" placeholder="Enter term" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">EMI Payment</label> <input type="text"
							name="paymnetEmi" id="paymnetEmi" required="required"
							placeholder="Enter EMI Payment" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Family Member Name</label> <input type="text"
							name="familyMembername" id="familyMembername" required="required"
							placeholder="Enter Family Member Name" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Rate of Interest(%)</label> <input type="text"
							name="rateofinterest" id="rateofinterest" required="required"
							placeholder="Enter rate of interest" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Contact No.</label> <input type="text"
							name="contact" id="contact" required="required"
							placeholder="Enter Contact No." />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Amount Of Loan</label> <input type="text"
							name="amountLoan" id="amountLoan" required="required"
							placeholder="Enter Amount Of Loan." />
					</div>
				</div>

				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Total Principle Of Loan</label> <input type="text"
									name="totalPrincipalloan" id="totalPrincipalloan"
									required="required" placeholder="Enter Total Principle Of Loan" />
							</div>
						</div> -->

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Branch Address</label> <input type="text"
							name="BranchAddress" id="BranchAddress" required="required"
							placeholder="Enter Branch Address" />
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

					<div class="d-flex flex-column formFields mb-4">
						<label for=""> Installment</label> <select id="installment"
							name="installment" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-select installment-</option>

						</select>
					</div>
				</div>

				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Interest Due </label> <input type="text"
									name="dueInterest" id="dueInterest" required="required"
									placeholder="Enter Location" />
							</div>
						</div> -->


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">Registration Date</label> <input
							type="date" name="registrationDate" id="registrationDate"
							required="required" placeholder="Enter Vehicle No"
							style="text-transform: uppercase;" />
					</div>
				</div>



				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for=""> Principle Due </label> <input type="text"
									name="duePrincipal" id="duePrincipal" required="required"
									placeholder="Enter Location" />
							</div>
						</div> -->


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Total Amount Due </label> <input type="text"
							name="dueAmounttotal" id="dueAmounttotal" required="required"
							placeholder="Enter Location" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Payment Amount</label> <input type="text"
							name="paymentAmount" id="paymentAmount" required="required"
							placeholder="Enter Relative Name" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">Payment Date</label> <input type="date"
							name="PaymentDate" id="PaymentDate" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Net Amount</label> <input type="text"
							name="netAmount" id="netAmount" required="required"
							placeholder="Enter DOB" />
					</div>
				</div>



				<div class="col-lg-3">

					<div class="d-flex flex-column formFields mb-4">
						<label for=""> Payment Source</label> <select id="sourcePayment"
							name="sourcePayment" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Type</option>
							<option value="Blue">Blue</option>
						</select>
					</div>
				</div>


				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Down Payment</label>
								<textarea name="downPayment" id="downPayment"
									style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
							</div>
						</div> -->

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Financial Consultant ID</label> <input type="text"
							name="financialConsultantId" id="financialConsultantId"
							required="required" placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Financial Consultant Name</label> <input type="text"
							name="financialConsultantName" id="financialConsultantName"
							required="required" placeholder="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Remarks Section</label> <input type="text"
							name="sectionRemARK" id="sectionRemARK" required="required"
							placeholder="Enter Remarks Section" />
					</div>
				</div>
			</div>
		</div>

		<!-- <div class="row mt-4">
					<div class="col-12 text-center">
						<button id="saveBtn" class="btnStyle bg-success">Save</button>
						<button id="saveBtn" class="btnStyle"
							style="background-color: #FFA500;">Update</button>
						<button id="saveBtn" class="btnStyle bg-primary">Print</button>
					</div>
				</div> -->
	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/LoanManagment/RegularInsatllmentPayment.js"></script>
