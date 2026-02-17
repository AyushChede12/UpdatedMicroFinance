
<div class="pagetitle">
	<h1>ACCOUNT MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="home"> <i
					class="bi bi-wallet2"></i>
			</a></li>
			<li class="breadcrumb-item action">TRAIL BALANCE REPORT</li>
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
						<label for=""> BRANCH NAME</label> <select id="branchName"
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
		</div>
	</div>
</form>

<div class="row mt-5">
	<div class="col-12">
		<label for="vehicalNo"><b><u>TRAIL BALANCE</u></b></label><br> <label
			for="vehicalNo"><b>BRANCH :</b></label><br> <label
			for="vehicalNo"><b>DATE :</b></label> BETWEEN
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<h5 class="card-title"></h5>

				<table class="table table-borderless datatable overflow-scroll">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th style="white-space: nowrap;">LEDGER NAME</th>
							<th style="white-space: nowrap;">OPENING</th>
							<th style="white-space: nowrap;">DEBIT</th>
							<th style="white-space: nowrap;">CREDIT</th>
							<th style="white-space: nowrap;">CLOSING</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>
