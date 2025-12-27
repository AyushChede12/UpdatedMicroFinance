
<div class="pagetitle">
	<h1>Policy Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-piggy-bank"></i>
			</a></li>
			<li class="breadcrumb-item action">Daily Premium Renewal</li>
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
					<div class="d-flex flex-column formFields">
						<label for="Agent">Policy Code <span class="star">*</span></label>
						<select id="policyCode" name="policyCode" required
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Policy Code</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Renewal Date <span class="star">*</span></label> <input
							type="date" name="renewalDate" id="renewalDate"
							required="required" placeholder="Enter Vehicle No"
							style="text-transform: uppercase;" />
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
							<label>Policy Date <span class="star">*</span></label> <input
								type="date" name="policyDate" id="policyDate"
								required="required" placeholder="Enter Vehicle No"
								style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Maturity Date <span class="star">*</span></label> <input
								type="date" name="maturityDate" id="maturityDate"
								required="required" placeholder="Enter Vehicle No"
								style="text-transform: uppercase;" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Customer Code <span class="star">*</span></label> <input
								type="text" name="customerCode" id="customerCode"
								required="required" placeholder="Enter Customer Code" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Customer Name <span class="star">*</span></label> <input
								type="text" name="clientName" id="clientName"
								required="required" placeholder="Enter Customer Name" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Branch Name <span class="star">*</span></label> <input
								type="text" name="branchname" id="branchname"
								required="required" placeholder="Enter Branch Name" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Contact No <span class="star">*</span></label> <input
								type="text" name="contactNo" id="contactNo" required="required"
								placeholder="Enter Mobile No." />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Policy Amount <span class="star">*</span></label> <input
								type="text" name="policyAmount" id="policyAmount"
								required="required" placeholder="Enter Nominee Name" />
						</div>
					</div>




					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Policy Type <span class="star">*</span></label> <input
								type="text" name="policyType" id="policyType"
								required="required" placeholder="Enter Nominee Name" />
						</div>
					</div>


					<!-- in this two text fieldds are required -->
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Policy Term <span class="star">*</span></label> <input
								type="text" name="policyTerm" id="policyTerm"
								required="required" placeholder="Enter Education" />
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
							<label for="">Total Deposits <span class="star">*</span></label>
							<input type="text" name="totalDeposit" id="totalDeposit"
								required="required" placeholder="Enter Education" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="">Payment Due <span class="star">*</span></label> <input
								type="text" name="paymentDue" id="paymentDue"
								required="required" placeholder="Enter Education" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">Last Payment Date <span class="star">*</span></label>
							<input type="text" name="lastPaymentDate" id="lastPaymentDate"
								required="required" placeholder="Enter Education" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">Due Date <span class="star">*</span></label> <input
								type="date" name="dueDate" id="dueDate" required="required"
								placeholder="Enter Vehicle No"
								style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">No Of Installment <span class="star">*</span></label>
							<input type="text" name="noOfInst" id="noOfInst"
								required="required" placeholder="Enter Education" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">Installments Completed <span class="star">*</span></label>
							<input type="text" name="noOfInstPaid" id="noOfInstPaid"
								required="required" placeholder="Enter Education" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields mt-4">
							<label for="">Mode Of Payment <span class="star">*</span></label>
							<input type="text" name="modeOfPayment" id="modeOfPayment"
								required="required" placeholder="Enter Education" />
						</div>
					</div>




				</div>
			</div>

			<div class="row mt-4">
				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
						Photo <span class="star">*</span>
					</label> <label for="customerPhoto" id="drop-area"> <input
						accept="image/*" name="customerPhoto" id="customerPhoto"
						hidden="hidden" onchange="photopreview();"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="photoPreview" /><input type="hidden" name="photoHidden"
								id="photoHidden">

						</div>
					</label>
				</div>

				<div class="col-lg-3 mb-5">
					<label for=""
						style="font-size: 12px; font-family: 'Poppins', sans-serif; font-weight: 700; margin-bottom: 5px;">Upload
						Signature <span class="star">*</span>
					</label> <label for="customerSignature" id="drop-area"> <input
						accept="image/*" name="customerSignature" id="customerSignature"
						hidden="hidden" onchange="signpreview();"
						style="background-size: cover; background-repeat: no-repeat" />
						<div id="img-view">
							<img src="../images/upload/upload.png" alt="upload_icon"
								id="signaturePreview" /><input type="hidden"
								name="signatureHidden" id="signatureHidden">

						</div>
					</label>
				</div>

			</div>

		</div>

		<div class="row" style="margin-left: 80%;">
			<div class="col-12 text-center">
				<button id="viewBtn" type="button" class="btn btn-primary"
					data-toggle="modal" data-target="#installmentModal">View
					Installment</button>
				<button id="buttonSave" type="button" class="btn btn-info">Save</button>
			</div>
		</div>

	</form>



</div>


</main>

<!-- MODAL FOR VIEW INSTALLMENT -->
<div class="modal fade" id="installmentModal" tabindex="-1"
	role="dialog" aria-labelledby="installmentModalLabel"
	aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered"
		role="document">
		<div class="modal-content">
			<div class="modal-header bg-primary text-white">
				<h5 class="modal-title" id="installmentModalLabel">Installment
					Details</h5>
				<button type="button" class="close text-white" data-dismiss="modal"
					aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>

			<div class="modal-body">
				<div class="table-responsive">
					<table class="table table-bordered table-hover text-center"
						id="installmentModal">
						<thead class="thead-dark">
							<tr>
								<th>Installment No</th>
								<th>Due Date</th>
								<th>Amount</th>
								<th>Status</th>
								<th>Payment Date</th>
							</tr>
						</thead>
						<tbody>

						</tbody>
					</table>
				</div>
			</div>

			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/PolicyManagment/DailyPolicy.js"></script>
