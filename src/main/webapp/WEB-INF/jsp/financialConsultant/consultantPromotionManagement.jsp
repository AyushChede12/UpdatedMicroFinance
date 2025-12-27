
<div class="pagetitle">
	<h1>Financial Consultant</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-briefcase text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">Consultant Promotion
				Management</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Financial Consultant
						Promotion</li>
				</ol>
			</nav>
			<div class="row">
				<input type="hidden" id="id" name="id">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields">
						<label for="">Select Code</label> <select id="financialCode"
							name="financialCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Code</option>

						</select>
					</div>
				</div>

				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="position">Position</label> <input type="text"
									name="position" id="position" required="required"
									placeholder="Enter Position" style="text-transform: uppercase;" />
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px">
								<label>Branch</label> <input type="text" name="Branch"
									id="Branch" required="required" placeholder="Enter Branch"
									style="text-transform: uppercase;" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Senior Code</label> <input type="text"
									name="seniorcode" id="seniorcode" required="required"
									placeholder="Enter Senior Code"
									style="text-transform: uppercase;" />
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px">
								<label>Position</label> <input type="text" name="Position2"
									id="Position" required="required" placeholder="Enter Senior Position"
									style="text-transform: uppercase;" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Immidiate Sr.</label> <input type="text"
									name="immidiateSr" id="immidiateSr" required="required"
									placeholder="Enter Immidiate Sr" />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px">
								<label>Sr.Position</label> <input type="text" name="srPosition"
									id="srPosition" required="required" placeholder="Enter Sr. Position" />
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px">
								<label for="">Immidiate Jr.</label> <input type="text"
									name="immidiatejr" id="immidiatejr" required="required"
									placeholder="Enter Immidiate Jr." />
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Jr. Position</label> <input type="text"
									name="jrPosition" id="jrPosition" required="required"
									placeholder="Enter Jr. Position" />
							</div>
						</div>
 -->
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Select Branch</label> <input type="text" id="Branch"
							name="branchName" required="required"
							class="form-control selectField"
							style="height: 30px; background-color: #fff;" readonly="readonly">
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Old Position</label> <input type="text" id="oldPosition"
							name="oldPosition" required="required"
							class="form-control selectField"
							style="height: 30px; background-color: #fff;" readonly="readonly">
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>New Position</label> <select id="newPosition"
							name="newPosition" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">New Position</option>
							<option value="L1">L1</option>
							<option value="L2">L2</option>
							<option value="L3">L3</option>
							<option value="L4">L4</option>
							<option value="L5">L5</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Promotion Date</label> <input type="date"
							name="promotionDate" id="promotionDate" required="required"
							placeholder="Enter New Senior" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">New Senior Code</label> <input type="text"
							name="seniorCode" id="newseniorCode" required="required"
							placeholder="Enter New Senior" readonly="readonly" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Senior Name</label> <input type="text" name="seniorName"
							id="newseniorname" required="required"
							placeholder="Enter Senior Name" readonly="readonly" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Senior Position</label> <input type="text"
							name="seniorPosition" id="newseniorposition" required="required"
							placeholder="Enter New Senior Position" readonly="readonly" />
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-12 text-center">
					<button type="button" id="updateBtn" class="btnStyle"
						style="background-color: #FFA500;">Update</button>
				</div>

			</div>

		</div>



	</form>
	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">

				<div class="card-body table-responsive">
					<h5 class="card-title">Promotion Management Details</h5>


					<div style="overflow-x: auto; white-space: nowrap;">
						<table class="table table-borderless datatable" id="tabl">
							<thead class="table-light">
								<tr style="font-family: 'Poppins', sans-serif;">
									<th scope="col">Sl No.</th>
									<th scope="col">Financial Code</th>
									<th scope="col">Branch</th>
									<th scope="col">Old Position</th>
									<th scope="col">New Position</th>
									<th scope="col">Promotion Date</th>
									<th scope="col">Senior Code</th>
									<th scope="col">Senior Position</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
						</table>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<script
	src="${pageContext.request.contextPath}/js/FinancialConsultant/consultantPromotionManagement.js"></script>