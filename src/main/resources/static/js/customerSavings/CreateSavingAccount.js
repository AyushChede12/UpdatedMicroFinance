function updateToggleColor(toggleElement) {
	if (!toggleElement) return;

	const label = toggleElement.nextElementSibling; // assumes label is just after input
	if (label) {
		if (toggleElement.checked) {
			label.classList.add('active'); // checkbox checked hone par class add
		} else {
			label.classList.remove('active'); // unchecked hone par class remove
		}
	}
}

// Aur optional: click/change par automatically update
document.querySelectorAll('.toggle__input').forEach(function(toggle) {
	toggle.addEventListener('change', function() {
		updateToggleColor(toggle);
	});
});



//shubham kewat
//fetch Policy Name
/*document.getElementById("newPhoto").addEventListener("click", function() {
	document.getElementById("newPhotoFile").click();
});

document.getElementById("newPhoto").addEventListener("change", function() {
	const file = this.files[0];
	const error = document.getElementById("chknewPhoto");

	if (!file) {
		error.innerText = "Please select photo";
		return;
	}

	if (!file.type.startsWith("image/")) {
		error.innerText = "Only image files allowed";
		this.value = "";
		return;
	}

	const reader = new FileReader();
	reader.onload = function(e) {
		document.getElementById("newPhoto").src = e.target.result;
		error.innerText = "";
	};
	reader.readAsDataURL(file);
});


// -------- SIGNATURE --------
document.getElementById("newSignature").addEventListener("click", function() {
	document.getElementById("newSignatureFile").click();
});

document.getElementById("newSignatureFile").addEventListener("change", function() {
	const file = this.files[0];
	const error = document.getElementById("chknewSignature");

	if (!file) {
		error.innerText = "Please select signature";
		return;
	}

	if (!file.type.startsWith("image/")) {
		error.innerText = "Only image files allowed";
		this.value = "";
		return;
	}

	const reader = new FileReader();
	reader.onload = function(e) {
		document.getElementById("newSignature").src = e.target.result;
		error.innerText = "";
	};
	reader.readAsDataURL(file);
});
document.getElementById("jointPhoto").addEventListener("click", function() {
	document.getElementById("jointPhotoFile").click();
});

 When file selected 
document.getElementById("jointPhotoFile").addEventListener("change", function() {
	const file = this.files[0];
	const errorMsg = document.getElementById("chkjointPhoto");

	if (!file) {
		errorMsg.innerText = "Please select joint photo";
		return;
	}

	 Validate image type 
	if (!file.type.startsWith("image/")) {
		errorMsg.innerText = "Only image files are allowed";
		this.value = "";
		return;
	}

	 Validate image size (2MB) 
	if (file.size > 2 * 1024 * 1024) {
		errorMsg.innerText = "Image size must be less than 2MB";
		this.value = "";
		return;
	}

	 Preview image 
	const reader = new FileReader();
	reader.onload = function(e) {
		document.getElementById("jointPhoto").src = e.target.result;
		errorMsg.innerText = "";
	};
	reader.readAsDataURL(file);
});*/
$(document).ready(function() {
	$("#myJointPhoto").hide();
	$.ajax({
		url: "api/customersavings/fetchsavingchemecatalog",
		type: "GET",
		success: function(response) {
			console.log("API response:", response);
			var dropdown = $('#selectPlan');
			dropdown.empty();
			dropdown.append('<option value="">SELECT</option>');

			if (response.status === "FOUND" && response.data) {
				$.each(response.data, function(index, item) {
					dropdown.append('<option value="' + item + '">' + item + '</option>');
				});
			} else {
				dropdown.append('<option value="">NO POLICY FOUND</option>');
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


$(document).ready(function() {

	$.ajax({
		url: '/api/customermanagement/approved',
		type: 'GET',
		success: function(response) {
			if (response.status === "OK" && Array.isArray(response.data)) {

				const $select = $('#selectByCustomer');
				const $select1 = $('#jointOperationCode');

				$select.empty().append('<option value="">SELECT</option>');
				$select1.empty().append('<option value="">SELECT</option>');

				response.data.forEach(customer => {

					// Build customer full name
					const fullName = [
						customer.firstName,
						customer.middleName,
						customer.lastName
					].filter(Boolean).join(" ");

					// Only add if name & code exist
					if (fullName && customer.memberCode) {
						const optionText = `${fullName} - ${customer.memberCode}`;
						const optionValue = customer.memberCode;

						$select.append(`<option value="${optionValue}">${optionText}</option>`);
						$select1.append(`<option value="${optionValue}">${customer.memberCode}</option>`);
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

$('#selectByCustomer').on('change', function() {
	let selectedCode = $(this).val();

	if (selectedCode !== "") {
		$.ajax({
			url: 'api/customersavings/fetchCustomerCode',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({ memberCode: selectedCode }),
			success: function(response) {
				if (response.status === "FOUND") {
					let customer = response.data[0];
					// Build full name
					const fullName = [
						customer.firstName,
						customer.middleName,
						customer.lastName
					].filter(Boolean).join(" ");
					$('#enterCustomerName').val(fullName);
					$('#familyDetails').val(customer.guardianName);
					$('#contactNumber').val(customer.contactNo);
					$('#suggestedNomineeName').val(customer.nomineeName);
					$('#suggestedNomineeAge').val(customer.nomineeAge);
					$('#suggestedNomineeRelation').val(customer.nomineeRelationToApplicant);
					$('#address').val(customer.customerAddress);
					$('#district').val(customer.district);
					$('#branchName').val(customer.branchName);
					$('#pinCode').val(customer.pinCode);
					$('#district').val(customer.district);
					$('#state').val(customer.state);
					$('#dateOfBirth').val(customer.dob);
					$('#emailId').val(customer.emailId);
					$('#aadharNo').val(customer.aadharNo);
					//photo
					/*if (customer.customerPhoto) {
						const imagePath = `Uploads/${customer.customerPhoto}`; // Construct full image path
						document.getElementById("photo").src = imagePath; // Set image source
						document.getElementById("photoHidden").value = customer.customerPhoto; // Set hidden input value
					} else {
						document.getElementById("photo").src = 'Uploads/upload.jpg'; // Default placeholder
						document.getElementById("photoHidden").value = ''; // Clear hidden input value
					}*/
					if (customer.customerPhoto) {
						const imagePath = `Uploads/${customer.customerPhoto}`;
						$("#photoPreview").attr("src", imagePath);
						$("#photoHidden").val(imagePath);
						const fakePhotoEvent = { target: { result: imagePath } };
						photoSizeEdit(fakePhotoEvent);

					} else {
						$("#photoPreview").attr("src", "Uploads/default-placeholder.jpg");
						$("#photoHidden").val("");
					}

					if (customer.customerSignature) {
						const imagePath = `Uploads/${customer.customerSignature}`;
						$("#signaturePreview").attr("src", imagePath);
						$("#signatureHidden").val(imagePath);
						const fakePhotoEvent = { target: { result: imagePath } };
						photoSizeEdit(fakePhotoEvent);

					} else {
						$("#signaturePreview").attr("src", "Uploads/default-placeholder.jpg");
						$("#signatureHidden").val("");
					}
					//signature
					/*if (customer.customerSignature) {
						const imagePath = `Uploads/${customer.customerSignature}`; // Construct full image path
						document.getElementById("signature").src = imagePath; // Set image source
						document.getElementById("signatureHidden").value = customer.customerSignature; // Set hidden input value
					} else {
						document.getElementById("signature").src = 'Uploads/upload.jpg'; // Default placeholder
						document.getElementById("signatureHidden").value = ''; // Clear hidden input value
					}*/

				} else {
					alert('No customer data found!');
					$('#enterCustomerName').val('');
					$('#previousShareCount').val('');
					//$('#panCardNumber').val('');
				}
			},
			error: function() {
				alert('Error while fetching customer data!');
			}
		});
	} else {
		$('#enterCustomerName').val('');
		$('#previousShareCount').val('');
		$('#panCardNumber').val('');
	}
});

function newPhotoUpload() {
	const file = document.getElementById("newPhoto").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			newPhotoSizeEdit(e);
			$("#newPhotoHidden").val("");
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for photo.");
	}
}

function newSignatureUpload() {
	const file = document.getElementById("newSignature").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			newSignatureSizeEdit(e);
			$("#newSignatureHidden").val("");
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for photo.");
	}
}

function jointPhotoUpload() {
	const file = document.getElementById("jointPhoto").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			jointPhotoSizeEdit(e);
			$("#jointPhotoHidden").val("");
		};
		reader.readAsDataURL(file);
	} else {
		alert("Please upload a valid image file for photo.");
	}
}

//Ayush
/*function signatureUpload() {
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
}*/

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

function newPhotoSizeEdit(e) {
	const previewimg = document.getElementById("newPhotoPreview");
	previewimg.src = e.target.result;
	previewimg.style.width = "100%";
	previewimg.style.height = "100%";
	previewimg.style.objectFit = "cover";
	previewimg.style.overflow = "hidden";
	previewimg.style.borderRadius = "20px";
}


function newSignatureSizeEdit(e) {
	const previewimg = document.getElementById("newSignaturePreview");
	previewimg.src = e.target.result;
	previewimg.style.width = "100%";
	previewimg.style.height = "100%";
	previewimg.style.objectFit = "cover";
	previewimg.style.overflow = "hidden";
	previewimg.style.borderRadius = "20px";
}

function jointPhotoSizeEdit(e) {
	const previewimg = document.getElementById("jointPhotoPreview");
	previewimg.src = e.target.result;
	previewimg.style.width = "100%";
	previewimg.style.height = "100%";
	previewimg.style.objectFit = "cover";
	previewimg.style.overflow = "hidden";
	previewimg.style.borderRadius = "20px";
}




//fetch only customer name on cahnge in dropdown
$('#jointOperationCode').on('change', function() {
	let selectedCode = $(this).val();

	if (selectedCode !== "") {
		$.ajax({
			url: 'api/customersavings/fetchCustomerCode',
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
			url: 'api/customersavings/fetchfinancialcode?financialCode=' + encodeURIComponent(selectedCode), // Pass as query param
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
										<td>${item.typeofaccount}</td>
				                        <td>${item.selectByCustomer}</td>
				                        <td>${item.enterCustomerName}</td>
										<td>${item.contactNumber}</td>
										<td>${item.branchName}</td>
										<td>${item.address}</td>
										<td>${item.district}</td>
										<td>${(item.state).toUpperCase()}</td>
										<td><button class="iconbutton" onclick="viewData(${item.id})" title="View"><i class="fa-solid fa-pen-to-square text-primary"></i></button></td>
										<td><button class="iconbutton" onclick="deleteData(${item.id})" title="Delete"><i class="fa-solid fa-trash text-danger"></i></button></td>
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
	// Ensure the hidden input is updated with the image file name
	/*	let imageSrc = $('#photo').attr('src');
		let imageName = imageSrc.split('/').pop(); // Extract the file name
		$('#photoHidden').val(imageName);
	
		// Ensure the hidden input is updated with the image file name
		let imageSrc1 = $('#signature').attr('src');
		let imageName1 = imageSrc1.split('/').pop(); // Extract the file name
		$('#signatureHidden').val(imageName1);*/

	// Ensure the hidden input is updated with the image file name
	/*let imageSrc2 = $('#jointPhoto').attr('src');
	let imageName2 = imageSrc2.split('/').pop(); // Extract the file name
	$('#jointPhotoHidden').val(imageName2);

	let imageSrc3 = $('#newPhoto').attr('src');
	let imageName3 = imageSrc2.split('/').pop(); // Extract the file name
	$('#newPhotoHidden').val(imageName3);

	let imageSrc4 = $('#newSignature').attr('src');
	let imageName4 = imageSrc2.split('/').pop(); // Extract the file name
	$('#newSignatureHidden').val(imageName4);*/
	$('#saveBtn').click(function(event) {
		event.preventDefault();

		const formData = new FormData();

		/* ================= DTO FIELDS ================= */
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
		formData.append("openingFees", $('#openingFees').val());
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
		formData.append("accountFreeze", $('#toggle-member-status4').is(':checked') ? 1 : 0);
		/* ================= STRING IMAGES ================= */
		// Existing images (already saved)
		function getFileName(path) {
			if (!path) return "";
			return path.substring(path.lastIndexOf('/') + 1);
		}

		var photoPath = $('#photoHidden').val();
		var signaturePath = $('#signatureHidden').val();

		var photoName = getFileName(photoPath);
		var signatureName = getFileName(signaturePath);

		formData.append("photo", photoName);
		formData.append("signature", signatureName);

		/* ================= MULTIPART FILES ================= */
		const jointPhoto = $('#jointPhoto')[0]?.files[0];
		const newPhoto = $('#newPhoto')[0]?.files[0];
		const newSignature = $('#newSignature')[0]?.files[0];

		if (jointPhoto) formData.append("jointPhoto", jointPhoto);
		if (newPhoto) formData.append("newPhoto", newPhoto);
		if (newSignature) formData.append("newSignature", newSignature);

		/* ================= DEBUG ================= */
		for (let pair of formData.entries()) {
			console.log(pair[0], pair[1]);
		}

		/* ================= AJAX ================= */
		$.ajax({
			type: "POST",
			url: "api/customersavings/saveandupdatesavingaccount",
			data: formData,
			processData: false,
			contentType: false,
			success: function(response) {
				alert("success");
				if (response.status == 'OK') {
					alert("OK");
					alert(response.message + "\nAccount No: " + $('#accountNumber').val());
					location.reload();
				}
				else {
					alert("else");
					alert("Customer already exists!");
				}
			},
			error: function(xhr) {
				alert("Customer already exists!");
			}
		});
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
				$("#openingFees").val(data.openingFees);
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
				//$("#messageSend").val(data.messageSend);
				//$("#debitCardIssue").val(data.debitCardIssue);
				$("#accountNumber").val(data.accountNumber);

				if (data.photo) {
					const photoPath = `Uploads/${data.photo}`; // Construct full image path
					$("#photoPreview").attr("src", photoPath);
					$("#photoHidden").val(photoPath);
					const fakePhotoEvent = { target: { result: photoPath } };
					photoSizeEdit(fakePhotoEvent);
				} else {
					$("#photoPreview").attr("src", "Uploads/default-placeholder.jpg");
					$("#photoHidden").val("");
				}
				//signature
				if (data.signature) {
					const signPath = `Uploads/${data.signature}`; // Construct full image path
					$("#signaturePreview").attr("src", signPath);
					$("#signatureHidden").val(signPath);
					const fakeSignEvent = { target: { result: signPath } };
					signatureSizeEdit(fakeSignEvent);
				} else {
					$("#signaturePreview").attr("src", "Uploads/default-placeholder.jpg");
					$("#signatureHidden").val("");
				}
				//Jointphoto
				var operationType=$("#operationType").val();
				if (operationType == "Joint") {
					$("#myJointPhoto").show();
					if (data.jointPhoto) {
						const jointPhotoPath = `Uploads/${data.jointPhoto}`; // Construct full image path
						$("#jointPhotoPreview").attr("src", jointPhotoPath);
						$("#jointPhotoHidden").val(jointPhotoPath);
						const fakeJointEvent = { target: { result: jointPhotoPath } };
						jointPhotoSizeEdit(fakeJointEvent);
					} else {
						$("#jointPhotoPreview").attr("src", "Uploads/default-placeholder.jpg");
						$("#signatureHidden").val("");
					}
				}


				if (data.newPhoto) {
					const newPhotoPath = `Uploads/${data.newPhoto}`; // Construct full image path
					$("#newPhotoPreview").attr("src", newPhotoPath);
					$("#newPhotoHidden").val(newPhotoPath);
					const fakeNewPhotoEvent = { target: { result: newPhotoPath } };
					newPhotoSizeEdit(fakeNewPhotoEvent);
				} else {
					$("#newPhotoPreview").attr("src", "Uploads/default-placeholder.jpg");
					$("#newPhotoHidden").val("");
				}

				if (data.newSignature) {
					const newSignPath = `Uploads/${data.newSignature}`; // Construct full image path
					$("#newSignaturePreview").attr("src", newSignPath);
					$("#newSignatureHidden").val(newSignPath);
					const fakeNewSignEvent = { target: { result: newSignPath } };
					newSignatureSizeEdit(fakeNewSignEvent);
				} else {
					$("#newSignaturePreview").attr("src", "Uploads/default-placeholder.jpg");
					$("#newSignatureHidden").val("");
				}

				/*let isChecked = data.accountStatus === 1;
				$("#toggle-member-status").prop('checked', isChecked);
				let isChecked2 = data.messageSend === 1;
				$("#toggle-member-status1").prop('checked', isChecked2);
				let isChecked3 = data.debitCardIssue === 1;
				$("#toggle-member-status2").prop('checked', isChecked3);*/
				document.getElementById("toggle-member-status").checked = data.accountStatus === true || data.accountStatus === '1';
				document.getElementById("toggle-member-status1").checked = data.messageSend === true || data.messageSend === '1';
				document.getElementById("toggle-member-status2").checked = data.debitCardIssue === true || data.debitCardIssue === '1';
				document.getElementById("toggle-member-status3").checked = data.isLocker === true || data.isLocker === '1';
				document.getElementById("toggle-member-status4").checked = data.accountFreeze === true || data.accountFreeze === '1';
				// Call updateToggleColor manually
				updateToggleColor(document.getElementById("toggle-member-status"));
				updateToggleColor(document.getElementById("toggle-member-status1"));
				updateToggleColor(document.getElementById("toggle-member-status2"));
				updateToggleColor(document.getElementById("toggle-member-status3"));
				updateToggleColor(document.getElementById("toggle-member-status4"));
			} else {
				alert("Account not found: " + response.message);
			}
		},
		error: function(xhr) {
			alert("Request failed: " + xhr.responseText);
		}
	});
}

function deleteData(id) {
	if (confirm("Are you sure you want to delete this branch?")) {
		$.ajax({
			url: "api/customersavings/deleteSavingAccountDataById",
			type: "POST",
			data: { id: id },
			success: function(response) {
				if (response.success) {
					alert(response.message);
					location.reload();
				} else {
					alert("Delete failed: " + response.message);
				}
			},
			error: function(xhr, status, error) {
				alert("Failed to delete financial Year.");
				console.error("Error:", error);
			}
		});
	}

}

$(document).ready(function () {

    $('#updateBtn').click(function (event) {
        event.preventDefault();

        const formData = new FormData();

        // ================= SAFE FILE INPUTS =================
        const newPhotoInput = document.getElementById("newPhoto");
        const newSignatureInput = document.getElementById("newSignature");
        const jointPhotoInput = document.getElementById("jointPhoto");

        const newPhotoFile =
            newPhotoInput && newPhotoInput.files.length > 0
                ? newPhotoInput.files[0]
                : null;

        const newSignatureFile =
            newSignatureInput && newSignatureInput.files.length > 0
                ? newSignatureInput.files[0]
                : null;

        const newJointPhotoFile =
            jointPhotoInput && jointPhotoInput.files.length > 0
                ? jointPhotoInput.files[0]
                : null;

        // ================= NORMAL FIELDS =================
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
        formData.append("openingFees", $('#openingFees').val());
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
        formData.append("accountFreeze", $('#toggle-member-status4').is(':checked') ? 1 : 0);

        // ================= FILE APPEND (VERY IMPORTANT) =================
        // NOTE: MultipartFile ke liye STRING kabhi mat bhejo

        if (newPhotoFile) {
            formData.append("photo", newPhotoFile);
        }

        if (newSignatureFile) {
            formData.append("signature", newSignatureFile);
        }

        if (newJointPhotoFile) {
            formData.append("jointPhoto", newJointPhotoFile);
        }

        // ================= DEBUG =================
        for (let pair of formData.entries()) {
            console.log(pair[0], pair[1]);
        }

        // ================= AJAX =================
        $.ajax({
            type: "POST",
            url: "api/customersavings/saveandupdatesavingaccount",
            data: formData,
            processData: false,
            contentType: false,
            success: function () {
                alert("Saving Account data updated successfully!\nAccount No : " + $('#accountNumber').val());
                location.reload();
            },
            error: function (xhr) {
                console.error(xhr.responseText);
                alert("Update failed");
            }
        });
    });

});
ss


function operationTypeFunc() {
	var operationType = $("#operationType").val();
	if (operationType === 'Single') {
		$("#myJointPhoto").hide();
	}
	else {
		$("#myJointPhoto").show();
	}
}