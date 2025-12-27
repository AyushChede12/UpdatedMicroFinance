
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-house-door"></i>
			</a></li>
			<li class="breadcrumb-item action">Regular Loan Statement</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Select Loan Type</label> <select id="loanId&Name"
							name="loanId&Name" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Loan Type</option>
							<option value="Regular">Regular Loan Statement</option>
							<option value="Irregular">Irregular Loan Statement</option>
						</select>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for=""> Loan Id</label> <select id="loanStatementID"
							name="loanStatementID" required="required"
							class="form-control selectField" style="height: 30px;">

						</select>
					</div>
				</div>

			</div>
		</div>

		<div class="row mt-4">
			<div class="col-12 text-center">
				<button id="searchLoanStatement" class="btnStyle bg-success">search</button>

			</div>
		</div>
	</form>

	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales" id="receiptArea"></div>
		</div>
	</div>

</div>

<script
	src="${pageContext.request.contextPath}/js/LoanManagment/LoanStatement.js"></script>
