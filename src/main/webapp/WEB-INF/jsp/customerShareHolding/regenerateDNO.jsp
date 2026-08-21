
<div class="pagetitle">
	<h1>CUSTOMER SHAREHOLDING</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-building-fill-down"></i>
			</a></li>
			<li class="breadcrumb-item action">REGENERATE DNO</li>
		</ol>
	</nav>
</div>
<div>
	<nav>
		<ol class="breadcrumb breadcrumb-title">
			<li class="breadcrumb-item action">SEARCH BOX</li>
		</ol>
	</nav>
	<div class="row">
		<div class="col-lg-6">
			<div class="d-flex flex-column formFields">
				<label for="selectDecisionMaker">SELECT CUSTOMER :</label> 
				<select id="selectDecisionMaker" name="selectDecisionMaker"
					class="form-control selectField mb-4" style="height: 30px;">
					<option value="">ALL CUSTOMERS</option>
				</select>
			</div>
		</div>
	</div>
	<div class="row">
		<div class="col-3">
			<button id="searchBtn" type="button" class="btnStyle"
				style="background-color: #FFA500;">
				<i class="bi bi-search"></i> SEARCH
			</button>
		</div>
	</div>

	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales" id="dnoPrintSection">
				<div class="card-body table-responsive">
					<div class="d-flex justify-content-between align-items-center">
						<h5 class="card-title">
							SEARCH RESULT <span>| DISTINCTIVE NUMBERS (DNO) LIST</span>
						</h5>
					</div>
					<table class="table table-borderless datatable overflow-scroll">
						<thead class="table-light">
							<tr style="font-family: 'Poppins', sans-serif;">
								<th scope="col">SR.NO</th>
								<th scope="col">CUSTOMER CODE</th>
								<th scope="col">MEMBER NAME</th>
								<th scope="col">SHARE DATE</th>
								<th scope="col">NO. OF SHARE</th>
								<th scope="col">SHARE AMT</th>
								<th scope="col">CERTIFICATE NO</th>
								<th scope="col">DISTINCTIVE NO (DNO) RANGE</th>
							</tr>
						</thead>
						<tbody id="dnoTableBody">
						</tbody>
					</table>
				</div>
			</div>
			<button type="button" class="btn btn-warning mt-3" id="printbtn"
				style="float: right;">
				<i class="fa-solid fa-print"></i> PRINT DNO REPORT
			</button>
		</div>
	</div>
</div>
<script
	src="${pageContext.request.contextPath}/js/CustomerShareHolding/regenerateDNO.js"></script>