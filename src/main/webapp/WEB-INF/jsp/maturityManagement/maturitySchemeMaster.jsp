
<div class="pagetitle">
	<h1>Maturity Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-calendar-check"></i>
			</a></li>
			<li class="breadcrumb-item action">Maturity Scheme Master</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formdd">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Daily Deposit</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields">
						<label for="">Policy Code <span id="star"> *</span></label> <select
							id="ddPolicyCode" name="ddPolicyCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Policy Code</option>
						</select> <small id="chkpolicycodeD" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Inst.From <span id="star"> *</span></label>
						<select id="ddInstFrom" name="ddInstFrom" required="required"
							class="form-control selectField monthname" style="height: 30px;">
							<option value="">Select Month</option>
						</select> <small id="finstallD" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Inst. To <span id="star"> *</span></label> <select
							id="ddInstTo" name="ddInstTo" required="required"
							class="form-control selectField monthname" style="height: 30px;">
							<option value="">Select Month</option>
						</select> <small id="tinstallD" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Interest Rate <span id="star"> *</span>( in
							% )
						</label> <input type="text" name="ddInterestRate" id="ddInterestRate"
							required="required" placeholder="Enter ROI" /> <small
							id="chkintrestD" style="color: red;"></small>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Deduction ( in % )</label> <input type="text"
							name="ddDeduction" id="ddDeduction" required="required"
							placeholder="Enter Deduction" /> <small id="chkdeductionD"
							style="color: red;"></small>
					</div>
				</div>

			</div>
			<div class="row">
				<div class="col-12 text-center">
					<button id="ddsaveBtn" class="btnStyle bg-info">Save</button>
				</div>
			</div>
		</div>

	</form>


	<form id="formrd">
		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Recurring Deposite</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields">
						<label for="">Policy Code <span id="star"> *</span></label> <select
							id="rdPolicyCode" name="rdPolicyCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">GROW</option>
						</select> <small id="chkpolicycodeR" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Inst.From <span id="star"> *</span></label>
						<select id="rdInstFrom" name="rdInstFrom" required="required"
							class="form-control selectField monthname" style="height: 30px;">
							<option value="">Select Month</option>
						</select> <small id="finstallR" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Inst. To <span id="star"> *</span></label> <select
							id="rdInstTo" name="rdInstTo" required="required"
							class="form-control selectField monthname" style="height: 30px;">
							<option value="">Select Month</option>
						</select> <small id="tinstallR" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Interest Rate <span id="star"> *</span>( in
							% )
						</label> <input type="text" name="rdInterestRate" id="rdInterestRate"
							required="required" placeholder="Enter ROI" /> <small
							id="chkintrestR" style="color: red;"></small>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Deduction( in % )</label> <input type="text"
							name="rdDeduction" id="rdDeduction" required="required"
							placeholder="Enter Deduction" /> <small id="chkdeductionR"
							style="color: red;"></small>

					</div>

				</div>

			</div>

			<div class="row">
				<div class="col-12 text-center">
					<button id="rdsaveBtn" class="btnStyle bg-info">Save</button>
				</div>
			</div>
		</div>
	</form>

	<form id="formfd">
		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Fixed Deposit</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields">
						<label for="">Policy Code <span id="star"> *</span></label> <select
							id="fdPolicyCode" name="fdPolicyCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Policy Code</option>
						</select> <small id="chkpolicycodeF" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Months From <span id="star">
								*</span></label> <select id="fdInstFrom" name="fdInstFrom" required="required"
							class="form-control selectField monthname" style="height: 30px;">
							<option value="">Select Month</option>
						</select> <small id="finstallF" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Months To <span id="star"> *</span></label> <select
							id="fdInstTo" name="fdInstTo" required="required"
							class="form-control selectField monthname" style="height: 30px;">
							<option value="">Select Month</option>
						</select> <small id="tinstallF" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Interest Rate <span id="star"> *</span>( in
							% )
						</label> <input type="text" name="fdInterestRate" id="fdInterestRate"
							required="required" placeholder="Enter ROI" /> <small
							id="chkintrestF" style="color: red;"></small>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Deduction ( in % )</label> <input type="text"
							name="fdDeduction" id="fdDeduction" required="required"
							placeholder="Enter Deduction" /> <small id="chkdeductionF"
							style="color: red;"></small>
					</div>

				</div>

			</div>

			<div class="row">
				<div class="col-12 text-center">
					<button id="fdsaveBtn" class="btnStyle bg-info">Save</button>
				</div>
			</div>
		</div>
	</form>



	<form id="formmis">
		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">MIS Deposit</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields">
						<label for="">Policy Code <span id="star"> *</span></label> <select
							id="mPolicyCode" name="mPolicyCode" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">ALL</option>
						</select> <small id="chkpolicycodeM" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="vehicalNo">Months From <span id="star">
								*</span></label> <select id="misInstFrom" name="misInstFrom"
							required="required" class="form-control selectField monthname"
							style="height: 30px;">
							<option value="">Select Month</option>
						</select> <small id="finstallM" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Months To <span id="star"> *</span></label> <select
							id="misInstTo" name="misInstTo" required="required"
							class="form-control selectField monthname" style="height: 30px;">
							<option value="">Select Month</option>
						</select> <small id="tinstallM" style="color: red;"></small>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Interest Rate <span id="star"> *</span>( in
							% )
						</label> <input type="text" name="misInterestRate" id="misInterestRate"
							required="required" placeholder="Enter ROI" /> <small
							id="chkintrestM" style="color: red;"></small>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">
						<label>Deduction ( in % )</label> <input type="text"
							name="misDeduction" id="misDeduction" required="required"
							placeholder="Enter Deduction" /> <small id="chkdeductionM"
							style="color: red;"></small>

					</div>

				</div>

			</div>

			<div class="row">
				<div class="col-12 text-center">
					<button id="missaveBtn" class="btnStyle bg-info">Save</button>
				</div>
			</div>
		</div>


	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/MaturityManagement/maturityscheme.js"></script>