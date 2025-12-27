
<div class="pagetitle">
	<h1>Loan Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Emi & Loan Calculator</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Emi & Loan Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Interest Type</label> <select name="intrestType"
							id="intrestType" onchange="calculateEMI()"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Interest Type</option>
							<option value="FlatInterest">Flat Interest</option>
							<option value=reducinginterest>Redused Interest</option>
							<option value="Rule78">Rule 78</option>

						</select>
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Loan Amount</label> <input type="text"
							name="loanAmount" id="loanAmount" required="required"
							placeholder="Loan Amount" style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Yearly Interest</label> <input type="text"
							name="yearlyIntrest" id="yearlyIntrest" required="required"
							placeholder="Yearly Interest" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Interest Mode</label> <select
							id="interestModeCalculater" name="interestModeCalculater"
							onchange="calculateEMI()" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Interest Mode</option>
							<option value="Daily">Daily</option>
							<option value="Weekly">Weekly</option>
							<option value="Fortnightly">Fortnightly</option>
							<option value="Monthly">Monthly</option>
							<option value="Quarterly">Quarterly</option>

						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Monthly Term</label> <input type="text"
							name="monthlyTerm" id="monthlyTerm" required="required"
							placeholder="Enter Term in Month"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">EMI</label> <input type="text" name="emi"
							id="emi" readonly="readonly" placeholder="Enter Term in Month"
							style="text-transform: uppercase;" />
					</div>
				</div>



			</div>

			<div class="row">
				<div class="col-12 text-center">
					<button type="button" id="saveBtn" class="btnStyle"
						onclick="calculateEMI()" style="background-color: #FFA500;">Calculate</button>
					<button id="" class="btnStyle bg-danger">View Amortization</button>
				</div>
			</div>
	</form>

	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">

				<div class="card-body table-responsive">
					<h5 class="card-title">
						Loan Calculator <span>| Today</span>
					</h5>

					<table class="table table-borderless datatable overflow-scroll">
						<thead class="table-light">
							<tr style="font-family: 'Poppins', sans-serif;">
								<th scope="col">EMI No.</th>
								<th scope="col">Due Date</th>
								<th scope="col">EMI</th>
								<th scope="col">Principle</th>
								<th scope="col">Interest</th>
								<th scope="col">Current Balance</th>

							</tr>
						</thead>
						<tbody id="tbody">


						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</div>

<script src="./js/LoanManagment/emiLoanCalculator.js"></script>
<script
	src="${pageContext.request.contextPath}/js/LoanManagment/emiLoanCalculator.js"></script>
