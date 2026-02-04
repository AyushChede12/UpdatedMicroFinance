

<div class="pagetitle">
	<h1>SAVING / CURRENT ACCOUNT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-bank text-blue"></i>
			</a></li>
			<li class="breadcrumb-item action">CUSTOMER SAVINGS STATEMENT</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">SEARCH BOX</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">SELECT ACCOUNT NUMBER</label> <select
							id="accountNumber" name="accountNumber" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">--SELECT ACCOUNT NO--</option>
						</select>
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col-lg-6 text-center">
					<button id="searchByAccNo" class="btn btn-warning"
						style="margin-left: 80%;">SEARCH</button>
				</div>
			</div>

		</div>

		<div class="row mt-5">
			<div class="col-12">
				<div class="card recent-sales">

					<div class="card-body table-responsive">
						<h5 class="card-title">
							SAVING STATEMENT <span>| TODAY</span>
						</h5>
						<div class="form-div" id="form-div" style="margin-top: 20px;">
							<div class="form-header">
								<h2 style="color: red; margin-top: 0px;">MICROFINANCE
									SOFTWARE</h2>
								<p style="margin-top: -10px">NAGPUR</p>
							</div>
							<div class="form-div-main" style="padding: 5px;">
								<div
									style="display: flex; text-align: center; justify-item: center; width: 100%; border-bottom: 2px solid black; padding-bottom: 10px;">
									<h4 style="margin: auto;">NEW RECEIPT</h4>
								</div>

								<div style="width: 55%; float: left; padding-top: 20px;">
									<p style="font-weight: 600;">
										ACCOUNT NO : <span id="accountNoDisplay"></span>
									</p>
									<p style="font-weight: 600;">
										A/C HOLDER NAME : <span id="memberName"></span>
									</p>
									<p style="font-weight: 600;">
										RELATIVE NAME/RELATION : <span id="relativeDetails"></span>
									</p>
									<p style="font-weight: 600;">
										ADDRESS :<span id="address"></span>
									</p>
								</div>


								<div style="width: 43%; float: right; padding-top: 20px;+">
									<!-- <p style="font-weight: 600;">Print Date : <span></span></p> -->
									<p style="font-weight: 600;">
										OP. DATE : <span id="opDate"></span>
									</p>
									<p style="font-weight: 600;">
										CUSTOMER CODE : <span id="selectMember"></span>
									</p>
									<!-- <p style="font-weight: 600;">
														PAN : <span id="pan"></span>
													</p> -->
									<p style="font-weight: 600;">
										MODE OF OP. : <span id="modeOfOp"></span>
									</p>
									<p style="font-weight: 600;">
										OP. BRANCH : <span id="BranchName"></span>
									</p>


									<!-- <p style="font-weight: 600;">Consideration Amount : 36500</p> -->
									<!-- <p style="font-weight: 600;">Transaction Date : 22/11/2024</p> -->
									<!-- <p style="font-weight: 600;">Maturity Date : 21/11/2025</p> -->
								</div>
								<div
									style="width: 200px; height: 150px; display: flex; flex-direction: column; text-align: center; font-weight: 600;">
									<div
										style="width: 800%; height: 40px; border-bottom: 2px solid black;">
									</div>


								</div>
								<div class="box-body">
									<div class="clearfix margin-bottom-10"
										style="margin-top: -50px;"></div>
									<table class="table table-borderless datatable overflow-scroll">
										<thead class="table-light">
											<tr style="font-family: 'Poppins', sans-serif;">
												<th scope="col">ACCOUNT NO.</th>
												<th scope="col">TXN DATE</th>
												<th scope="col">CREDIT</th>
												<th scope="col">DEBIT</th>
												<th scope="col">BALANCE</th>
												<th scope="col">PAYMODE</th>
												<th scope="col">BRANCH</th>
												<th scope="col">REMARKS</th>
											</tr>
										</thead>
										<tbody id="tableSavingAcc">

										</tbody>
									</table>
								</div>
							</div>

						</div>

						<table class="table table-borderless datatable overflow-scroll">

						</table>
					</div>
				</div>
			</div>
		</div>
	</form>

</div>
<script
	src="${pageContext.request.contextPath}/js/customerSavings/savingsAccountStatement.js"></script>