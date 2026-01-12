$(document).ready(function() {
	console.log("Document ready");

	$.ajax({
		url: '/api/customermanagement/approved',
		type: 'GET',
		success: function(response) {

			console.log("API response:", response);

			const customers = response.data;

			if (Array.isArray(customers) && customers.length > 0) {

				const memberDropdown = $('#memberId');
				const guarantorDropdown = $('#guarantorMemberId');
				const coApplicantDropdown = $('#coApplicantMemberId');

				memberDropdown.empty();
				guarantorDropdown.empty();
				coApplicantDropdown.empty();

				const defaultOption = '<option value="">SELECT MEMBER</option>';

				memberDropdown.append(defaultOption);
				guarantorDropdown.append(defaultOption);
				coApplicantDropdown.append(defaultOption);

				customers.forEach(function(customer) {

					// 👍 Create full name safely
					let fullName = [
						customer.firstName,
						customer.middleName,
						customer.lastName
					].filter(Boolean).join(" ");
					// Ensure full name or memberCode exists
					if (customer.memberCode && fullName) {

						const option = `
	                        <option value="${customer.memberCode}" data-name="${fullName}">
	                            ${(fullName).toUpperCase()} - ${customer.memberCode}
	                        </option>
	                    `;

						memberDropdown.append(option);
						guarantorDropdown.append(option);
						coApplicantDropdown.append(option);
					}
				});

			} else {
				alert('No member data found');
			}
		},

		error: function(xhr, status, error) {
			console.error('AJAX Error:', status, error);
			alert('Failed to fetch members');
		}
	});

});


$(document).ready(function() {
	$('#memberId,#guarantorMemberId,#coApplicantMemberId').on('change', function() {
		const selectedCode = $(this).val(); // This is your memberCode now!
		const changedId = $(this).attr('id'); // ✅ Correct

		if (selectedCode !== "") {
			$.ajax({
				url: 'api/loanmanegment/getByMemberCodeNewLoanApplication',
				type: 'GET',
				data: { memberCode: selectedCode },
				success: function(response) {
					console.log("Response:", response);

					if (response.status === "OK") {

						// ✅ Your API returns a list
						const dataList = response.data;

						if (Array.isArray(dataList) && dataList.length > 0) {
							// ✅ Get the first customer in the list
							const d = dataList[0];

							if (changedId === 'memberId') {
								$('#relativeDetails').val(d.relationToApplicant || '');
								$('#dateOfBirth').val(d.dob || '');
								$('#age').val(d.customerAge || '');
								$('#contactNo').val(d.contactNo || '');
								$('#notificationStatus').val(d.noficationStatus || '');
								$('#address').val(d.customerAddress || '');
								$('#pinCode').val(d.pinCode || '');
								$('#branchName').val(d.branchName || '');
								if (d.customerPhoto) {
									const photoPath = `Uploads/${d.customerPhoto}`;
									$("#photoPreview").attr("src", photoPath);
									$("#photoHidden").val(photoPath); // ✅ Only file name!
									photoSizeEdit({ target: { result: photoPath } });
								} else {
									$("#photoPreview").attr("src", "Uploads/default-placeholder.jpg");
									$("#photoHidden").val("");
								}

								if (d.customerSignature) {
									const signPath = `Uploads/${d.customerSignature}`;

									$('#signaturePreview').attr('src', signPath);
									$('#signatureHidden').val(signPath); // ✅ Only file name!
									signatureSizeEdit({ target: { result: signPath } });
								} else {
									$('#signaturePreview').attr('src', 'Uploads/default-placeholder.jpg');
									$('#signatureHidden').val("");
								}



							} else if (changedId === 'guarantorMemberId') {
								$('#guarantorPinCode').val(d.pinCode || '');
								$('#guarantorAddress').val(d.customerAddress || '');
								$('#guarantorContactNo').val(d.contactNo || '');

							} else if (changedId === 'coApplicantMemberId') {
								$('#coApplicantPinCode').val(d.pinCode || '');
								$('#coApplicantAddress').val(d.customerAddress || '');
								$('#coApplicantContactNo').val(d.contactNo || '');
							}
						} else {
							alert("No customer found for this member code!");
						}

					} else {
						alert("Customer not found!");
					}
				},
				error: function(xhr) {
					console.error("AJAX Error:", xhr.responseText);
					alert("Something went wrong while fetching data.");
				}
			});
		} else {
			$('input, textarea').not('#findMember').val('');
		}
	});
});

function photoSizeEdit(e) {
	const previewimg = document.getElementById("photoPreview");
	previewimg.src = e.target.result;
	previewimg.style.width = "100%";
	previewimg.style.height = "100%";
	previewimg.style.objectFit = "cover";
	previewimg.style.overflow = "hidden";
	previewimg.style.borderRadius = "20px";
}

function signatureSizeEdit(e) {
	const previewimg = document.getElementById("signaturePreview");
	previewimg.src = e.target.result;
	previewimg.style.width = "100%";
	previewimg.style.height = "100%";
	previewimg.style.objectFit = "cover";
	previewimg.style.overflow = "hidden";
	previewimg.style.borderRadius = "20px";
}

$(document).ready(function() {
/*	$.ajax({
		url: "api/loanmanegment/fetchLoanSchemeCatalog",
		type: "GET",
		success: function(response) {
			var plan=response.data;
			console.log("API response:", response);

			var dropdown = $('#loanPlanName');     // shows: memberCode only
			dropdown.empty();
			dropdown.append('<option value="">SELECT</option>');

			if (response.status === "FOUND") {
				$.each(response.data, function(index, customer) {
					dropdown.append('<option value="' + customer.loanPlaneName + '">' + (customer.loanPlaneName).toUpperCase() + '</option>');
				});
			} else {
				dropdown.append('<option value="">No customers found</option>');
			}
		},
		error: function() {
			alert("Failed to fetch customer list.");
		}
	});*/
	
	$.ajax({
	    url: "api/loanmanegment/fetchLoanSchemeCatalog",
	    type: "GET",
	    success: function (response) {
	        console.log("API response:", response);

	        var dropdown = $('#loanPlanName');
	        dropdown.empty();
	        dropdown.append('<option value="">SELECT</option>');

	        if (response.status === "FOUND" && Array.isArray(response.data)) {
	            $.each(response.data, function (index, scheme) {
	                dropdown.append(
	                    `<option value="${scheme.loanPlaneName}">
	                        ${(scheme.loanPlaneName || "").toUpperCase()}
	                     </option>`
	                );
	            });
	        } else {
	            dropdown.append('<option value="">No data found</option>');
	        }
	    },
	    error: function () {
	        alert("Failed to fetch loan scheme list.");
	    }
	});

});

$('#loanPlanName').on('change', function() {
	let selectedName = $(this).val();

	if (selectedName !== "") {
		$.ajax({
			url: 'api/loanmanegment/allfetchdataLoanPlanName?loanPlanName=' + encodeURIComponent(selectedName), // Pass as query param
			type: 'GET',
			success: function(response) {
				if (response.status === "FOUND") {
					let customer = response.data[0];
					$('#typeOfLoan').val(customer.typeLoan);
					const emicollection = $('#loanMode').val(customer.loanMode).val();
					const tensure = $('#loanTerm').val(customer.loanTerm).val();
					const interestinyear = $('#rateOfInterest').val(customer.rateIntrestType).val();
					$("#hiddenLoanAmount").val(customer.loanAmount);
					$('#hiddenProcessingFee').val(customer.feeProcessing);
					$('#hiddenLegalCharges').val(customer.chargesLegal);
					$('#hiddenGST').val(customer.gst);
					$('#hiddenInsuranceFee').val(customer.feeInsurence);
					$('#hiddenValuationFees').val(customer.feeValuation);
					/*$('#loanAmount').val(customer.loanAmount);*/
					const loanamount = parseFloat($('#loanAmount').val());
					const roitype = $('#interestType').val(customer.typeIntrest).val();

					/*calculateEMI(emicollection, tensure, interestinyear, loanamount, roitype);*/


					const feeProcessing = parseFloat(customer.feeProcessing) || 0;
					const chargesLegal = parseFloat(customer.chargesLegal) || 0;
					const gst = parseFloat(customer.gst) || 0;
					const feeInsurence = parseFloat(customer.feeInsurence) || 0;
					const feeValuation = parseFloat(customer.feeValuation) || 0;


					calculateCharges(feeProcessing, chargesLegal, gst, feeInsurence, feeValuation, loanamount);
				} else {
					alert('No data found!');
					$('#openingAmount').val('');
				}
			},
			error: function() {
				alert('Error while fetching data!');
				$('#openingAmount').val('');
			}
		});
	} else {
		$('#openingAmount').val('');
	}
});
/*
function calculateEMI(emicollection, tensure, interestinyear, loanamount, roitype) {
	const periods = tensure; // ✅ ALWAYS use entered term — no conversion!
	let periodicRate;

	// ✅ Only adjust the rate — periods stays fixed
	switch (emicollection) {
		case "Daily":
			periodicRate = interestinyear / 365 / 100;
			break;
		case "Weekly":
			periodicRate = interestinyear / 52 / 100;
			break;
		case "Fortnightly":
			periodicRate = interestinyear / 24 / 100;
			break;
		case "Monthly":
			periodicRate = interestinyear / 12 / 100;
			break;
		case "Quarterly":
			periodicRate = interestinyear / 4 / 100;
			break;
	}*/

let emi;

if (roitype === "Flat Interest") {
	const totalInterest = loanamount * periodicRate * periods;
	const totalAmount = loanamount + totalInterest;
	emi = totalAmount / periods;

	document.getElementById("emiPayment").value = emi.toFixed(2);

}

else if (roitype === "Reducing Interest") {
	const r = periodicRate;
	emi = (loanamount * r * Math.pow(1 + r, periods)) / (Math.pow(1 + r, periods) - 1);

	document.getElementById("emiPayment").value = emi.toFixed(2);
}

else if (roitype === "Rule 78") {
	const totalInterest = loanamount * periodicRate * periods;
	const sumOfDigits = (periods * (periods + 1)) / 2;

	let interestPerPeriod = [];
	for (let i = periods; i >= 1; i--) {
		interestPerPeriod.push((i / sumOfDigits) * totalInterest);
	}

	const totalAmount = loanamount + totalInterest;
	emi = totalAmount / periods;

	document.getElementById("emiPayment").value = emi.toFixed(2);
}

function calculateCharges(feeProcessing, chargesLegal, gst, feeInsurence, feeValuation, loanamount) {

	const processingFee = (loanamount * feeProcessing) / 100;
	const legalCharges = (loanamount * chargesLegal) / 100;
	const feeInsurence1 = (loanamount * feeInsurence) / 100;
	const feeValuation1 = (loanamount * feeValuation) / 100;
	const statinaryCharges = 50;
	const gsst = ((processingFee + legalCharges + feeValuation1) * gst) / 100;

	$('#processingFee').val(processingFee.toFixed(2));
	$('#legalCharges').val(legalCharges.toFixed(2));
	$('#gst').val(gsst.toFixed(2));
	$('#insuranceFee').val(feeInsurence1.toFixed(2));
	$('#valuationFees').val(feeValuation1.toFixed(2));
	$('#stationaryFee').val(statinaryCharges.toFixed(2));

}

//saving loan application details
$(document).ready(function() {
	$('#saveBtn').on('click', function() {
		const memberId = $('#memberId').val();
		const memberName = $('#memberId option:selected').data('name');

		var loanApplication = {
			loanId: $('#loanId').val(),
			loanDate: $('#loanDate').val(),
			memberId: memberId,
			memberName: memberName,
			relativeDetails: $('#relativeDetails').val(),
			dateOfBirth: $('#dateOfBirth').val(),
			age: $('#age').val(),
			contactNo: $('#contactNo').val(),
			messageStatus: $('#messageStatus').val(),
			address: $('#address').val(),
			pinCode: $('#pinCode').val(),
			branchName: $('#branchName').val(),
			loanPlanName: $('#loanPlanName').val(),
			typeOfLoan: $('#typeOfLoan').val(),
			loanMode: $('#loanMode').val(),
			loanTerm: $('#loanTerm').val(),
			rateOfInterest: $('#rateOfInterest').val(),
			loanAmount: $('#loanAmount').val(),
			interestType: $('#interestType').val(),
			emiPayment: $('#emiPayment').val(),
			purposeOfLoan: $('#purposeOfLoan').val(),

			// Guarantor Details
			guarantorMemberId: $('#guarantorMemberId').val(),
			guarantorIdentity: $('#guarantorIdentity').val(),
			guarantorAddress: $('#guarantorAddress').val(),
			guarantorPinCode: $('#guarantorPinCode').val(),
			guarantorContactNo: $('#guarantorContactNo').val(),
			guarantorSecurityType: $('#guarantorSecurityType').val(),

			// Co-Applicant Details
			coApplicantMemberId: $('#coApplicantMemberId').val(),
			coApplicantIdentity: $('#coApplicantIdentity').val(),
			coApplicantAddress: $('#coApplicantAddress').val(),
			coApplicantPinCode: $('#coApplicantPinCode').val(),
			coApplicantContactNo: $('#coApplicantContactNo').val(),
			coApplicantSecurityType: $('#coApplicantSecurityType').val(),
			loanStatus: "ACTIVE",

			// Deduction Details
			processingFee: $('#processingFee').val(),
			legalCharges: $('#legalCharges').val(),
			gst: $('#gst').val(),
			insuranceFee: $('#insuranceFee').val(),
			valuationFees: $('#valuationFees').val(),
			stationaryFee: $('#stationaryFee').val(),
			financialConsultantId: $('#financialConsultantId').val(),
			financialConsultantName: $('#financialConsultantName').val(),
			approvalDate: $('#approvalDate').val(),
			approvalStatus: $('#approvalStatus').val(),
			photo: $('#photoHidden').val(),
			signature: $('#signatureHidden').val()
		};

		$.ajax({
			url: 'api/loanmanegment/saveloanapplication',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(loanApplication),
			success: function(response) {
				console.log('Response:', response);
				if (response.status === 'CREATED') {
					alert("Loan Code: " + response.loanId + "\n" + response.message);
				} else {
					alert('Failed: ' + response.message);
				}
			},
			error: function(xhr, status, error) {
				console.error('Error:', error);
				alert('Error while saving loan application.');
			}
		});

	});
});

$(document).ready(function() {
	$.ajax({
		url: 'api/financialconsultant/getAllFinancialConsultantDetails',
		type: 'POST',
		success: function(response) {
			console.log("API Response:", response); // ✅ Debug to check!

			const consultantDropdown = $('#financialConsultantId');
			consultantDropdown.empty();
			consultantDropdown.append('<option value="">SELECT CONSULTANT ID</option>');

			response.data.forEach(function(customer) {
				// ✅ Only the code
				const option = `<option value="${customer.financialCode}">${customer.financialCode}</option>`;
				consultantDropdown.append(option);
			});
		},

		error: function(xhr, status, error) {
			console.error('AJAX Error:', status, error);
			alert('Failed to fetch consultant data.');
		}
	});
});
$(document).ready(function() {
	$('#financialConsultantId').on('change', function() {
		const selectedCode = $(this).val();
		console.log("Selected Financial Code:", selectedCode);

		if (selectedCode) {
			$.ajax({
				url: 'api/financialconsultant/getfinancialHierarchyByFinancialCode',
				type: 'GET',
				data: { financialCode: selectedCode },
				success: function(response) {
					console.log("API Response:", response);

					// ✅ If your API returns an ARRAY
					const consultant = Array.isArray(response.data) ? response.data[0] : response.data;

					if (consultant && consultant.financialName) {
						$('#financialConsultantName').val(consultant.financialName);
					} else {
						$('#financialConsultantName').val('');
						alert('No consultant name found for this code.');
					}
				},
				error: function(xhr, status, error) {
					console.error('AJAX Error:', status, error);
					alert('Error fetching consultant name.');
				}
			});
		} else {
			$('#financialConsultantName').val('');
		}
	});
});

/*
function calculateNewFees() {
	var hiddenloanAmount = parseFloat(document.getElementById('hiddenLoanAmount').value);

	var loanAmount = parseFloat(document.getElementById('loanAmount').value);
	var processingfee = parseFloat(document.getElementById('hiddenProcessingFee').value || 0);
	var legalcharge = parseFloat(document.getElementById('hiddenLegalCharges').value || 0);
	var gst = parseFloat(document.getElementById('hiddenGST').value || 0);
	var insurancefee = parseFloat(document.getElementById('hiddenInsuranceFee').value || 0);
	var valuationfee = parseFloat(document.getElementById('hiddenValuationFees').value || 0);
	var errorDiv = document.getElementById('chkloanamount');

	if (loanAmount < hiddenloanAmount) {
		document.getElementById('chkloanamount').innerHTML = "* loan amount should be greater than " + hiddenloanAmount;
		errorDiv.style.display = "block";
		return false;
	}
	else {
		errorDiv.innerHTML = "";
		errorDiv.style.display = "none";
	}*/
	function calculateNewFees() {

		var hiddenloanAmount = parseFloat(document.getElementById('hiddenLoanAmount').value || 0);
		var loanAmount = parseFloat(document.getElementById('loanAmount').value || 0);
		var rateOfInterest = parseFloat(document.getElementById('rateOfInterest').value || 0);

		var processingPercent = parseFloat(document.getElementById('hiddenProcessingFee').value || 0);
		var legalPercent = parseFloat(document.getElementById('hiddenLegalCharges').value || 0);
		var gstPercent = parseFloat(document.getElementById('hiddenGST').value || 0);
		var insurancePercent = parseFloat(document.getElementById('hiddenInsuranceFee').value || 0);
		var valuationPercent = parseFloat(document.getElementById('hiddenValuationFees').value || 0);

		var errorDiv = document.getElementById('chkloanamount');
		if (loanAmount < hiddenloanAmount) {
			errorDiv.innerHTML = "* loan amount should be greater than " + hiddenloanAmount;
			errorDiv.style.display = "block";
			return false;
		} else {
			errorDiv.innerHTML = "";
			errorDiv.style.display = "none";
		}

		var processingFee = (loanAmount * processingPercent) / 100;
		var legalCharges = (loanAmount * legalPercent) / 100;
		var gstCharges = (loanAmount * gstPercent) / 100;
		var insuranceFee = (loanAmount * insurancePercent) / 100;
		var valuationFee = (loanAmount * valuationPercent) / 100;
		/*var gstAmount = ((processingFee + legalCharges + valuationFee) * gstPercent) / 100;*/

		var stationaryFee = 50; // fixed
		var stationaryFees = (loanAmount * rateOfInterest) / 100;
		// ✅ SET VALUES IN INPUTS
		document.getElementById('processingFee').value = processingFee.toFixed(2);
		document.getElementById('legalCharges').value = legalCharges.toFixed(2);
		document.getElementById('insuranceFee').value = insuranceFee.toFixed(2);
		document.getElementById('valuationFees').value = valuationFee.toFixed(2);
		document.getElementById('gst').value = gstCharges.toFixed(2);
		document.getElementById('stationaryFee').value = stationaryFees.toFixed(2);
	
}
