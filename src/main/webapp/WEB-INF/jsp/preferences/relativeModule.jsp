
<div class="pagetitle">
	<h1>Preferences</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-gear"></i>
			</a></li>
			<li class="breadcrumb-item action">Relative Module</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Relative</li>
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
						<label for="">Add Relation <span class="star">*</span></label> <input
							type="text" name="relation" id="relation"
							placeholder="Enter Relation" style="text-transform: uppercase;" />
						<small id="chkrelation" style="color: red;"></small>
					</div>
				</div>

				<div class="row" style="margin-top: 15px; margin-left: 10px;">
					<div class="col-12 text-center">
						<button type="button" id="saveBtn" class="btnStyle bg-warning"
							onclick="saveRelative()">Add</button>
						<button type="button" id="updateBtn" class="btnStyle bg-success"
							onclick="updateRelative()">Update</button>
					</div>
				</div>

				<!-- <div class="col-lg-3">
                            <div class="d-flex flex-column formFields" style="margin-bottom: 30px">

                                <button id="saveBtn" class="btnStyle bg-primary">Add</button>

                            </div>
                        </div> -->









			</div>


			<div class="mt-5">
				<div class="row mt-5">
					<div class="col-12">
						<div class="card recent-sales">

							<div class="card-body table-responsive">
								<h5 class="card-title">
									Relative Details <span>| Table View</span>
								</h5>

								<table class="table table-borderless datatable overflow-scroll">
									<thead class="table-light">
										<tr style="font-family: 'Poppins', sans-serif;">
											<th scope="col">Sr No</th>
											<th scope="col">Relation</th>
											<th scope="col">Edit</th>
											<th scope="col">Delete</th>
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
	</form>

</div>
<script
	src="${pageContext.request.contextPath}/js/preferences/relative.js"></script>