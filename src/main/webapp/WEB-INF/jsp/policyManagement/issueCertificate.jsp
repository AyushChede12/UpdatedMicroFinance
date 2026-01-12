
		<div class="pagetitle">
			<h1>POLICY MANAGEMENT</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="openDashboard"> <i
							class="bi bi-piggy-bank"></i>
					</a></li>
					<li class="breadcrumb-item action">ISSUE CERTIFICATE </li>
				</ol>
			</nav>
		</div>

		<div>
			<form id="formid">
				<div>
					<nav>
						<ol class="breadcrumb breadcrumb-title">
							<li class="breadcrumb-item action">PRINT SEARCH RESULTS </li>
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


							<div class="col-lg-12 mb-4 ">
								<div class="d-flex flex-column formFields">
									<label for="">FIND bB POLICY CODE <span class="star">*</span></label>
									<select id="policyCode" name="policyCode" required="required"
										class="form-control selectField" style="height: 30px;">
										<option value="">SELECT POLICY CODE</option>

									</select>
								</div>
							</div>







						</div>

						<div class="row" style="margin-top: 20px; margin-left: 750px;">
							<div class="col-12 text-center">
								<button type="button" id="findBtn" class="btn btn-dark">FIND</button>
							</div>
						</div>

					</div>

					<div class="mt-5">
						<div class="row" id="policyDataRow">
							<div class="col-lg-12">
								<!-- Scrollable table wrapper -->
								<div style="overflow-x: auto; max-height: 400px;">
									<table class="table table-bordered table-striped"
										id="policyTable">
										<thead class="thead-dark"
											style="position: sticky; top: 0; background-color: #343a40; color: white;">
											<tr>
												<th>POLICY CODE</th>
												<th>CUSTOMER NAME</th>
												<th>POLICY AMOUNT</th>
												<th>MATURITY DATE</th>
												<th>MATURITY AMOUNT</th>
												<th>CONTACT NO.</th>
												<th>NOMINEE</th>
												<th>ADDRESS</th>
												<th>ACTION</th>
											</tr>
										</thead>
										<tbody id="policyTableBody">
											<!-- Data will be inserted here -->
										</tbody>
									</table>
								</div>
								<!-- Certificate Template (hidden, will be cloned for print) -->

							</div>
						</div>
					</div>
					<div id="certificateTemplate"
						style="font-family: Arial, sans-serif; padding: 30px;">
						<div
							style="border: 3px solid black; padding: 20px; border-radius: 10px; text-align: center;">
							<h2 style="text-decoration: underline;">POLICY ISSUE
								CERTIFICATE</h2>
							<p>THIS IS TO CERTIFY THAT</p>
							<h3 id="certClientName"></h3>
							<p>
								IS THE HOLDER OF POLICY CODE<strong id="certPolicyCode"></strong>.
							</p>
							<p>
								POLICY AMOUNT: <strong id="certPolicyAmount"></strong>
							</p>
							<p>
								MATURITY AMOUNT: <strong id="certMaturityAmount"></strong>
							</p>
							<p>
								MATURITY DATE: <strong id="certMaturityDate"></strong>
							</p>
							<p>
								CONTACT NO: <strong id="certContact"></strong>
							</p>
							<p>
								NOMINEE: <strong id="certNominee"></strong>
							</p>
							<p>
								ADDRESS: <strong id="certAddress"></strong>
							</p>
							<br> <br>
							<p style="text-align: right;">AUTHORIZED SIGNATURE</p>
						</div>
					</div>
				</div>

			</form>

		</div>

	<script
	src="${pageContext.request.contextPath}/js/PolicyManagment/issueCertificate.js"></script>
