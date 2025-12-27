
		<div class="pagetitle">
			<h1>Preferences</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="openDashboard"> <i
							class="bi bi-gear"></i>
					</a></li>
					<li class="breadcrumb-item action">Create Branch</li>
				</ol>
			</nav>
		</div>

		<div>
			<form id="formid">
				<div>
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action">Branch Details</li>
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
							<input type="hidden" name="id" id="id">
							<div class="d-flex flex-column formFields">
								<label for="">Branch Code <span class="star">*</span></label> <input
									type="text" name="branchCode" id="branchCode"
									required="required" placeholder="Enter Branch Code"
									style="text-transform: uppercase;" /> <small id="chkbranchcode"
									style="color: red;"></small>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields"
								style="margin-bottom: 30px">
								<label>Branch Name <span class="star">*</span></label> <input
									type="Text" name="branchName" id="branchName"
									required="required" placeholder="Enter Branch Name"
									style="text-transform: uppercase;" /> <small id="chkbranchName"
									style="color: red;"></small>
							</div>
						</div>



						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Opening Date <span class="star">*</span></label> <input
									type="date" name="openingDate" id="openingDate"
									required="required" style="text-transform: uppercase;" /> <small
									id="chkopeningdate" style="color: red;"></small>
							</div>
						</div>


						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Address <span class="star">*</span></label>
								<textarea name="address" id="address"
									style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px; text-transform: uppercase;"></textarea>
								<small id="chkaddress" style="color: red;"></small>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">PIN <span class="star">*</span></label> <input
									type="text" name="pin" id="pin" required="required"
									placeholder="Enter Pin" style="text-transform: uppercase;" /> <small
									id="chkpin" style="color: red;"></small>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="state">State <span class="star">*</span></label> <select
									id="state" name="state" class="form-control selectField"
									style="height: 30px;">
									<option value="">Select State</option>
									<option value="MAHARASHTRA">MAHARASHTRA</option>
									<option value="RAJASTHAN">RAJASTHAN</option>
									<option value="PUNJAB">PUNJAB</option>
									<option value="GUJARAT">GUJARAT</option>
									<option value="ODISHA">ODISHA</option>
									<option value="ANDAMAN & NICOBAR">ANDAMAN & NICOBAR</option>
								</select> <small id="chkstate" style="color: red;"></small>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Branch Manager Contact No <span
									class="star">*</span></label> <input type="text"
									name="branchManagerContactNo" id="branchManagerContactNo"
									required="required"
									placeholder="Enter Branch Manager Contact No" /> <small
									id="chkbranchManager" style="color: red;"></small>
							</div>
						</div>

						<div class="col-lg-3">
							<div class="d-flex flex-column formFields">
								<label for="">Account Department Contact No <span
									class="star">*</span></label> <input type="text"
									name="accountDepartmentContactNo"
									id="accountDepartmentContactNo" required="required"
									placeholder="Enter Account Department Contact No" /> <small
									id="chkaccountDepartment" style="color: red;"></small>
							</div>
						</div>

					</div>



					<div class="row" style="margin-top: 30px;">
						<div class="col-12 text-center">
							<button type="button" id="showBtn" class="btnStyle bg-primary"
								onclick="showTableData()">Show</button>
							<button type="button" id="hideBtn" class="btnStyle bg-success"
								onclick="hideTableData()">Hide</button>
							<button type="button" id="saveBtn" class="btnStyle bg-warning">Save</button>
							<button type="button" id="updateBtn" class="btnStyle bg-success"
								onclick="updateBranch()">Update</button>
						</div>
					</div>
			</form>



		</div>


		<div class="row mt-5">
			<div class="col-12">
				<div class="card recent-sales">

					<div class="card-body table-responsive">
						<h5 class="card-title">
							Branch Data <span>| Table View</span>
						</h5>

						<table class="table table-borderless datatable overflow-scroll">
							<thead class="table-light">
								<tr style="font-family: 'Poppins', sans-serif;">
									<th scope="col">Sr No</th>
									<th scope="col">Branch Code</th>
									<th scope="col">Branch Name</th>
									<th scope="col">Opening Date</th>
									<th scope="col">Address</th>
									<th scope="col">Pin Code</th>
									<th scope="col">State</th>
									<th scope="col">Primary Contact</th>
									<th scope="col">Contact</th>
									<th scope="col">Edit</th>
									<th scope="col">Delete</th>
								</tr>
							</thead>
							<tbody id="tableBody">

							</tbody>
						</table>
						<div class="mt-2 text-center">
							<button id="prevBtn" class="btn btn-sm btn-primary">
								<i class="bi bi-chevron-double-left"></i>
							</button>
							<span id="pageInfo" class="mx-2"></span>
							<button id="nextBtn" class="btn btn-sm btn-primary">
								<i class="bi bi-chevron-double-right"></i>
							</button>
						</div>
					</div>
				</div>
			</div>
		</div>
<script src="${pageContext.request.contextPath}/js/preferences/branch.js"></script>