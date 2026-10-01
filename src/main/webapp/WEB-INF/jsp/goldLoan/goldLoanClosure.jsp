<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<style>
.noc-header-card {
	background: linear-gradient(135deg, #1e3a5f 0%, #0a1628 100%);
	color: #fff;
	border-radius: 14px;
	padding: 22px 28px;
	margin-bottom: 28px;
	box-shadow: 0 12px 30px -5px rgba(0,0,0,0.25);
}
.noc-stat-box {
	background: rgba(255,255,255,0.09);
	backdrop-filter: blur(8px);
	border: 1px solid rgba(255,255,255,0.14);
	border-radius: 10px;
	padding: 14px 18px;
	text-align: center;
}
.noc-stat-label { font-size: 11px; text-transform: uppercase; letter-spacing: 0.5px; color: #94a3b8; margin-bottom: 4px; }
.noc-stat-val { font-size: 18px; font-weight: 700; color: #f8fafc; }
.noc-stat-val.highlight { font-size: 22px; color: #4ade80; }
.noc-eligible-badge { display: inline-block; padding: 4px 12px; border-radius: 20px; font-size: 11px; font-weight: 700; background: #dcfce7; color: #166534; border: 1px solid #86efac; }
.noc-modal-header { background: linear-gradient(135deg, #166534 0%, #14532d 100%); color: white; border-radius: 12px 12px 0 0; padding: 18px 24px; }
.noc-receipt { font-family: "Courier New", Courier, monospace; background: #fff; color: #000; padding: 24px; border: 2px dashed #cbd5e1; border-radius: 8px; }
.noc-receipt-header { text-align: center; border-bottom: 2px solid #000; padding-bottom: 12px; margin-bottom: 16px; }
.noc-receipt-seal { width: 80px; height: 80px; border: 3px solid #166534; border-radius: 50%; display: inline-flex; align-items: center; justify-content: center; color: #166534; font-weight: 900; font-size: 13px; text-align: center; margin: 10px auto; line-height: 1.2; }
.loan-emi-progress { background: #e2e8f0; border-radius: 8px; height: 12px; overflow: hidden; margin-top: 6px; }
.loan-emi-fill { height: 100%; border-radius: 8px; transition: width 0.6s ease; }
@media print { .no-print { display: none !important; } }
</style>

<div class="pagetitle">
	<h1>JEWELLERY LOANS</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="${pageContext.request.contextPath}/openDashboard">Home</a></li>
			<li class="breadcrumb-item">Jewellery Loans</li>
			<li class="breadcrumb-item active">Loan Closure (NOC)</li>
		</ol>
	</nav>
</div>

<section class="section no-print">
	<div class="row">
		<div class="col-12">
			<div class="card shadow-sm border-0">
				<div class="card-header py-3" style="background: linear-gradient(90deg,#1e3a5f,#0a1628); border-radius: 10px 10px 0 0;">
					<h5 class="mb-0 text-white"><i class="bi bi-shield-check me-2"></i>GOLD LOAN CLOSURE — NO OBJECTION CERTIFICATE (NOC)</h5>
					<small class="text-info">For customers who have completed all EMI installments</small>
				</div>
				<div class="card-body p-4">
					<div class="alert alert-info d-flex align-items-start gap-3 mb-4" style="border-left: 4px solid #0ea5e9; border-radius: 10px;">
						<i class="bi bi-info-circle-fill fs-4 mt-1 text-info"></i>
						<div>
							<strong>About This Module</strong><br>
							This module is for loans where <strong>all scheduled EMIs have been fully paid</strong>.
							Upon closure, a <strong>No Objection Certificate (NOC)</strong> is issued and gold collateral is released.<br>
							<small class="text-muted">For early payoff before loan term ends, use <a href="${pageContext.request.contextPath}/earlyGoldLoanClosure">Early Loan Closure</a>.</small>
						</div>
					</div>

					<h6 class="fw-bold text-primary mb-3"><i class="bi bi-search me-2"></i>STEP 1 — SELECT LOAN ACCOUNT</h6>
					<div class="row g-3 align-items-end mb-4">
						<div class="col-md-5">
							<label class="form-label fw-semibold">Loan ID <span class="text-danger">*</span></label>
							<select id="nocLoanSelect" class="form-select" onchange="loadNocLoanDetails(this.value)">
								<option value="">-- Loading eligible loans... --</option>
							</select>
							<small class="text-muted">Only loans with all EMIs paid appear here</small>
						</div>
						<div class="col-md-3">
							<label class="form-label fw-semibold">Or Enter Manually</label>
							<div class="input-group">
								<input type="text" id="manualGoldId" class="form-control" placeholder="e.g. GL00001">
								<button class="btn btn-outline-primary" onclick="loadNocLoanDetails(document.getElementById('manualGoldId').value)" type="button"><i class="bi bi-search"></i></button>
							</div>
						</div>
					</div>

					<div id="nocLoanDetailsCard" style="display:none;">
						<div class="noc-header-card mb-4">
							<div class="d-flex justify-content-between align-items-start flex-wrap gap-2 mb-3">
								<div>
									<h5 class="mb-1 text-white" id="nocDisplayName">--</h5>
									<span class="text-info small" id="nocDisplayId">--</span>
									<span class="noc-eligible-badge ms-2">ELIGIBLE FOR NOC</span>
								</div>
								<div class="text-end">
									<div class="text-muted small">Loan Date</div>
									<div class="text-white fw-bold" id="nocDisplayLoanDate">--</div>
								</div>
							</div>
							<div class="row g-3">
								<div class="col-6 col-md-3"><div class="noc-stat-box"><div class="noc-stat-label">Loan Amount</div><div class="noc-stat-val highlight" id="nocStatAmount">Rs.0</div></div></div>
								<div class="col-6 col-md-3"><div class="noc-stat-box"><div class="noc-stat-label">EMI Amount</div><div class="noc-stat-val" id="nocStatEmi">Rs.0</div></div></div>
								<div class="col-6 col-md-3"><div class="noc-stat-box"><div class="noc-stat-label">Total Installments</div><div class="noc-stat-val" id="nocStatTerm">--</div></div></div>
								<div class="col-6 col-md-3"><div class="noc-stat-box"><div class="noc-stat-label">Installments Paid</div><div class="noc-stat-val" id="nocStatPaid" style="color:#4ade80;">--</div></div></div>
							</div>
							<div class="mt-3">
								<div class="d-flex justify-content-between small text-white mb-1">
									<span>EMI Completion Progress</span>
									<span id="nocProgressPct">--</span>
								</div>
								<div class="loan-emi-progress">
									<div class="loan-emi-fill bg-success" id="nocProgressBar" style="width:0%;"></div>
								</div>
							</div>
						</div>

						<div class="row g-3 mb-4">
							<div class="col-md-4"><label class="form-label fw-semibold small text-muted">MEMBER CODE</label><input type="text" class="form-control form-control-sm" id="nocMemberCode" readonly></div>
							<div class="col-md-4"><label class="form-label fw-semibold small text-muted">INTEREST TYPE</label><input type="text" class="form-control form-control-sm" id="nocInterestType" readonly></div>
							<div class="col-md-4"><label class="form-label fw-semibold small text-muted">RATE OF INTEREST</label><input type="text" class="form-control form-control-sm" id="nocRateOfInterest" readonly></div>
							<div class="col-md-4"><label class="form-label fw-semibold small text-muted">BRANCH</label><input type="text" class="form-control form-control-sm" id="nocBranch" readonly></div>
							<div class="col-md-4"><label class="form-label fw-semibold small text-muted">TOTAL PAYABLE</label><input type="text" class="form-control form-control-sm" id="nocTotalPayable" readonly></div>
							<div class="col-md-4"><label class="form-label fw-semibold small text-muted">LOAN PLAN</label><input type="text" class="form-control form-control-sm" id="nocLoanPlan" readonly></div>
						</div>

						<h6 class="fw-bold text-primary mb-3 mt-4"><i class="bi bi-pencil-square me-2"></i>STEP 2 — CLOSURE DETAILS</h6>
						<div class="row g-3 mb-4">
							<div class="col-md-4"><label class="form-label fw-semibold">Closure Date <span class="text-danger">*</span></label><input type="date" id="nocClosureDate" class="form-control" required></div>
							<div class="col-md-4"><label class="form-label fw-semibold">Payment Branch</label><input type="text" id="nocPayBranch" class="form-control" placeholder="Branch Name"></div>
							<div class="col-md-4"><label class="form-label fw-semibold">Deduct Fine?</label><select id="nocDeductFine" class="form-select" onchange="toggleFineAmount()"><option value="No">No</option><option value="Yes">Yes</option></select></div>
							<div class="col-md-4" id="nocFineAmountBox" style="display:none;"><label class="form-label fw-semibold">Fine Amount (Rs.)</label><input type="number" id="nocFineAmount" class="form-control" placeholder="0.00" min="0" step="0.01"></div>
							<div class="col-md-4"><label class="form-label fw-semibold">FC Code</label><input type="text" id="nocFinancialCode" class="form-control" placeholder="FC Code"></div>
							<div class="col-md-4"><label class="form-label fw-semibold">FC Name</label><input type="text" id="nocFinancialName" class="form-control" placeholder="FC Name"></div>
							<div class="col-12"><label class="form-label fw-semibold">Remarks</label><textarea id="nocRemarks" class="form-control" rows="2" placeholder="Closure remarks (optional)"></textarea></div>
						</div>

						<div class="d-flex gap-3 align-items-center mt-2">
							<button class="btn btn-success px-5 py-2 fw-bold" id="nocSubmitBtn" onclick="submitNormalClosure()">
								<i class="bi bi-shield-check me-2"></i>CLOSE LOAN AND GENERATE NOC
							</button>
							<button class="btn btn-outline-secondary" onclick="resetNocForm()"><i class="bi bi-x-circle me-1"></i> Reset</button>
						</div>
					</div>

					<div id="nocNotEligibleMsg" style="display:none;" class="alert alert-warning mt-3">
						<i class="bi bi-exclamation-triangle-fill me-2"></i>
						<span id="nocNotEligibleText">This loan is not yet eligible for NOC closure.</span>
					</div>
				</div>
			</div>
		</div>
	</div>
</section>

<div class="modal fade" id="nocReceiptModal" tabindex="-1" aria-hidden="true">
	<div class="modal-dialog modal-lg modal-dialog-centered">
		<div class="modal-content border-0 shadow-lg">
			<div class="noc-modal-header d-flex justify-content-between align-items-center">
				<div>
					<h5 class="mb-0 text-white"><i class="bi bi-file-earmark-check me-2"></i>NO OBJECTION CERTIFICATE</h5>
					<small class="text-light opacity-75">Gold Loan Closure - NOC Issued Successfully</small>
				</div>
				<button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
			</div>
			<div class="modal-body p-4">
				<div class="noc-receipt" id="printableNOC">
					<div class="noc-receipt-header">
						<div class="text-center mb-2">
							<strong style="font-size:18px;">MICROFINANCE INSTITUTION</strong><br>
							<span style="font-size:12px;">Jewellery Loan Department</span>
						</div>
						<h4 class="text-center my-2" style="letter-spacing:3px; text-decoration:underline;">NO OBJECTION CERTIFICATE</h4>
						<div class="text-center">Receipt No: <strong id="nocReceiptNo">--</strong></div>
					</div>
					<p style="line-height:2; font-size:13px;">
						This is to certify that <strong id="nocReceiptName">--</strong> (Member Code: <strong id="nocReceiptMember">--</strong>)
						has successfully repaid all dues against Gold Loan Account No. <strong id="nocReceiptGoldId">--</strong>,
						sanctioned on <strong id="nocReceiptLoanDate">--</strong>.<br><br>
						All <strong id="nocReceiptInstallments">--</strong> EMI installments have been paid in full.
						The loan account stands <strong>CLOSED</strong> as on <strong id="nocReceiptClosureDate">--</strong>.
					</p>
					<table style="width:100%; border-collapse:collapse; font-size:12px; margin:14px 0;">
						<tr><td style="padding:4px 8px; border:1px solid #ccc; width:50%;"><strong>Loan Amount</strong></td><td style="padding:4px 8px; border:1px solid #ccc;" id="nocReceiptLoanAmt">--</td></tr>
						<tr><td style="padding:4px 8px; border:1px solid #ccc;"><strong>Total Installments</strong></td><td style="padding:4px 8px; border:1px solid #ccc;" id="nocReceiptTotalInst">--</td></tr>
						<tr><td style="padding:4px 8px; border:1px solid #ccc;"><strong>Installments Paid</strong></td><td style="padding:4px 8px; border:1px solid #ccc;" id="nocReceiptPaidInst">--</td></tr>
						<tr><td style="padding:4px 8px; border:1px solid #ccc;"><strong>Closure Date</strong></td><td style="padding:4px 8px; border:1px solid #ccc;" id="nocReceiptClosureDateRow">--</td></tr>
						<tr style="background:#f0fdf4;"><td style="padding:4px 8px; border:1px solid #ccc;"><strong>LOAN STATUS</strong></td><td style="padding:4px 8px; border:1px solid #ccc;"><strong style="color:#166534;">CLOSED - NOC ISSUED</strong></td></tr>
					</table>
					<p style="font-size:12px; margin-top:16px;">
						The pledged gold ornaments/jewellery are hereby released and may be collected from the branch upon presentation of this certificate and valid ID proof.
					</p>
					<div class="d-flex justify-content-between mt-4">
						<div class="text-center"><div style="border-top:1px solid #000; padding-top:4px; width:150px;">Borrower Signature</div></div>
						<div class="text-center"><div class="noc-receipt-seal">NOC<br>ISSUED</div></div>
						<div class="text-center"><div style="border-top:1px solid #000; padding-top:4px; width:150px;">Authorized Signatory</div></div>
					</div>
				</div>
			</div>
			<div class="modal-footer no-print">
				<button class="btn btn-outline-secondary" data-bs-dismiss="modal"><i class="bi bi-x me-1"></i>Close</button>
				<button class="btn btn-primary" onclick="printNOC()"><i class="bi bi-printer me-1"></i>Print NOC</button>
			</div>
		</div>
	</div>
</div>

<script>
const NOC_BASE = '${pageContext.request.contextPath}/securedGoldLoan';
let currentNocLoan = null;

async function loadNocEligibleLoans() {
	try {
		const res = await fetch(NOC_BASE + '/getNocEligibleGoldLoans');
		const data = await res.json();
		const sel = document.getElementById('nocLoanSelect');
		sel.innerHTML = '<option value="">-- Select Eligible Loan --</option>';
		if (data.data && data.data.length > 0) {
			data.data.forEach(item => {
				const opt = document.createElement('option');
				opt.value = item.goldID || item.goldId;
				opt.textContent = (item.goldID || item.goldId) + ' -- ' + (item.customerName || item.clientName || '');
				sel.appendChild(opt);
			});
		} else {
			sel.innerHTML = '<option value="">-- No loans eligible for NOC yet --</option>';
		}
	} catch (e) { console.error('Failed to load NOC eligible loans', e); }
}

async function loadNocLoanDetails(goldId) {
	goldId = (goldId || '').trim();
	if (!goldId) {
		document.getElementById('nocLoanDetailsCard').style.display = 'none';
		document.getElementById('nocNotEligibleMsg').style.display = 'none';
		return;
	}
	try {
		const res = await fetch(NOC_BASE + '/calculateForeclosure?goldId=' + encodeURIComponent(goldId));
		const data = await res.json();
		if (!data.data) {
			document.getElementById('nocNotEligibleMsg').style.display = 'block';
			document.getElementById('nocNotEligibleText').textContent = data.message || 'No data found for this loan ID.';
			document.getElementById('nocLoanDetailsCard').style.display = 'none';
			return;
		}
		currentNocLoan = data.data;
		const loan = data.data;
		const term = loan.totalInstallments || 0;
		const paid = loan.paidInstallments || 0;
		const pct = term > 0 ? Math.round((paid / term) * 100) : 0;
		if (paid < term) {
			document.getElementById('nocNotEligibleMsg').style.display = 'block';
			document.getElementById('nocNotEligibleText').textContent =
				'This loan has ' + paid + ' of ' + term + ' installments paid. All ' + term + ' EMIs must be paid before NOC can be issued.';
			document.getElementById('nocLoanDetailsCard').style.display = 'none';
			return;
		}
		document.getElementById('nocNotEligibleMsg').style.display = 'none';
		document.getElementById('nocLoanDetailsCard').style.display = 'block';
		document.getElementById('nocDisplayName').textContent = loan.customerName || '--';
		document.getElementById('nocDisplayId').textContent = goldId;
		document.getElementById('nocDisplayLoanDate').textContent = loan.loanDate || loan.lastPaymentDate || '--';
		document.getElementById('nocStatAmount').textContent = 'Rs.' + fmt(loan.sanctionedPrincipal);
		document.getElementById('nocStatEmi').textContent = 'Rs.' + fmt(loan.emiAmount || 0);
		document.getElementById('nocStatTerm').textContent = term;
		document.getElementById('nocStatPaid').textContent = paid + ' / ' + term;
		document.getElementById('nocProgressPct').textContent = Math.min(100, pct) + '% Complete';
		document.getElementById('nocProgressBar').style.width = Math.min(100, pct) + '%';
		document.getElementById('nocMemberCode').value = loan.memberCode || '--';
		document.getElementById('nocInterestType').value = loan.interestType || '--';
		document.getElementById('nocRateOfInterest').value = (loan.rateOfInterest || '--') + '%';
		document.getElementById('nocBranch').value = loan.lockerBranch || '--';
		document.getElementById('nocTotalPayable').value = loan.totalPayable != null ? 'Rs.' + fmt(loan.totalPayable) : '--';
		document.getElementById('nocLoanPlan').value = loan.loanPlanName || '--';
		document.getElementById('nocClosureDate').value = new Date().toISOString().split('T')[0];
	} catch (e) {
		document.getElementById('nocNotEligibleMsg').style.display = 'block';
		document.getElementById('nocNotEligibleText').textContent = 'Error loading loan data: ' + e.message;
		document.getElementById('nocLoanDetailsCard').style.display = 'none';
	}
}

function fmt(v) {
	if (!v && v !== 0) return '0.00';
	return parseFloat(v).toLocaleString('en-IN', {minimumFractionDigits: 2, maximumFractionDigits: 2});
}

function toggleFineAmount() {
	document.getElementById('nocFineAmountBox').style.display =
		document.getElementById('nocDeductFine').value === 'Yes' ? 'block' : 'none';
}

function resetNocForm() {
	document.getElementById('nocLoanSelect').value = '';
	document.getElementById('manualGoldId').value = '';
	document.getElementById('nocLoanDetailsCard').style.display = 'none';
	document.getElementById('nocNotEligibleMsg').style.display = 'none';
	currentNocLoan = null;
}

async function submitNormalClosure() {
	const goldId = (document.getElementById('nocLoanSelect').value || document.getElementById('manualGoldId').value || '').trim();
	if (!goldId) { alert('Please select or enter a Loan ID.'); return; }
	if (!currentNocLoan) { alert('Please load loan details first.'); return; }
	const closureDate = document.getElementById('nocClosureDate').value;
	if (!closureDate) { alert('Please select the closure date.'); return; }
	const deductFine = document.getElementById('nocDeductFine').value;
	const fineAmt = deductFine === 'Yes' ? (document.getElementById('nocFineAmount').value || '0') : '0';
	const btn = document.getElementById('nocSubmitBtn');
	btn.disabled = true;
	btn.innerHTML = '<span class="spinner-border spinner-border-sm me-2"></span>Processing...';
	const payload = {
		goldID: goldId,
		paymentDate: closureDate,
		paymentBranch: document.getElementById('nocPayBranch').value,
		deductFine: deductFine,
		deductFineAmount: fineAmt,
		financialCode: document.getElementById('nocFinancialCode').value,
		financialName: document.getElementById('nocFinancialName').value,
		remarks: document.getElementById('nocRemarks').value,
		goldLoanStatus: 'CLOSED'
	};
	try {
		const res = await fetch(NOC_BASE + '/executeNormalLoanClosure', {
			method: 'POST',
			headers: {'Content-Type': 'application/json'},
			body: JSON.stringify(payload)
		});
		const result = await res.json();
		if (result.status === 'OK' || result.status === 200) {
			showNocReceipt(result.data || payload, currentNocLoan);
			resetNocForm();
			loadNocEligibleLoans();
		} else {
			alert(result.message || 'Closure failed. Please try again.');
		}
	} catch (e) {
		alert('Network error: ' + e.message);
	} finally {
		btn.disabled = false;
		btn.innerHTML = '<i class="bi bi-shield-check me-2"></i>CLOSE LOAN AND GENERATE NOC';
	}
}

function showNocReceipt(closureData, loanDetails) {
	const receiptNo = closureData.settlementReceiptNo || ('NOC-' + Date.now());
	const closureDate = closureData.paymentDate || new Date().toLocaleDateString('en-IN');
	document.getElementById('nocReceiptNo').textContent = receiptNo;
	document.getElementById('nocReceiptName').textContent = closureData.customerName || loanDetails.customerName || '--';
	document.getElementById('nocReceiptMember').textContent = closureData.customerCode || loanDetails.memberCode || '--';
	document.getElementById('nocReceiptGoldId').textContent = closureData.goldID || '--';
	document.getElementById('nocReceiptLoanDate').textContent = loanDetails.loanDate || '--';
	document.getElementById('nocReceiptInstallments').textContent = loanDetails.paidInstallments || '--';
	document.getElementById('nocReceiptClosureDate').textContent = closureDate;
	document.getElementById('nocReceiptLoanAmt').textContent = 'Rs.' + fmt(loanDetails.sanctionedPrincipal);
	document.getElementById('nocReceiptTotalInst').textContent = loanDetails.totalInstallments || '--';
	document.getElementById('nocReceiptPaidInst').textContent = loanDetails.paidInstallments || '--';
	document.getElementById('nocReceiptClosureDateRow').textContent = closureDate;
	const modal = new bootstrap.Modal(document.getElementById('nocReceiptModal'));
	modal.show();
}

function printNOC() {
	const printContents = document.getElementById('printableNOC').outerHTML;
	const w = window.open('', '', 'height=700,width=900');
	w.document.write('<html><head><title>NOC Certificate</title><style>body{font-family:"Courier New",monospace;padding:30px;}.noc-receipt{border:2px dashed #333;padding:24px;}.noc-receipt-header{text-align:center;border-bottom:2px solid #000;padding-bottom:12px;margin-bottom:16px;}.noc-receipt-seal{width:80px;height:80px;border:3px solid #166534;border-radius:50%;display:inline-flex;align-items:center;justify-content:center;color:#166534;font-weight:900;font-size:13px;text-align:center;line-height:1.2;}table{width:100%;border-collapse:collapse;font-size:12px;margin:14px 0;}td{padding:4px 8px;border:1px solid #ccc;}.d-flex{display:flex;justify-content:space-between;margin-top:24px;}</style></head><body>' + printContents + '</body></html>');
	w.document.close();
	w.print();
}

document.addEventListener('DOMContentLoaded', loadNocEligibleLoans);
</script>