
		<div class="pagetitle">
			<h1>CUSTOMER SHAREHOLDING</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="openDashboard"> <i
							class="bi bi-building-fill-down"></i>
					</a></li>
					<li class="breadcrumb-item action">TRANSFER SHARE </li>
				</ol>
			</nav>
		</div>

		<div>
			<form id="formid">
				<div>
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action">CUTOMER DETAILS</li>
						</ol>
					</nav>
					<div class="row">
						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<input type="hidden" id="id" name="id">
								<input type="hidden" value="${generatedCertificateNo}" id="certificateNo"  name="certificateNo"/>
								
								
								<label for="">FIND BY CODE</label> <select id="findByCode"
									name="findByCode" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">SELECT CODE</option>
									
								</select>
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">CUSTOMER NAME</label> <input type="text"
									name="customerName" id="customerName" required="required"
									placeholder="ENTER CUSTOMER NAME" readonly="readonly"/>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="vehicalNo">START DATE</label> <input type="date"
									name="startDate" id="startDate" required="required"
									placeholder="Enter" readonly="readonly"
									style="text-transform: uppercase;" />
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">PREVIOUS ACCOUNT BALANCE </label> <input type="text"
									name="previousAccountBalance" id="previousAccountBalance" required="required"
									placeholder="ENTER PREVIOUS ACCOUNT BALANCE" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">PREVIOUS SHARE COUNT</label> <input type="text"
									name="previousShareCount" id="previousShareCount" required="required"
									placeholder="ENTER PREVIOUS SHARE COUNT" />
							</div>
						</div>

						<div class="col-lg-3"baseValue>
							<div class="d-flex flex-column formFields">
								<label for="">BASE VALUE</label> <input type="text" name="baseValue"
									id="baseValue" required="required"
									placeholder="ENTER BASE VALUE" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">BRANCH</label> <select id="branch" name="branch"
									required="required" class="form-control selectField"
									style="height: 30px; " placeholder="ENTER BRANCH">
									<option value="">SELECT BRANCH </option>
								</select>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="vehicalNo">DATE OF TRANSFER</label> <input type="date"
									name="dateOfTransfer" id="dateOfTransfer" required="required"
									placeholder=""
									style="text-transform: uppercase;" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields  mb-4">
								<label for="">SHARE ISSUED TO CUSTOMER </label> <select id="shareIssuedBy"
									name="shareIssuedBy" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">SELECT </option>
								</select>
							</div>
						</div>

						  <div class="col-lg-3">
							<div class="d-flex flex-column formFields  mb-4">
								<label for="">NO. OF SHARE</label> <input type="text"
									name="noOfShare" id="noOfShare" required="required"
									placeholder="ENTER NO. OF SHARE" />
							</div>
						</div> 

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">AMOUNT TRANSFERRED</label> <input type="text"
									name="amountTransferred" id="amountTransferred" required="required"
									placeholder="Enter Amount Transferred" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">BALANCE SHARE </label> <input type="text" readonly="readonly"
									name="balanceShares" id="balanceShares" required="required"
									placeholder="" />
							</div>
						</div>
						
						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">PREVIOUS ACCOUNT BALANCE</label> <input type="text"
									name="previousAccountBalance" id="previousAccountBalance" required="required"
									placeholder="ENTER PREVIOUS ACCOUNT BALANCE" />
							</div>
						</div>
						<div class="col-lg-3">
							<div class="d-flex flex-column formFields ">
								<label for="">PREVIOUS SHARE COUNT</label> <input type="text"
									name="previousShareCount" id="previousShareCount" required="required"
									placeholder="ENTER PREVIOUS SHARE COUNT" />
							</div>
						</div>


					</div>
					<div class="mt-5">
						<nav>
							<ol class="breadcrumb breadcrumb-title">
								<li class="breadcrumb-item action">PAYMENTS DETAILS</li>
							</ol>
						</nav>
						<div class="row">

							<div class="col-lg-3">
								<div class="d-flex flex-column formFields">
									<label for="">MODE OF PAYMENT </label> <select id="modeOfPayment"
										name="modeOfPayment" required="required"
										class="form-control selectField" style="height: 30px;">
										<option value="">SELECT PAYMENT </option>
										<option value="cash">CASH</option>
										<option value="cheque">CHEQUE</option>
										<option value="neft">NEFT</option>
										<option value="online">ONLINE</option>
									</select>
								</div>
							</div>

							<div class="col-lg-3">
								<div class="d-flex flex-column formFields mb-4">
									<label for="">COMMENTS</label>
									<textarea name="comments" id="comments"
									style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
								</div>
							</div>


						</div>
					</div>

					<div class="row">
						<div class="col-3">
							<button type="button" id="saveBtn" class="btnStyle bg-success" onclick="saveShares()">SAVE</button>
							<button type="button" id="updateBtn" class="btnStyle bg-success" onclick="updateShares()">UPDATE</button>

						</div>
					</div>
			</form>


			<div class="row mt-5">
				<div class="col-12">
					<div class="card recent-sales">

						<div class="card-body table-responsive">
							<h5 class="card-title">
								RECENT SALES <span>| TODAY</span>
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