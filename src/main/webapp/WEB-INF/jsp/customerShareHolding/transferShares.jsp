
<div class="pagetitle">
	<h1>CUSTOMER SHAREHOLDING</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-building-fill-down"></i>
			</a></li>
			<li class="breadcrumb-item action">TRANSFER SHARE</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<input type="hidden" id="id" name="id">
		<input type="hidden" id="certificateNo" name="certificateNo" value="${generatedCertificateNo}">
		<input type="hidden" id="customerName" name="customerName">
		<input type="hidden" id="startDate" name="startDate">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">CUSTOMER DETAILS</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="transferType">TRANSFER TYPE</label> 
						<select id="transferType" name="transferType"
							onchange="transferTypeFunc()" class="form-control selectField"
							style="height: 30px;">
							<option value="">SELECT TRANSFER TYPE</option>
							<option value="B2C">BANK TO CUSTOMER</option>
							<option value="C2C">CUSTOMER TO CUSTOMER</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3" id="fCustomer" style="display: none;">
					<div class="d-flex flex-column formFields">
						<label for="fromCustomerCode">FROM CUSTOMER</label> 
						<select id="fromCustomerCode" name="fromCustomerCode" class="form-control selectField" style="height: 30px;">
							<option value="">SELECT FROM CUSTOMER</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3" id="availShare" style="display: none;">
					<div class="d-flex flex-column formFields">
						<label for="availableShares">FROM CUST AVAILABLE SHARES</label> 
						<input type="text" name="availableShares" id="availableShares"
							placeholder="ENTER AVAILABLE SHARES" readonly="readonly" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="toCustomerCode">TO CUSTOMER</label> 
						<select id="toCustomerCode" name="toCustomerCode" class="form-control selectField" style="height: 30px;">
							<option value="">SELECT TO CUSTOMER</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3" id="toAvailShareDiv">
					<div class="d-flex flex-column formFields">
						<label for="toAvailableShares">TO CUST CURRENT SHARES</label> 
						<input type="text" name="toAvailableShares" id="toAvailableShares"
							placeholder="TO CUSTOMER SHARES" readonly="readonly" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="branch">BRANCH</label> 
						<select id="branch" name="branch" required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">SELECT BRANCH</option>
						</select>
					</div>
				</div>
			</div>
			
			<div class="mt-5">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">SHARE DETAILS</li>
					</ol>
				</nav>
				<div class="row">
					<input type="hidden" id="transferRefNo" name="transferRefNo">
				
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mb-4">
							<label for="noOfShare">NO. OF SHARE</label> 
							<input type="number" name="noOfShare" id="noOfShare" required="required"
								placeholder="ENTER NO. OF SHARE" min="1" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="baseValue">SHARE BASE VALUE</label> 
							<input type="text" name="baseValue" id="baseValue" required="required" readonly="readonly"
								placeholder="ENTER BASE VALUE" value="10" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="amountTransferred">AMOUNT TRANSFERRED</label> 
							<input type="text" name="amountTransferred" id="amountTransferred" readonly="readonly"
								required="required" placeholder="AMOUNT TRANSFERRED" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="balanceShares">BALANCE SHARE</label> 
							<input type="text" readonly="readonly" name="balanceShares" id="balanceShares"
								required="required" placeholder="ENTER BALANCE SHARE" />
						</div>
					</div>
				</div>
			</div>

			<div class="mt-5">
				<nav id="pDetails">
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">PAYMENTS DETAILS</li>
					</ol>
				</nav>
				<div class="row" id="paymentDetailsRow">
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="modeOfPayment">MODE OF PAYMENT </label> 
							<select id="modeOfPayment" name="modeOfPayment"
								class="form-control selectField" style="height: 30px;">
								<option value="">SELECT PAYMENT</option>
								<option value="Cash">CASH</option>
								<option value="Cheque">CHEQUE</option>
								<option value="NEFT">NEFT</option>
								<option value="Online">ONLINE</option>
							</select>
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mb-4">
							<label for="dateOfTransfer">DATE OF TRANSFER</label> 
							<input type="date" name="dateOfTransfer" id="dateOfTransfer"
								required="required" style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mb-4">
							<label for="comments">COMMENTS</label>
							<textarea name="comments" id="comments"
								style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
						</div>
					</div>
				</div>
			</div>

			<div class="row mt-3">
				<div class="col-6 d-flex gap-2">
					<button type="button" id="saveBtn" class="btnStyle bg-success"
						onclick="saveShares()">SAVE</button>
					<button type="button" id="updateBtn" class="btnStyle bg-success"
						onclick="updateShares()" style="display: none;">UPDATE</button>
					<button type="button" id="resetBtn" class="btnStyle"
						style="background-color: #6c757d; color: white;"
						onclick="resetTransferForm()">RESET</button>
				</div>
			</div>
		</div>
	</form>

	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">
				<div class="card-body table-responsive">
					<h5 class="card-title">
						RECENT TRANSFERS <span>| ALL RECORDS</span>
					</h5>

					<table class="table table-borderless datatable overflow-scroll">
						<thead class="table-light">
							<tr style="font-family: 'Poppins', sans-serif;">
								<th scope="col">SR NO.</th>
								<th scope="col">CUSTOMER CODE</th>
								<th scope="col">CUSTOMER NAME</th>
								<th scope="col">START DATE</th>
								<th scope="col">BRANCH</th>
								<th scope="col">NO. OF SHARE</th>
								<th scope="col">DATE OF TRANSFER</th>
								<th scope="col">EDIT</th>
								<th scope="col">DELETE</th>
							</tr>
						</thead>
						<tbody id="transfersharetable">
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script
	src="${pageContext.request.contextPath}/js/CustomerShareHolding/TransferShares.js"></script>
