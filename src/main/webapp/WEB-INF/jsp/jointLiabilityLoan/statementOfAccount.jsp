
<div class="pagetitle">
	<h1>Joint Liability Loan</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-person-bounding-box"></i>
			</a></li>
			<li class="breadcrumb-item action">Statement Of Account</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details for Print</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="groupCode">Find by Group Code*</label> <select
							id="groupCode" name="groupCode" required
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Customer Name</option>
						</select>
					</div>
				</div>



			</div>


		</div>




	</form>
	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">
				<div class="card-body table-responsive">
					<h5 class="card-title">Details Search List</h5>
					<table class="table table-bordered">
						<thead class="thead-light">
							<tr>
								<th>Group ID</th>
								<th>Community Name</th>
								<th>Opening Date</th>
								<th>Branch Name</th>
								<th>Community Leader</th>
								<th>Community Address</th>
								<th>Contact No</th>
								<th>Scheduled Collection Days</th>
								<th>Scheduled Time</th>





							</tr>
						</thead>
						<tbody id="InstallmentLoanBody">


							<!-- More rows -->
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</div>

<script
	src="${pageContext.request.contextPath}/js/Joinlibiliy/statementOfAccount.js"></script>

