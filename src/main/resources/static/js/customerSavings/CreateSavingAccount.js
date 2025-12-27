//shubham kewat
//fetch Policy Name
$(document).ready(function() {
	$.ajax({
		url: "api/customersavings/fetchsavingchemecatalog",
		type: "GET",
		success: function(response) {
			console.log("API response:", response);
			var dropdown = $('#selectPlan');
			dropdown.empty();
			dropdown.append('<option value="">Select</option>');

			if (response.status === "FOUND" && response.data) {
				$.each(response.data, function(index, item) {
					dropdown.append('<option value="' + item + '">' + item + '</option>');
				});
			} else {
				dropdown.append('<option value="">No Policyname found</option>');
			}
		},
		error: function() {
			alert("Failed to fetch Policyname.");
		}
	});
});

//fetch minimum opening balance
$('#selectPlan').on('change', function() {
	let selectedName = $(this).val();

	if (selectedName !== "") {
		$.ajax({
			url: 'api/customersavings/fetchpolicyname?policyName=' + encodeURIComponent(selectedName), // Pass as query param
			type: 'GET',
			success: function(response) {
				if (response.status === "FOUND") {
					let customer = response.data[0];
					$('#balance').val(customer.monthlyMinimumBalance);
				} else {
					alert('No data found!');
					$('#balance').val('');
				}
			},
			error: function() {
				alert('Error while fetching data!');
				$('#balance').val('');
			}
		});
	} else {
		$('#balance').val('');
	}
});



//janvi : Customer name list fetch
$(document).ready(function() {
	// Fetch all customers and populate the "select by code" dropdown
	$.ajax({
		url: '/api/customermanagement/approved', // Make sure this path is correct
		type: 'GET',
		success: function(response) {
			if (response.status === "OK" && Array.isArray(response.data)) {
				const $select = $('#selectByCustomer');
				const $select1 = $('#jointOperationCode');
				$select.empty().append('<option value="">Select</option>');
				$select1.empty().append('<option value="">Select</option>');

				response.data.forEach(customer => {
					if (customer.customerName && customer.memberCode) {
						const optionText = `${customer.customerName} - ${customer.memberCode}`;
						const optionValue = customer.memberCode; // or use customer.id or full object if needed
						$select.append(`<option value="${optionValue}">${optionText}</option>`);
					}
					if (customer.customerName && customer.memberCode) {
						const optionText = `${customer.memberCode}`;
						const optionValue = customer.memberCode; // or use customer.id or full object if needed
						$select1.append(`<option value="${optionValue}">${optionText}</option>`);
					}
				});
			} else {
				alert("No approved customers found.");
			}
		},
		error: function() {
			alert("Failed to fetch approved customers.");
		}
	});
});


//Member Code fetch in Customer Name 

$('#selectByCustomer').on('change', function () {

    let selectedCode = $(this).val();

    if (selectedCode !== "") {

        $.ajax({
            url: 'api/customersavings/fetchCustomerByCode',
            type: 'POST',
            contentType: 'application/json',
            dataType: 'json',
            data: JSON.stringify({
                memberCode: selectedCode
            }),

            success: function (response) {
				if (response.status === "FOUND") {
					let customer = response.data[0];

					// Fill the fields
					$('#enterCustomerName').val(customer.customerName);
					$('#familyDetails').val(customer.guardianName);
					$('#contactNumber').val(customer.contactNo);
					$('#suggestedNomineeName').val(customer.nomineeName);
					$('#suggestedNomineeAge').val(customer.nomineeAge);
					$('#suggestedNomineeRelation').val(customer.nomineeRelationToApplicant);
					$('#address').val(customer.customerAddress);
					$('#district').val(customer.district);
					$('#branchName').val(customer.branchName);
					$('#pinCode').val(customer.pinCode);
					$('#state').val(customer.state);
					$('#dateOfBirth').val(customer.dob);
					$('#emailId').val(customer.emailId);
					$('#aadharNo').val(customer.aadharNo);

					// Make all fetched fields readonly
					$('#enterCustomerName, #familyDetails, #contactNumber, #suggestedNomineeName, #suggestedNomineeAge, #suggestedNomineeRelation, #address, #district, #branchName, #pinCode, #state, #dateOfBirth, #emailId, #aadharNo')
					.prop("readonly", true);

					//photo
					if (customer.customerPhoto) {
						const imagePath = `Uploads/${customer.customerPhoto}`;
						document.getElementById("photo").src = imagePath;
						document.getElementById("photoHidden").value = customer.customerPhoto;
					} else {
						document.getElementById("photo").src = 'Uploads/upload.jpg';
						document.getElementById("photoHidden").value = '';
					}
					//signature
					if (customer.customerSignature) {
						const imagePath = `Uploads/${customer.customerSignature}`;
						document.getElementById("signature").src = imagePath;
						document.getElementById("signatureHidden").value = customer.customerSignature;
					} else {
						document.getElementById("signature").src = 'Uploads/upload.jpg';
						document.getElementById("signatureHidden").value = '';
					}
				} else {
					alert('No customer data found!');

					// Clear values and remove readonly
					$('#enterCustomerName, #familyDetails, #contactNumber, #suggestedNomineeName, #suggestedNomineeAge, #suggestedNomineeRelation, #address, #district, #branchName, #pinCode, #state, #dateOfBirth, #emailId, #aadharNo')
					.prop("readonly", false)
					.val('');
				}
			},
			error: function() {
				alert('Error while fetching customer data!');
			}
		});
	} else {
		// Clear values and remove readonly if dropdown is empty
		$('#enterCustomerName, #familyDetails, #contactNumber, #suggestedNomineeName, #suggestedNomineeAge, #suggestedNomineeRelation, #address, #district, #branchName, #pinCode, #state, #dateOfBirth, #emailId, #aadharNo')
		.prop("readonly", false)
		.val('');
	}
});

//fetch only customer name on cahnge in dropdown
$('#jointOperationCode').on('change', function() {
	let selectedCode = $(this).val();

	if (selectedCode !== "") {
		$.ajax({
			url: 'api/customersavings/fetchCustomerByCode',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({ memberCode: selectedCode }),
			success: function(response) {
				if (response.status === "FOUND") {
					let customer = response.data[0];
					$('#jointSurvivorCode').val(customer.customerName);
					//Jointphoto
					if (customer.customerPhoto) {
						const imagePath = `Uploads/${customer.customerPhoto}`; // Construct full image path
						document.getElementById("jointPhoto").src = imagePath; // Set image source
						document.getElementById("jointPhotoHidden").value = customer.customerPhoto; // Set hidden input value
					} else {
						document.getElementById("jointPhoto").src = 'Uploads/upload.jpg'; // Default placeholder
						document.getElementById("jointPhotoHidden").value = ''; // Clear hidden input value
					}
				} else {
					alert('No customer data found!');
					$('#jointSurvivorCode').val('');
				}
			},
			error: function() {
				alert('Error while fetching customer data!');
				$('#jointSurvivorCode').val('');
			}
		});
	} else {
		$('#jointSurvivorCode').val('');
	}
});

//fetch financial name from financialConsultantController
$('#financialConsultantCode').on('blur', function() {

	let selectedCode = $(this).val();

	if (selectedCode !== "") {
		$.ajax({
			url: 'api/customersavings/fetchfinancialcode?financialCode=' + encodeURIComponent(selectedCode),
			type: 'GET',
			success: function(response) {
				if (response.status === "FOUND") {
					let customer = response.data[0];
					$('#financialConsultantName').val(customer.financialName);
				} else {
					alert('No data found!');
					$('#financialConsultantName').val('');
				}
			},
			error: function() {
				alert('Error while fetching data!');
				$('#financialConsultantName').val('');
			}
		});
	} else {
		$('#financialConsultantName').val('');
	}
});



// save saving account details 
$(document).ready(function() {
	// Ensure the hidden input is updated with the image file name
	let imageSrc = $('#photo').attr('src');
	let imageName = imageSrc.split('/').pop(); // Extract the file name
	$('#photoHidden').val(imageName);

	// Ensure the hidden input is updated with the image file name
	let imageSrc1 = $('#signature').attr('src');
	let imageName1 = imageSrc1.split('/').pop(); // Extract the file name
	$('#signatureHidden').val(imageName1);

	// Ensure the hidden input is updated with the image file name
	let imageSrc2 = $('#jointPhoto').attr('src');
	let imageName2 = imageSrc2.split('/').pop(); // Extract the file name
	$('#jointPhotoHidden').val(imageName2);

	$('#saveBtn').click(function(event) {
		event.preventDefault();

		// ------------ REQUIRED FIELD VALIDATION ------------
		if ($("#selectByCustomer").val().trim() === "") {
			alert("Please select customer first!");
			return;
		}
		if ($("#enterCustomerName").val().trim() === "") {
			alert("Please enter customer name!");
			return;
		}
		if ($("#contactNumber").val().trim() === "") {
			alert("Please enter contact number!");
			return;
		}
		if ($("#aadharNo").val().trim() === "") {
			alert("Please enter Aadhar Number!");
			return;
		}
		if ($("#openingDate").val().trim() === "") {
			alert("Please select opening date!");
			return;
		}
		// Add more fields if needed...

		// ------------ HIDDEN IMAGES UPDATE ------------
		$('#photoHidden').val($('#photo').attr('src').split('/').pop());
		$('#signatureHidden').val($('#signature').attr('src').split('/').pop());
		$('#jointPhotoHidden').val($('#jointPhoto').attr('src').split('/').pop());

		// ------------ CREATE FORMDATA ------------
		const formData = new FormData();

		const fields = [
			"typeofaccount", "openingDate", "selectByCustomer", "enterCustomerName",
			"dateOfBirth", "familyDetails", "contactNumber", "suggestedNomineeName",
			"suggestedNomineeAge", "suggestedNomineeRelation", "address", "district",
			"branchName", "state", "pinCode", "operationType", "jointOperationCode",
			"jointSurvivorCode", "familyRelation", "selectPlan",
			"financialConsultantCode", "financialConsultantName", "balance",
			"emailId", "aadharNo", "authenticateWith", "modeOfPayment",
			"chequeNo", "chequeDate", "depositAcc1", "refNumber1", "depositAcc2",
			"refNumber2", "depositAcc3", "comment", "accountNumber"
		];

		fields.forEach(f => formData.append(f, $('#' + f).val()));

		// Checkbox toggles
		formData.append("accountStatus", $('#toggle-member-status').is(":checked") ? 1 : 0);
		formData.append("messageSend", $('#toggle-member-status1').is(":checked") ? 1 : 0);
		formData.append("debitCardIssue", $('#toggle-member-status2').is(":checked") ? 1 : 0);
		formData.append("isLocker", $('#toggle-member-status3').is(":checked") ? 1 : 0);

		// Image values
		formData.append("photo", $('#photoHidden').val());
		formData.append("signature", $('#signatureHidden').val());
		formData.append("jointPhoto", $('#jointPhotoHidden').val());

		// ------------ AJAX SAVE CALL ------------
		$.ajax({
			type: "POST",
			url: "api/customersavings/saveandupdatesavingaccount",
			data: formData,
			processData: false,
			contentType: false,

			success: function(response) {
				alert("Saving Account data saved successfully!\nAccount No : " + $('#accountNumber').val());
				location.reload();
			},

			error: function(xhr) {
				alert("Customer already exists in saving account.");
			}
		});
	});

	$.ajax({
		type: "GET",
		url: "api/customersavings/getAllSavingAccountData",
		contentType: "application/json",
		success: function(response) {
			console.log("Full Response from API:", response);
			if (response.status == "FOUND") {
				let data = response.data;
				let tableBody = $(".datatable tbody");
				tableBody.empty();
				data.forEach((item, index) => {
					let row = `<tr>
			                        <td>${index + 1}</td>
			                        <td>${item.accountNumber}</td>
									<td>${(item.typeofaccount).toUpperCase()}</td>
			                        <td>${item.selectByCustomer}</td>
			                        <td>${(item.enterCustomerName).toUpperCase()}</td>
									<td>${item.contactNumber}</td>
									<td>${(item.branchName).toUpperCase()}</td>
									<td>${(item.address).toUpperCase()}</td>
									<td>${(item.district).toUpperCase()}</td>
									<td>${(item.state).toUpperCase()}</td>
									<td><button class="iconbutton" onclick="viewData(${item.id})" title="View"><i class="fa-solid fa-pen-to-square text-primary"></i></button></td>
									<td>									<button class="iconbutton" onclick="deleteData(${item.id}, this)" title="Delete">
									       <i class="fa-solid fa-trash text-danger"></i>
									   </button></td>
			                    </tr>`;
					tableBody.append(row);
				});
			} else {
				alert("Failed to fetch saving account data: " + response.message);
			}
		},
		error: function() {
			alert("Error while calling the API.");
		}
	});
});

function viewData(id) {
    $.ajax({
        url: "api/customersavings/getSavingAccountDataById",
        type: "GET",
        data: { id: id },
        success: function(response) {
            if (response.status == "FOUND") {
                const data = response.data;

                $("#id").val(data.id);
                $("#openingDate").val(data.openingDate);
                $("#selectByCustomer").val(data.selectByCustomer);
                $("#enterCustomerName").val(data.enterCustomerName);
                $("#dateOfBirth").val(data.dateOfBirth);
                $("#familyDetails").val(data.familyDetails);
                $("#contactNumber").val(data.contactNumber);
                $("#suggestedNomineeName").val(data.suggestedNomineeName);
                $("#suggestedNomineeAge").val(data.suggestedNomineeAge);
                $("#suggestedNomineeRelation").val(data.suggestedNomineeRelation);
                $("#address").val(data.address);
                $("#district").val(data.district);
                $("#branchName").val(data.branchName);
                $("#state").val(data.state);
                $("#pinCode").val(data.pinCode);
                $("#operationType").val(data.operationType);
                $("#jointOperationCode").val(data.jointOperationCode);
                $("#jointSurvivorCode").val(data.jointSurvivorCode);
                $("#familyRelation").val(data.familyRelation);
                $("#selectPlan").val(data.selectPlan);
                $("#balance").val(data.balance);
                $("#financialConsultantCode").val(data.financialConsultantCode);
                $("#financialConsultantName").val(data.financialConsultantName);
                $("#emailId").val(data.emailId);
                $("#aadharNo").val(data.aadharNo);
                $("#authenticateWith").val(data.authenticateWith);
                $("#modeOfPayment").val(data.modeOfPayment);
                $("#chequeNo").val(data.chequeNo);
                $("#chequeDate").val(data.chequeDate);
                $("#depositAcc1").val(data.depositAcc1);
                $("#depositAcc2").val(data.depositAcc2);
                $("#refNumber1").val(data.refNumber1);
                $("#depositAcc3").val(data.depositAcc3);
                $("#refNumber2").val(data.refNumber2);
                $("#comment").val(data.comment);
                $("#accountNumber").val(data.accountNumber);

                // Photo
                if (data.photo) {
                    const imagePath = `Uploads/${data.photo}`;
                    $("#photo").attr("src", imagePath);
                    $("#photoHidden").val(data.photo);
                } else {
                    $("#photo").attr("src", 'Uploads/upload.jpg');
                    $("#photoHidden").val('');
                }

                // Signature
                if (data.signature) {
                    const imagePath = `Uploads/${data.signature}`;
                    $("#signature").attr("src", imagePath);
                    $("#signatureHidden").val(data.signature);
                } else {
                    $("#signature").attr("src", 'Uploads/upload.jpg');
                    $("#signatureHidden").val('');
                }

                // Joint Photo
                if (data.jointPhoto) {
                    const imagePath = `Uploads/${data.jointPhoto}`;
                    $("#jointPhoto").attr("src", imagePath);
                    $("#jointPhotoHidden").val(data.jointPhoto);
                } else {
                    $("#jointPhoto").attr("src", 'Uploads/upload.jpg');
                    $("#jointPhotoHidden").val('');
                }

                // Status Toggles  
                document.getElementById("toggle-member-status").checked =
                    data.accountStatus === true || data.accountStatus === '1';
                document.getElementById("toggle-member-status1").checked =
                    data.messageSend === true || data.messageSend === '1';
                document.getElementById("toggle-member-status2").checked =
                    data.debitCardIssue === true || data.debitCardIssue === '1';
                document.getElementById("toggle-member-status3").checked =
                    data.isLocker === true || data.isLocker === '1';

                updateToggleColor(document.getElementById("toggle-member-status"));
                updateToggleColor(document.getElementById("toggle-member-status1"));
                updateToggleColor(document.getElementById("toggle-member-status2"));
                updateToggleColor(document.getElementById("toggle-member-status3"));

                // 👉 SCROLL TO FORM (SMOOTH)
                document.getElementById("formid").scrollIntoView({
                    behavior: "smooth",
                    block: "start"
                });

            } else {
                alert("Account not found: " + response.message);
            }
        },
        error: function(xhr) {
            alert("Request failed: " + xhr.responseText);
        }
    });
}

function deleteData(id, button) {

    if (confirm("Are you sure you want to delete this data?")) {

        $.ajax({
            url: "/api/customersavings/deleteSavingAccountDataById",
            type: "POST",
            data: { id: id },

            success: function (response) {
                console.log("Delete API Response:", response);

                alert(response.message || "Deleted Successfully");

                // Row remove instant
                if (button) {
                    $(button).closest('tr').remove();
                }

                // Force page reload
                window.location.reload(true);
            },

            error: function (xhr, status, error) {
                alert("Error deleting record.");
                console.error("Error:", error);
            }
        });
    }
}



$(document).ready(function() {
	let imageSrc = $('#photo').attr('src');
	let imageName = imageSrc.split('/').pop(); // Extract the file name
	$('#photoHidden').val(imageName);

	// Ensure the hidden input is updated with the image file name
	let imageSrc1 = $('#signature').attr('src');
	let imageName1 = imageSrc1.split('/').pop(); // Extract the file name
	$('#signatureHidden').val(imageName1);

	// Ensure the hidden input is updated with the image file name
	let imageSrc2 = $('#jointPhoto').attr('src');
	let imageName2 = imageSrc2.split('/').pop(); // Extract the file name
	$('#jointPhotoHidden').val(imageName2);

	$('#updateBtn').click(function(event) {
		event.preventDefault();

		// Update the hidden input with the current file name from the image
		let updatedImageSrc = $('#photo').attr('src');
		let updatedImageName = updatedImageSrc.split('/').pop(); // Extract the file name
		$('#photoHidden').val(updatedImageName);

		// Update the hidden input with the current file name from the image
		let updatedImageSrc1 = $('#signature').attr('src');
		let updatedImageName1 = updatedImageSrc1.split('/').pop(); // Extract the file name
		$('#signatureHidden').val(updatedImageName1);

		// Update the hidden input with the current file name from the image
		let updatedImageSrc2 = $('#jointPhoto').attr('src');
		let updatedImageName2 = updatedImageSrc2.split('/').pop(); // Extract the file name
		$('#jointPhotoHidden').val(updatedImageName2);

		const formData = new FormData();
		formData.append("id", $('#id').val());
		formData.append("typeofaccount", $('#typeofaccount').val());
		formData.append("openingDate", $('#openingDate').val());
		formData.append("selectByCustomer", $('#selectByCustomer').val());
		formData.append("enterCustomerName", $('#enterCustomerName').val());
		formData.append("dateOfBirth", $('#dateOfBirth').val());
		formData.append("familyDetails", $('#familyDetails').val());
		formData.append("contactNumber", $('#contactNumber').val());
		formData.append("suggestedNomineeName", $('#suggestedNomineeName').val());
		formData.append("suggestedNomineeAge", $('#suggestedNomineeAge').val());
		formData.append("suggestedNomineeRelation", $('#suggestedNomineeRelation').val());
		formData.append("address", $('#address').val());
		formData.append("district", $('#district').val());
		formData.append("branchName", $('#branchName').val());
		formData.append("state", $('#state').val());
		formData.append("pinCode", $('#pinCode').val());
		formData.append("operationType", $('#operationType').val());
		formData.append("jointOperationCode", $('#jointOperationCode').val());
		formData.append("jointSurvivorCode", $('#jointSurvivorCode').val());
		formData.append("familyRelation", $('#familyRelation').val());
		formData.append("selectPlan", $('#selectPlan').val());
		formData.append("balance", $('#balance').val());
		formData.append("financialConsultantCode", $('#financialConsultantCode').val());
		formData.append("financialConsultantName", $('#financialConsultantName').val());
		formData.append("emailId", $('#emailId').val());
		formData.append("aadharNo", $('#aadharNo').val());
		formData.append("authenticateWith", $('#authenticateWith').val());
		formData.append("modeOfPayment", $('#modeOfPayment').val());
		formData.append("chequeNo", $('#chequeNo').val());
		formData.append("chequeDate", $('#chequeDate').val());
		formData.append("depositAcc1", $('#depositAcc1').val());
		formData.append("refNumber1", $('#refNumber1').val());
		formData.append("depositAcc2", $('#depositAcc2').val());
		formData.append("refNumber2", $('#refNumber2').val());
		formData.append("depositAcc3", $('#depositAcc3').val());
		formData.append("comment", $('#comment').val());
		formData.append("accountNumber", $('#accountNumber').val());
		formData.append("accountStatus", $('#toggle-member-status').is(':checked') ? 1 : 0);
		formData.append("messageSend", $('#toggle-member-status1').is(':checked') ? 1 : 0);
		formData.append("debitCardIssue", $('#toggle-member-status2').is(':checked') ? 1 : 0);
		formData.append("isLocker", $('#toggle-member-status3').is(':checked') ? 1 : 0);
		// Append the extracted photoWithAadhar file name
		formData.append("photo", $('#photoHidden').val());

		// Append the extracted photoWithAadhar file name
		formData.append("signature", $('#signatureHidden').val());

		// Append the extracted photoWithAadhar file name
		formData.append("jointPhoto", $('#jointPhotoHidden').val());

		// Append files (photo and signature)
		/*const photo = $('#photo')[0].files[0];
		const signature = $('#signature')[0].files[0];

		if (photo) {
			formData.append("photo", photo);
		}
		if (signature) {
			formData.append("signature", signature);
		}
*/
		// Debug: Log all key-value pairs from FormData
		for (let pair of formData.entries()) {
			if (!pair[1]) {
				console.warn(`⚠️ Field "${pair[0]}" is EMPTY or NULL ->`, pair[1]);
			} else {
				console.log(`✅ ${pair[0]}:`, pair[1]);
			}
		}

		$.ajax({
			type: 'POST',
			url: 'api/customersavings/saveandupdatesavingaccount',
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {

				let id = $('#id').val(); // check if id is present

				if (id === "" || id === null || id === "0") {
					// 🔵 NEW ACCOUNT SAVED
					alert("Saving Account Saved Successfully!\nAccount Number : " + $('#accountNumber').val());
				} else {
					// 🟢 EXISTING ACCOUNT UPDATED
					alert("Saving Account Updated Successfully!\nAccount Number : " + $('#accountNumber').val());
				}

				location.reload();
			},
			error: function(xhr) {
				console.error('Error:', xhr.responseText);
				alert('Customer already exists in saving account.');
			}
		});
	});
});

document.addEventListener("DOMContentLoaded", function() {
	document.getElementById("openingFeesTable").style.display = "none";
});

document.getElementById("balance").addEventListener("click", function(event) {
	event.stopPropagation();

	let table = document.getElementById("openingFeesTable");
	table.style.display = (table.style.display === "none" || table.style.display === "")
		? "block" : "none";
});


document.getElementById("openingFeesTable").addEventListener("click", function(event) {
	event.stopPropagation();
});


document.addEventListener("click", function() {
	document.getElementById("openingFeesTable").style.display = "none";
});



function calcOpeningFees() {

	let n2000 = (document.getElementById("qty2000").value || 0) * 2000;
	let n500 = (document.getElementById("qty500").value || 0) * 500;
	let n200 = (document.getElementById("qty200").value || 0) * 200;
	let n100 = (document.getElementById("qty100").value || 0) * 100;
	let n50 = (document.getElementById("qty50").value || 0) * 50;
	let n20 = (document.getElementById("qty20").value || 0) * 20;
	let n10 = (document.getElementById("qty10").value || 0) * 10;
	let n5 = (document.getElementById("qty5").value || 0) * 5;

	document.getElementById("res2000").innerText = n2000;
	document.getElementById("res500").innerText = n500;
	document.getElementById("res200").innerText = n200;
	document.getElementById("res100").innerText = n100;
	document.getElementById("res50").innerText = n50;
	document.getElementById("res20").innerText = n20;
	document.getElementById("res10").innerText = n10;
	document.getElementById("res5").innerText = n5;

	let total = n2000 + n500 + n200 + n100 + n50 + n20 + n10 + n5;

	document.getElementById("totalOpening").innerText = total;
	document.getElementById("balance").value = total;
}
$(document).ready(function() {


	$("#jointPhotoDiv").hide();


	$("#operationType").on("change", function() {
		let type = $(this).val();

		if (type === "Joint") {
			$("#jointPhotoDiv").show();
		} else {
			$("#jointPhotoDiv").hide();
		}
	});

});
document.addEventListener("DOMContentLoaded", function() {

	let operationType = document.getElementById("operationType");
	let jointDiv = document.getElementById("jointOperationCodeDiv");
	let jointOperationCode = document.getElementById("jointOperationCode");


	jointDiv.style.display = "none";

	operationType.addEventListener("change", function() {

		if (operationType.value === "Joint") {
			jointDiv.style.display = "block";
			jointOperationCode.disabled = false;
		} else {
			jointDiv.style.display = "none";
			jointOperationCode.disabled = true;
		}
	});
});
document.getElementById("printBtn").addEventListener("click", function() {
	window.print();
});

$(document).ready(function() {
	// Fetch Financial Consultant Codes on page load                                          
	fetchFinancialConsultantCodes();
});

function fetchFinancialConsultantCodes() {
	$.ajax({
		url: '/api/financialconsultant/getAllFinancialConsultantCodes', // Controller endpoint
		type: 'GET',
		contentType: 'application/json',
		success: function(response) {
			if (response.status === 200 && response.data) {
				// response.data is the list of codes                                         
				let codes = response.data;

				// Example: Populate a select dropdown with codes                             
				let dropdown = $("#financialCodeDropdown");
				dropdown.empty(); // clear existing options                                   
				dropdown.append("<option value=''>-- Select Code --</option>");

				codes.forEach(function(code) {
					dropdown.append(`<option value="${code}">${code}</option>`);
				});
			} else {
				console.log("No codes found or error:", response.message);
			}
		},
		error: function(err) {
			console.error("AJAX error fetching financial codes:", err);
		}
	});
}                                                                                             
