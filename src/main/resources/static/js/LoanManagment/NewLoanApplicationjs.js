/* =====================================================
   GLOBAL DOCUMENT READY
===================================================== */
$(document).ready(function () {
	console.log("Document ready");

	fetchApprovedMembers();
	fetchLoanSchemes();
	fetchFinancialConsultants();

	/* ================= EVENTS ================= */
	$('#memberId,#guarantorMemberId,#coApplicantMemberId').on('change', handleMemberChange);

	$('#loanPlanName').on('change', handleLoanPlanChange);

	// 🔥 EMI AUTO CALCULATION TRIGGER
	$(document).on(
		'keyup change',
		'#loanAmount,#rateOfInterest,#loanTerm,#loanMode,#interestType',
		function () {
			calculateEMI();
		}
	);

	$('#saveBtn').on('click', saveLoanApplication);

	$('#financialConsultantId').on('change', fetchConsultantName);
});

/* =====================================================
   FETCH APPROVED MEMBERS
===================================================== */
function fetchApprovedMembers() {
	$.ajax({
		url: '/api/customermanagement/approved',
		type: 'GET',
		success: function (response) {

			const customers = response.data || [];
			const memberDropdown = $('#memberId');
			const guarantorDropdown = $('#guarantorMemberId');
			const coApplicantDropdown = $('#coApplicantMemberId');

			memberDropdown.empty().append('<option value="">SELECT MEMBER</option>');
			guarantorDropdown.empty().append('<option value="">SELECT MEMBER</option>');
			coApplicantDropdown.empty().append('<option value="">SELECT MEMBER</option>');

			customers.forEach(customer => {
				const fullName = [customer.firstName, customer.middleName, customer.lastName]
					.filter(Boolean).join(" ");

				if (customer.memberCode && fullName) {
					const option = `
						<option value="${customer.memberCode}" data-name="${fullName}">
							${fullName.toUpperCase()} - ${customer.memberCode}
						</option>`;
					memberDropdown.append(option);
					guarantorDropdown.append(option);
					coApplicantDropdown.append(option);
				}
			});
		},
		error: () => alert('Failed to fetch members')
	});
}

/* =====================================================
   MEMBER / GUARANTOR / CO-APPLICANT CHANGE
===================================================== */
function handleMemberChange() {

	const memberCode = $(this).val();
	const changedId = $(this).attr('id');
	if (!memberCode) return;

	$.ajax({
		url: 'api/loanmanegment/getByMemberCodeNewLoanApplication',
		type: 'GET',
		data: { memberCode },
		success: function (response) {

			if (response.status !== "OK" || !response.data.length) return;
			const d = response.data[0];

			if (changedId === 'memberId') {
				$('#relativeDetails').val(d.relationToApplicant || '');
				$('#dateOfBirth').val(d.dob || '');
				$('#age').val(d.customerAge || '');
				$('#contactNo').val(d.contactNo || '');
				$('#address').val(d.customerAddress || '');
				$('#pinCode').val(d.pinCode || '');
				$('#branchName').val(d.branchName || '');

				setImage('#photoPreview', '#photoHidden', d.customerPhoto);
				setImage('#signaturePreview', '#signatureHidden', d.customerSignature);
			}

			if (changedId === 'guarantorMemberId') {
				$('#guarantorAddress').val(d.customerAddress || '');
				$('#guarantorPinCode').val(d.pinCode || '');
				$('#guarantorContactNo').val(d.contactNo || '');
			}

			if (changedId === 'coApplicantMemberId') {
				$('#coApplicantAddress').val(d.customerAddress || '');
				$('#coApplicantPinCode').val(d.pinCode || '');
				$('#coApplicantContactNo').val(d.contactNo || '');
			}
		}
	});
}

/* =====================================================
   IMAGE HANDLER
===================================================== */
function setImage(previewId, hiddenId, imageName) {
	if (imageName) {
		const path = `Uploads/${imageName}`;
		$(previewId).attr('src', path);
		$(hiddenId).val(path);
	} else {
		$(previewId).attr('src', 'Uploads/default-placeholder.jpg');
		$(hiddenId).val('');
	}
}

/* =====================================================
   FETCH LOAN SCHEMES
===================================================== */
function fetchLoanSchemes() {
	$.ajax({
		url: 'api/loanmanegment/fetchLoanSchemeCatalog',
		type: 'GET',
		success: function (response) {

			const dropdown = $('#loanPlanName');
			dropdown.empty().append('<option value="">SELECT</option>');

			if (response.status === "FOUND") {
				response.data.forEach(scheme => {
					dropdown.append(`
						<option value="${scheme.loanPlaneName}">
							${(scheme.loanPlaneName || '').toUpperCase()}
						</option>
					`);
				});
			}
		}
	});
}

/* =====================================================
   LOAN PLAN CHANGE
===================================================== */
function handleLoanPlanChange() {

	const loanPlanName = $(this).val();
	if (!loanPlanName) return;

	$.ajax({
		url: 'api/loanmanegment/allfetchdataLoanPlanName',
		type: 'GET',
		data: { loanPlanName },
		success: function (response) {

			if (response.status !== "FOUND") return;
			const c = response.data[0];

			$('#typeOfLoan').val(c.typeLoan);
			$('#loanMode').val(c.loanMode);
			$('#loanTerm').val(c.loanTerm);
			$('#rateOfInterest').val(c.rateIntrestType);
			$('#interestType').val(c.typeIntrest);

			$('#hiddenProcessingFee').val(c.feeProcessing);
			$('#hiddenLegalCharges').val(c.chargesLegal);
			$('#hiddenGST').val(c.gst);
			$('#hiddenInsuranceFee').val(c.feeInsurence);
			$('#hiddenValuationFees').val(c.feeValuation);

			calculateEMI();
			calculateNewFees();
		}
	});
}

/* =====================================================
   EMI CALCULATION (FINAL & WORKING)
===================================================== */
function calculateEMI() {

	const loanAmount = parseFloat($('#loanAmount').val()) || 0;
	const annualRate = parseFloat($('#rateOfInterest').val()) || 0;
	const tenure = parseInt($('#loanTerm').val()) || 0;
	const emiMode = ($('#loanMode').val() || '').toUpperCase();
	const roiType = ($('#interestType').val() || '').toUpperCase();

	if (!loanAmount || !annualRate || !tenure) {
		$('#emiPayment').val('');
		return;
	}

	let rate = 0;
	switch (emiMode) {
		case "DAILY": rate = annualRate / 365 / 100; break;
		case "WEEKLY": rate = annualRate / 52 / 100; break;
		case "FORTNIGHTLY": rate = annualRate / 24 / 100; break;
		case "MONTHLY": rate = annualRate / 12 / 100; break;
		default: return;
	}

	let emi = 0;

	if (roiType === "REDUCING INTEREST") {
		emi = (loanAmount * rate * Math.pow(1 + rate, tenure)) /
			(Math.pow(1 + rate, tenure) - 1);
	}
	else if (roiType === "FLAT INTEREST") {
		emi = (loanAmount + (loanAmount * rate * tenure)) / tenure;
	}

	$('#emiPayment').val(emi.toFixed(2));
}

/* =====================================================
   CHARGES CALCULATION
===================================================== */
function calculateNewFees() {

	const loanAmount = parseFloat($('#loanAmount').val()) || 0;

	const processing = loanAmount * (parseFloat($('#hiddenProcessingFee').val()) || 0) / 100;
	const legal = loanAmount * (parseFloat($('#hiddenLegalCharges').val()) || 0) / 100;
	const insurance = loanAmount * (parseFloat($('#hiddenInsuranceFee').val()) || 0) / 100;
	const valuation = loanAmount * (parseFloat($('#hiddenValuationFees').val()) || 0) / 100;
	const gst = (processing + legal + valuation) * (parseFloat($('#hiddenGST').val()) || 0) / 100;

	$('#processingFee').val(processing.toFixed(2));
	$('#legalCharges').val(legal.toFixed(2));
	$('#insuranceFee').val(insurance.toFixed(2));
	$('#valuationFees').val(valuation.toFixed(2));
	$('#gst').val(gst.toFixed(2));
	$('#stationaryFee').val('50.00');
}

/* =====================================================
   SAVE LOAN APPLICATION
===================================================== */
function saveLoanApplication() {

	const loanApplication = {
		loanId: $('#loanId').val(),
		loanDate: $('#loanDate').val(),
		memberId: $('#memberId').val(),
		memberName: $('#memberId option:selected').data('name'),
		relativeDetails: $('#relativeDetails').val(),
		dateOfBirth: $('#dateOfBirth').val(),
		age: $('#age').val(),
		contactNo: $('#contactNo').val(),
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
		loanStatus: "ACTIVE"
	};

	$.ajax({
		url: 'api/loanmanegment/saveloanapplication',
		type: 'POST',
		contentType: 'application/json',
		data: JSON.stringify(loanApplication),
		success: res => alert(res.message),
		error: () => alert("Error while saving loan")
	});
}

/* =====================================================
   FINANCIAL CONSULTANT
===================================================== */
function fetchFinancialConsultants() {
	$.ajax({
		url: 'api/financialconsultant/getAllFinancialConsultantDetails',
		type: 'POST',
		success: function (response) {
			const dropdown = $('#financialConsultantId');
			dropdown.empty().append('<option value="">SELECT CONSULTANT</option>');
			response.data.forEach(c =>
				dropdown.append(`<option value="${c.financialCode}">${c.financialCode}</option>`)
			);
		}
	});
}

function fetchConsultantName() {
	const code = $(this).val();
	if (!code) return;

	$.ajax({
		url: 'api/financialconsultant/getfinancialHierarchyByFinancialCode',
		type: 'GET',
		data: { financialCode: code },
		success: res => $('#financialConsultantName').val(res.data[0]?.financialName || '')
	});
}
