
<div class="pagetitle">
	<h1>Joint Liability Loan</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-person-bounding-box"></i>
			</a></li>
			<li class="breadcrumb-item action">Find Loan Record</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Loan Search for Print</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Loan Branch*</label>
						<div class="position-relative">
							<div class="select-btn1" style="cursor: pointer;">
								<span name="loanName" id="loanNameId" style="font-size: 12px;">Select
									GroupID</span> <i class="fa-solid fa-angle-down"></i>
							</div>
							<div class="content" id="contentCityName" style="display: none;">
								<div class="search">
									<input type="text" id="city-search" class="m-0"
										placeholder="Search" />
								</div>
								<ul class="options" id="city-options">
									<!-- Options will be dynamically added here -->

								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Start Date:</label> <input type="date"
							name="vehicalNo" id="vehicalNo" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">End Date :</label> <input type="date"
							name="vehicalNo" id="vehicalNo" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Customer Name:</label> <input type="date"
							name="vehicalNo" id="vehicalNo" required="required"
							placeholder="Enter Vehicle No" style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Loan Reference No.*</label>
						<div class="position-relative">
							<div class="select-btn1" style="cursor: pointer;">
								<span name="loanName" id="loanNameId" style="font-size: 12px;">Select
									GroupID</span> <i class="fa-solid fa-angle-down"></i>
							</div>
							<div class="content" id="contentCityName" style="display: none;">
								<div class="search">
									<input type="text" id="city-search" class="m-0"
										placeholder="Search" />
								</div>
								<ul class="options" id="city-options">
									<!-- Options will be dynamically added here -->

								</ul>
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Customer code:</label> <input type="text"
							name="membercode" id="vehicalNo" required="required"
							placeholder="Enter membercode" style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Scheme Name:</label> <input type="text"
							name="vehicalNo" id="vehicalNo" required="required"
							placeholder="Enter plan name" style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Agent Code:</label> <input type="text"
							name="vehicalNo" id="vehicalNo" required="required"
							placeholder="Enter Advisor code"
							style="text-transform: uppercase;" />
					</div>
				</div>



			</div>
			<div class="row">
				<div class="col-12 text-center">

					<button id="saveBtn" class="btnStyle"
						style="background-color: #FFA500;">
						<i class="bi bi-search"></i>Serach
					</button>

				</div>
			</div>


		</div>




	</form>
	<div class="row mt-5">
		<div class="col-12">
			<div class="card recent-sales">

				<div class="card-body table-responsive">
					<h5 class="card-title">Serach Result</h5>

					<table class="table table-borderless datatable overflow-scroll">
						<thead class="table-light">
							<tr style="font-family: 'Poppins', sans-serif;">
								<th scope="col">#</th>
								<th scope="col">Customer</th>
								<th scope="col">Product</th>
								<th scope="col">Price</th>
								<th scope="col">Status</th>
								<th scope="col">Action</th>
							</tr>
						</thead>
						<tbody>
							<tr style="font-family: 'Poppins', sans-serif;">
								<th scope="row"><a href="#">1</a></th>
								<td>Arun Kumar</td>
								<td><a href="#" className="text-primary">Milk</a></td>
								<td>$29</td>
								<td><span class="badge bg-success text-white">Approved</span>
								</td>
								<td class="d-flex" style="gap: .7rem;">
									<button class="iconbutton">
										<i class="fa-solid fa-pen-to-square text-success"></i>
									</button>
									<button class="iconbutton">
										<i class="fa-solid fa-eye text-primary"></i>
									</button>
									<button class="iconbutton">
										<i class="fa-solid fa-trash text-danger"></i>
									</button>
								</td>
							</tr>

							<tr>
								<th scope="row"><a href="#">2</a></th>
								<td>Deepak Dalwe</td>
								<td><a href="#" className="text-primary">Ghee</a></td>
								<td>$16.5</td>
								<td><span class="badge bg-danger text-white">Rejected</span>
								</td>
								<td class="d-flex" style="gap: .7rem;">
									<button class="iconbutton">
										<i class="fa-solid fa-pen-to-square text-success"></i>
									</button>
									<button class="iconbutton">
										<i class="fa-solid fa-eye text-primary"></i>
									</button>
									<button class="iconbutton">
										<i class="fa-solid fa-trash text-danger"></i>
									</button>
								</td>
							</tr>
							<tr>
								<th scope="row"><a href="#">2</a></th>
								<td>Deepak Dalwe</td>
								<td><a href="#" className="text-primary">Ghee</a></td>
								<td>$16.5</td>
								<td><span class="badge bg-danger text-white">Rejected</span>
								</td>
								<td class="d-flex" style="gap: .7rem;">
									<button class="iconbutton">
										<i class="fa-solid fa-pen-to-square text-success"></i>
									</button>
									<button class="iconbutton">
										<i class="fa-solid fa-eye text-primary"></i>
									</button>
									<button class="iconbutton">
										<i class="fa-solid fa-trash text-danger"></i>
									</button>
								</td>
							</tr>
							<tr>
								<th scope="row"><a href="#">2</a></th>
								<td>Deepak Dalwe</td>
								<td><a href="#" className="text-primary">Ghee</a></td>
								<td>$16.5</td>
								<td><span class="badge bg-danger text-white">Rejected</span>
								</td>
								<td class="d-flex" style="gap: .7rem;">
									<button class="iconbutton">
										<i class="fa-solid fa-pen-to-square text-success"></i>
									</button>
									<button class="iconbutton">
										<i class="fa-solid fa-eye text-primary"></i>
									</button>
									<button class="iconbutton">
										<i class="fa-solid fa-trash text-danger"></i>
									</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>

</div>
<script
	src="${pageContext.request.contextPath}/js/Joinlibiliy/findLoanRecords.js"></script>