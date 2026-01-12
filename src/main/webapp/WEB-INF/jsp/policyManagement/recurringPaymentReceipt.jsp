
<div class="pagetitle">
	<h1>POLICY MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-piggy-bank"></i>
			</a></li>
			<li class="breadcrumb-item action">RECURRING PAYMENT RECEIPT </li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">PRINT SEARCH RESULTS</li>
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
							<label for="">FIND BY POLICY CODE <span class="star">*</span></label>
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

			<div class="row mt-5" id="policyDataRow">
				<div class="col-12">
					<div class="card recent-sales">
						<div class="card-body table-responsive">
							<h5 class="card-title">
								RECURRING POLICY DETAILS  <span>| TABLE VIEW</span>
							</h5>

							<table class="table table-bordered" style="text-align: center;">
								<thead class="table-light">
									<tr>
										<th style="white-space: nowrap;">SR. NO</th>
										<th style="white-space: nowrap;">POLICY CODE</th>
										<th style="white-space: nowrap;">CUSTOMER NAME</th>
										<th style="white-space: nowrap;">PAYMENT DATE</th>
										<th style="white-space: nowrap;">POLICY AMOUNT</th>
										<th style="white-space: nowrap;">PLAN CODE</th>
										<th style="white-space: nowrap;">MATURITY DATE</th>
										<th style="white-space: nowrap;">MATURITY AMOUNT</th>
										<th style="white-space: nowrap;">TIME DURATION</th>
										<th style="white-space: nowrap;">BRANCH</th>
										<th style="white-space: nowrap;">PAYMENT MODE</th>
										<th style="white-space: nowrap;">PRINT RECEIPT</th>
									</tr>
								</thead>
								<tbody id="policyTableBody">
									<!-- Dynamic rows will be injected here -->
								</tbody>
							</table>

						</div>
					</div>

				</div>
			</div>

			<!-- RD Receipt Template -->
			<div id="receiptTemplate"
				style="display: none; font-family: 'Poppins', sans-serif;">
				<div
					style="width: 650px; margin: auto; padding: 20px; border: 2px solid #000; border-radius: 8px;">
					<h2 style="text-align: center; margin-bottom: 10px;">Recurring
						Deposit (RD) Receipt</h2>
					<hr>
					<p>
						<b>Policy Code:</b> <span id="rPolicyCode"></span>
					</p>
					<p>
						<b>Customer Name:</b> <span id="rCustomerName"></span>
					</p>
					<p>
						<b>Payment Date:</b> <span id="rPaymentDate"></span>
					</p>
					<p>
						<b>Policy Amount:</b> &#8377; <span id="rPolicyAmount"></span>
					</p>
					<p>
						<b>Plan Code:</b> <span id="rPlanCode"></span>
					</p>
					<p>
						<b>Maturity Date:</b> <span id="rMaturityDate"></span>
					</p>
					<p>
						<b>Maturity Amount:</b> &#8377; <span id="rMaturityAmount"></span>
					</p>
					<p>
						<b>Duration:</b> <span id="rDuration"></span>
					</p>
					<p>
						<b>Branch:</b> <span id="rBranchName"></span>
					</p>
					<p>
						<b>Mode of Payment:</b> <span id="rModeOfPayment"></span>
					</p>
					<br> <br>
					<p style="text-align: right; margin-top: 40px;">
						<b>Authorized Signature</b>
					</p>
				</div>
			</div>

		</div>

	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/PolicyManagment/recurringPaymentReceipt.js"></script>