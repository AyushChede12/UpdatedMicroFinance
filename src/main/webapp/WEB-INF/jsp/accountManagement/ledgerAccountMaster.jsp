
<div class="pagetitle">
	<h1>Account Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">Ledger Account Master</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">New Ledger Entry</li>
				</ol>
			</nav>
			<!-- Hidden fields -->
			<input type="hidden" name="accountId" id="accountId" /> <input
				type="hidden" name="currentBalance" id="currentBalance" value="0.00" />
			<div class="row mb-3">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Account Code <span class="star">*</span></label> <input
							type="text" name="accountCode" id="accountCode"
							placeholder="Enter Code" /> <span id="accountCodeError"
							style="color: red; font-size: 12px;"></span>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Account Title <span class="star">*</span></label> <input
							type="text" name="accountTitle" id="accountTitle"
							placeholder="Enter Ledger name" /> <span id="accountTitleError"
							style="color: red; font-size: 12px;"></span>

					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="groupName">Account Group <span class="star">*</span></label>
						<select id="groupName" name="groupName"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Group</option>
							<!-- Groups (Assets, Liabilities, Income, Equity, Expenses) 
			     will be loaded dynamically from JS/backend -->
						</select> <span id="groupNameError" style="color: red; font-size: 12px;"></span>
					</div>
				</div>

				<!-- Account Type -->
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="accountType">Account Type <span class="star">*</span></label>
						<select id="accountType" name="accountType"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Type</option>
							<!-- Sub-types will be injected dynamically based on group selection -->
						</select> <span id="accountTypeError" style="color: red; font-size: 12px;"></span>
					</div>
				</div>
			</div>

			<!-- Opening Balance -->
			<div class="row mb-3">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label>Opening Balance</label> <input type="number"
							name="openingBalance" id="openingBalance"
							placeholder="Enter Opening Balance" step="0.01" min="0"
							value="0.00" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="openingBalanceType">Balance Type</label> <select
							id="openingBalanceType" name="openingBalanceType"
							class="form-control selectField" style="height: 30px;" disabled>
							<option value="DR">DR</option>
							<option value="CR">CR</option>
						</select>
					</div>
				</div>


				<!-- Status -->
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Status</label> <select id="status" name="status"
							class="form-control selectField" style="height: 30px;">
							<option value="Active">Active</option>
							<option value="Inactive">Inactive</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Branch Name <span class="star">*</span>
						</label> <select id="branchName" name="branchName"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Branch Name</option>
						</select> <span id="branchNameError" style="color: red; font-size: 12px;"></span>

					</div>



					<div class="d-flex justify-content-start gap-3 mt-4">
						<button id="saveBtn" type="submit" class="btnStyle"
							style="background-color: #FFA500;">Save</button>
						<button id="clearBtn" type="reset" class="btnStyle bg-primary">Clear</button>

						<button type="button" id="toggleBtn" class="btnStyle bg-success"
							onclick="showTableData()">Show</button>


					</div>

				</div>
			</div>
		</div>


	</form>

	<div class="mt-5">
		<div class="row mt-5">
			<div class="col-12">
				<div class="card recent-sales">

					<div class="card-body table-responsive">
						<h5 class="card-title">
							Ledger List <span>| Table View</span>
						</h5>

						<table class="table table-borderless datatable overflow-scroll">
							<thead class="table-light">
								<tr style="font-family: 'Poppins', sans-serif;">
									<th scope="col">ID</th>
									<th scope="col">Account Code</th>
									<th scope="col">Account Title</th>
									<th scope="col">Account Group</th>
									<th scope="col">Account Type</th>
									<th scope="col">Opening Balance</th>
									<th scope="col">Opening Balance Type</th>
									<th scope="col">Current Balance</th>
									<th scope="col">Status</th>
									<th scope="col">Branch Name</th>
									<th scope="col">View</th>
								</tr>
							</thead>
							<tbody id="tableBody">


							</tbody>
						</table>
						<button id="selectAllBtn" class="btnStyle bg-secondary">Select
							All</button>
					</div>
				</div>
			</div>
		</div>
	</div>


</div>

<script>
	$(document).ready(function() {
		BranchNameDropdown();
	});
</script>

<script
	src="${pageContext.request.contextPath}/js/account-management/ledgeraccountmaster.js"></script>
