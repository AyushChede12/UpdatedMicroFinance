
<div class="pagetitle">
	<h1>Data Correction</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-pencil-square"></i>
			</a></li>
			<li class="breadcrumb-item action">Shareholding Adjustment</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">

		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Share Details</li>
				</ol>
			</nav>
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
					<input type="hidden" name="id" id="id">
					<div class="d-flex flex-column formFields">
						<label for="">Find By Code</label> <select id="findByCode"
							name="findByCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-- Search Customer Code --</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="customerName">Customer Name</label> <input type="text"
							name="customerName" id="customerName" required="required"
							placeholder="Enter Customer Name"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Start Date</label> <input type="date" name="startDate"
							id="startDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="previousAccountBalance">Previous Account
							Balance</label> <input type="text" name="previousAccountBalance"
							id="previousAccountBalance" required="required"
							placeholder="Enter Previous Balance"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Previous Share Count</label> <input type="text"
							name="previousShareCount" id="previousShareCount"
							required="required" placeholder="Enter Previous No Of Share"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Base Value</label> <input type="text"
							name="baseValue" id="baseValue" required="required"
							placeholder="Enter Face Value" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Branch</label> <select id="branchName" name="branchName"
							required="required" class="form-control selectField"
							style="height: 30px;">
						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label for="">Date of Transfer</label> <input type="date"
							name="dateOfTransfer" id="dateOfTransfer" required="required"
							placeholder="Enter Age" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Shares Issued By</label> <select id="shareIssuedBy"
							name="shareIssuedBy" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Shares Issued By</option>
							<option value="Tata Motors Ltd.">Tata Motors Ltd.</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Share Count</label> <input type="text"
							name="noOfShare" id="noOfShare" required="required"
							placeholder="Enter Share Count" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Transfer Amount</label> <input type="text"
							name="amountTransferred" id="amountTransferred"
							required="required" placeholder="Enter Transfer Amount" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Balance Shares</label> <input type="text"
							name="balanceShares" id="balanceShares" required="required"
							placeholder="Enter Balance Shares" />
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
						<label>Mode of payment</label> <select id="modeOfPayment"
							name="modeOfPayment" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Mode of payment</option>
							<option value="Cash">Cash</option>
							<option value="Online">Online</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Comments</label>
						<textarea name="comments" id="comments"
							placeholder="Enter Comments if any"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

			</div>

		</div>
		<div class="row">
			<div class="col-12 text-center" style="margin-top: 30px;">
				<button type="button" id="printBtn" class="btn btn-warning">Print</button>
				<button type="button" id="updateBtn" class="btn btn-success">Update</button>
				<button type="button" id="deleteBtn" class="btn btn-danger">Delete</button>
			</div>
		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/dataCorrection/shareHoldingUpdate.js"></script>
