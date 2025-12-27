
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">Inter Branch Cash Transfer</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Enter Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Start Date</label> <input type="date"
							name="startDate" id="startDate" required="required"
							placeholder="Enter From Date" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Source Branch</label> <select id="sourceBranch"
							name="sourceBranch" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select From Branch</option>
							<option value="Blue">Blue</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Receiving branch</label> <select
							id="receivingbranch" name="receivingbranch" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select To Branch</option>
							<option value="Blue">Blue</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for=""> Total Amount</label> <input type="text"
							name="totalAmount" id="totalAmount" required="required"
							placeholder="Enter Amount" />
					</div>
				</div>
			</div>
		</div>
</div>

<div class="row">
	<div class="col-12 text-center mt-3">
		<button id="saveBtn" class="btnStyle"
			style="background-color: #FFA500;">Transfer</button>
	</div>
</div>
</form>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title"></h5>

				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">Date</th>
							<th scope="col">Name</th>
							<th scope="col">Amount</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/account-management/interBranchCashTransfer.js"></script>