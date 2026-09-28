$(document).ready(function() {

	$.ajax({
		url: 'api/securedGoldLoan/getAllActive',
		type: 'GET',
		success: function(response) {
			// Check data
			if (!(response && response.data && Array.isArray(response.data))) {
				alert("No Gold Data found.");
				return;
			}

			// 👉 Step 1: Distinct Set banaye
			let distinctMap = new Map();
			// Map use kiya taaki GoldID ke hisab se latest/first customerName bhi mil jaye

			response.data.forEach(function(item) {
				let goldId = item.goldID || item.goldId;
				if (goldId && goldId.trim() !== "") {
					distinctMap.set(goldId.trim(), item.customerName);
				}
			});

			// 👉 Step 2: Select2 ke liye data convert
			let goldOptions = [];
			distinctMap.forEach((customerName, goldId) => {
				goldOptions.push({
					id: goldId,
					text: goldId + " - " + customerName
				});
			});

			// 👉 Step 3: Select2 Initialize (distinct data)
			$('#findByGoldLoanId').select2({
				placeholder: '-- Search Gold ID or Name --',
				data: goldOptions,
				matcher: function(params, data) {
					if ($.trim(params.term) === '') return data;
					if (typeof data.text === 'undefined') return null;

					const term = params.term.toLowerCase();
					const text = data.text.toLowerCase();
					return text.includes(term) ? data : null;
				}
			});
		},
		error: function(xhr, status, error) {
			console.error("Error fetching Gold Data:", error);
			alert("Failed to load Gold ID.");
		}
	});

	// Load Financial Consultants (Codes and Names)
	function loadFinancialConsultants(selectedCode) {
		$.ajax({
			url: 'api/financialconsultant/getAllFinancialConsultantDetails',
			type: 'GET',
			dataType: 'json',
			success: function(response) {
				const $dropdown = $('#financialConsultantId');
				$dropdown.empty().append('<option value="">-- SELECT FINANCIAL CONSULTANT --</option>');
				if (response && response.data && Array.isArray(response.data)) {
					response.data.forEach(function(c) {
						const code = c.financialCode || '';
						const name = (c.financialName || '').toUpperCase();
						if (code) {
							$dropdown.append(`<option value="${code}" data-name="${name}">${code} - ${name}</option>`);
						}
					});
					if (selectedCode) {
						$dropdown.val(selectedCode).trigger('change');
					}
				}
			},
			error: function(xhr) {
				console.error("Error loading financial consultants:", xhr);
			}
		});
	}

	loadFinancialConsultants();

	// Auto-fill consultant name on code selection
	$("#financialConsultantId").change(function() {
		const selectedOpt = $(this).find("option:selected");
		const name = selectedOpt.data("name") || "";
		if (name) {
			$("#financialConsultantName").val(name);
		}
	});

	$("#findByGoldLoanId").change(function() {

		let findByGoldLoanId = $("#findByGoldLoanId").val();
		if (findByGoldLoanId !== "") {
			$.ajax({
				url: "api/securedGoldLoan/getByGoldIDforApproval",
				type: "POST",
				contentType: "application/json",
				data: JSON.stringify({
					goldID: findByGoldLoanId
				}),
				success: function(response) {
					if (response.status == "OK") {
						let data = response.data[0];
						$("#goldLoanDate").val(data.loanDate);
						$("#customerCode").val(data.memberCode);
						$("#customerName").val(data.customerName.toUpperCase());
						$("#dateOfBirth").val(data.dateOfBirth);
						$("#age").val(data.age);
						$("#contactNo").val(data.contactNo);
						$("#address").val(data.address);
						$("#pinCode").val(data.pinCode);
						$("#branchName").val(data.branchName.toUpperCase());
						$("#loanPlanName").val(data.loanPlanName.toUpperCase());
						$("#typeOfLoan").val(data.typeOfLoan.toUpperCase());
						$("#loanMode").val(data.loanMode.toUpperCase());
						$("#loanTerm").val(data.loanTerm.toUpperCase());
						$("#rateOfInterest").val(data.rateOfInterest);
						$("#loanAmount").val(data.loanAmount);
						$("#interestType").val(data.interestType.toUpperCase());
						$("#emiPayment").val(data.emiPayment.toUpperCase());
						$("#purposeOfLoan").val(data.purposeOfLoan);

						//Gold Details
						$("#karat").val(data.karat.toUpperCase());
						$("#itemType").val(data.itemType);
						$("#custgoldRate").val(data.custgoldRate.toUpperCase());
						$("#itemName").val(data.itemName.toUpperCase());
						$("#lockerBranch").val(data.lockerBranch.toUpperCase());
						$("#purity").val(data.purity);
						$("#itemQty").val(data.itemQty);
						$("#itemWt").val(data.itemWt);
						$("#grossWt").val(data.grossWt);
						$("#stoneWt").val(data.stoneWt);
						$("#netWt").val(data.netWt);
						$("#marketValuation").val(data.marketValuation);
						$("#eligibleLoan").val(data.eligibleLoan);

						//Guarantor Details
						$("#guarantorcustomerCode").val(data.guarantorcustomerCode);
						$("#guarantorIdentity").val(data.guarantorIdentity);
						$("#guarantorAddress").val(data.guarantorAddress);
						$("#guarantorPinCode").val(data.guarantorPinCode);
						$("#guarantorContactNo").val(data.guarantorContactNo);
						$("#guarantorSecurityType").val(data.guarantorSecurityType);

						//CoApplicant Details
						$("#coApplicantMemberId").val(data.coApplicantMemberId);
						$("#coApplicantIdentity").val(data.coApplicantIdentity);
						$("#coApplicantAddress").val(data.coApplicantAddress);
						$("#coAge").val(data.coAge);
						$("#coApplicantContactNo").val(data.coApplicantContactNo);
						$("#securityDetails").val(data.securityDetails);

						//Deduction Details
						$("#processingFee").val(data.processingFee);
						$("#legalCharges").val(data.legalCharges);
						$("#stampDuty").val(data.stampDuty);
						$("#smsCharges").val(data.smsCharges);
						$("#mainCharges").val(data.mainCharges);
						$("#stationaryFee").val(data.stationaryFee);
						$("#gst").val(data.gst);
						$("#insuFee").val(data.insuFee);
						$("#penaltyCharge").val(data.penaltyCharge);
						$("#valuationFees").val(data.valuationFees);
						$("#overCharge").val(data.overCharge);
						$("#collectionCharge").val(data.collectionCharge);
						if (data.financialConsultantId) {
							$("#financialConsultantId").val(data.financialConsultantId).trigger('change');
						}
						if (data.financialConsultantName) {
							$("#financialConsultantName").val(data.financialConsultantName);
						}

						if (data.approvalStatus === true || data.approvalStatus === 1 || data.approvalStatus === "1") {
							$('#approvalStatus').val("Approved").css('color', 'green');
						} else {
							$('#approvalStatus').val("Not Approved").css('color', 'red');
						}

						// Payment Status display: UNPAID until disbursed
						let pStatus = (data.paymentStatus && data.paymentStatus.trim() !== "") ? data.paymentStatus.toUpperCase() : "UNPAID";
						$("#paymentStatus").val(pStatus);
						if (pStatus === "PAID") {
							$("#paymentStatus").css({"color": "green", "font-weight": "bold"});
							$("#paymentBtn").prop("disabled", true).text("LOAN ALREADY DISBURSED").css("background-color", "#28a745");
						} else {
							$("#paymentStatus").css({"color": "red", "font-weight": "bold"});
							$("#paymentBtn").prop("disabled", false).text("DISBURSE TO SAVINGS ACCOUNT").css("background-color", "#FFA500");
						}

						// Net Disbursement Amount
						let disburseAmt = data.netDisbursement || data.sanctionedAmount || data.loanAmount || "0";
						$("#paymentAmount").val(disburseAmt);
						$("#noOfInst").val(data.loanAmount || "0");
						$("#modeofPayment").val("Saving Account");

						// Set default payment date to today
						if (!$("#paymentDate").val()) {
							let today = new Date().toISOString().split('T')[0];
							$("#paymentDate").val(today);
						}

						// Auto-fetch Customer Savings Account Number
						if (data.memberCode) {
							$.ajax({
								url: "api/customersavings/getAccountNumbersByCode?selectByCustomer=" + encodeURIComponent(data.memberCode),
								type: "GET",
								success: function(accResp) {
									if (accResp && accResp.data && accResp.data.length > 0) {
										let acc = accResp.data[0];
										let accNum = acc.accountNumber || (typeof acc === "string" ? acc : "");
										$("#depositAccount").val(accNum);
									} else if (accResp && Array.isArray(accResp) && accResp.length > 0) {
										let acc = accResp[0];
										let accNum = acc.accountNumber || (typeof acc === "string" ? acc : "");
										$("#depositAccount").val(accNum);
									}
								},
								error: function() {
									console.log("Could not load savings account for member " + data.memberCode);
								}
							});
						}

					} else {
						alert("No customer found for this member code.");
					}
				},
				error: function() {
					alert("Member not found or server error.");
				}
			});
		}
	});

	$("#paymentBtn").click(function(e) {
		e.preventDefault();

		let goldLoanId = $("#findByGoldLoanId").val();
		if (!goldLoanId || goldLoanId.trim() === "") {
			alert("Please search and select a Gold Loan ID first!");
			return;
		}

		let currentStatus = $("#paymentStatus").val();
		if (currentStatus === "PAID") {
			alert("This Gold Loan is already disbursed and PAID.");
			return;
		}

		let depositAcc = $("#depositAccount").val();
		if (!depositAcc || depositAcc.trim() === "") {
			alert("Customer savings account not found! A savings account is required for disbursement.");
			return;
		}

		let payAmt = $("#paymentAmount").val();
		if (!payAmt || parseFloat(payAmt) <= 0) {
			alert("Invalid disbursement amount!");
			return;
		}

		let requestData = {

			// ---------- Customer Details ----------
			goldID: goldLoanId,
			customerCode: $("#customerCode").val(),
			customerName: $("#customerName").val(),
			dateOfBirth: $("#dateOfBirth").val(),
			age: $("#age").val(),
			contactNo: $("#contactNo").val(),
			address: $("#address").val(),
			pinCode: $("#pinCode").val(),
			branchName: $("#branchName").val(),

			// ---------- Loan Details ----------
			goldLoanDate: $("#goldLoanDate").val(),
			loanPlanName: $("#loanPlanName").val(),
			typeOfLoan: $("#typeOfLoan").val(),
			loanTerm: $("#loanTerm").val(),
			loanMode: $("#loanMode").val(),
			rateOfInterest: $("#rateOfInterest").val(),
			loanAmount: $("#loanAmount").val(),
			interestType: $("#interestType").val(),
			emiPayment: $("#emiPayment").val(),
			purposeOfLoan: $("#purposeOfLoan").val(),

			// ---------- Gold/Silver Details ----------
			karat: $("#karat").val(),
			itemType: $("#itemType").val(),
			custgoldRate: $("#custgoldRate").val(),
			itemName: $("#itemName").val(),
			lockerBranch: $("#lockerBranch").val(),
			purity: $("#purity").val(),
			itemQty: $("#itemQty").val(),
			itemWt: $("#itemWt").val(),
			grossWt: $("#grossWt").val(),
			stoneWt: $("#stoneWt").val(),
			netWt: $("#netWt").val(),
			marketValuation: $("#marketValuation").val(),
			eligibleLoan: $("#eligibleLoan").val(),

			// ---------- Guarantor Details ----------
			guarantorcustomerCode: $("#guarantorcustomerCode").val(),
			guarantorIdentity: $("#guarantorIdentity").val(),
			guarantorAddress: $("#guarantorAddress").val(),
			guarantorPinCode: $("#guarantorPinCode").val(),
			guarantorContactNo: $("#guarantorContactNo").val(),
			guarantorSecurityType: $("#guarantorSecurityType").val(),

			// ---------- Co-Applicant Details ----------
			coApplicantMemberId: $("#coApplicantMemberId").val(),
			coApplicantIdentity: $("#coApplicantIdentity").val(),
			coApplicantAddress: $("#coApplicantAddress").val(),
			coAge: $("#coAge").val(),
			coApplicantContactNo: $("#coApplicantContactNo").val(),
			securityDetails: $("#securityDetails").val(),

			// ---------- Deduction Details ----------
			processingFee: $("#processingFee").val(),
			legalCharges: $("#legalCharges").val(),
			stampDuty: $("#stampDuty").val(),
			smsCharges: $("#smsCharges").val(),
			mainCharges: $("#mainCharges").val(),
			stationaryFee: $("#stationaryFee").val(),
			gst: $("#gst").val(),
			insuFee: $("#insuFee").val(),
			penaltyCharge: $("#penaltyCharge").val(),
			valuationFees: $("#valuationFees").val(),
			overdueInterestCharge: $("#overdueInterestCharge").val(),
			collectionCharge: $("#collectionCharge").val(),
			financialCode: $("#financialConsultantId").val(),
			financialName: $("#financialConsultantName").val(),

			// ---------- Payment Details ----------
			paymentDate: $("#paymentDate").val() || new Date().toISOString().split('T')[0],
			paymentStatus: "PAID",
			modeOfPayment: "Saving Account",
			paymentAmount: payAmt,
			chargeDeductCash: "0",
			remarks: $("#remarks").val() || "Gold Loan Disbursed to Savings Account",
			amountDue: $("#loanAmount").val(),
			depositAccount: depositAcc
		};

		// Disable button during processing
		$("#paymentBtn").prop("disabled", true).text("DISBURSING...");

		$.ajax({
			url: "api/securedGoldLoan/disburseGoldLoanPayment",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(requestData),
			success: function(response) {
				if (response.status === "OK" || response.status === "200") {
					alert(response.message || "Gold Loan disbursed successfully to customer savings account!");
					$("#paymentStatus").val("PAID").css({"color": "green", "font-weight": "bold"});
					$("#paymentBtn").prop("disabled", true).text("LOAN ALREADY DISBURSED").css("background-color", "#28a745");
				} else {
					alert("Warning: " + response.message);
					$("#paymentBtn").prop("disabled", false).text("DISBURSE TO SAVINGS ACCOUNT").css("background-color", "#FFA500");
				}
			},
			error: function(xhr) {
				let errMsg = "Disbursement failed.";
				try {
					let errObj = JSON.parse(xhr.responseText);
					if (errObj && errObj.message) errMsg = errObj.message;
				} catch (e) {}
				alert("Error: " + errMsg);
				$("#paymentBtn").prop("disabled", false).text("DISBURSE TO SAVINGS ACCOUNT").css("background-color", "#FFA500");
			}
		});
	});

});

function fetchEMIValues() {

	var goldID = $("#findByGoldLoanId").val();

	var loanAmount = Number($("#loanAmount").val()) || 0;
	var rateOfInterest = Number($("#rateOfInterest").val()) || 0;
	//var loanTerm = Number($("#loanTerm").val()) || 0;

	let monthlyInterest = (loanAmount * rateOfInterest) / (100 * 12);
	//let monthlyInterest = totalInterest / loanTerm;

	$.ajax({
		url: "api/securedGoldLoan/getEMIInstallmentDataByGoldID",
		type: "GET",
		data: { goldID: goldID },

		success: function(response) {

			console.log(response);

			// EMIInstallment table मध्ये data असेल
			if (response && response.data && response.data.length > 0) {

				var lastEmi = response.data[response.data.length - 1];
				var pendingPrincipal = lastEmi.pendingPrincipal || 0;

				$("#pendingPrincipal").val(pendingPrincipal);

				// installment आहे
				$("#paymentAmount").val(pendingPrincipal);

			} else {

				// EMIInstallment table मध्ये data नाही
				var paymentAmount = loanAmount + monthlyInterest;

				$("#paymentAmount").val(paymentAmount);
				

			}

		},

		error: function() {
			alert("Error");

			/*// API error आला तरी run होईल
			var paymentAmount = loanAmount + monthlyInterest;

			$("#paymentAmount").val(paymentAmount);*/

		},

		/*complete: function() {
			alert("3")
			// काहीच response नसेल तरी run
			if (!$("#paymentAmount").val()) {

				var paymentAmount = loanAmount + monthlyInterest;

				$("#paymentAmount").val(paymentAmount);

			}

		}*/

	});

}