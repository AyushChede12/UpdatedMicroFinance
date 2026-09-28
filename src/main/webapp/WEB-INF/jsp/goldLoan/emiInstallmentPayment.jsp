
<div class="pagetitle">
	<h1>SECURED GOLD LOAN</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-cash-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">EMI INSTALLMENT PAYMENT</li>
		</ol>
	</nav>
</div>

<div class="row">
	<div class="col-lg-3">
		<div class="d-flex flex-column formFields mb-4">
			<label for="findByGoldLoanId" id="goldSelection">CUSTOMER
				SELECTION </label> <select id="findByGoldLoanId" name="findByGoldLoanId"
				class="form-control selectField" style="width: 100%;">
				<option value="">-- SERACH GOLD ID --</option>
			</select>
		</div>
	</div>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">SERACH DETAILS</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanDate">DATE OF LOAN</label> <input type="date"
							name="loanDate" id="loanDate" required="required"
							readonly="readonly" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="customerCode">CUSTOMER CODE</label> <input type="text"
							name="customerCode" id="customerCode" readonly="readonly"
							required="required" placeholder="ENTER CUSTOMER CODE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="customerName">CUSTOMER NAME</label> <input type="text"
							name="customerName" id="customerName" readonly="readonly"
							required="required" placeholder="ENTER CUSTOMER NAME" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">LOAN PLAN NAME </label> <input type="text"
							readonly="readonly" name="loanPlanName" id="loanPlanName"
							required="required" placeholder="ENTER LOAN PLAN" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">INTEREST TYPE</label> <input type="text"
							readonly="readonly" name="interestType" id="interestType"
							required="required" placeholder="ENTER INTEREST TYPE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">LOAN MODE</label> <input type="text"
							readonly="readonly" name="loanMode" id="loanMode"
							required="required" placeholder="ENTER LOAN MODE" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Term</label> <input type="text" name="loanTerm"
							readonly="readonly" id="loanTerm" required="required"
							placeholder="ENTER TERM" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">EMI PAYMENT</label> <input type="text"
							readonly="readonly" name="emiPayment" id="emiPayment"
							required="required" placeholder="ENTER EMI PAYMENT" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">TYPE OF LOAN</label> <input type="text"
							readonly="readonly" name="typeOfLoan" id="typeOfLoan"
							required="required" placeholder="ENTER TYPE OF LOAN" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">RATE OF INTEREST(%)</label> <input type="text"
							readonly="readonly" name="rateOfInterest" id="rateOfInterest"
							required="required" placeholder="ENTER RATE OF INTEREST" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">CONTACT NO.</label> <input type="text"
							readonly="readonly" name="contactNo" id="contactNo"
							required="required" placeholder="ENTER CONTACT NO" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">AMOUNT OF LOAN</label> <input type="text"
							readonly="readonly" name="loanAmount" id="loanAmount"
							required="required" placeholder="ENTER AMOUNT OF LOAN." />
					</div>
				</div>

				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Total Principle Of Loan</label> <input type="text"
									name="totalPrincipalloan" id="totalPrincipalloan"
									required="required" placeholder="Enter Total Principle Of Loan" />
							</div>
						</div> -->

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="branchName">BRANCH NAME</label> <input type="text"
							readonly="readonly" name="branchName" id="branchName"
							required="required" placeholder="ENTER BRANCH NAME" />
					</div>
				</div>

			</div>
		</div>





		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Payment Details</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-3">

					<div class="d-flex flex-column formFields mb-4">
						<label for="">INSTALLMENT</label> <select id="installment"
							name="installment" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-SELECT INSTALLMENT-</option>

						</select>
					</div>
				</div>

				<!-- <div class="col-lg-3">
							<div class="d-flex flex-column formFields mb-4">
								<label for="">Interest Due </label> <input type="text"
									name="dueInterest" id="dueInterest" required="required"
									placeholder="Enter Location" />
							</div>
						</div> -->


				<div class="col-lg-3">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="emiDueDate">EMI DUE DATE</label> <input
							type="date" name="emiDueDate" id="emiDueDate" readonly
							placeholder="EMI DUE DATE"
							style="background: #f0f7ff; font-weight: bold; color: #0d47a1; text-transform: uppercase;" />
						<input type="hidden" name="registrationDate" id="registrationDate" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="dueAmount">TOTAL AMOUNT DUE</label> <input type="text"
							name="dueAmount" id="dueAmount" required="required"
							placeholder="ENTER AMOUNT DUE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="pendingInterest">PENDING INTEREST</label> <input type="text"
							name="pendingInterest" id="pendingInterest" required="required"
							placeholder="ENTER PENDING INTEREST" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="pendingPrincipal">PENDING PRINCIPAL</label> <input type="text"
							name="pendingPrincipal" id="pendingPrincipal" required="required"
							placeholder="ENTER PENDING PRINCIPAL" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="totalDue">TOTAL DUE</label> <input type="text" name="totalDue"
							id="totalDue" required="required" placeholder="ENTER TOTAL DUE" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="paymentAmount">PAYMENT AMOUNT</label> <input type="text"
							name="paymentAmount" id="paymentAmount" required="required"
							placeholder="ENTER PAYMENT AMOUNT" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="PaymentDate">PAYMENT DATE</label> <input type="date"
							name="PaymentDate" id="PaymentDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="netAmount">NET AMOUNT</label> <input type="text"
							name="netAmount" id="netAmount" required="required"
							placeholder="ENTER NET AMOUNT" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="sourcePayment">PAYMENT MODE <span id="star">*</span></label>
						<select id="sourcePayment" name="sourcePayment"
							required="required" class="form-control selectField"
							style="height: 30px;">
							<option value="">-SELECT PAYMENT MODE-</option>
							<option value="Cash">CASH</option>
							<option value="Saving Account">SAVING ACCOUNT</option>
						</select>
						<!-- Alias for backward compatibility -->
						<input type="hidden" id="modeofPayment" name="modeofPayment" value="" />
					</div>
				</div>

				<div class="col-lg-3" id="savingAccountWrapper" style="display: none;">
					<div class="d-flex flex-column formFields mb-4">
						<label for="savingAccountNo">SAVINGS ACCOUNT NO <span style="color:red;">*</span></label>
						<select id="savingAccountNo" name="accountNo"
							class="form-control selectField" style="height: 30px;">
							<option value="">SELECT ACCOUNT</option>
						</select>
						<input type="hidden" id="accountNumber" name="accountNumber" value="" />
					</div>
				</div>

				<div class="col-lg-3" id="savingBalanceWrapper" style="display: none;">
					<div class="d-flex flex-column formFields mb-4">
						<label for="savingBalance">AVAILABLE BALANCE</label> <input type="text"
							name="savingBalance" id="savingBalance" readonly
							placeholder="&#8377; 0.00"
							style="background: #e8f5e9; color: #1b5e20; font-weight: bold;" />
						<input type="hidden" id="savingsBalance" value="" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="penaltyAmount">PENALTY AMOUNT</label> <input type="text"
							name="penaltyAmount" id="penaltyAmount" readonly
							placeholder="&#8377; 0.00" style="background: #fff8f8; font-weight: bold; color: #c62828;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="daysLate">DAYS LATE</label> <input type="text"
							name="daysLate" id="daysLate" readonly
							placeholder="0" style="background: #f9f9f9; font-weight: bold;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="financialConsultantId">FINANCIAL CONSULTANT CODE</label>
						<select id="financialConsultantId" name="financialConsultantId"
							class="form-control selectField" style="height: 30px;">
							<option value="">-- SELECT FINANCIAL CONSULTANT --</option>
						</select>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="financialConsultantName">FINANCIAL CONSULTANT NAME</label>
						<input type="text" name="financialConsultantName"
							id="financialConsultantName" readonly="readonly"
							placeholder="FINANCIAL CONSULTANT NAME" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="remarks">REMARKS</label> <input type="text"
							name="remarks" id="remarks"
							placeholder="ENTER REMARKS" />
					</div>
				</div>

				<!-- CASH NOTE DENOMINATION SECTION -->
				<div class="col-12" id="cashDenominationWrapper" style="display: none; margin-top: 15px; margin-bottom: 20px;">
					<div style="background: #ffffff; border: 1px solid #cbd5e1; border-left: 4px solid #059669; border-radius: 8px; padding: 16px; box-shadow: 0 1px 3px rgba(0,0,0,0.05);">
						<div class="d-flex justify-content-between align-items-center mb-3">
							<div style="font-weight: 700; color: #1e293b; font-size: 14px;">
								<i class="bi bi-cash-stack" style="color: #059669; margin-right: 6px; font-size: 16px;"></i>
								CASH NOTE DENOMINATION
							</div>
							<div class="d-flex align-items-center gap-3">
								<span style="font-size: 12px; color: #64748b;">Total Notes: <b id="totalNotesCount" style="color: #1e293b;">0</b></span>
								<span style="font-size: 13px; font-weight: 700; color: #059669;">Total Cash: <span id="denominationGrandTotal">&#8377; 0.00</span></span>
								<span id="denominationMatchBadge" style="display: none; padding: 3px 8px; border-radius: 4px; font-size: 11px; font-weight: bold;"></span>
							</div>
						</div>

						<div class="row g-2">
							<div class="col-lg-2 col-md-4 col-6">
								<div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 8px; text-align: center;">
									<div style="font-weight: bold; color: #334155; font-size: 13px;">&#8377; 500</div>
									<div class="d-flex align-items-center justify-content-center gap-1 mt-1">
										<span style="font-size: 11px; color: #64748b;">×</span>
										<input type="number" min="0" id="denom500" class="form-control form-control-sm denom-count" placeholder="0" style="width: 75px; text-align: center; height: 28px; font-weight: bold;" />
									</div>
									<div id="denomSub500" style="font-size: 11px; color: #059669; margin-top: 4px; font-weight: bold;">&#8377; 0</div>
								</div>
							</div>

							<div class="col-lg-2 col-md-4 col-6">
								<div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 8px; text-align: center;">
									<div style="font-weight: bold; color: #334155; font-size: 13px;">&#8377; 200</div>
									<div class="d-flex align-items-center justify-content-center gap-1 mt-1">
										<span style="font-size: 11px; color: #64748b;">×</span>
										<input type="number" min="0" id="denom200" class="form-control form-control-sm denom-count" placeholder="0" style="width: 75px; text-align: center; height: 28px; font-weight: bold;" />
									</div>
									<div id="denomSub200" style="font-size: 11px; color: #059669; margin-top: 4px; font-weight: bold;">&#8377; 0</div>
								</div>
							</div>

							<div class="col-lg-2 col-md-4 col-6">
								<div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 8px; text-align: center;">
									<div style="font-weight: bold; color: #334155; font-size: 13px;">&#8377; 100</div>
									<div class="d-flex align-items-center justify-content-center gap-1 mt-1">
										<span style="font-size: 11px; color: #64748b;">×</span>
										<input type="number" min="0" id="denom100" class="form-control form-control-sm denom-count" placeholder="0" style="width: 75px; text-align: center; height: 28px; font-weight: bold;" />
									</div>
									<div id="denomSub100" style="font-size: 11px; color: #059669; margin-top: 4px; font-weight: bold;">&#8377; 0</div>
								</div>
							</div>

							<div class="col-lg-2 col-md-4 col-6">
								<div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 8px; text-align: center;">
									<div style="font-weight: bold; color: #334155; font-size: 13px;">&#8377; 50</div>
									<div class="d-flex align-items-center justify-content-center gap-1 mt-1">
										<span style="font-size: 11px; color: #64748b;">×</span>
										<input type="number" min="0" id="denom50" class="form-control form-control-sm denom-count" placeholder="0" style="width: 75px; text-align: center; height: 28px; font-weight: bold;" />
									</div>
									<div id="denomSub50" style="font-size: 11px; color: #059669; margin-top: 4px; font-weight: bold;">&#8377; 0</div>
								</div>
							</div>

							<div class="col-lg-2 col-md-4 col-6">
								<div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 8px; text-align: center;">
									<div style="font-weight: bold; color: #334155; font-size: 13px;">&#8377; 20</div>
									<div class="d-flex align-items-center justify-content-center gap-1 mt-1">
										<span style="font-size: 11px; color: #64748b;">×</span>
										<input type="number" min="0" id="denom20" class="form-control form-control-sm denom-count" placeholder="0" style="width: 75px; text-align: center; height: 28px; font-weight: bold;" />
									</div>
									<div id="denomSub20" style="font-size: 11px; color: #059669; margin-top: 4px; font-weight: bold;">&#8377; 0</div>
								</div>
							</div>

							<div class="col-lg-2 col-md-4 col-6">
								<div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 8px; text-align: center;">
									<div style="font-weight: bold; color: #334155; font-size: 13px;">&#8377; 10</div>
									<div class="d-flex align-items-center justify-content-center gap-1 mt-1">
										<span style="font-size: 11px; color: #64748b;">×</span>
										<input type="number" min="0" id="denom10" class="form-control form-control-sm denom-count" placeholder="0" style="width: 75px; text-align: center; height: 28px; font-weight: bold;" />
									</div>
									<div id="denomSub10" style="font-size: 11px; color: #059669; margin-top: 4px; font-weight: bold;">&#8377; 0</div>
								</div>
							</div>

							<div class="col-lg-2 col-md-4 col-6">
								<div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 8px; text-align: center;">
									<div style="font-weight: bold; color: #334155; font-size: 13px;">&#8377; 5</div>
									<div class="d-flex align-items-center justify-content-center gap-1 mt-1">
										<span style="font-size: 11px; color: #64748b;">×</span>
										<input type="number" min="0" id="denom5" class="form-control form-control-sm denom-count" placeholder="0" style="width: 75px; text-align: center; height: 28px; font-weight: bold;" />
									</div>
									<div id="denomSub5" style="font-size: 11px; color: #059669; margin-top: 4px; font-weight: bold;">&#8377; 0</div>
								</div>
							</div>

							<div class="col-lg-2 col-md-4 col-6">
								<div style="background: #f8fafc; border: 1px solid #e2e8f0; border-radius: 6px; padding: 8px; text-align: center;">
									<div style="font-weight: bold; color: #334155; font-size: 13px;">&#8377; 2</div>
									<div class="d-flex align-items-center justify-content-center gap-1 mt-1">
										<span style="font-size: 11px; color: #64748b;">×</span>
										<input type="number" min="0" id="denom2" class="form-control form-control-sm denom-count" placeholder="0" style="width: 75px; text-align: center; height: 28px; font-weight: bold;" />
									</div>
									<div id="denomSub2" style="font-size: 11px; color: #059669; margin-top: 4px; font-weight: bold;">&#8377; 0</div>
								</div>
							</div>

							<div class="col-lg-2 col-md-4 col-6">
								<div style="background: #fff8e1; border: 1px solid #ffe082; border-radius: 6px; padding: 8px; text-align: center;">
									<div style="font-weight: bold; color: #5d4037; font-size: 13px;">&#8377; 1 <span style="font-size:10px; color:#795548;">(Coin)</span></div>
									<div class="d-flex align-items-center justify-content-center gap-1 mt-1">
										<span style="font-size: 11px; color: #64748b;">×</span>
										<input type="number" min="0" id="denom1" class="form-control form-control-sm denom-count" placeholder="0" style="width: 75px; text-align: center; height: 28px; font-weight: bold;" />
									</div>
									<div id="denomSub1" style="font-size: 11px; color: #795548; margin-top: 4px; font-weight: bold;">&#8377; 0</div>
								</div>
							</div>
						</div>

						<!-- Denomination Alert Box -->
						<div id="denominationAlertMsg" style="display: none; margin-top: 12px; padding: 10px 14px; border-radius: 6px; font-size: 13px; font-weight: 600;"></div>
					</div>
				</div>

			</div>
		</div>

		<input type="hidden" id="paidInstallments" name="paidInstallments" value="0" />

		<div class="row mt-4 mb-4">
			<div class="col-12 text-center">
				<button type="button" id="payEmiBtn" class="btn btn-success px-4 py-2" style="font-weight: 600; font-size: 14px; border-radius: 6px; box-shadow: 0 2px 6px rgba(16,185,129,0.3);">
					<i class="bi bi-credit-card-2-front" style="margin-right: 6px;"></i> PAY EMI
				</button>
				<button type="button" id="resetBtn" class="btn btn-secondary px-4 py-2" style="font-weight: 600; font-size: 14px; border-radius: 6px; margin-left: 12px;">
					<i class="bi bi-arrow-counterclockwise" style="margin-right: 6px;"></i> RESET
				</button>
				<!-- Hidden button for backward-compatibility if referenced -->
				<button type="button" id="saveBtn" style="display: none;"></button>
			</div>
		</div>

		<div class="mt-5" id="emiHistorySection" style="display: none;">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">PAID INSTALLMENT HISTORY</li>
				</ol>
			</nav>
			<div class="table-responsive">
				<table class="table table-bordered table-striped" id="emiHistoryTable">
					<thead class="table-dark">
						<tr>
							<th>#</th>
							<th>INSTALLMENT</th>
							<th>DUE AMOUNT</th>
							<th>PAID AMOUNT</th>
							<th>PAYMENT DATE</th>
							<th>PAYMENT MODE</th>
							<th>SAVINGS A/C</th>
							<th>REMARKS</th>
						</tr>
					</thead>
					<tbody id="emiHistoryBody">
					</tbody>
				</table>
			</div>
		</div>
	</form>

</div>

<script
	src="${pageContext.request.contextPath}/js/SecuredGoldLoan/EMIInsatllmentPayment.js"></script>

