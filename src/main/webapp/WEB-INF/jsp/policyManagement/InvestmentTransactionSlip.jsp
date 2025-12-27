
<style>
.report-container {
	font-family: 'Segoe UI', Arial, sans-serif;
	color: #222;
	padding: 30px;
	background: #fff;
	border-radius: 12px;
	box-shadow: 0 0 8px rgba(0, 0, 0, 0.1);
}

.report-header {
	text-align: center;
	border-bottom: 3px solid #007bff;
	margin-bottom: 20px;
}

.report-header h2 {
	font-weight: 700;
	color: #007bff;
}

.report-header p {
	margin: 0;
	font-size: 14px;
}

.section-title {
	font-size: 16px;
	margin-top: 25px;
	margin-bottom: 10px;
	font-weight: bold;
	border-left: 4px solid #007bff;
	padding-left: 10px;
}

.report-table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 20px;
}

.report-table th, .report-table td {
	border: 1px solid #ccc;
	padding: 8px 12px;
	font-size: 14px;
}

.report-table th {
	background: #f7f9fc;
	width: 30%;
}

.signature-section {
	margin-top: 40px;
	text-align: right;
}

.signature-section hr {
	width: 200px;
	border-top: 2px solid #000;
	margin-bottom: 5px;
}
</style>

<div class="pagetitle">
	<h1>Policy Management</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-piggy-bank"></i>
			</a></li>
			<li class="breadcrumb-item action">Investment Transaction Slip</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Print Search Results</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="col-lg-12 mb-4 ">
						<div class="d-flex flex-column formFields">
							<label for="">Find by Policy Code <span class="star">*</span></label>
							<select id="findPolicyNumber" name="findPolicyNumber"
								required="required" class="form-control selectField"
								style="height: 30px;">
								<option value="">Select Policy Code</option>

							</select>
						</div>
					</div>





				</div>

				<div class="row" style="margin-top: 20px; margin-left: 750px;">
					<div class="col-12 text-center">
						<button type="button" id="findBtn" class="btn btn-dark">Find</button>
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
										<th>Policy Code</th>
										<th>Customer Name</th>
										<th>Policy Amount</th>
										<th>Renewal Date</th>
										<th>Policy Type</th>
										<th>Maturity Amount</th>
										<th>Deposit Amount</th>
										<th>Start Date</th>
										<th>Policy Term</th>
										<th>Maturity Date</th>
										<th>Customer Code</th>
										<th>Contact No</th>
										<th>Total Deposit</th>
										<th>Payment Due</th>
										<th>No. of Installments Paid</th>
										<th>Approved</th>
										<th>Branch Name</th>
										<th>Action</th>
									</tr>
								</thead>
								<tbody id="policyTableBody">
									<!-- Data will be inserted here -->
								</tbody>
							</table>
						</div>
					</div>
				</div>
			</div>

			<br> <br> <br> <br> <br> <br> <br>


			<!-- <div id="transactionSection" class="transaction-section">
						<div style="width: 70%; margin: auto">
							<h1>Microfinance Services</h1>
							<p>Address : Nagpur(440024) - Maharashtra</p>
							<hr />

							<div class="d-flex justify-content-between">
								<p>
									Branch Name: <span id="branchCodeSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
								<p>
									Start Date: <span id="docSpan"
										style="width: 15vw; display: inline-block;"></span>
								</p>
							</div>

							<div class="d-flex justify-content-between">
								<p>
									Policy Code: <span id="policyNoSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
								<p>
									Customer Code: <span id="memberCodeSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
							</div>

							<p>
								Customer Name: <span id="applicantNameSpan"
									style="width: 12vw; display: inline-block;"></span>
							</p>
							<p>
								Contact No: <span id="mobileSpan"
									style="width: 12vw; display: inline-block;"></span>
							</p>

							<div class="d-flex justify-content-between">
								<p>
									Policy Type: <span id="planSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
								<p>
									Policy Term: <span id="termSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
								<p>
									Approved: <span id="approvedSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
							</div>

							<div class="d-flex justify-content-between">
								<p>
									Policy Amount: <span id="renewalAmountSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
								<p>
									Total Deposit: <span id="totalValueSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
								<p>
									Payment Due: <span id="paymentDueSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
							</div>

							<div class="d-flex justify-content-between">
								<p>
									Maturity Amount: <span id="maturitySpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
								<p>
									Maturity Date: <span id="maturityDateSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
								<p>
									No. of Installments Paid: <span id="installmentsPaidSpan"
										style="width: 12vw; display: inline-block;"></span>
								</p>
							</div>

							<div class="d-flex justify-content-end">
								<hr style="border-color: black; width: 20vw;">
								<p style="position: relative; top: 23px; right: 17rem">Authorized
									Signature</p>
							</div>
						</div>
					</div> -->

			<br> <br> <br> <br> <br> <br> <br>
			<div class="mb-4"
				style="display: flex; justify-content: center; margin-top: -55px;">
				<button id="printBtn" class="btn btn-success">Print</button>
			</div>


		</div>

		<!-- ✅ Modal for Report Preview -->
		<div class="modal fade" id="printModal" tabindex="-1"
			aria-labelledby="printModalLabel" aria-hidden="true">
			<div
				class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
				<div class="modal-content">
					<div class="modal-header bg-primary text-white">
						<h5 class="modal-title" id="printModalLabel">Policy Report
							Preview</h5>
						<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
					</div>

					<div class="modal-body">
						<div id="modalDataContainer"></div>
					</div>

					<div class="modal-footer">
						<button id="printBtn" class="btn btn-success">
							<i class="bi bi-printer"></i> Print
						</button>
						<button id="downloadBtn" class="btn btn-danger">
							<i class="bi bi-file-earmark-pdf"></i> PDF
						</button>
					</div>
				</div>
			</div>
		</div>

	</form>
</div>

<!-- Load html2pdf -->
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/html2pdf.js/0.10.1/html2pdf.bundle.min.js"></script>

<script>
    document.getElementById("printBtn").addEventListener("click", function () {
        const printContent = document.getElementById("transactionSection").innerHTML;

        const printWindow = window.open('', '', 'width=800,height=600');
        printWindow.document.write('<html><head><title>Print</title>');
        printWindow.document.write('<style>');
        printWindow.document.write(`
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            table {
                width: 100%;
                border-collapse: collapse;
            }
            table, th, td {
                border: 1px solid black;
                padding: 8px;
                text-align: left;
            }
        `);
        printWindow.document.write('</style>');
        printWindow.document.write('</head><body>');
        printWindow.document.write(printContent);
        printWindow.document.write('</body></html>');
        printWindow.document.close();

        // Wait for new window to load before printing
        printWindow.onload = function () {
            printWindow.focus();
            printWindow.print();
            printWindow.close();
        };
    });
</script>

	<script
	src="${pageContext.request.contextPath}/js/PolicyManagment/policyReport.js"></script>
