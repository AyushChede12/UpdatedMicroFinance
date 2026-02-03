$(document).ready(function () {
	$.ajax({
		url: '/api/customermanagement/approved',
		type: 'GET',
		success: function (response) {
			if (response.status === "OK" && Array.isArray(response.data)) {
				const $select = $('#selectCustomer');
				$select.empty().append('<option value="">Select Customer Code</option>');

				response.data.forEach(customer => {

					// ✅ Combine name using array
					const fullName = [
						customer.firstName,
						customer.middleName,
						customer.lastName
					]
					.filter(name => name && name.trim() !== "")
					.join(" ");

					if (fullName && customer.memberCode) {
						const optionText = `${fullName} - ${customer.memberCode}`;
						const optionValue = customer.memberCode;

						$select.append(
							`<option value="${optionValue}">${optionText}</option>`
						);
					}
				});
			} else {
				alert("No approved customers found.");
			}
		},
		error: function () {
			alert("Failed to fetch approved customers.");
		}
	});
});


function fetchBySelectedCustomer() {
	const memberCode = $("#selectCustomer").val();
	if (!memberCode) return;
	const input = { memberCode };

	$.ajax({
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify(input),
		url: "api/customermanagement/fetchBySelectedCustomer",
		success: function(data) {
			if (data && data.length > 0) {
				const c = data[0];

				// Populate text fields safely
				
				$("#customerName").val(
									[
										c.firstName,
										c.middleName,
										c.lastName
									]
									.filter(name => name && name.trim() !== "")
									.join(" ")
								);
				$("#memberCode").val(c.memberCode || "");
				$("#contactNo").val(c.contactNo || "");
				$("#singupDate").val(c.signupDate || "");
				$("#aadharNo").val(c.aadharNo || "");
				$("#pan").val(c.panNo || "");
				$("#state").val(c.state || "");
				$("#district").val(c.district || "");
				$("#drivingLicenceNo").val(c.drivingLicenceNo || "");
				$("#voterNo").val(c.voterNo || "");
				$("#relationDetails").val(c.guardianName || "");
				$("#address").val(c.customerAddress || "");
				$("#pinCode").val(c.pinCode || "");
				$("#suggestedNominee").val(c.nomineeName || "");
				$("#emailId").val(c.emailId || "");
				$("#dateofBirth").val(c.dob || "");
				$("#ageOfNominee").val(c.nomineeAge || "");
				$("#branchName").val(c.branchName || "");
				$("#relation").val(c.relationToApplicant || "");

				// Photo
				if (c.customerPhoto) {
					const photoPath = `Uploads/${c.customerPhoto}`;
					$("#photoPreview").attr("src", photoPath);
					$("#photoHidden").val(photoPath);
					photoSizeEdit({ target: { result: photoPath } });
				} else {
					$("#photoPreview").attr("src", "Uploads/default-placeholder.jpg");
					$("#photoHidden").val("");
				}

				// Signature
				if (c.customerSignature) {
					const signPath = `Uploads/${c.customerSignature}`;
					$("#signaturePreview").attr("src", signPath);
					$("#signatureHidden").val(signPath);
					signatureSizeEdit({ target: { result: signPath } });
				} else {
					$("#signaturePreview").attr("src", "Uploads/default-placeholder.jpg");
					$("#signatureHidden").val("");
				}

			} else {
				alert("No data found for the selected member.");
				clearCustomerFields();
			}
		},
		error: function(jqXHR, textStatus, errorThrown) {
			alert("Failed to fetch data: " + textStatus + ", " + errorThrown);
		}
	});
}


$(document).ready(function() {
	// If already selected on load
	if ($("#selectCustomer").val()) {
		fetchBySelectedCustomer();
	}

	// On dropdown change
	$("#selectCustomer").on("change", function() {
		if ($(this).val()) {
			fetchBySelectedCustomer();
		} else {
			clearCustomerFields();
		}
	});
});


$(document).ready(function() {
	// Trigger the function when schemeType dropdown value changes
	$("#schemeType").on("change", function() {
		getSchemeNameBySchemeType();
	});

	// Optional: Trigger it on page load if a value is already selected
	if ($("#schemeType").val()) {
		getSchemeNameBySchemeType();
	}
});

$(document).ready(function() {
	$("#schemeType").on("change", function() {
		getSchemeNameBySchemeType();
	});

	if ($("#schemeType").val()) {
		getSchemeNameBySchemeType();
	}
});

function getSchemeNameBySchemeType() {
	var selectedSchemeType = $("#schemeType").val();
	console.log("Selected Scheme Type:", selectedSchemeType);

	var requestData = {};
	if (selectedSchemeType === "DRD") {
		requestData.drd = selectedSchemeType;
	} else if (selectedSchemeType === "RD") {
		requestData.rd = selectedSchemeType;
	} else if (selectedSchemeType === "FD") {
		requestData.fd = selectedSchemeType;
	} else if (selectedSchemeType === "MIS") {
		requestData.mis = selectedSchemeType;
	}

	$.ajax({
		type: "GET",
		url: "api/Policymangment/getSchemeNameBySchemeType",
		// ✅ Include prefix if controller uses @RequestMapping("/api")
		data: requestData,
		success: function(response) {
			console.log("Response received:", response);
			$("#schemeName").empty().append(`<option value="">Select Scheme Name</option>`);

			if (response.allBrands) {
				response.allBrands.forEach(function(planNameDD) {
					$("#schemeName").append(`<option value="${planNameDD}">${planNameDD}</option>`);
				});
			}
			if (response.allRds) {
				response.allRds.forEach(function(planNameRD) {
					$("#schemeName").append(`<option value="${planNameRD}">${planNameRD}</option>`);
				});
			}
			if (response.allFRDs) {
				response.allFRDs.forEach(function(planNameFD) {
					$("#schemeName").append(`<option value="${planNameFD}">${planNameFD}</option>`);
				});
			}
			if (response.allMISRDs) {
				response.allMISRDs.forEach(function(planNameMD) {
					$("#schemeName").append(`<option value="${planNameMD}">${planNameMD}</option>`);
				});
			}
		},
		error: function(xhr, status, error) {
			console.error(`Error fetching schemes (Status: ${status}):`, error);
			alert("An error occurred while fetching scheme data. Please try again.");
		}
	});
}


function updateSchemeMode() {
	var schemeType = $("#schemeType").val(); // the schemeType you selected
	var schemeModeDropdown = $("#schemeMode"); // your target dropdown

	// Define the scheme modes based on type
	var schemeModes = {
		"RD": "Monthly",
		"MIS": "N/A",
		"FD": "Yearly",
		"DRD": "Daily"
	};

	// Clear existing options
	schemeModeDropdown.empty();

	// Populate based on schemeType
	if (schemeType && schemeModes[schemeType]) {
		schemeModeDropdown.append(new Option(schemeModes[schemeType], schemeModes[schemeType]));
	} else {
		schemeModeDropdown.append(new Option("Select", ""));
	}
}

$(document).ready(function() {
	$("#schemeType").on("change", function() {
		updateSchemeMode();
	});
});


$(document).ready(function() {
	// Auto-set policy start date to today
	const today = new Date();
	const formattedToday = today.toISOString().split("T")[0];
	$("#policyStartDate").val(formattedToday);

	// Trigger on schemeName change
	$("#schemeName").on("change", function() {
		fetchTermBySchemeName();
	});

	// Trigger recalculation when policyStartDate is changed manually
	$("#policyStartDate").on("change", function() {
		displayMaturityDate();
	});
});

function fetchTermBySchemeName() {
	const selectedSchemeName = $("#schemeName").val();
	const schemeType = $("#schemeType").val();

	if (!selectedSchemeName) {
		$("#schemeTerm").val("");
		$("#roi").val("");
		$("#depositAmount").val("");
		$("#maturityAmount").val("");
		$("#maturityDate").val("");
		return;
	}

	let apiUrl = "";
	let dataParam = {};
	let termField = "";
	let interestRateField = "";
	let planCodeField = "";

	switch (schemeType) {
		case "DRD":
			apiUrl = "api/Policymangment/ddterm";
			dataParam = { planNameDD: selectedSchemeName };
			termField = "ddterm";
			interestRateField = "rateOfInterest";
			planCodeField = "planCodeDD";
			break;
		case "RD":
			apiUrl = "api/Policymangment/rdterm";
			dataParam = { planNameRD: selectedSchemeName };
			termField = "rdterm";
			interestRateField = "rateOfInterestRD";
			planCodeField = "planCodeRD";
			break;
		case "FD":
			apiUrl = "api/Policymangment/fdterm";
			dataParam = { planNameFD: selectedSchemeName };
			termField = "fdterm";
			interestRateField = "rateOfInterestFD";
			planCodeField = "planCodeFD";
			break;
		case "MIS":
			apiUrl = "api/Policymangment/misterm";
			dataParam = { planNameMD: selectedSchemeName };
			termField = "misterm";
			interestRateField = "rateOfInterestMD";
			planCodeField = "planCodeMD";
			break;
		default:
			alert("Invalid scheme type selected.");
			return;
	}

	$.ajax({
		type: "GET",
		url: apiUrl,
		data: dataParam,
		dataType: "json",
		success: function(response) {
			let data = response.data || response;
			if (data) {
				// Set term and ROI
				const term = data[termField] || "";
				const roi = data[interestRateField] || "";
				const hiddenSchemeCode = data[planCodeField] || "";

				$("#schemeTerm").val(term);
				$("#roi").val(roi);
				$("#hiddenSchemeCode").val(hiddenSchemeCode);


				// Update mode (e.g., Monthly/Yearly)
				updateSchemeMode();

				// ❗ Delay maturity calculation slightly to ensure fields are set
				setTimeout(() => {
					displayMaturityDate(); // ✅ Calculate maturity date based on current term and start date
					calculateDepositAndMaturity(); // ✅ Recalculate deposit + maturity amount
				}, 100);
			} else {
				alert("No scheme data found.");
			}
		},
		error: function(xhr, status, error) {
			console.error("Error fetching scheme data:", error);
			alert("Error fetching scheme data. Please try again.");
		}
	});
}



// Determine schemeMode from schemeType
function getSchemeMode(schemeType) {
	switch (schemeType) {
		case "DRD": return "Daily";
		case "RD": return "Monthly";
		case "FD": return "Yearly";
		case "MIS": return "Yearly";
		default: return "";
	}
}

function displayMaturityDate() {
	const start = $("#policyStartDate").val();
	const mode = $("#schemeMode").val();
	const term = parseInt($("#schemeTerm").val()); // ✅ consistent with your field

	console.log("Maturity Calculation Triggered", { start, mode, term });

	if (!start || !mode || isNaN(term)) {
		$("#maturityDate").val("");
		return;
	}

	const startDate = new Date(start);
	let maturityDate = new Date(startDate);

	if (mode === "Daily") {
		maturityDate.setDate(maturityDate.getDate() + term);
	} else if (mode === "Monthly") {
		maturityDate.setMonth(maturityDate.getMonth() + term);
	} else if (mode === "Yearly") {
		maturityDate.setFullYear(maturityDate.getFullYear() + term);
	}

	const yyyy = maturityDate.getFullYear();
	const mm = String(maturityDate.getMonth() + 1).padStart(2, '0');
	const dd = String(maturityDate.getDate()).padStart(2, '0');

	const finalDate = `${yyyy}-${mm}-${dd}`;
	$("#maturityDate").val(finalDate);
}


$(document).ready(function() {
	$("#policyAmount, #schemeTerm, #schemeMode, #roi").on("change keyup", function() {
		calculateDepositAndMaturity();
	});


});

function calculateDepositAndMaturity() {
	const policyAmount = parseFloat($("#policyAmount").val()); // This is per-installment amount
	const term = parseInt($("#schemeTerm").val());
	const schemeMode = $("#schemeMode").val();
	const roi = parseFloat($("#roi").val());

	if (isNaN(policyAmount) || isNaN(term) || !schemeMode || isNaN(roi)) {
		$("#depositAmount").val("");
		$("#maturityAmount").val("");
		return;
	}

	let installmentsPerYear = 0;

	switch (schemeMode) {
		case "Daily":
			installmentsPerYear = 1;
			break;
		case "Monthly":
			installmentsPerYear = 1;
			break;
		case "Quarterly":
			installmentsPerYear = 4;
			break;
		case "Half-Yearly":
			installmentsPerYear = 2;
			break;
		case "Yearly":
			installmentsPerYear = 1;
			break;
		default:
			alert("Unknown scheme mode selected.");
			return;
	}

	const totalInstallments = installmentsPerYear * term;
	const totalDepositAmount = policyAmount * totalInstallments;
	const r = roi / 100;
	const n = installmentsPerYear;
	const t = term;

	// Use Future Value of Ordinary Annuity Formula:
	// M = P × [((1 + r/n)^(nt) - 1) / (r/n)]
	const compoundRate = r / n;
	const maturityAmount = policyAmount * ((Math.pow(1 + compoundRate, n * t) - 1) / compoundRate);

	$("#depositAmount").val(totalDepositAmount.toFixed(2));
	$("#maturityAmount").val(maturityAmount.toFixed(2));
}

$("#saveBtn").click(function(e) {
	e.preventDefault();

	const schemeType = $("#schemeType").val();
	if (!schemeType) {
		alert("Please select a Scheme Type first.");
		return;
	}

	let imageSrc = $('#photoPreview').attr('src');
	let imageName = imageSrc.split('/').pop(); // Extract the file name
	$('#photoHidden').val(imageName);

	// Ensure the hidden input is updated with the image file name
	let imageSrc1 = $('#signaturePreview').attr('src');
	let imageName1 = imageSrc1.split('/').pop(); // Extract the file name
	$('#signatureHidden').val(imageName1);

	// Step 1: Get next policy code from backend
	$.ajax({
		url: "api/Policymangment/getNextPolicyCode",
		type: "GET",
		data: { schemeType: schemeType },
		success: function(policyCode) {
			$("#policyCode").val(policyCode); // set code in hidden field



			// Step 2: Prepare FormData (for multipart request)
			let formData = new FormData();
			formData.append("policyCode", policyCode);
			formData.append("policyStartDate", $("#policyStartDate").val());
			formData.append("memberSelection", $("#selectCustomer").val());
			formData.append("customerName", $("#customerName").val());
			formData.append("dateofBirth", $("#dateofBirth").val());
			formData.append("relationDetails", $("#relationDetails").val());
			formData.append("contactNo", $("#contactNo").val());
			formData.append("suggestedNominee", $("#suggestedNominee").val());
			formData.append("ageOfNominee", $("#ageOfNominee").val());
			formData.append("relation", $("#relation").val());
			formData.append("address", $("#address").val());
			formData.append("district", $("#district").val());
			formData.append("state", $("#state").val());
			formData.append("pinCode", $("#pinCode").val());
			formData.append("tds", $("#tds").val());
			formData.append("branchName", $("#branchName").val());
			formData.append("modeOfOperation", $("#ModeOfOperation").val());
			formData.append("jointName", $("#jointName").val());
			formData.append("jointMemCode", $("#jointMemCode").val());
			formData.append("schemeType", $("#schemeType").val());
			formData.append("schemeTerm", $("#schemeTerm").val());
			formData.append("schemeName", $("#schemeName").val());
			formData.append("schemeMode", $("#schemeMode").val());
			formData.append("schemeCode", $("#hiddenSchemeCode").val());
			formData.append("roi", $("#roi").val());
			formData.append("maturityDate", $("#maturityDate").val());
			formData.append("policyAmount", $("#policyAmount").val());
			formData.append("depositAmount", $("#depositAmount").val());
			formData.append("paidAmount", $("#policyAmount").val());
			formData.append("amountDue", (parseFloat($("#depositAmount").val()) - parseFloat($("#policyAmount").val())).toFixed(2));
			formData.append("introMCode", $("#introMCode").val());
			formData.append("maturityAmount", $("#maturityAmount").val());
			formData.append("MISInterest", $("#MISInterest").val());
			formData.append("paymentBy", $("#paymentBy").val());
			formData.append("remark", $("#remark").val());
			formData.append("agent", $("#Agent").val());
			formData.append("smsSend", $('#toggle-sms-send').is(':checked') ? "1" : "0");
			formData.append("lastInstPaid", "1");

			formData.append("image1", $('#photoHidden').val());
			formData.append("image2", $('#signatureHidden').val());

			// Step 4: Send POST request with multipart/form-data
			$.ajax({
				url: "api/Policymangment/saveandupdateAddInvestment",
				type: "POST",
				data: formData,
				processData: false, // prevent automatic processing
				contentType: false, // let browser set content type
				success: function(response) {
					alert("✅ " + response.message);
					$("#formid")[0].reset();
				},
				error: function(xhr) {
					alert("❌ Error: " + (xhr.responseJSON?.message || "Something went wrong."));
					location.reload();
				}
			});
		},
		error: function() {
			alert("❌ Failed to generate policy code.");
		}
	});
});



$(document).ready(function() {
	$.ajax({
		url: "api/financialconsultant/getAllFinancialConsultantDetails",
		type: "POST",
		success: function(response) {
			const consultants = response.data;
			const $agentDropdown = $("#Agent");

			$agentDropdown.empty(); // Clear any existing options
			$agentDropdown.append('<option value="">Select Payment By</option>');

			// Create a Set to avoid duplicate codes
			const addedCodes = new Set();

			consultants.forEach(consultant => {
				const code = consultant.financialCode;

				// Add only if it's not null/empty/"undefined"
				if (code && code.trim() !== "" && code.trim().toLowerCase() !== "undefined") {
					if (!addedCodes.has(code)) {
						$agentDropdown.append(`<option value="${code}">${code}</option>`);
						addedCodes.add(code);
					}
				}
			});
		},
		error: function(xhr, status, error) {
			console.error("Failed to fetch financial consultant details:", error);
		}
	});
});

function photopreview() {
	const file = document.getElementById("photo").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			const previewimg = document.getElementById("bike1imagePreview");
			document.getElementById("bike1imagePreview").src = e.target.result;
			previewimg.style.width = "100%";
			previewimg.style.height = "100%";
			previewimg.style.objectFit = "cover"
			previewimg.style.overflow = "hidden"
			previewimg.style.borderRadius = "20px"
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for photo.");
	}
}


//Ayush
function signpreview() {
	const file = document.getElementById("signature").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			const previevimg = document.getElementById("bike2imagePreview");
			document.getElementById("bike2imagePreview").src = e.target.result;
			previevimg.style.width = "100%";
			previevimg.style.height = "100%";
			previevimg.style.objectFit = "cover"
			previevimg.style.overflow = "hidden"
			previevimg.style.borderRadius = "20px"
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for signature.");
	}
}

function photoUpload() {
	const file = document.getElementById("photo").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			photoSizeEdit(e);
			$("#photoHidden").val("");

		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for photo.");
	}
}


//Ayush
function signatureUpload() {
	const file = document.getElementById("signature").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			signatureSizeEdit(e);
			$("#signatureHidden").val("");
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for signature.");
	}
}

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

document.addEventListener('DOMContentLoaded', function() {
	const toggles = document.querySelectorAll('.toggle__input');

	toggles.forEach((toggle) => {
		updateToggleColor(toggle);

		toggle.addEventListener('change', () => {
			updateToggleColor(toggle);
			console.log(`${toggle.dataset.toggleType} is now ${toggle.checked}`);
		});
	});

	function updateToggleColor(input) {
		const label = input.nextElementSibling;
		if (label) {
			label.style.backgroundColor = input.checked ? '#28a745' : '#ccc';
		}
	}
});
