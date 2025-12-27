
		<div class="pagetitle">
			<h1>Customer Shareholding</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="openDashboard"> <i
							class="bi bi-building-fill-down"></i>
					</a></li>
					<li class="breadcrumb-item action">Unalloatted Share</li>
				</ol>
			</nav>
		</div>
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Box</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-6">
					<div class="d-flex flex-column formFields">
						<label for="">Select Decision Maker :</label> <select
							id="selectDecisionMaker" name="selectDecisionMaker" required="required"
							class="form-control selectField mb-4" style="height: 30px;">
							<option value="">Select</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-3">
					<button id="searchBtn" class="btnStyle"
						style="background-color: #FFA500;">
						<i class="bi bi-search"></i> Search
					</button>
				</div>
			</div>

			<div class="row mt-5">
				<div class="col-12">
					<div class="card recent-sales">
						<div class="card-body table-responsive">
							<div class="d-flex justify-content-between align-items-center">
								<h5 class="card-title">
									Search Result <span>|share data List</span>
								</h5>
							</div>
							<table class="table table-borderless datatable overflow-scroll">
								<thead class="table-light">
									<tr style="font-family: 'Poppins', sans-serif;">
										<th scope="col">Sr No.</th>
										<th scope="col">Customer Name</th>
										<th scope="col">Customer Code</th>
										<th scope="col">Start Date</th>
										<th scope="col">Date of Transfer</th>
										<th scope="col">No. Of Share</th>
										<th scope="col">Share Amount</th>			
									</tr>
								</thead>
								<tbody>
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>
		</div>
<script
	src="${pageContext.request.contextPath}/js/CustomerShareHolding/UnAllotedShare.js"></script>