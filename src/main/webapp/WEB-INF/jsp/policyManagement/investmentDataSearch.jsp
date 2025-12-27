
<div class="pagetitle">
	<h1>Policy Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-piggy-bank"></i>
			</a></li>
			<li class="breadcrumb-item action">Investment Data Search</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Print Search Results</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-5">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 20px;">
						<label for="policyCode" id="policySelection">Policy Code </label>
						<select id="policyCode" name="policyCode"
							class="form-control selectField" style="width: 100%;">
							<option value="">-- Search Policy Number --</option>
						</select>
					</div>
				</div>

				<div class="row" style="margin-top: 20px;">
					<div class="col-12 text-center">
						<button type="button" id="findBtn" class="btn btn-dark">Find</button>
					</div>
				</div>

			</div>

			<!-- <div class="mt-5">
						<div class="row" id="policyDataRow">
							<div class="col-lg-12">
								Scrollable table wrapper
								<div style="overflow-x: auto; max-height: 400px;">
									<table class="table table-bordered table-striped"
										id="policyTable">
										<thead class="thead-dark"
											style="position: sticky; top: 0; background-color: #343a40; color: white;">
											<tr>
												<th>Sr No.</th>
												<th>Policy Code</th>
												<th>Customer Name</th>
												<th>Start Date</th>
												<th>Contact No</th>
												<th>Address</th>
												<th>District</th>
												<th>State</th>
												<th>Branch</th>
												<th>Policy Type</th>
												<th>Policy Amount</th>
												<th>Maturity Amount</th>
												<th>Payment Mode</th>
												<th>Approved Status</th>
											</tr>
										</thead>
										<tbody id="policyTableBody">
											Data will be inserted here
										</tbody>
									</table>
								</div>
								Certificate Template (hidden, will be cloned for print)

							</div>
						</div>
					</div> -->

			<div class="row mt-5" id="policyDataRow">
				<div class="col-12">
					<div class="card recent-sales">
						<div class="card-body table-responsive">
							<h5 class="card-title">
								Policy Details <span>| Data</span>
							</h5>

							<table class="table table-bordered">
								<thead class="table-light">
									<tr>
										<th style="white-space: nowrap;">Sr. No</th>
										<th style="white-space: nowrap;">Policy Code</th>
										<th style="white-space: nowrap;">Customer Name</th>
										<th style="white-space: nowrap;">Start Date</th>
										<th style="white-space: nowrap;">Contact No</th>
										<th style="white-space: nowrap;">Address</th>
										<th style="white-space: nowrap;">District</th>
										<th style="white-space: nowrap;">State</th>
										<th style="white-space: nowrap;">Branch</th>
										<th style="white-space: nowrap;">Policy Type</th>
										<th style="white-space: nowrap;">Policy Amount</th>
										<th style="white-space: nowrap;">Maturity Amount</th>
										<th style="white-space: nowrap;">Payment Mode</th>
										<th style="white-space: nowrap;">Approved Status</th>
									</tr>
								</thead>
								<tbody id="policyTableBody">
									<!-- Dynamic rows will be injected here -->
								</tbody>
							</table>

						</div>
					</div>
					<div class="mt-2 text-center">
						<button id="prevBtnDD" class="btn btn-sm btn-primary">
							<i class="bi bi-chevron-double-left"></i>
						</button>
						<span id="pageInfoDD" class="mx-2"></span>
						<button id="nextBtnDD" class="btn btn-sm btn-primary">
							<i class="bi bi-chevron-double-right"></i>
						</button>
					</div>
				</div>
			</div>
		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/PolicyManagment/investmentSearch.js"></script>
