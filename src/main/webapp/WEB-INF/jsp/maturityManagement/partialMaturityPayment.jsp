
<div class="pagetitle">
	<h1>Maturity Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-calendar-check"></i>
			</a></li>
			<li class="breadcrumb-item action">Partial Maturity Payment</li>
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
						<label for="">Plan type :<span id="star"> *</span></label> <select
							id="plantype" name="plantype" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="Select">Select</option>
							<option value="RD">RD</option>
							<option value="FD">FD</option>
							<option value="MIS">MIS</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<input type="hidden" name="id" id="id">
					<div class="d-flex flex-column formFields">
						<label for="policyCode">Policy Code</label> <select
							id="policyCode" name="policyCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-- Policy Code --</option>

						</select>
					</div>
				</div>



			</div>
			<div class="mt-5">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">Policy Details</li>
					</ol>
				</nav>
				<div class="row">
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="vehicalNo">Plan Code :</label> <input type="text"
								name="planCode" id="planCode" required="required" placeholder=""
								style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="vehicalNo">Customer Name :</label> <input type="text"
								name="customerName" id="customerName" required="required"
								placeholder="" style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Policy Name:</label> <input type="text" name="policyName"
								id="policyName" required="required" placeholder=""
								style="text-transform: uppercase;" />
						</div>
					</div>




					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Duration:</label> <input type="text" name="duration"
								id="duration" required="required" placeholder="" />

						</div>

					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Policy Amount:</label> <input type="text"
								name="policyAmount" id="policyAmount" required="required"
								placeholder="" />

						</div>

					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Actual Maturity:</label> <input type="text"
								name="maturityAmount" id="maturityAmount" required="required"
								placeholder="" />

						</div>

					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Maturity Date:</label> <input type="text"
								name="maturityDate" id="maturityDate" required="required"
								placeholder="" />

						</div>

					</div>
					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Sys.Payable:</label> <input type="text" name="sysPayable"
								id="sysPayable" required="required" placeholder=""
								value="sysPayable" />

						</div>

					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Deduction(-):</label> <input type="text" name="deduction"
								id="deduction" required="required" placeholder=""
								value="deduction " />

						</div>

					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Net Payable:</label> <input type="text" name="netPayable"
								id="netPayable" required="required" placeholder="" />

						</div>

					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Approval Branch Name:</label> <input type="text"
								name="Approvebranch" id="Approvebranch" required="required" />

						</div>

					</div>



					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Approve Status:</label> <input type="text"
								name="approveStatus" id="approveStatus" required="required"
								value="NotApproved" readonly="readonly" />

						</div>

					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<input type="hidden" name="id" id="id">
							<div class="d-flex flex-column formFields">
								<label> User Approver:</label> <select id="userApprover"
									name="userApprover" required="required"
									class="form-control selectField" style="height: 30px;">
									<option value="">Team Member</option>

								</select>
							</div>

						</div>

					</div>

				</div>
			</div>


			<div class="mt-5">
				<nav>
					<ol class="breadcrumb breadcrumb-title">
						<li class="breadcrumb-item action">Payable Detail</li>
					</ol>
				</nav>
				<div class="row">
					<div class="col-lg-3">

						<div class="d-flex flex-column formFields">
							<label for="">Closing Date: <span id="star"> *</span></label> <input
								type="date" name="closingDate" id="closingDate"
								required="required" placeholder=""
								style="text-transform: uppercase;" />
						</div>
					</div>


					<div class="col-lg-3">
						<div class="d-flex flex-column formFields">
							<label for="vehicalNo">Paid Amount: <span id="star">
									*</span></label> <input type="text" name="depositAmount" id="depositAmount"
								required="required" placeholder=""
								style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Due Amount:</label> <input type="text" name="dueAmount"
								id="dueAmount" required="required" placeholder=""
								style="text-transform: uppercase;" />
						</div>
					</div>

					<div class="col-lg-3">
						<div class="d-flex flex-column formFields"
							style="margin-bottom: 30px">
							<label>Comment :</label> <input type="text" name="Comment"
								id="Comment" required="required" placeholder="" />
						</div>
					</div>
				</div>

			</div>



			<div class="row">
				<div class="col-12 text-center">
					<button id="saveBtn" class="btn btn-danger">Break</button>
				</div>
			</div>
		</div>
	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/MaturityManagement/partialmaturity.js"></script>