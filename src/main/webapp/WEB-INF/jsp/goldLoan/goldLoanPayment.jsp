
<div class="pagetitle">
	<h1>Secured Gold Loan</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-coin"></i>
			</a></li>
			<li class="breadcrumb-item action">Gold Loan Payment</li>
		</ol>
	</nav>
</div>

<div>
	<form id="loanApprovalForm">
		<div class="">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Details</li>
				</ol>
			</nav>
			<div class="row">

				<div class="col-lg-5">
					<div class="d-flex flex-column formFields mb-4">
						<label for="findByGoldLoanId" id="goldSelection">Gold ID </label>
						<select id="findByGoldLoanId" name="findByGoldLoanId"
							class="form-control selectField" style="width: 100%;">
							<option value="">-- Search Gold ID --</option>
						</select>
					</div>
				</div>


			</div>


		</div>
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Loan Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanDate">Date of Loan</label> <input type="date"
							name="goldLoanDate" id="goldLoanDate" required="required"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="customerCode">Customer Code</label> <input type="text"
							name="customerCode" id="customerCode" readonly="readonly"
							required="required" placeholder="Enter Customer Code"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="customerName">Customer Name</label> <input type="text"
							name="customerName" id="customerName" readonly="readonly"
							required="required" placeholder="Enter Customer Name"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="dateOfBirth">Date Of Birth</label> <input type="date"
							name="dateOfBirth" id="dateOfBirth" readonly="readonly"
							required="required" style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Age </label> <input type="text" name="age"
							readonly="readonly" id="age" required="required" placeholder="" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Contact No.</label> <input type="text"
							readonly="readonly" name="contactNo" id="contactNo"
							required="required" placeholder="Enter Contact No." />
					</div>
				</div>

				<div class="col-lg-3" style="margin-bottom: 30px;">
					<div class="d-flex flex-column formFields">
						<label for="">Address</label>
						<textarea name="address" id="address" readonly="readonly"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="loanName">Pin Code</label> <input type="text"
							name="pinCode" id="pinCode" required="required"
							readonly="readonly" placeholder="Enter Pin Code"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="branchName">Branch Name</label> <input type="text"
							name="branchName" id="branchName" required="required"
							readonly="readonly" placeholder="Enter Branch Name"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Plan Name</label> <input type="text"
							name="loanPlanName" id="loanPlanName" required="required"
							placeholder="Enter Loan Plan Name" readonly="readonly"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Type Of Loan</label> <input type="text"
							name="typeOfLoan" id="typeOfLoan" required="required"
							placeholder="Enter Type of Loan " readonly="readonly"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Term</label> <input type="text" name="loanTerm"
							id="loanTerm" required="required" readonly="readonly"
							placeholder="Enter Plan Duration"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Loan Mode</label> <input type="text" name="loanMode"
							id="loanMode" required="required" readonly="readonly"
							placeholder="Loan Category" style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Rate of Interest (%pa.)</label> <input type="text"
							name="rateOfInterest" id="rateOfInterest" required="required"
							placeholder="Enter Loan Rate of Interest" readonly="readonly"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Amount Of Loan</label> <input type="text"
							name="loanAmount" id="loanAmount" required="required"
							placeholder="Enter Amount Of Loan" readonly="readonly"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Interest Type</label> <input type="text"
							name="interestType" id="interestType" required="required"
							placeholder="Enter Interest Type" readonly="readonly"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">EMI Payment</label> <input type="text"
							name="emiPayment" id="emiPayment" required="required"
							placeholder="Enter EMI Payment" readonly="readonly"
							style="text-transform: uppercase;" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Purpose of Loan </label> <input type="text"
							name="purposeOfLoan" id="purposeOfLoan" required="required"
							placeholder="Enter Purpose of Loan" readonly="readonly"
							style="text-transform: uppercase;" />
					</div>
				</div>

			</div>
		</div>

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Gold/Silver Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="karat">Karat</label> <input type="text" name="karat"
							id="karat" required="required" placeholder="Enter Karat"
							readonly="readonly" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Item Type</label> <select id="itemType"
							name="itemType" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">-Select-</option>
							<option value="Gold">Gold</option>
						</select>
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Karat Rate</label> <input type="text"
							readonly="readonly" name="custgoldRate" id="custgoldRate"
							required="required" placeholder="Enter Karat Rate" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Item Name</label> <input type="text" name="itemName"
							id="itemName" required="required" readonly="readonly"
							placeholder="Enter Item Name" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Locker Branch</label> <input type="text"
							name="lockerBranch" id="lockerBranch" required="required"
							readonly="readonly" placeholder="Enter Locker Branch" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="purity">Purity</label> <input type="text"
							name="purity" id="purity" required="required" readonly="readonly"
							placeholder="Enter Purity" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Item Quantity</label> <input type="text"
							name="itemQty" id="itemQty" required="required"
							readonly="readonly" placeholder="Enter Quantity" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Item Weight</label> <input type="text" name="itemWt"
							id="itemWt" required="required" readonly="readonly"
							placeholder="Enter Item Weight" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Gross Weight</label> <input type="text"
							name="grosswt" id="grossWt" required="required"
							readonly="readonly" placeholder="Enter Gross Weight" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Stone Weight</label> <input type="text"
							name="stoneWt" id="stoneWt" required="required"
							readonly="readonly" placeholder="Enter Stone Weight" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Net Weight</label> <input type="text" name="netWt"
							readonly="readonly" id="netWt" required="required"
							placeholder="Enter Net Weight" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Market Valuation</label> <input type="text"
							name="marketValuatiion" id="marketValuation" readonly="readonly"
							required="required" placeholder="Enter Market Valuation" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Eligible Loan</label> <input type="text"
							name="eligibleLoan" id="eligibleLoan" required="required"
							readonly="readonly" placeholder="Enter Eligible Loan" />
					</div>
				</div>

			</div>
		</div>

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Gurantor Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="guarantorcustomerCode">Member Id</label> <input
							type="text" name="guarantorcustomerCode"
							id="guarantorcustomerCode" required="required"
							readonly="readonly" placeholder="Enter Customer Code" />
					</div>
				</div>
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Gurantor Identity</label> <input type="text"
							name="guarantorIdentity" id="guarantorIdentity"
							readonly="readonly" required="required"
							placeholder="Enter Guranntor Identity" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Address</label>
						<textarea name="guarantorAddress" id="guarantorAddress"
							readonly="readonly"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Pin Code</label> <input type="number"
							name="guarantorPinCode" id="guarantorPinCode" readonly="readonly"
							required="required" placeholder="Enter Pin Code" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Gurantor Contact No.</label> <input type="text"
							name="guarantorContactNo" id="guarantorContactNo"
							readonly="readonly" required="required"
							placeholder="Enter  Gurantor Contact No." />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Security Type</label> <input type="text"
							name="guarantorSecurityType" id="guarantorSecurityType"
							readonly="readonly" required="required"
							placeholder="Enter  Security Type" />
					</div>
				</div>






			</div>


		</div>

		<div class="mt-5">
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Co-Applicant Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields"
						style="margin-bottom: 30px">

						<div class="position-relative">
							<div class="d-flex flex-column formFields mb-4">
								<label for="coApplicantMemberId">Customer Code</label> <input
									type="text" name="coApplicantMemberId" id="coApplicantMemberId"
									required="required" readonly="readonly"
									placeholder="Enter Customer Code" />
							</div>
						</div>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">CoApplicant Identity</label> <input type="text"
							name="coApplicantIdentity" id="coApplicantIdentity"
							readonly="readonly" required="required"
							placeholder="Enter Guranntor Identity" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Address</label>
						<textarea name="coApplicantAddress" id="coApplicantAddress"
							readonly="readonly"
							style="border: 1px solid rgb(224, 224, 224); border-radius: 5px; outline: none; padding: 5px; font-size: 12px;"></textarea>
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="coAge">Age</label> <input type="text" name="coAge"
							readonly="readonly" id="coAge" required="required"
							placeholder="Enter Age" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Gurantor Contact No.</label> <input type="text"
							name="coApplicantContactNo" id="coApplicantContactNo"
							readonly="readonly" required="required"
							placeholder="Enter  Gurantor Contact No." />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="securityDetails">Security Type</label> <input
							type="text" name="securityDetails" id="securityDetails"
							readonly="readonly" required="required"
							placeholder="Enter  Security Type" />
					</div>
				</div>

			</div>



		</div>

		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Deduction Details</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">

					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Processing Fee </label> <input type="text"
							name="processingFee" id="processingFee" required="required"
							readonly="readonly" style="text-transform: uppercase;"
							placeholder="Enter Processing Fee" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Legal Charges </label> <input type="text"
							name="legalCharges" id="legalCharges" required="required"
							readonly="readonly" style="text-transform: uppercase;"
							placeholder="Enter Legal Charges" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="loanName">Stamp Duty</label> <input type="text"
							name="stampDuty" id="stampDuty" required="required"
							readonly="readonly" placeholder="Enter Stamp Duty Fee"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="loanName">SMS Charges</label> <input type="text"
							name="smsCharges" id="smsCharges" required="required"
							readonly="readonly" placeholder="Enter Sms Charges fees"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="MainCharges">Maintainance Charges</label> <input
							type="text" name="mainCharges" id="mainCharges"
							readonly="readonly" required="required"
							placeholder="Enter Maintainance Charge"
							style="text-transform: uppercase;" />
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Stationary Charges Fee</label> <input type="text"
							name="stationaryFee" id="stationaryFee" required="required"
							readonly="readonly" placeholder="Enter Stationary Number Fee" />
					</div>
				</div>




				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">GST</label> <input type="text" name="gst" id="gst"
							required="required" placeholder="Enter GST" readonly="readonly"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Insurance Fees</label> <input type="text"
							name="insuFee" id="insuFee" required="required"
							readonly="readonly" placeholder="Enter Insurance Fee"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Penalty Charge</label> <input type="text"
							name="penaltyCharge" id="penaltyCharge" required="required"
							readonly="readonly" placeholder="Enter Penalty Charge"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Valuation Fees</label> <input type="text"
							name="valuationFees" id="valuationFees" required="required"
							readonly="readonly" placeholder="Enter Valuation Fees"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Overdue Intrest Charge</label> <input type="text"
							name="overCharge" id="overCharge" required="required"
							readonly="readonly" placeholder="Enter Overdue Charge"
							style="text-transform: uppercase;" />
					</div>
				</div>


				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Collection Charge</label> <input type="text"
							name="collectionCharge" id="collectionCharge" readonly="readonly"
							required="required" placeholder="Enter Collection Charge"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="financialConsultantId">Financial Consultant
							Name</label> <input type="text" name="financialConsultantId"
							id="financialConsultantId" required="required"
							placeholder="Enter Cosultant ID"
							style="text-transform: uppercase;" />
					</div>
				</div>

				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Financial Consultant Name</label> <input type="text"
							name="financialConsultantName" id="financialConsultantName"
							required="required" placeholder="Enter Cosultant Name"
							readonly="readonly" style="text-transform: uppercase;" />
					</div>
				</div>



			</div>
		</div>
		<nav>
			<ol class="breadcrumb breadcrumb-title">
				<li class="breadcrumb-item action">Payment Details</li>
			</ol>
		</nav>
		<div class="row">
			<div class="col-lg-3">

				<div class="d-flex flex-column formFields mb-4">
					<label for="loanName"> Date Of Payment </label> <input type="date"
						name="paymentDate" id="paymentDate" required="required"
						style="text-transform: uppercase;" />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="loanName">Payment Status</label> <input type="text"
						name="paymentStatus" id="paymentStatus" readonly
						style="color: red; font-weight: bold; font-size: 12px; text-transform: uppercase;"
						required="required" />


				</div>
			</div>
			<div class="col-lg-3">
				<div class="d-flex flex-column formFields">
					<label for="referenceCode">Mode of Payment <span id="star">*</span></label>
					<select id="modeofPayment" name="modeofPayment" required="required"
						class="form-control selectField" style="height: 30px;">
						<option value="">Enter Mode of Payment</option>
						<option value="Cash">CASH</option>
						<option value="Online">Online</option>
						<option value="Cheque">Cheque</option>
						<option value="NEFT">NEFT</option>


					</select>
				</div>
			</div>


			<div class="col-lg-3" id="displayCheque">
				<div class="d-flex flex-column formFields"
					style="margin-bottom: 30px">
					<label>Cheque Number <span id="star">*</span></label> <input
						type="text" name="chequeNo" id="chequeNo" required="required"
						placeholder="Enter Cheque No" style="text-transform: uppercase;" />
				</div>
			</div>

			<div class="col-lg-3" id="displaycheqdate">
				<div class="d-flex flex-column formFields"
					style="margin-bottom: 30px">
					<label>Cheque Date <span id="star">*</span></label> <input
						type="date" name="chequeDate" id="chequeDate" required="required"
						placeholder="Enter Cheque Date" style="text-transform: uppercase;" />
				</div>
			</div>


			<div class="col-lg-3" id="displaydeposit">
				<div class="d-flex flex-column formFields"
					style="margin-bottom: 30px">
					<label>Deposit Account <span id="star">*</span></label> <input
						type="text" name="depositAccount" id="depositAccount"
						required="required" placeholder="Enter Deposit Account"
						style="text-transform: uppercase;" />
				</div>
			</div>


			<div class="col-lg-3" id="displayRef">
				<div class="d-flex flex-column formFields">
					<label for="">Ref Number/UPI ID</label> <input type="text"
						name="refNo" id="refNo" required="required"
						placeholder="Enter Deposit Account"
						style="text-transform: uppercase;" />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="">Chrg. Deduct Cash</label> <select
						id="chargDeductCash" name="chargDeductCash" required="required"
						class="form-control selectField" style="height: 30px;">
						<option value="">Select Yes/No</option>
						<option value="Blue">Yes</option>
						<option value="Blue">No</option>

					</select>
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="loanName">Remarks</label> <input type="text"
						name="remarks" id="remarks" required="required"
						style="text-transform: uppercase;" />
				</div>
			</div>

			<div class="col-lg-3">
				<div class="d-flex flex-column formFields mb-4">
					<label for="loanName">Amount Due</label> <input type="text"
						name="noOfInst" id="noOfInst" required="required"
						style="text-transform: uppercase;" />
				</div>
			</div>




			<div class="col-12 text-center">
				<button type="button" id="paymentBtn" class="btnStyle"
					style="background-color: #FFA500;">Payment</button>

			</div>

		</div>
	</form>
</div>
<script>
	$(document).ready(function() {

		// sab fields ko default hide karo
		$("#displayCheque").hide();
		$("#displaycheqdate").hide();
		$("#displaydeposit").hide();
		$("#displayRef").hide();

		$("#modeofPayment").change(function() {
			let mode = $(this).val();

			// sab ko hide kardo pehle
			$("#displayCheque").hide();
			$("#displaycheqdate").hide();
			$("#displaydeposit").hide();
			$("#displayRef").hide();

			// sari required hata do pehle
			$("#chequeNo").prop("required", false);
			$("#chequeDate").prop("required", false);
			$("#depositAccount").prop("required", false);
			$("#refNo").prop("required", false);

			// ab payment mode ke hisab se show/hide
			if (mode === "Cash") {
				// Cash -> kuch nahi show hoga
			}

			else if (mode === "Cheque") {
				$("#displayCheque").show();
				$("#displaycheqdate").show();
				$("#depositAccount").show();

				$("#chequeNo").prop("required", true);
				$("#chequeDate").prop("required", true);
				$("#depositAccount").prop("required", true);
			}

			else if (mode === "Online") {
				$("#displayRef").show();

				$("#refNo").prop("required", true);
			}

			else if (mode === "NEFT") {
				$("#displayRef").show();
				$("#displaydeposit").show();

				$("#refNo").prop("required", true);
				$("#depositAccount").prop("required", true);
			}
		});

	});
</script>

<script
	src="${pageContext.request.contextPath}/js/SecuredGoldLoan/GoldPayment.js"></script>