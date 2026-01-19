$(document).ready(function() {

	$("#updateBtn").hide();

	// ==============================
	// ✅ SAVE BUTTON
	// ==============================
	$("#saveBtn").on("click", function(e) {
		e.preventDefault();

		// ✅ Convert text fields to uppercase
		convertTextToUppercase();

		// ✅ Validation
		if (!validateLoanSchemeForm()) {
			return;
		}

		// ✅ Submit form
		submitLoanForm("save");
	});


	// ==============================
	// ✅ UPDATE BUTTON
	// ==============================
	$("#updateBtn").on("click", function(e) {
		e.preventDefault();

		// ✅ Convert text fields to uppercase
		convertTextToUppercase();

		// ✅ Validation
		if (!validateLoanSchemeForm()) {
			return;
		}

		// ✅ Submit form
		submitLoanForm("update");
	});


	// ✅ Load Table at start
	loadLoanTable();
});


// ============================================
// ✅ COMMON FUNCTION TO CONVERT TEXT TO UPPERCASE
// ============================================
function convertTextToUppercase() {
	$("input[type=text], textarea").each(function() {
		if ($(this).val()) {
			$(this).val($(this).val().toUpperCase());
		}
	});
}


// ============================================
// ✅ VALIDATION FUNCTION (Same file me add karo)
// ============================================
function validateLoanSchemeForm() {

	let loanSchemeCode = $("#loanSchemeCode").val().trim();
	let loanPlaneName = $("#loanPlaneName").val().trim();
	let typeLoan = $("#typeLoan").val().trim();
	let age = $("#age").val().trim();
	let loanTerm = $("#loanTerm").val().trim();
	let emiType = $("#emiType").val().trim();
	let loanAmount = $("#loanAmount").val().trim();
	let loanMode = $("#loanMode").val().trim();
	let rateIntrestType = $("#rateIntrestType").val().trim();
	let typeIntrest = $("#typeIntrest").val().trim();
	let typesecurity = $("#typesecurity").val().trim();

	let feeProcessing = $("#feeProcessing").val().trim();
	let chargesLegal = $("#chargesLegal").val().trim();
	let gst = $("#gst").val().trim();
	let feeInsurence = $("#feeInsurence").val().trim();
	let feeValuation = $("#feeValuation").val().trim();

	let lateAllowanceday = $("#lateAllowanceday").val().trim();
	let modePanalty = $("#modePanalty").val().trim();
	let pennaltyMonthly = $("#pennaltyMonthly").val().trim();

	// ✅ Patterns
	let numberPattern = /^[0-9]+(\.[0-9]{1,2})?$/;
	let intPattern = /^[0-9]+$/;

	// ==========================
	// ✅ Required Validations
	// ==========================
	if (loanSchemeCode === "") {
		alert("Loan Scheme Code is required");
		$("#loanSchemeCode").focus();
		return false;
	}

	if (loanPlaneName === "") {
		alert("Loan Plan Name is required");
		$("#loanPlaneName").focus();
		return false;
	}

	if (typeLoan === "" || typeLoan === "SELECT TYPE OF LOAN") {
		alert("Please select Type of Loan");
		$("#typeLoan").focus();
		return false;
	}

	if (age === "") {
		alert("Age is required");
		$("#age").focus();
		return false;
	} else if (!intPattern.test(age) || parseInt(age) < 18 || parseInt(age) > 100) {
		alert("Age must be between 18 to 100");
		$("#age").focus();
		return false;
	}

	if (loanTerm === "") {
		alert("Loan Term is required");
		$("#loanTerm").focus();
		return false;
	} else if (!intPattern.test(loanTerm) || parseInt(loanTerm) <= 0) {
		alert("Enter valid Loan Term");
		$("#loanTerm").focus();
		return false;
	}

	if (emiType === "" || emiType === "SELECT EMI TYPE") {
		alert("Please select EMI Type");
		$("#emiType").focus();
		return false;
	}

	if (loanAmount === "") {
		alert("Loan Amount is required");
		$("#loanAmount").focus();
		return false;
	} else if (!numberPattern.test(loanAmount) || parseFloat(loanAmount) <= 0) {
		alert("Enter valid Loan Amount");
		$("#loanAmount").focus();
		return false;
	}
	// ✅ Minimum loan amount rule (your function)
	else if (parseFloat(loanAmount) < 100000) {
		alert("Loan Amount must be minimum 100000");
		$("#loanAmount").focus();
		return false;
	}

	if (loanMode === "" || loanMode === "SELECT LOAN MODE") {
		alert("Please select Loan Mode");
		$("#loanMode").focus();
		return false;
	}

	if (rateIntrestType === "") {
		alert("Rate of Interest is required");
		$("#rateIntrestType").focus();
		return false;
	} else if (!numberPattern.test(rateIntrestType) || parseFloat(rateIntrestType) <= 0 || parseFloat(rateIntrestType) > 60) {
		alert("Enter valid Rate of Interest (1 to 60)");
		$("#rateIntrestType").focus();
		return false;
	}

	if (typeIntrest === "" || typeIntrest === "SELECT ROI TYPE") {
		alert("Please select Interest Type");
		$("#typeIntrest").focus();
		return false;
	}

	if (typesecurity === "" || typesecurity === "SELECT SECURITY") {
		alert("Please select Security Type");
		$("#typesecurity").focus();
		return false;
	}

	// ==========================
	// ✅ Optional Numeric Validations
	// ==========================
	if (feeProcessing !== "" && (!numberPattern.test(feeProcessing) || parseFloat(feeProcessing) < 0)) {
		alert("Enter valid Processing Fee");
		$("#feeProcessing").focus();
		return false;
	}

	if (chargesLegal !== "" && (!numberPattern.test(chargesLegal) || parseFloat(chargesLegal) < 0)) {
		alert("Enter valid Legal Charges");
		$("#chargesLegal").focus();
		return false;
	}

	if (gst !== "" && (!numberPattern.test(gst) || parseFloat(gst) < 0 || parseFloat(gst) > 28)) {
		alert("Enter valid GST (0 to 28)");
		$("#gst").focus();
		return false;
	}

	if (feeInsurence !== "" && (!numberPattern.test(feeInsurence) || parseFloat(feeInsurence) < 0)) {
		alert("Enter valid Insurance Fee");
		$("#feeInsurence").focus();
		return false;
	}

	if (feeValuation !== "" && (!numberPattern.test(feeValuation) || parseFloat(feeValuation) < 0)) {
		alert("Enter valid Valuation Fee");
		$("#feeValuation").focus();
		return false;
	}

	if (lateAllowanceday !== "" && (!intPattern.test(lateAllowanceday) || parseInt(lateAllowanceday) < 0)) {
		alert("Enter valid Late Allowance Day");
		$("#lateAllowanceday").focus();
		return false;
	}

	if (modePanalty === "" || modePanalty === "SELECT PENALTY TYPE") {
		alert("Please select Penalty Mode");
		$("#modePanalty").focus();
		return false;
	}

	if (pennaltyMonthly !== "" && (!numberPattern.test(pennaltyMonthly) || parseFloat(pennaltyMonthly) < 0)) {
		alert("Enter valid Monthly Penalty");
		$("#pennaltyMonthly").focus();
		return false;
	}

	return true;
}


// ============================================
// ✅ COMMON AJAX FUNCTION FOR SAVE / UPDATE
// ============================================
function submitLoanForm(type) {

	let id = $("#loanId").val();

	const loanData = {
		id: type === "update" ? id : null,

		loanSchemeCode: $("#loanSchemeCode").val(),
		loanPlaneName: $("#loanPlaneName").val(),
		typeLoan: $("#typeLoan").val(),
		age: $("#age").val(),
		loanTerm: $("#loanTerm").val(),
		emiType: $("#emiType").val(),
		loanAmount: $("#loanAmount").val(),
		loanMode: $("#loanMode").val(),
		rateIntrestType: $("#rateIntrestType").val(),
		typeIntrest: $("#typeIntrest").val(),
		typesecurity: $("#typesecurity").val(),

		// Deductions
		feeProcessing: $("#feeProcessing").val(),
		chargesLegal: $("#chargesLegal").val(),
		gst: $("#gst").val(),
		feeInsurence: $("#feeInsurence").val(),
		feeValuation: $("#feeValuation").val(),

		// Late Penalty
		lateAllowanceday: $("#lateAllowanceday").val(),
		modePanalty: $("#modePanalty").val(),
		pennaltyMonthly: $("#pennaltyMonthly").val(),

		// ✅ Toggle value
		planStatus: $("#planStatus").is(":checked") ? 1 : 0
	};

	$.ajax({
		type: "POST",
		url: "api/loanmanegment/saveLoanManagment",
		contentType: "application/json",
		dataType: "json",
		data: JSON.stringify(loanData),
		success: function(response) {

			if (response.status === "OK") {

				if (type === "save") {
					alert("Data Saved Successfully ✅");
				} else {
					alert("Data Updated Successfully ✅");
				}

				// ✅ Reset buttons
				$("#saveBtn").show();
				$("#updateBtn").hide();

				// ✅ Clear form
				clearLoanForm();

				// ✅ Reload table
				loadLoanTable();

			} else {
				alert("Failed: " + response.message);
			}
		},
		error: function(xhr) {
			alert("Error occurred: " + xhr.responseText);
		}
	});
}


// ============================================
// ✅ CLEAR FORM FUNCTION
// ============================================
function clearLoanForm() {
	$("#loanId").val("");
	$("#loanSchemeCode").val("");
	$("#loanPlaneName").val("");
	$("#typeLoan").val("");
	$("#age").val("");
	$("#loanTerm").val("");
	$("#emiType").val("");
	$("#loanAmount").val("");
	$("#loanMode").val("");
	$("#rateIntrestType").val("");
	$("#typeIntrest").val("");
	$("#typesecurity").val("");

	$("#feeProcessing").val("");
	$("#chargesLegal").val("");
	$("#gst").val("");
	$("#feeInsurence").val("");
	$("#feeValuation").val("");

	$("#lateAllowanceday").val("");
	$("#modePanalty").val("");
	$("#pennaltyMonthly").val("");

	$("#planStatus").prop("checked", false);
	updateToggleColor(document.getElementById('planStatus'));
}


// ============================================
// ✅ LOAD TABLE DATA
// ============================================
function loadLoanTable() {
	$.ajax({
		url: "api/loanmanegment/allDataFetchLoanSchemCatelog",
		type: "GET",
		dataType: "json",
		success: function(response) {
			let rows = "";

			if (response.status === "OK" && Array.isArray(response.data)) {
				response.data.forEach(function(loan) {
					rows += `
                        <tr>
                            <td>${loan.id}</td>
                            <td>${loan.loanPlaneName || "-"}</td>
                            <td>${loan.typeLoan || "-"}</td>
                            <td>${loan.age || "-"}</td>
                            <td>${loan.loanTerm || "-"}</td>
                            <td>${loan.emiType || "-"}</td>
                            <td>
                                <button class="btn btn-sm btn-warning" onclick="editLoanById(${loan.id})">
                                    <i class="fa fa-edit"></i>
                                </button>
                            </td>
                            <td>
                                <button class="btn btn-sm btn-danger" onclick="deleteLoan(${loan.id})">
                                    <i class="fa fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    `;
				});
			} else {
				rows = "<tr><td colspan='8'>No data found</td></tr>";
			}

			$("#loanTableBody").html(rows);
		},
		error: function(xhr) {
			console.error("Error loading table:", xhr.statusText);
			$("#loanTableBody").html("<tr><td colspan='8'>Error loading data</td></tr>");
		}
	});
}


// ============================================
// ✅ EDIT LOAN BY ID
// ============================================
function editLoanById(id) {

	$("#updateBtn").show();
	$("#saveBtn").hide();

	$.ajax({
		url: "api/loanmanegment/getLoanByIdEdite",
		type: "GET",
		data: { id: id },
		success: function(response) {

			if (response.status === "OK") {

				const loan = response.data;

				$('#loanId').val(loan.id);
				$('#loanSchemeCode').val(loan.loanSchemeCode);
				$('#loanPlaneName').val(loan.loanPlaneName);
				$('#typeLoan').val(loan.typeLoan);
				$('#age').val(loan.age);
				$('#loanTerm').val(loan.loanTerm);
				$('#emiType').val(loan.emiType);
				$('#loanAmount').val(loan.loanAmount);
				$('#loanMode').val(loan.loanMode);
				$('#rateIntrestType').val(loan.rateIntrestType);
				$('#typeIntrest').val(loan.typeIntrest);
				$('#typesecurity').val(loan.typesecurity);

				$('#feeProcessing').val(loan.feeProcessing);
				$('#chargesLegal').val(loan.chargesLegal);
				$('#gst').val(loan.gst);
				$('#feeInsurence').val(loan.feeInsurence);
				$('#feeValuation').val(loan.feeValuation);

				$('#lateAllowanceday').val(loan.lateAllowanceday);
				$('#modePanalty').val(loan.modePanalty);
				$('#pennaltyMonthly').val(loan.pennaltyMonthly);

				// ✅ Toggle
				$('#planStatus').prop('checked', parseInt(loan.planStatus) === 1);
				updateToggleColor(document.getElementById('planStatus'));

			} else {
				alert("Loan not found: " + response.message);
			}
		},
		error: function(xhr) {
			alert("Error fetching loan details: " + xhr.responseText);
		}
	});
}


// ============================================
// ✅ TOGGLE COLOR UPDATE
// ============================================
function updateToggleColor(input) {
	const label = input.nextElementSibling;
	if (input.checked) {
		label.style.backgroundColor = "#4caf50";
		label.style.borderColor = "#4caf50";
	} else {
		label.style.backgroundColor = "#ccc";
		label.style.borderColor = "#ccc";
	}
}


// ============================================
// ✅ DELETE FUNCTION
// ============================================
function deleteLoan(id) {
	if (confirm("Are you sure you want to delete this loan?")) {

		$.ajax({
			url: "api/loanmanegment/deleteLoanById",
			type: "POST",
			data: { id: id },
			success: function(response) {

				if (response.status === "OK") {
					alert("Loan deleted successfully ✅");
					loadLoanTable();
				} else {
					alert("Failed: " + response.message);
				}
			},
			error: function(xhr) {
				alert("Error while deleting loan ❌");
				console.log("Status:", xhr.status);
				console.log("Response:", xhr.responseText);
			}
		});
	}
}


// ============================================
// ✅ Your old function (kept, optional)
// ============================================
function validateLoanAmount() {
	const loanAmount = document.getElementById("loanAmount").value;
	const error = document.getElementById("loanAmountError");

	if (loanAmount !== "" && Number(loanAmount) < 100000) {
		error.style.display = "block";
	} else {
		error.style.display = "none";
	}
}
