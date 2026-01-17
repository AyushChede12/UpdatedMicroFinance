
<div class="pagetitle">
	<h1>SAVING / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			
			<li class="breadcrumb-item action">SAVINGS ACCOUNT INTEREST TRANSFER</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">INTEREST MASTER</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">GENERAL NAME</label> <input type="text" name="price"
							id="price" required="required" placeholder="Member Code" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">FROM DATE</label> <input type="date"
							name="vehicalNo" id="vehicalNo" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">TO DATE</label> <input type="date"
							name="vehicalNo" id="vehicalNo" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">COMMENTS</label> <input type="text" name="price"
							id="price" required="required" placeholder="Member Code" />
					</div>
				</div>

				<div class="row">
					<div class="col-12 text-center">
						<button id="saveBtn" class="btn btn-warning"
							style="margin-left: 80%; background-color: orange;">GENERATE</button>
					</div>
				</div>
			</div>
		</div>


		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">INTEREST DETAILS</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">SEARCH BY GENERAL CODE</label> <select id="colour"
							name="colour" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT COLOUR</option>
							<option value="Blue">Blue</option>
						</select>
					</div>
				</div>
			</div>
		</div>

		<div class="row">
			<div class="col-12 text-center">
				<button id="saveBtn" class="btn btn-warning"
					style="margin-left: 80%; background-color: orange;">SEARCH
					DATA</button>
			</div>
		</div>
	</form>

</div>
<script
		src="${pageContext.request.contextPath}/js/customerSavings/SBInterestTransfer.js"></script>