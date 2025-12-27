
<div class="pagetitle">
	<h1>Secured Gold Loan</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Print NOC</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div class="">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details For Print</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="findByGoldLoanId" id="goldSelection">Find By
							Gold Id </label> <select id="findByGoldLoanId" name="findByGoldLoanId"
							class="form-control selectField" style="width: 100%;">
							<option value="">-- Select Gold ID --</option>
						</select>
					</div>
				</div>
			</div>
		</div>
		<div class="row">
			<div class="col-12 text-center">

				<button class="btnStyle" style="background-color: #FFA500;"
					id="generateNoc">Generate NOC</button>

			</div>
		</div>

	</form>
	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales" id="receiptArea"></div>
		</div>
	</div>

	<!-- Print Button (hidden by default) -->
	<div style="text-align: center; margin-top: 20px;">
		<button id="printBtn" onclick="printDocument()"
			style="display: none; padding: 8px 20px; font-size: 16px; font-weight: bold; background: #007bff; color: #fff; border: none; border-radius: 6px; cursor: pointer;">
			Print</button>
	</div>
</div>

<script
	src="${pageContext.request.contextPath}/js/SecuredGoldLoan/NocgenerationGold.js"></script>