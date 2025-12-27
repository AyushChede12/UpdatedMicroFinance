
		<div class="pagetitle">
			<h1>Customer Shareholding</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="openDashboard"> <i
							class="bi bi-building-fill-down"></i>
					</a></li>
					<li class="breadcrumb-item action">Transfer Share</li>
				</ol>
			</nav>
		</div>

		<div>
			<form id="formid">
				<div>
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action">Customer Details</li>
						</ol>
					</nav>
					<div class="row">
						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<input type="hidden" id="id" name="id">
								<input type="hidden" value="${generatedCertificateNo}" id="certificateNo"  name="certificateNo"/>
								
								
								<label for="">Find By Code</label> <select id="findByCode"
									name="findByCode" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select Code</option>
									
								</select>
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Customer Name</label> <input type="text"
									name="customerName" id="customerName" required="required"
									placeholder="Enter Customer Name" readonly="readonly"/>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="vehicalNo">Start Date</label> <input type="date"
									name="startDate" id="startDate" required="required"
									placeholder="Enter" readonly="readonly"
									style="text-transform: uppercase;" />
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Previous Account Balance</label> <input type="text"
									name="previousAccountBalance" id="previousAccountBalance" required="required"
									placeholder="Enter Previous Account Balance" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Previous Share Count</label> <input type="text"
									name="previousShareCount" id="previousShareCount" required="required"
									placeholder="Enter Previous Share Count" />
							</div>
						</div>

						<div class="col-lg-3"baseValue>
							<div class="d-flex flex-column formFields">
								<label for="">Base Value</label> <input type="text" name="baseValue"
									id="baseValue" required="required"
									placeholder="Enter Base Value" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Branch</label> <select id="branch" name="branch"
									required="required" class="form-control selectField"
									style="height: 30px; " placeholder="Enter Branch">
									<option value="">Select Branch</option>
								</select>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="vehicalNo">Date of Transfer</label> <input type="date"
									name="dateOfTransfer" id="dateOfTransfer" required="required"
									placeholder="Enter Vehicle No"
									style="text-transform: uppercase;" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields  mb-4">
								<label for="">Shares Issued To Customer </label> <select id="shareIssuedBy"
									name="shareIssuedBy" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Select </option>
								</select>
							</div>
						</div>

						  <div class="col-lg-3">
							<div class="d-flex flex-column formFields  mb-4">
								<label for="">No. Of Share</label> <input type="text"
									name="noOfShare" id="noOfShare" required="required"
									placeholder="Enter No. Of Share" />
							</div>
						</div> 

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Amount Transferred</label> <input type="text"
									name="amountTransferred" id="amountTransferred" required="required"
									placeholder="Enter Amount Transferred" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Balance Shares </label> <input type="text" readonly="readonly"
									name="balanceShares" id="balanceShares" required="required"
									placeholder="" />
							</div>
						</div>
						
						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Previous Account Balance</label> <input type="text"
									name="previousAccountBalance" id="previousAccountBalance" required="required"
									placeholder="Enter Previous Account Balance" />
							</div>
						</div>
						<div class="col-lg-3">
							<div class="d-flex flex-column formFields ">
								<label for="">Previous Share Count</label> <input type="text"
									name="previousShareCount" id="previousShareCount" required="required"
									placeholder="Enter Previous Share Count" />
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
									<label for="">Mode of Payment </label> <select id="modeOfPayment"
										name="modeOfPayment" required="required"
										class="form-control selectField" style="height: 30px;">
										<option value="">Select Payment </option>
										<option value="cash">Cash</option>
										<option value="cheque">Cheque</option>
										<option value="neft">NEFT</option>
										<option value="online">Online</option>
									</select>
								</div>
							</div>

							<div class="col-lg-3">
								<div class="d-flex flex-column formFields mb-4">
									<label for="">Comments</label>
									<textarea name="comments" id="comments"
									style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
								</div>
							</div>


						</div>
					</div>

					<div class="row">
						<div class="col-3">
							<button type="button" id="saveBtn" class="btnStyle bg-success" onclick="saveShares()">Save</button>
							<button type="button" id="updateBtn" class="btnStyle bg-success" onclick="updateShares()">Update</button>

						</div>
					</div>
			</form>


			<div class="row mt-5">
				<div class="col-12">
					<div class="card recent-sales">

						<div class="card-body table-responsive">
							<h5 class="card-title">
								Recent Sales <span>| Today</span>
							</h5>

							<table class="table table-borderless datatable overflow-scroll">
								<thead class="table-light">
									<tr style="font-family: 'Poppins', sans-serif;">
										<th scope="col">Sr No.</th>
										<th scope="col">Customer Code</th>
										<th scope="col">Customer Name</th>
										<th scope="col">Start Date</th>
										<th scope="col">Branch</th>
										<th scope="col">No. Of Share</th>
										<th scope="col">Date of Transfer</th>
										
										<th scope="col">Edit</th>	
										<th scope="col">Delete</th>				
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