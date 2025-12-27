
		<div class="pagetitle">
			<h1>Preferences</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="openDashboard"> <i
							class="bi bi-gear"></i>
					</a></li>
					<li class="breadcrumb-item action">Financial Year</li>
				</ol>
			</nav>
		</div>

		<div>
			<form id="formid">
				<div>
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action">Enter Details</li>
						</ol>
					</nav>
					<div class="row">
						<div class="col-lg-3">
							<!-- <div class="d-flex flex-column formFields" style="margin-bottom: 30px">
                <label>Verify With</label>
                <div class="position-relative">
                  <div class="select-btn1" style="cursor: pointer;">
                    <span name="cityName" id="cityNameId" style="font-size: 12px;">Select</span> <i
                      class="fa-solid fa-angle-down"></i>
                  </div>
                  <div class="content" id="contentCityName" style="display: none;">
                    <div class="search">
                      <input type="text" id="city-search" class="m-0" placeholder="Search City" />
                    </div>
                    <ul class="options" id="city-options">
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                      <li>ABC</li>
                    </ul>
                  </div>
                </div>
              </div> -->
							<input type="hidden" id="id" name="id">
							<div class="d-flex flex-column formFields">
								<label for="">Financial Year Name <span class="star">*</span></label>
								<input type="text" name="financialYearName"
									id="financialYearName" required="required"
									placeholder="Enter Financial Year Name"
									style="text-transform: uppercase;" /> <small id="chkfyname"
									style="color: red;"></small>
							</div>

						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px">
								<label>Date From <span class="star">*</span></label> <input
									type="date" name="fromDate" id="fromDate" required="required"
									placeholder="Enter Date From"
									style="text-transform: uppercase;" /> <small id="chkdatefrom"
									style="color: red;"></small>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px">
								<label>Date To <span class="star">*</span></label> <input
									type="date" name="toDate" id="toDate" required="required"
									placeholder="Enter Date To" style="text-transform: uppercase;" />
								<small id="chkdateto" style="color: red;"></small>
							</div>
						</div>


						<div class="col-lg-3" style="margin-top: 15px;">
							<div class="col-12 text-center">
								<button id="addBtn" class="btnStyle bg-warning"
									onclick="saveFinancialYear()">Add</button>
								<button type="button" id="updateBtn" class="btnStyle bg-success"
									onclick="updateFY()">Update</button>
							</div>
						</div>

					</div>

					<div class="mt-5">
						<div class="row">
							<div class="col-12">
								<div class="card recent-sales">

									<div class="card-body table-responsive">
										<h5 class="card-title">
											Financial Year Data <span>| Table View</span>
										</h5>

										<table
											class="table table-borderless datatable overflow-scroll">
											<thead class="table-light">
												<tr style="font-family: 'Poppins', sans-serif;">
													<th scope="col">Sr No</th>
													<th scope="col">Financial Year Name</th>
													<th scope="col">Date From</th>
													<th scope="col">Date To</th>
													<th scope="col">Edit</th>
												</tr>
											</thead>
											<tbody id="tableBody">

											</tbody>
										</table>
									</div>
								</div>
							</div>

						</div>
					</div>
				</div>


			</form>



		</div>
<script src="${pageContext.request.contextPath}/js/preferences/financialYear.js"></script>
