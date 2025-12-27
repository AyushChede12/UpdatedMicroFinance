
<div class="pagetitle">
	<h1>Cusomer Saving</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">SB Interest Transfer</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Interest Master</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">General Name</label> <input type="text" name="price"
							id="price" required="required" placeholder="Member Code" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">From Date</label> <input type="date"
							name="vehicalNo" id="vehicalNo" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">To Date</label> <input type="date"
							name="vehicalNo" id="vehicalNo" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Comments</label> <input type="text" name="price"
							id="price" required="required" placeholder="Member Code" />
					</div>
				</div>

				<div class="row">
					<div class="col-12 text-center">
						<button id="saveBtn" class="btn btn-warning"
							style="margin-left: 80%; background-color: orange;">Generate</button>
					</div>
				</div>
			</div>
		</div>


		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Interest Details</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Search By General Code</label> <select id="colour"
							name="colour" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Colour</option>
							<option value="Blue">Blue</option>
						</select>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-12 text-center">
				<button id="saveBtn" class="btn btn-warning"
					style="margin-left: 80%; background-color: orange;">Search
					Data</button>
			</div>
		</div>
	</form>

</div>
<script
		src="${pageContext.request.contextPath}/js/customerSavings/SBInterestTransfer.js"></script>