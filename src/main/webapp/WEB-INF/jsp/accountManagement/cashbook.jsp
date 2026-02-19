
<div class="pagetitle">
	<h1>ACCOUNT MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">CASH BOOK</li>
		</ol>
	</nav>
</div>

<form id="formid">
	<div>
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">SEARCH INFORMATION</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="">BRANCH NAME</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">--SELECT BRANCH--</option>
						</select>
					</div>
				</div>

				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">START DATE</label> <input type="date"
							name="startDate" id="startDate" required="required" />
					</div>
				</div>

				<div class="col-lg-4">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">END DATE</label> <input type="date"
							name="endDate" id="endDate" required="required" />
					</div>
				</div>
			</div>
		</div>
	</div>

	<div class="row">
		<div class="col-12 text-center mt-3">
			<button id="viewBtn" class="btnStyle"
				style="background-color: #FFA500;">VIEW</button>
			<button id="showDetilsBtn" class="btnStyle"
				style="background-color: #ff8400;">SHOW DETAILS</button>
		</div>
	</div>
</form>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title">SEARCH RESULT</h5>


				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th style="white-space: nowrap;">SR NO.</th>
							<th style="white-space: nowrap;">DATE</th>
							<th style="white-space: nowrap;">TRANSACTION ID</th>
							<th style="white-space: nowrap;">ACCOUNT NO</th>
							<th style="white-space: nowrap;">DESCRIPTION</th>
							<th style="white-space: nowrap;">DEBIT (CASH IN)</th>
							<th style="white-space: nowrap;">CREDIT (CASH OUT)</th>
							<th style="white-space: nowrap;">BALANCE</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

