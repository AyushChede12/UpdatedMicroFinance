<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style>
	.gold-doc-card {
		background: #ffffff;
		border: 1px solid #e2e8f0;
		border-radius: 12px;
		padding: 24px;
		margin-bottom: 24px;
		box-shadow: 0 2px 12px -2px rgba(15, 23, 42, 0.04);
	}
	.breadcrumb-section-title {
		font-family: 'Poppins', sans-serif;
		font-size: 13.5px;
		font-weight: 700;
		color: #0f766e;
		letter-spacing: 0.5px;
		text-transform: uppercase;
		display: flex;
		align-items: center;
		gap: 8px;
		margin-bottom: 16px;
		padding-bottom: 8px;
		border-bottom: 1px solid #f1f5f9;
	}
	.formFields {
		margin-bottom: 16px;
	}
	.formFields label {
		font-size: 11.5px;
		font-weight: 600;
		color: #334155;
		margin-bottom: 6px;
		letter-spacing: 0.3px;
		text-transform: uppercase;
		display: block;
	}
	.formFields .form-control,
	.formFields select.form-control,
	.formFields .selectField {
		height: 38px !important;
		border: 1px solid #cbd5e1 !important;
		border-radius: 6px !important;
		font-size: 12.5px !important;
		padding: 6px 12px !important;
		color: #1e293b !important;
		background-color: #ffffff;
		width: 100% !important;
		box-sizing: border-box;
		transition: border-color 0.2s ease, box-shadow 0.2s ease;
	}
	.formFields .form-control:focus,
	.formFields select.form-control:focus,
	.formFields .selectField:focus {
		border-color: #0f766e !important;
		box-shadow: 0 0 0 3px rgba(15, 118, 110, 0.15) !important;
		outline: none !important;
	}
	.formFields .form-control[readonly] {
		background-color: #f8fafc !important;
		color: #475569 !important;
		cursor: default;
	}
	/* Select2 container alignment */
	.select2-container {
		width: 100% !important;
	}
	.select2-container .select2-selection--single {
		height: 38px !important;
		border: 1px solid #cbd5e1 !important;
		border-radius: 6px !important;
		padding: 5px 10px !important;
		display: flex !important;
		align-items: center !important;
	}
	.select2-container--default .select2-selection--single .select2-selection__rendered {
		line-height: 26px !important;
		color: #1e293b !important;
		font-size: 12.5px !important;
		padding-left: 0 !important;
	}
	.select2-container--default .select2-selection--single .select2-selection__arrow {
		height: 36px !important;
		right: 6px !important;
	}
</style>

<div class="pagetitle">
	<h1>SECURED GOLD LOAN</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"><i class="bi bi-cash-coin"></i></a></li>
			<li class="breadcrumb-item action">GOLD LOAN DOCUMENT PRINT &amp; GENERATION</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<!-- Section 1: Search & Document Selection -->
		<div class="gold-doc-card">
			<div class="breadcrumb-section-title">
				<i class="bi bi-search"></i> SELECT GOLD LOAN &amp; DOCUMENT
			</div>
			<div class="row align-items-end">
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="findByGoldLoanId" id="goldSelection">FIND BY GOLD ID / CLIENT NAME <span style="color:red;">*</span></label>
						<select id="findByGoldLoanId" name="findByGoldLoanId" class="form-control selectField" style="width: 100%;">
							<option value="">-- SEARCH GOLD ID / CLIENT NAME --</option>
						</select>
					</div>
				</div>

				<div class="col-lg-4 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="loanDocument">SELECT LOAN DOCUMENT <span style="color:red;">*</span></label>
						<select id="loanDocument" name="loanDocument" required="required" disabled="disabled" class="form-control selectField">
							<option value="" disabled="disabled" selected="selected">-- Select Gold ID First --</option>
							<option value="APPLICATION_FORM">APPLICATION &amp; APPRAISAL FORM</option>
							<option value="SANCTION_LETTER">SANCTION LETTER</option>
							<option value="LOAN_AGREEMENT">LOAN AGREEMENT &amp; PLEDGE DEED</option>
							<option value="REPAYMENT_SCHEDULE">EMI REPAYMENT SCHEDULE</option>
							<option value="GUARANTOR_DECLARATION">GUARANTOR DECLARATION</option>
							<option value="DISBURSEMENT_RECEIPT">DISBURSEMENT RECEIPT</option>
							<option value="NOC">NOC &amp; RELEASE CERTIFICATE</option>
						</select>
						<small id="docTypeHint" class="text-muted mt-1" style="font-size: 11px;">Documents are dynamically gated based on loan lifecycle status.</small>
						<span id="docTypeError" style="color: red; font-size: 12px; display: none;">PLEASE SELECT A DOCUMENT TYPE</span>
					</div>
				</div>

				<div class="col-lg-5 col-md-12">
					<div class="d-flex mb-3" style="gap: 10px;">
						<button type="button" class="btn btn-primary px-3 shadow-sm" id="previewDocBtn" disabled="disabled" style="height: 38px;">
							<i class="bi bi-eye mr-1"></i> PREVIEW
						</button>
						<button type="button" class="btn btn-warning px-3 shadow-sm font-weight-bold" id="generateDocBtn" disabled="disabled" style="height: 38px;">
							<span id="generateSpinner" class="spinner-border spinner-border-sm mr-1 d-none" role="status" aria-hidden="true"></span>
							<i class="bi bi-file-earmark-pdf mr-1" id="generateIcon"></i> GENERATE DOC
						</button>
						<button type="button" class="btn btn-outline-secondary px-3" id="resetBtn" style="height: 38px;" title="Reset selection">
							<i class="bi bi-arrow-counterclockwise"></i>
						</button>
						<!-- Backward-compatibility button retained hidden -->
						<button class="btnStyle bg-warning d-none" id="generateDoc" style="display: none;"></button>
					</div>
				</div>
			</div>
		</div>

		<!-- Section 2: Fixed 4-Column Gold Loan Details Grid -->
		<div class="gold-doc-card">
			<div class="breadcrumb-section-title">
				<i class="bi bi-info-circle"></i> GOLD LOAN DETAILS (4-COLUMN GRID)
			</div>
			<div class="row">
				<!-- Row 1 -->
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="loanDate">DATE OF LOAN</label>
						<input type="text" readonly="readonly" name="loanDate" id="loanDate" class="form-control" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="customerCode">CUSTOMER CODE</label>
						<input type="text" readonly="readonly" name="customerCode" id="customerCode" class="form-control" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="customerName">CLIENT / CUSTOMER NAME</label>
						<input type="text" readonly="readonly" name="customerName" id="customerName" class="form-control font-weight-bold text-teal" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="contactNo">CONTACT NO.</label>
						<input type="text" readonly="readonly" name="contactNo" id="contactNo" class="form-control" placeholder="--" />
					</div>
				</div>

				<!-- Row 2 -->
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="loanPlanName">LOAN PLAN NAME</label>
						<input type="text" readonly="readonly" name="loanPlanName" id="loanPlanName" class="form-control" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="loanAmount">SANCTIONED AMOUNT (₹)</label>
						<input type="text" readonly="readonly" name="loanAmount" id="loanAmount" class="form-control font-weight-bold text-success" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="rateOfInterest">RATE OF INTEREST</label>
						<input type="text" readonly="readonly" name="rateOfInterest" id="rateOfInterest" class="form-control" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="loanTerm">LOAN TERM</label>
						<input type="text" readonly="readonly" name="loanTerm" id="loanTerm" class="form-control" placeholder="--" />
					</div>
				</div>

				<!-- Row 3 -->
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="interestType">INTEREST TYPE</label>
						<input type="text" readonly="readonly" name="interestType" id="interestType" class="form-control" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="loanMode">LOAN MODE</label>
						<input type="text" readonly="readonly" name="loanMode" id="loanMode" class="form-control" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="emiPayment">EMI PAYMENT (₹)</label>
						<input type="text" readonly="readonly" name="emiPayment" id="emiPayment" class="form-control font-weight-bold" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="goldLoanStatus">CURRENT STATUS</label>
						<input type="text" readonly="readonly" name="goldLoanStatus" id="goldLoanStatus" class="form-control font-weight-bold" placeholder="--" />
					</div>
				</div>

				<!-- Row 4 -->
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="netDisbursement">NET DISBURSED (₹)</label>
						<input type="text" readonly="readonly" name="netDisbursement" id="netDisbursement" class="form-control font-weight-bold text-primary" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="totalNetWt">TOTAL NET WEIGHT (g)</label>
						<input type="text" readonly="readonly" name="totalNetWt" id="totalNetWt" class="form-control font-weight-bold text-warning" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="marketValuation">TOTAL VALUATION (₹)</label>
						<input type="text" readonly="readonly" name="marketValuation" id="marketValuation" class="form-control font-weight-bold" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="guarantorName">LINKED GUARANTOR</label>
						<input type="text" readonly="readonly" name="guarantorName" id="guarantorName" class="form-control" placeholder="--" />
					</div>
				</div>

				<!-- Row 5: Repayment & Calculation Breakdown -->
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="totalDeductions">TOTAL DEDUCTIONS (₹)</label>
						<input type="text" readonly="readonly" name="totalDeductions" id="totalDeductions" class="form-control font-weight-bold text-danger" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="totalInterest">TOTAL INTEREST (₹)</label>
						<input type="text" readonly="readonly" name="totalInterest" id="totalInterest" class="form-control font-weight-bold" style="color: #b45309; background-color: #fffbeb;" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="totalPayableAmount">TOTAL AMOUNT TO PAY (₹)</label>
						<input type="text" readonly="readonly" name="totalPayableAmount" id="totalPayableAmount" class="form-control font-weight-bold" style="color: #1d4ed8; background-color: #eff6ff;" placeholder="--" />
					</div>
				</div>
				<div class="col-lg-3 col-md-6">
					<div class="d-flex flex-column formFields">
						<label for="repaymentPolicy">INTEREST CALCULATION BASE</label>
						<input type="text" readonly="readonly" name="repaymentPolicy" id="repaymentPolicy" class="form-control text-muted" value="Charged on Applied Principal" style="font-size: 11px;" />
					</div>
				</div>

				<!-- Retained original hidden field for backward-compatibility -->
				<input type="hidden" name="itemName" id="itemName" />
			</div>
		</div>

		<!-- Section 3: Pledged Gold Ornaments Inventory Table -->
		<div class="gold-doc-card" id="ornamentsCard" style="display: none;">
			<div class="breadcrumb-section-title">
				<i class="bi bi-gem"></i> PLEDGED GOLD ORNAMENTS BREAKDOWN
			</div>
			<div class="table-responsive">
				<table class="table table-bordered table-hover align-middle mb-0" id="ornamentsTable">
					<thead class="thead-light">
						<tr>
							<th style="width: 5%; text-align: center;">#</th>
							<th style="width: 25%;">Item Description</th>
							<th style="width: 15%;">Type / Karat</th>
							<th style="width: 12%; text-align: right;">Gross Wt (g)</th>
							<th style="width: 12%; text-align: right;">Net Wt (g)</th>
							<th style="width: 15%; text-align: right;">Gold Rate / g</th>
							<th style="width: 16%; text-align: right;">Valuation (₹)</th>
						</tr>
					</thead>
					<tbody id="ornamentsBody">
					</tbody>
				</table>
			</div>
		</div>

		<!-- Section 4: Recently Generated Documents Audit History -->
		<div class="gold-doc-card">
			<div class="d-flex justify-content-between align-items-center mb-3">
				<div class="breadcrumb-section-title mb-0 border-0 p-0">
					<i class="bi bi-clock-history"></i> RECENTLY GENERATED DOCUMENTS (AUDIT LOG)
				</div>
				<span class="badge badge-light border text-dark font-weight-bold" id="auditCountBadge">0 Documents</span>
			</div>
			<div class="table-responsive">
				<table class="table table-hover align-middle mb-0" id="docLogsTable">
					<thead class="thead-light text-secondary text-uppercase small">
						<tr>
							<th class="pl-3" style="width: 50px;">#</th>
							<th>Generation Date &amp; Time</th>
							<th>Document Type</th>
							<th>Generated By User</th>
							<th>File Name</th>
							<th class="text-center" style="width: 130px;">Action</th>
						</tr>
					</thead>
					<tbody id="docLogsBody">
						<tr>
							<td colspan="6" class="text-center py-4 text-muted">Please select a Gold Loan ID to view generated document history.</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<!-- Backward-compatibility container for original in-page print preview -->
		<div class="row mt-4 d-none" style="display: none;">
			<div class="col-12">
				<div class="card recent-sales" id="receiptArea"></div>
			</div>
		</div>

		<!-- Print Button (backward compatibility) -->
		<div style="text-align: center; margin-top: 20px; display: none;">
			<button id="printBtn" onclick="printDocument()" style="display: none;"></button>
		</div>
	</form>
</div>

<!-- Modal: Interactive Document HTML Preview (Bootstrap 4 & 5 Compatible) -->
<div class="modal fade" id="docPreviewModal" tabindex="-1" role="dialog" aria-labelledby="docPreviewModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-xl modal-dialog-scrollable" role="document">
		<div class="modal-content border-0 shadow">
			<div class="modal-header text-white py-2" style="background-color: #0f766e;">
				<h5 class="modal-title font-weight-bold" id="docPreviewModalLabel">
					<i class="bi bi-file-earmark-text mr-1"></i> Gold Loan Document Preview
				</h5>
				<button type="button" class="close text-white" data-dismiss="modal" data-bs-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body p-0" style="background-color: #525659; min-height: 520px;">
				<div class="d-flex justify-content-center p-3">
					<div id="previewContainer" class="bg-white shadow" style="width: 850px; min-height: 900px; padding: 40px; border-radius: 4px;">
						<!-- Rendered document HTML inserted here -->
					</div>
				</div>
			</div>
			<div class="modal-footer bg-light py-2">
				<span class="text-muted small mr-auto"><i class="bi bi-info-circle mr-1"></i> Review document preview before generating the final signed PDF.</span>
				<button type="button" class="btn btn-secondary btn-sm" data-dismiss="modal" data-bs-dismiss="modal">Close</button>
				<button type="button" class="btn btn-outline-primary btn-sm" id="modalPrintBtn">
					<i class="bi bi-printer mr-1"></i> Print Preview
				</button>
				<button type="button" class="btn btn-warning btn-sm font-weight-bold" id="modalGenerateBtn">
					<i class="bi bi-download mr-1"></i> Approve &amp; Download PDF
				</button>
			</div>
		</div>
	</div>
</div>

<script src="${pageContext.request.contextPath}/js/SecuredGoldLoan/goldLoanDocument.js?v=<%=System.currentTimeMillis()%>"></script>