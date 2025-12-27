
<div class="pagetitle">
	<h1>Incentive Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-award"></i>
			</a></li>
			<li class="breadcrumb-item action">Incentive Payment Details</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Incentive List Print</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>incentiveMonth</label> <select id="incentiveMonth"
							name="Incentive Month" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select</option>

						</select> </select>
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields ">
						<label for="">Code </label> <input type="text" name="code"
							id="code" required="required" placeholder="" />
					</div>

				</div>
			</div>
			<div class="row">
				<div class=" col-lg-3">
					<button id="saveBtn" class="btn btn-success">Update</button>
				</div>


			</div>
			<div class="row mt-5">
				<div class="col-12">
					<div class="card recent-sales">

						<div class="card-body table-responsive">
							<h5 class="card-title">
								Incentive Details <span>| Table View</span>
							</h5>

							<table class="table table-borderless datatable overflow-scroll">
								<thead class="table-light">
									<tr style="font-family: 'Poppins', sans-serif;">
										<th scope="col">S/N</th>
										<th scope="col">Month Name</th>
										<th scope="col">Code</th>
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
	</form>
</div>

<script
	src="${pageContext.request.contextPath}/js/incentive/incentivePaymentDetails.js"></script>