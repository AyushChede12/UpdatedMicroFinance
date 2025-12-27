
<div class="pagetitle">
	<h1>Incentive Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-award"></i>
			</a></li>
			<li class="breadcrumb-item action">Generate Incentive Payments</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Incentive Generate</li>
				</ol>
			</nav>
			<input type="hidden" id="teamCode" name="teamCode"> <input
				type="hidden" id="teamName" name="teamName">
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Team Member Name</label> <select id="teamValue"
							name="teamValue" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Incentive Month</label> <select id="incentiveMonth"
							name="incentiveMonth" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">Date From</label> <input type="date"
							name="dateFrom" id="dateFrom" required="required"
							placeholder="Enter Date From" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">Date To</label> <input type="date"
							name="dateTo" id="dateTo" required="required"
							placeholder="Enter Date To" style="text-transform: uppercase;" />
					</div>
				</div>

			</div>
			<div class="row">
				<div class=" col-lg-3">
					<button id="saveBtn" class="btn btn-outline-danger">Generate</button>
				</div>
			</div>
		</div>
	</form>
</div>
<script
		src="${pageContext.request.contextPath}/js/incentive/generateIncentive.js"></script>

