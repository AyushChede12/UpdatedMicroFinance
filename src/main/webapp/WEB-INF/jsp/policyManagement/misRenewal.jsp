
<div class="pagetitle">
	<h1>POLICY MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i class="bi bi-piggy-bank"></i> </a></li>
			<li class="breadcrumb-item action">MIS RENEWAL</li>
		</ol>
	</nav>
</div>

<style>
	.mis-status-badge { padding: 3px 10px; border-radius: 12px; font-size: 11px; font-weight: 700; letter-spacing: 0.5px; }
	.mis-status-active   { background:#d4edda; color:#155724; }
	.mis-status-matured  { background:#fff3cd; color:#856404; }
	.mis-status-closed   { background:#f8d7da; color:#721c24; }
	.mis-status-prematurely_closed { background:#f5c6cb; color:#491217; }
	.mis-status-renewed  { background:#cce5ff; color:#004085; }
	.mis-section-title   { font-family:'Poppins',sans-serif; font-size:12px; font-weight:700; background:#f4f6f9; padding:6px 12px; border-left:3px solid #0d6efd; margin-bottom:10px; }
	.mis-info-label      { font-size:11px; font-weight:700; color:#666; text-transform:uppercase; }
	.mis-info-value      { font-size:13px; font-weight:600; color:#222; }
	#misPolicyTable th, #misPolicyTable td { font-size:12px; }
	#misLedgerTable th, #misLedgerTable td { font-size:12px; }
	.mis-summary-card    { background:#f8f9fa; border-radius:8px; padding:14px; margin-bottom:10px; }
	.mis-summary-value   { font-size:18px; font-weight:700; color:#0d6efd; }
</style>

<div class="container-fluid">

	<!-- ══════════════════════════════════════════════════════════
	     SEARCH SECTION
	══════════════════════════════════════════════════════════ -->
	<div class="card mb-3">
		<div class="card-body">
			<div class="mis-section-title">SEARCH</div>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label class="mis-info-label">SEARCH BY CUSTOMER CODE</label>
						<select id="misSearchCustomer" name="misSearchCustomer"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT CUSTOMER CODE</option>
						</select>
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label class="mis-info-label">POLICY NUMBER</label>
						<select id="misSearchPolicy" name="misSearchPolicy"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT POLICY NUMBER</option>
						</select>
					</div>
				</div>
				<div class="col-lg-3 d-flex align-items-end">
					<button class="btn btn-primary btn-sm me-2" id="misSearchBtn">SEARCH</button>
					<button class="btn btn-secondary btn-sm" id="misLoadAllBtn">LOAD ALL</button>
				</div>
			</div>
		</div>
	</div>

	<!-- ══════════════════════════════════════════════════════════
	     POLICY LIST TABLE
	══════════════════════════════════════════════════════════ -->
	<div class="card mb-3">
		<div class="card-body">
			<div class="mis-section-title">MIS POLICY LIST</div>
			<div class="table-responsive">
				<table class="table table-hover table-bordered" id="misPolicyTable">
					<thead class="table-dark" style="font-size:11px;">
						<tr>
							<th>#</th>
							<th>POLICY NO.</th>
							<th>CUSTOMER</th>
							<th>PLAN</th>
							<th>PRINCIPAL (₹)</th>
							<th>ROI (%)</th>
							<th>MONTHLY PAYOUT (₹)</th>
							<th>START DATE</th>
							<th>MATURITY DATE</th>
							<th>NEXT PAYOUT</th>
							<th>STATUS</th>
						</tr>
					</thead>
					<tbody id="misPolicyTableBody">
						<tr><td colspan="11" class="text-center text-muted">Click "LOAD ALL" or search to view policies.</td></tr>
					</tbody>
				</table>
			</div>
			<!-- Action Buttons Below Table -->
			<div class="d-flex align-items-center mt-3 gap-2 flex-wrap">
				<button class="btn btn-primary btn-sm" id="misViewSelectedBtn" disabled>
					<i class="bi bi-eye"></i> VIEW
				</button>
				<button class="btn btn-primary btn-sm" id="misAddNextPayoutBtn" disabled style="font-weight:600;">
					<i class="bi bi-plus-circle"></i> ADD NEXT PAYOUT
				</button>
				<span id="selectedPolicyNotice" class="text-muted ms-2" style="font-size:12px;">Select a policy from table to perform actions.</span>
			</div>
		</div>
	</div>

	<!-- ══════════════════════════════════════════════════════════
	     POLICY DETAIL + SUMMARY + ACTIONS (shown after row click)
	══════════════════════════════════════════════════════════ -->
	<div id="misPolicyDetailSection" style="display:none;">
		<div class="row">
			<!-- Policy Details -->
			<div class="col-lg-6">
				<div class="card mb-3">
					<div class="card-body">
						<div class="mis-section-title">POLICY DETAILS</div>
						<div class="row g-2">
							<div class="col-6"><span class="mis-info-label">Policy Number</span><div class="mis-info-value" id="dpPolicyNumber">—</div></div>
							<div class="col-6"><span class="mis-info-label">Status</span><div id="dpStatus">—</div></div>
							<div class="col-6"><span class="mis-info-label">Customer Code</span><div class="mis-info-value" id="dpCustomerId">—</div></div>
							<div class="col-6"><span class="mis-info-label">Customer Name</span><div class="mis-info-value" id="dpCustomerName">—</div></div>
							<div class="col-6"><span class="mis-info-label">Plan Name</span><div class="mis-info-value" id="dpPlanName">—</div></div>
							<div class="col-6"><span class="mis-info-label">Tenure (Months)</span><div class="mis-info-value" id="dpTenure">—</div></div>
							<div class="col-6"><span class="mis-info-label">Interest Rate</span><div class="mis-info-value" id="dpRoi">—</div></div>
							<div class="col-6"><span class="mis-info-label">Payout Day</span><div class="mis-info-value" id="dpPayoutDay">—</div></div>
							<div class="col-6"><span class="mis-info-label">Lock-In (Months)</span><div class="mis-info-value" id="dpLockIn">—</div></div>
							<div class="col-6"><span class="mis-info-label">Nominee</span><div class="mis-info-value" id="dpNominee">—</div></div>
							<div class="col-6"><span class="mis-info-label">Start Date</span><div class="mis-info-value" id="dpStartDate">—</div></div>
							<div class="col-6"><span class="mis-info-label">Maturity Date</span><div class="mis-info-value" id="dpMaturityDate">—</div></div>
							<div class="col-6"><span class="mis-info-label">Principal Amount</span><div class="mis-info-value" id="dpPrincipal">—</div></div>
							<div class="col-6"><span class="mis-info-label">Monthly Payout</span><div class="mis-info-value" id="dpMonthlyPayout">—</div></div>
						</div>
					</div>
				</div>
			</div>

			<!-- Summary -->
			<div class="col-lg-6">
				<div class="card mb-3">
					<div class="card-body">
						<div class="mis-section-title">POLICY SUMMARY</div>
						<div class="row g-2">
							<div class="col-6">
								<div class="mis-summary-card text-center">
									<div class="mis-info-label">TOTAL INVESTED</div>
									<div class="mis-summary-value" id="smTotalInvested">₹0</div>
								</div>
							</div>
							<div class="col-6">
								<div class="mis-summary-card text-center">
									<div class="mis-info-label">TOTAL INTEREST EARNED</div>
									<div class="mis-summary-value" id="smTotalInterest">₹0</div>
								</div>
							</div>
							<div class="col-6">
								<div class="mis-summary-card text-center">
									<div class="mis-info-label">TOTAL TDS DEDUCTED</div>
									<div class="mis-summary-value" id="smTotalTds">₹0</div>
								</div>
							</div>
							<div class="col-6">
								<div class="mis-summary-card text-center">
									<div class="mis-info-label">NEXT PAYOUT DATE</div>
									<div class="mis-summary-value" style="font-size:14px;" id="smNextPayout">—</div>
								</div>
							</div>
							<div class="col-6">
								<div class="mis-summary-card text-center">
									<div class="mis-info-label">DAYS UNTIL MATURITY</div>
									<div class="mis-summary-value" id="smDaysMaturity">—</div>
								</div>
							</div>
							<div class="col-6">
								<div class="mis-summary-card">
									<div class="mis-info-label">LOCK-IN STATUS</div>
									<div class="mis-info-value" id="smLockInStatus">—</div>
									<small class="text-muted" id="smLockInEnd"></small>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- ── ACTIONS ROW ─────────────────────────────────────────────── -->
		<div class="row mb-3">
			<!-- Premature Close Panel (ACTIVE only) -->
			<div class="col-lg-6" id="misPrematureClosePanel" style="display:none;">
				<div class="card border-danger">
					<div class="card-header bg-danger text-white" style="font-size:12px; font-weight:700;">PREMATURE CLOSURE</div>
					<div class="card-body">
						<div id="pcLockInWarning" class="alert alert-warning" style="display:none; font-size:12px;">
							<strong>LOCK-IN ACTIVE:</strong> Premature closure not allowed until lock-in period ends on <span id="pcLockInEndDate"></span>.
						</div>
						<div id="pcCloseForm">
							<div class="row g-2 mb-2">
								<div class="col-6"><span class="mis-info-label">Penalty Rate</span><div class="mis-info-value" id="pcPenaltyRate">1%</div></div>
								<div class="col-6"><span class="mis-info-label">Penalty Amount (₹)</span><div class="mis-info-value" id="pcPenaltyAmount">—</div></div>
								<div class="col-6"><span class="mis-info-label">Principal (₹)</span><div class="mis-info-value" id="pcPrincipal">—</div></div>
								<div class="col-6"><span class="mis-info-label">Refund Amount (₹)</span><div class="mis-info-value text-success" id="pcRefundAmount">—</div></div>
							</div>
							<div class="mb-2">
								<label class="mis-info-label">CLOSURE REASON *</label>
								<textarea id="pcReason" class="form-control" rows="2" placeholder="Enter closure reason"></textarea>
							</div>
							<button class="btn btn-danger btn-sm" id="misPrematureCloseBtn">CONFIRM PREMATURE CLOSURE</button>
						</div>
					</div>
				</div>
			</div>

			<!-- Renew Panel (MATURED only) -->
			<div class="col-lg-4" id="misRenewPanel" style="display:none;">
				<div class="card border-success">
					<div class="card-header bg-success text-white" style="font-size:12px; font-weight:700;">POLICY RENEWAL</div>
					<div class="card-body">
						<p style="font-size:12px;">This policy has <strong>MATURED</strong>. Click below to renew it with the same terms. A new MIS policy will be created.</p>
						<button class="btn btn-success btn-sm" id="misRenewBtn">RENEW POLICY</button>
					</div>
				</div>
			</div>
		</div>

		<!-- ── PAYOUT LEDGER TABLE ─────────────────────────────────────── -->
		<div class="card mb-3">
			<div class="card-body">
				<div class="mis-section-title">PAYOUT HISTORY</div>
				<div class="table-responsive">
					<table class="table table-bordered table-sm" id="misLedgerTable">
						<thead class="table-secondary" style="font-size:11px;">
							<tr>
								<th>#</th>
								<th>PAYOUT DATE</th>
								<th>INTEREST (₹)</th>
								<th>TDS DEDUCTED (₹)</th>
								<th>NET PAID (₹)</th>
								<th>STATUS</th>
							</tr>
						</thead>
						<tbody id="misLedgerTableBody">
							<tr><td colspan="6" class="text-center text-muted">No payout records.</td></tr>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div><!-- end misPolicyDetailSection -->

</div>

<script src="${pageContext.request.contextPath}/js/PolicyManagment/misRenewal.js"></script>
