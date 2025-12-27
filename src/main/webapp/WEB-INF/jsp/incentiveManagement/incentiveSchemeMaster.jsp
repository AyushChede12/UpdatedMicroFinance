
<div class="pagetitle">
	<h1>Incentive Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-award"></i>
			</a></li>
			<li class="breadcrumb-item action">Incentive Scheme Master</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Incentive Master</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Incentive Month</label> <select id="incentiveMonth"
							name="incentiveMonth" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>

						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">Date From</label> <input type="date"
							name="dateFrom" id="dateFrom" required="required"
							placeholder="Enter Date From" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="vehicalNo">Date To</label> <input type="date"
							name="dateTo" id="dateTo" required="required"
							placeholder="Enter Date To" style="text-transform: uppercase;" />
					</div>
				</div>

				<!-- <div class="col-lg-3">
              <div class="d-flex flex-column formFields" style="margin-bottom: 30px">
                <label for="vehicalNo">To Date</label>
                <div class="position-relative">
                  <input type="date" name="vehicalNo" id="vehicalNo" required="required" placeholder="Enter Vehicle No"
                  style="text-transform: uppercase;" />
                </div>
              </div>
            </div> -->

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Comments </label> <input type="text" name="comments"
							id="comments" required="required" placeholder="Enter Comments" />
					</div>

				</div>



				<div class="row" style="margin-left: 45%;">
					<div class="col-12 text-center">
						<button id="saveBtn" class="btn btn-info ">Save</button>
					</div>
				</div>



				<table class="table table-borderless datatable overflow-scroll"
					style="margin-top: 30px;">
					<thead class="table-light">
						<tr style="font-family: 'Poppins', sans-serif;">
							<th scope="col">S/N</th>
							<th scope="col">Incentive Month</th>
							<th scope="col">Date From</th>
							<th scope="col">Date To</th>
							<th scope="col">Comments</th>

						</tr>
					</thead>
					<tbody id="incentiveTableBody">

					</tbody>
				</table>
			</div>
		</div>
	</form>
</div>
<script
	src="${pageContext.request.contextPath}/js/incentive/incentiveSchemeMaster.js"></script>

