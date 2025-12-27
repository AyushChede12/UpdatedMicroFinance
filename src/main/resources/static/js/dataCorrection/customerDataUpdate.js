$(document).ready(function() {

	//With Search in Dropdown
	$.ajax({
		url: 'api/customermanagement/approved',
		type: 'GET',
		success: function(response) {
			// Check if response has data array inside `data`
			if (response && response.data && Array.isArray(response.data) && response.data.length > 0) {
				let customerOptions = response.data.map(function(item) {
					return {
						id: item.memberCode,
						text: item.memberCode + " - " + item.customerName
					};
				});

				$('#customerCode').select2({
					placeholder: '-- Search Customer Code or Name --',
					data: customerOptions,
					matcher: function(params, data) {
						if ($.trim(params.term) === '') return data;
						if (typeof data.text === 'undefined') return null;

						const term = params.term.toLowerCase();
						const text = data.text.toLowerCase();
						return text.includes(term) ? data : null;
					}
				});
			} else {
				alert("No approved customers found.");
			}
		},
		error: function(xhr, status, error) {
			console.error("Error fetching customers:", error);
			alert("Failed to load customer codes.");
		}
	});

	$("#customerCode").change(function() {
		let customerCode = $("#customerCode").val();
		if (customerCode !== "") {
			$.ajax({
				type: "POST",
				url: "api/customershareholdingcontroller/fetchByCustomerCode",
				data: { memberCode: customerCode },
				success: function(response) {
					if (response.status == "FOUND") {
						let data = response.data[0];
						$("#id").val(data.id);
						$("#signupDate").val(data.signupDate);
						$("#authenticateFor").val(data.authenticateFor);
						$("#customerName").val(data.customerName.toUpperCase());
						$("#familyMemberName").val(data.guardianName.toUpperCase());
						$("#relationToApplicant").val(data.relationToApplicant.toUpperCase());
						$("#customerGender").val(data.customerGender);
						$("#dob").val(data.dob);
						$("#customerAge").val(data.customerAge);
						$("#relationshipStatus").val(data.relationshipStatus.toUpperCase());
						$("#customerAddress").val(data.customerAddress.toUpperCase());
						$("#district").val(data.district.toUpperCase());
						$("#state").val(data.state.toUpperCase());
						$("#branchName").val(data.branchName.toUpperCase());
						$("#pinCode").val(data.pinCode);
						$("#aadharNo").val(data.aadharNo);
						$("#panNo").val(data.panNo.toUpperCase());
						$("#voterNo").val(data.voterNo.toUpperCase());
						$("#contactNo").val(data.contactNo);
						$("#emailId").val(data.emailId.toUpperCase());
						$("#profession").val(data.profession.toUpperCase());
						$("#academicBackground").val(data.academicBackground.toUpperCase());
						$("#referralCode").val(data.referralCode.toUpperCase());
						$("#referralName").val(data.referralName.toUpperCase());
						$("#minor").val(data.minor);
						//$("#photoPreview").attr("src", data.customerPhoto ? `Uploads/${data.customerPhoto}` : "Uploads/default-placeholder.jpg");
						
						//Nominee 
						$("#nomineeName").val(data.nomineeName.toUpperCase());
						$("#nomineeRelationToApplicant").val(data.nomineeRelationToApplicant.toUpperCase());
						$("#nomineeAddress").val(data.nomineeAddress.toUpperCase());
						$("#nomineeKycNo").val(data.nomineeKycNo.toUpperCase());
						$("#nomineeMobileNo").val(data.nomineeMobileNo);
						$("#nomineeAge").val(data.nomineeAge);
						$("#nomineePanNo").val(data.nomineePanNo.toUpperCase());
						$("#nomineeKycType").val(data.nomineeKycType.toUpperCase());

						if (data.customerPhoto) {
							const photoPath = `Uploads/${data.customerPhoto}`;
							$("#photoPreview").attr("src", photoPath);
							$("#photoHidden").val(photoPath);
							const fakePhotoEvent = { target: { result: photoPath } };
							photoSizeEdit(fakePhotoEvent);

						} else {
							$("#photoPreview").attr("src", "Uploads/default-placeholder.jpg");
							$("#photoHidden").val("");
						}

						// Image: Signature
						if (data.customerSignature) {
							const signPath = `Uploads/${data.customerSignature}`;
							$("#signaturePreview").attr("src", signPath);
							$("#signatureHidden").val(signPath);
							const fakeSignEvent = { target: { result: signPath } };
							signatureSizeEdit(fakeSignEvent);

						} else {
							$("#signaturePreview").attr("src", "Uploads/default-placeholder.jpg");
							$("#signatureHidden").val("");
						}



						if (parseInt(data.memberStatus) === 1) {
							$('#toggle-member-status').prop('checked', true);
						} else {
							$('#toggle-member-status').prop('checked', false);
						}

						if (parseInt(data.memberBanking) === 1) {
							$('#toggle-mobile-banking').prop('checked', true);
						} else {
							$('#toggle-mobile-banking').prop('checked', false);
						}

						if (parseInt(data.netBanking) === 1) {
							$('#toggle-net-banking').prop('checked', true);
						} else {
							$('#toggle-net-banking').prop('checked', false);
						}

						if (parseInt(data.smsSend) === 1) {
							$('#toggle-sms-send').prop('checked', true);
						} else {
							$('#toggle-sms-send').prop('checked', false);
						}

						updateToggleColor(document.getElementById('toggle-member-status'));
						updateToggleColor(document.getElementById('toggle-mobile-banking'));
						updateToggleColor(document.getElementById('toggle-net-banking'));
						updateToggleColor(document.getElementById('toggle-sms-send'));

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

	$.ajax({
		url: "api/preference/getAllRelativeModule", // Add base path if needed like /api/preference/getAllBranchModule
		type: "GET",
		success: function(response) {
			if (response.status == "FOUND") {
				const relativeList = response.data;
				$("#nomineeRelationToApplicant").empty(); // Clear existing options
				$("#nomineeRelationToApplicant").append("<option value=''>-- Select Relative --</option>");

				for (let i = 0; i < relativeList.length; i++) {
					let relative = relativeList[i];
					let option = `<option value="${relative.relation}">${relative.relation}</option>`;
					$("#nomineeRelationToApplicant").append(option);
				}
			} else {
				alert("Error: " + response.message);
			}
		},
		error: function(xhr) {
			console.error("Error loading branches:", xhr.responseText);
			alert("Failed to load dropdown data.");
		}
	});



	$('#updateBtn').click(async function(event) {
		event.preventDefault();
		const customerCode = $('#customerCode').val();
		if (!customerCode) {
			alert("First select the data, then proceed to update.");
			return;
		}
		var customerData = new FormData();
		var id = $('#id').val();
		customerData.append("id", id);
		customerData.append("memberCode", customerCode);
		customerData.append("signupDate", $('#signupDate').val());
		customerData.append("authenticateFor", $('#authenticateFor').val());
		customerData.append("customerName", $('#customerName').val());
		customerData.append("customerGender", $('#customerGender').val());
		customerData.append("guardianName", $('#guardianName').val());
		customerData.append("relationToApplicant", $('#relationToApplicant').val());
		customerData.append("dob", $('#dob').val());
		customerData.append("customerAge", $('#customerAge').val());
		customerData.append("relationshipStatus", $('#relationshipStatus').val());
		customerData.append("customerAddress", $('#customerAddress').val());
		customerData.append("state", $('#state').val());
		customerData.append("district", $('#district').val());
		customerData.append("aadharNo", $('#aadharNo').val());
		customerData.append("pinCode", $('#pinCode').val());
		customerData.append("branchName", $('#branchName').val());
		customerData.append("panNo", $('#panNo').val());
		customerData.append("voterNo", $('#voterNo').val());
		customerData.append("drivingLicenceNo", $('#drivingLicenceNo').val());
		customerData.append("referralCode", $('#referralCode').val());
		customerData.append("referralName", $('#referralName').val());
		customerData.append("contactNo", $('#contactNo').val());
		customerData.append("emailId", $('#emailId').val());
		customerData.append("profession", $('#profession').val());
		customerData.append("academicBackground", $('#academicBackground').val());

		// Nominee
		customerData.append("nomineeName", $('#nomineeName').val());
		customerData.append("nomineeRelationToApplicant", $('#nomineeRelationToApplicant').val());
		customerData.append("nomineeAddress", $('#nomineeAddress').val());
		customerData.append("nomineeKycNo", $('#nomineeKycNo').val());
		customerData.append("nomineeMobileNo", $('#nomineeMobileNo').val());
		customerData.append("nomineeAge", $('#nomineeAge').val());
		customerData.append("nomineePanNo", $('#nomineePanNo').val());
		customerData.append("nomineeKycType", $('#nomineeKycType').val());
		customerData.append("memberStatus", $('#toggle-member-status').is(':checked') ? 1 : 0);
		customerData.append("memberBanking", $('#toggle-mobile-banking').is(':checked') ? 1 : 0);
		customerData.append("netBanking", $('#toggle-net-banking').is(':checked') ? 1 : 0);
		customerData.append("smsSend", $('#toggle-sms-send').is(':checked') ? 1 : 0);

		const photoFile = $('#customerPhoto')[0].files[0];
		const signatureFile = $('#customerSignature')[0].files[0];

		if (photoFile) {
			customerData.append("customerPhoto", photoFile);
		}

		if (signatureFile) {
			customerData.append("customerSignature", signatureFile);
		}

		$.ajax({
			type: 'POST',
			url: 'api/customermanagement/saveOrUpdateCustomer',
			data: customerData,
			contentType: false,
			processData: false,
			cache: false,
			success: function(response) {
				if (response.status === "OK") {
					alert("Customer Data Updated Successfully");
					location.reload();
				} else {
					alert("Something went wrong: " + response.message);
				}
			},
			error: function(xhr) {
				alert("Error while saving data: " + xhr.responseText);
			}
		});
	});

	$('#deleteBtn').click(function(event) {
		var id = $("#id").val();
		let customerCode = $("#customerCode").val();
		if (customerCode !== "") {
			if (confirm("Are you sure you want to delete this Customer Data?")) {
				$.ajax({
					url: "api/datacorrection/deleteCustomerDataByForm",
					type: "POST",
					data: { id: id },
					success: function(response) {
						if (response.status == "OK") {
							alert("Customer Data Deleted Successfully");
							location.reload();
						} else {
							alert("Delete failed: " + response.message);
						}
					},
					error: function(xhr, status, error) {
						alert("Failed to delete Customer.");
						console.error("Error:", error);
					}
				});
			}
		}
		else {
			alert("First Select Any One Data Then Proceed To Delete!");
		}

	});

	$("#printBtn").on("click", function() {

		const customerCode = $("#customerCode").val();
		if (!customerCode) {
			alert("Please select atleast one data then proceed to print!");
			return;
		}

		const c = window.companyData;

		let companyHeader = `
	        <h1 style="text-align:center; margin-bottom:0;">${c.companyName}</h1>
	        <h3 style="text-align:center; margin-top:5px;">(${c.shortName})</h3>
	        <p style="text-align:center;">
	            ${c.address}, ${c.city}, ${c.state} - ${c.pinCode}<br>
	            CIN: ${c.cinNo} | Email: ${c.emailId.toLowerCase()} | Helpline: ${c.helplineNo}
	        </p>
	        <hr>
	    `;

		function getVal(id) {
			let el = $("#" + id);
			if (el.is("select")) {
				let txt = el.find("option:selected").text();
				if (el.data("select2")) {
					let s2 = el.select2("data");
					if (s2.length > 0) txt = s2[0].text;
				}
				if (id === "customerCode" && txt.includes("-")) {
					txt = txt.split("-")[0].trim();
				}
				return txt;
			}
			return el.val() ? el.val() : "";
		}

		const photo = $("#photoPreview").attr("src");
		const sign = $("#signaturePreview").attr("src");

		const printContent = `
	        ${companyHeader}

	        <h2 style="text-align:center;margin-bottom:20px;">Customer Details</h2>

	        <table class="print-table">

	            <tr><th>Customer Code</th><td>${getVal("customerCode")}</td></tr>
	            <tr><th>Customer Name</th><td>${getVal("customerName")}</td></tr>
	            <tr><th>Gender</th><td>${getVal("customerGender")}</td></tr>
	            <tr><th>Date of Birth</th><td>${getVal("dob")}</td></tr>
	            <tr><th>Age</th><td>${getVal("customerAge")}</td></tr>
	            <tr><th>Relationship Status</th><td>${getVal("relationshipStatus")}</td></tr>
	            <tr><th>Address</th><td>${getVal("customerAddress")}</td></tr>
	            <tr><th>District</th><td>${getVal("district")}</td></tr>
	            <tr><th>State</th><td>${getVal("state")}</td></tr>
	            <tr><th>Branch</th><td>${getVal("branchName")}</td></tr>
	            <tr><th>Pin Code</th><td>${getVal("pinCode")}</td></tr>
	            <tr><th>Aadhar No</th><td>${getVal("aadharNo")}</td></tr>
	            <tr><th>PAN No</th><td>${getVal("panNo")}</td></tr>
	            <tr><th>Voter ID</th><td>${getVal("voterNo")}</td></tr>
	            <tr><th>Contact No</th><td>${getVal("contactNo")}</td></tr>
	            <tr><th>Email ID</th><td>${getVal("emailId")}</td></tr>
	            <tr><th>Profession</th><td>${getVal("profession")}</td></tr>
	            <tr><th>Academic Background</th><td>${getVal("academicBackground")}</td></tr>
	            <tr><th>Referral Code</th><td>${getVal("referralCode")}</td></tr>
	            <tr><th>Referral Name</th><td>${getVal("referralName")}</td></tr>

				<tr><th colspan="2" style="background:#f1f1f1;text-align:center;">Customer Images</th></tr>
	            <tr>
	                <th>Customer Photo</th>
	                <td><img src="${photo}" style="width:120px;height:120px;object-fit:cover;border-radius:10px;"></td>
	            </tr>

	            <tr>
	                <th>Customer Signature</th>
	                <td><img src="${sign}" style="width:150px;height:70px;object-fit:contain;"></td>
	            </tr>

	            <tr><th colspan="2" style="background:#f1f1f1;text-align:center;">Nominee Details</th></tr>
	            <tr><th>Nominee Name</th><td>${getVal("nomineeName")}</td></tr>
	            <tr><th>Relation</th><td>${getVal("nomineeRelationToApplicant")}</td></tr>
	            <tr><th>Address</th><td>${getVal("nomineeAddress")}</td></tr>
	            <tr><th>KYC No</th><td>${getVal("nomineeKycNo")}</td></tr>
	            <tr><th>Nominee Mobile</th><td>${getVal("nomineeMobileNo")}</td></tr>
	            <tr><th>Nominee Age</th><td>${getVal("nomineeAge")}</td></tr>
	            <tr><th>Nominee PAN</th><td>${getVal("nomineePanNo")}</td></tr>
	            <tr><th>KYC Type</th><td>${getVal("nomineeKycType")}</td></tr>

	        </table>
	    `;

		const printWindow = window.open("", "_blank");

		printWindow.document.write(`
	        <html>
	        <head>
	            <title>Customer Details</title>
	            <style>
	                body { font-family: Arial; padding: 25px; }
	                .print-table { width: 100%; border-collapse: collapse; }
	                .print-table th, .print-table td {
	                    padding: 8px; border: 1px solid #ccc; font-size: 14px;
	                }
	                .print-table th { background: #f2f2f2; width:30%; }
	            </style>
	        </head>
	        <body>
	            ${printContent}
	        </body>
	        </html>
	    `);

		printWindow.document.close();

		setTimeout(() => {
			printWindow.focus();
			printWindow.print();
		}, 300);
	});


});

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

function updateToggleColor(input) {
	const label = input.nextElementSibling;
	if (input.checked) {
		label.style.backgroundColor = "#4caf50";  // green
		label.style.borderColor = "#4caf50";
	} else {
		label.style.backgroundColor = "#ccc";  // gray
		label.style.borderColor = "#ccc";
	}
}

document.addEventListener('DOMContentLoaded', function() {
	const toggles = document.querySelectorAll('.toggle__input');

	toggles.forEach((toggle) => {
		updateToggleColor(toggle); // initial state
		toggle.addEventListener('change', function() {
			updateToggleColor(this);
		});
	});
});

function photoUpload() {
	const file = document.getElementById("customerPhoto").files[0];
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
	const file = document.getElementById("customerSignature").files[0];
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

function loadCompanyAdministration() {
	$.ajax({
		type: "GET",
		url: "api/preference/fetchAllCompanyAdministration",
		contentType: "application/json",
		success: function(response) {
			if (response.status === "FOUND" && response.data.length > 0) {
				let c = response.data[0];

				// Save for print use later
				window.companyData = c;

				// Show on screen (add your own div in JSP)
				$("#companyNameHeading").text(c.companyName + " (" + c.shortName + ")");
				$("#companyDetails").html(`
                        <b>Sign Up Date:</b> ${c.signUpDate} <br>
                        <b>CIN No:</b> ${c.cinNo} <br>
                        <b>Address:</b> ${c.address}, ${c.city}, ${c.state} - ${c.pinCode} <br>
                        <b>Email:</b> ${c.emailId} <br>
                        <b>Helpline:</b> ${c.helplineNo} <br>
                        <b>Branch Manager No:</b> ${c.branchManagerContactNo}
                    `);
			}
		}
	});
}

loadCompanyAdministration();
