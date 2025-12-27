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
					distinctMap.set(goldId.trim(), item.customerName.toUpperCase());
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
						$("#loanDate").val(data.loanDate);
						$("#customerCode").val(data.memberCode);
						$("#customerName").val(data.customerName.toUpperCase());
						$("#contactNo").val(data.contactNo);
						$("#branchName").val(data.branchName.toUpperCase());
						$("#loanPlanName").val(data.loanPlanName.toUpperCase());
						$("#typeOfLoan").val(data.typeOfLoan.toUpperCase());
						$("#loanMode").val(data.loanMode.toUpperCase());
						$("#loanTerm").val(data.loanTerm.toUpperCase());
						$("#rateOfInterest").val(data.rateOfInterest);
						$("#loanAmount").val(data.loanAmount);
						$("#interestType").val(data.interestType.toUpperCase());
						$("#emiPayment").val(data.emiPayment.toUpperCase());
						let term = data.loanTerm;

						let installmentDropdown = $("#installment");

						   installmentDropdown.empty(); // Clear previous options
						   installmentDropdown.append(`<option value="">-SELECT INSTALLMENT-</option>`);

						   if (!isNaN(term) && term > 0) {
						       for (let i = 1; i <= term; i++) {
						           installmentDropdown.append(
						               `<option value="${i}">INSTALLMENT ${i}</option>`
						           );
						       }
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
	
	// ---------------- ON INSTALLMENT CHANGE CALCULATION ----------------
	$("#installment").change(function () {

	    let installmentNo = Number($(this).val());
	    if (!installmentNo) return;

	    // Loan details already filled in inputs from backend
	    let loanAmount = Number($("#loanAmount").val());
	    let rateOfInterest = Number($("#rateOfInterest").val()); // yearly %
	    let loanTerm = Number($("#loanTerm").val());
	    let loanDate = $("#loanDate").val();

	    // ---------------- BASIC VALUES ----------------
	    let monthlyInterestRate = (rateOfInterest / 100) / 12;
	    let emi = Math.round(loanAmount / loanTerm);   // Simple EMI

	    // ---------------- CALCULATE FOR SELECTED INSTALLMENT ----------------
	    let remainingPrincipal = loanAmount;
	    let totalInterestPaid = 0;
	    let totalPrincipalPaid = 0;

	    for (let i = 1; i <= installmentNo; i++) {

	        let interestForMonth = Math.round(remainingPrincipal * monthlyInterestRate);
	        let principalForMonth = emi - interestForMonth;

	        if (principalForMonth < 0) principalForMonth = 0;

	        totalInterestPaid += interestForMonth;
	        totalPrincipalPaid += principalForMonth;

	        remainingPrincipal -= principalForMonth;
	        if (remainingPrincipal < 0) remainingPrincipal = 0;
	    }

	    // --------- Final Values to Display ----------
	    let pendingInterest = Math.round((loanAmount * monthlyInterestRate * loanTerm) - totalInterestPaid);
	    if (pendingInterest < 0) pendingInterest = 0;

	    let pendingPrincipal = Math.round(remainingPrincipal);
	    let dueAmount = emi;

	    // ---------- REGISTRATION DATE (loanDate + installmentNo months) ----------
	    let d = new Date(loanDate);
	    d.setMonth(d.getMonth() + installmentNo);
	    let formattedDate = d.toISOString().split("T")[0];

	    // ----------- SET VALUES TO INPUT FIELDS ----------
	    $("#registrationDate").val(formattedDate);
	    $("#dueAmount").val(dueAmount);
	    $("#pendingInterest").val(pendingInterest);
	    $("#pendingPrincipal").val(pendingPrincipal);

	});
	
	$("#saveBtn").click(function () {

	    // Collect data from your form fields
	    let emiData = {
	        goldID: $("#findByGoldLoanId").val(),
	        loanDate: $("#loanDate").val(),
	        customerCode: $("#customerCode").val(),
	        customerName: $("#customerName").val(),
	        loanPlanName: $("#loanPlanName").val(),
			interestType: $("#interestType").val(),
			loanMode: $("#loanMode").val(),
			loanTerm: $("#loanTerm").val(),
			emiPayment: $("#emiPayment").val(),
			typeOfLoan: $("#typeOfLoan").val(),
			rateOfInterest: $("#rateOfInterest").val(),
			contactNo: $("#contactNo").val(),
			loanAmount: $("#loanAmount").val(),
			branchName: $("#branchName").val(),
			
			//Payment Details
			installment: $("#installment").val(),
			registrationDate: $("#registrationDate").val(),
			dueAmount: $("#dueAmount").val(),
			pendingInterest: $("#pendingInterest").val(),
			pendingPrincipal: $("#pendingPrincipal").val(),
			totalDue: $("#totalDue").val(),
			paymentAmount: $("#paymentAmount").val(),
			paymentDate: $("#paymentDate").val(),
			netAmount: $("#netAmount").val(),
			paymentMode: $("#paymentMode").val(),
			financialCode: $("#financialCode").val(),
			financialName: $("#financialName").val(),
			remarks: $("#remarks").val(),
	    };

	    console.log("Sending EMI Data: ", emiData);

	    $.ajax({
	        url: "api/securedGoldLoan/saveEMIInstallmentData",
	        type: "POST",
	        contentType: "application/json",
	        data: JSON.stringify(emiData),
	        success: function (res) {
	            if (res.status === "OK") {
	                alert(res.data);
					location.reload();
	            } else {
	                alert(res.data);
	            }
	        },

	        error: function (xhr) {
	            alert(xhr);
	            console.error(xhr);
	        }
	    });

	});



});