
<div class="pagetitle">
	<h1>Data Correction</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-pencil-square"></i>
			</a></li>
			<li class="breadcrumb-item action">Renewal Data Correction</li>
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
				<input type="hidden" name="id" id="id">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 20px;">
						<label for="policyCode">Policy Code</label> <select
							id="policyCode" name="policyCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-- Search Policy Code --</option>

						</select>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="renewalDate">Update Date </label> <input type="date"
							name="renewalDate" id="renewalDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>


			</div>
			<hr>
			<div class="row">
				<div class="col-lg-3">
					<!-- <div class="d-flex flex-column formFields" style="margin-bottom: 30px">
                <label>Verify With</label>
                <div class="position-relative">
                  <div class="select-btn1" style="cursor: pointer;">
                    <span name="cityName" id="cityNameId" style="font-size: 12px;">Select</span> <i
                      class="fa-solid fa-angle-down"></i>
                  </div>
                  <div class="content" id="contentCityName" style="display: none;">
                    <div class="search">
                      <input type="text" id="city-search" class="m-0" placeholder="Search City" />
                    </div>
                    <ul class="options" id="city-options">
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                    </ul>
                  </div>
                </div>
              </div> -->
					<div class="d-flex flex-column formFields">
						<label for="policyDate">Policy Date</label> <input type="date"
							name="policyDate" id="policyDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="maturityDate">Payoff Date </label> <input type="date"
							name="maturityDate" id="maturityDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Customer Code</label> <input type="text"
							name="customerCode" id="customerCode" required="required"
							placeholder="Enter Customer Code"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="clientName">Customer Name </label> <input type="text"
							name="clientName" id="clientName" required="required"
							placeholder="Enter Customer Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Branch Name</label> <input type="text" name="branchname"
							id="branchname" placeholder="Enter Branch Name"
							required="required" style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Contact No</label> <input type="text" name="contactNo"
							id="contactNo" placeholder="Enter Contact No" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="policyAmount">Policy Amount</label> <input type="text"
							name="policyAmount" id="policyAmount" required="required"
							placeholder="Enter Policy Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label> Policy Type </label> <input type="text" name="policyType"
							id="policyType" required="required"
							placeholder="Enter Policy Type               "
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label for="policyTerm">Policy Term</label> <input type="text"
							name="policyTerm" id="policyTerm" required="required"
							placeholder="Enter Policy Term"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="maturityAmount">Maturity Amount</label> <input
							type="text" name="maturityAmount" id="maturityAmount"
							required="required" placeholder="Enter Maturity Amount"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label> Total Deposits </label> <input type="text"
							name="totalDeposit" id="totalDeposit" required="required"
							placeholder="Enter Total Deposited" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="paymentDue"> Payment Due </label> <input type="text"
							name="paymentDue" id="paymentDue" required="required"
							placeholder="Enter Amount Due" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="lastPaymentDate">Last Payment Date </label> <input
							type="text" name="lastPaymentDate" id="lastPaymentDate"
							required="required" placeholder="Enter Last Inst. Paid" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="dueDate">Deadline</label> <input type="date"
							name="dueDate" id="dueDate" required="required"
							placeholder="Enter Mem Code" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="noOfInst">No Of Installments </label> <input
							type="text" name="noOfInst" id="noOfInst" required="required"
							placeholder="Enter Installments Completed   " />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label for="noOfInstPaid">Installments Completed </label> <input
							type="text" name="noOfInstPaid" id="noOfInstPaid"
							required="required" placeholder="Enter Installments Completed   " />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="modeOfPayment">Mode Of Payment </label> <select
							id="modeOfPayment" name="modeOfPayment" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Paymode</option>
							<option value="Cash">Cash</option>
							<option value="Online">Online</option>


						</select>
					</div>
				</div>

			</div>

		</div>


		<div class="mt-5">


			<div class="row">
				<div class="col-12 text-center" style="margin-top: 30px;">
					<button type="button" id="printBtn" class="btnStyle bg-primary">View
						Installment</button>
					<button type="button" id="deleteBtn" class="btnStyle bg-danger"
						style="background-color: #FFA500;">Delete Last Entry</button>
				</div>
			</div>

		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/dataCorrection/renewalDataCorrection.js"></script>
