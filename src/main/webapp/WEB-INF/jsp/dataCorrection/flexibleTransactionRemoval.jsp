
<div class="pagetitle">
	<h1>Data Correction</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-piggy-bank"></i>
			</a></li>
			<li class="breadcrumb-item action">Flexible Transaction Removal</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Box</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<input type="hidden" name="id" id="id">
					<div class="d-flex flex-column formFields">
						<label for="Agent">Policy Code*</label> <select id="policyCode"
							name="policyCode" required class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Policy Code</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Renewal Date</label> <input type="date" name="renewalDate"
							id="renewalDate" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>


			</div>


			<div class="mt-5">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">Policy Information</li>
					</ol>
				</nav>
				<div class="row">
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Policy Date*</label> <input type="date" name="policyDate"
								id="policyDate" required="required"
								placeholder="Enter Vehicle No"
								style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Maturity Date*</label> <input type="date"
								name="maturityDate" id="maturityDate" required="required"
								placeholder="Enter Vehicle No"
								style="text-transform: uppercase;" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Customer Code* </label> <input type="text"
								name="customerCode" id="customerCode" required="required"
								placeholder="Enter Advisor/Collector Code" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Client Name </label> <input type="text"
								name="clientName" id="clientName" required="required"
								placeholder="Enter Relative Name" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Branch Name </label> <input type="text"
								name="branchname" id="branchname" required="required"
								placeholder="Enter Relative Name" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Contact No*</label> <input type="text"
								name="contactNo" id="contactNo" required="required"
								placeholder="Enter Mobile No." />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Policy Amount*</label> <input type="text"
								name="policyAmount" id="policyAmount" required="required"
								placeholder="Enter Nominee Name" />
						</div>
					</div>




					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Policy Type </label> <input type="text" name="policyType"
								id="policyType" required="required"
								placeholder="Enter Nominee Name" />
						</div>
					</div>


					<!-- in this two text fieldds are required -->
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Policy Trem </label> <input type="text"
								name="policyTerm" id="policyTerm" required="required"
								placeholder="Enter Education" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Maturity Amt.*</label> <input type="text"
								name="maturityAmount" id="maturityAmount" required="required"
								placeholder="Enter Education" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Total Deposits*</label> <input type="text"
								name="totalDeposit" id="totalDeposit" required="required"
								placeholder="Enter Education" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Payment Due*</label> <input type="text"
								name="paymentDue" id="paymentDue" required="required"
								placeholder="Enter Education" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">Last Payment Date *</label> <input type="text"
								name="lastPaymentDate" id="lastPaymentDate" required="required"
								placeholder="Enter Education" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">Due Date*</label> <input type="date" name="dueDate"
								id="dueDate" required="required" placeholder="Enter Vehicle No"
								style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">No Of Installment*</label> <input type="text"
								name="noOfInst" id="noOfInst" required="required"
								placeholder="Enter Education" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">Installments Completed*</label> <input type="text"
								name="noOfInstPaid" id="noOfInstPaid" required="required"
								placeholder="Enter Education" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">Mode Of Payment*</label> <input type="text"
								name="modeOfPayment" id="modeOfPayment" required="required"
								placeholder="Enter Education" />
						</div>
					</div>




				</div>
			</div>





		</div>

		<div class="mt-5">
			<div class="row">
				<div class="col-12 text-center" style="margin-top: 30px;">
					<button type="button" id="deleteBtn" class="btnStyle bg-danger"
						style="background-color: #FFA500;">Delete Last Entry</button>
				</div>
			</div>

		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/dataCorrection/flexibleTransactionRemoval.js"></script>
