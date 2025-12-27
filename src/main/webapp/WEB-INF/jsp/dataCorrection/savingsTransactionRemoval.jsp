
<div class="pagetitle">
	<h1>Data Correction</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-pencil-square"></i>
			</a></li>
			<li class="breadcrumb-item action">Savings Transaction Removal</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Account Details</li>
				</ol>
			</nav>

			<div class="row">
				<input type="hidden" name="id" id="id">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Select Account No.</label> <select id="accountNumber"
							name="accountNumber" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-- Search Account No --</option>
						</select>
					</div>
				</div>

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
						<label for="">Transaction Date</label> <input type="date"
							name="transactionDate" id="transactionDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Transaction ID</label> <input type="text"
							name="selectSavingTransactionId" id="selectSavingTransactionId"
							required="required" placeholder="Enter Transaction ID"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="branchName">Branch Name</label> <select
							id="branchName" name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
						</select>
					</div>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Customer Code</label> <input type="text"
							name="customerCode" id="customerCode" required="required"
							placeholder="Enter Customer Code"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Name</label> <input type="text" name="customerName"
							id="customerName" required="required"
							placeholder="Enter A/C Holder Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Contact No</label> <input type="text"
							name="contactNumber" id="contactNumber" required="required"
							placeholder="Enter Contact No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Co-Holder</label> <input type="text" name="jointHolderName"
							id="jointHolderName" required="required"
							placeholder="Joint Co-Holder Name"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label for="">SB policy Type</label> <input type="text"
							name="savingPlanName" id="savingPlanName" required="required"
							placeholder="Enter Policy Type" />
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
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Available Balance</label> <input type="text"
							name="averageBalance" id="averageBalance" required="required"
							placeholder="Enter Available Balance"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Payment Reason</label> <input type="text"
							name="transactionFor" id="transactionFor" required="required"
							placeholder="Enter Payment Reason"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Comments</label> <input type="text" name="comments"
							id="comments" required="required" placeholder="Enter Comments"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Transaction Type </label><select
							id="transactionType" name="transactionType" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>
							<option value="Deposit">Deposit</option>
							<option value="Withdraw">Withdraw</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Amount</label> <input type="text"
							name="transactionAmount" id="transactionAmount"
							required="required" placeholder="Enter Amount" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Mode Of Payment </label> <select id="payBy"
							name="payBy" required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">Select Payment By</option>
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
					<button type="button" id="deleteBtn" class="btnStyle bg-danger"
						style="background-color: #FFA500;">Delete</button>
				</div>
			</div>

		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/dataCorrection/savingTransactionRemoval.js"></script>

