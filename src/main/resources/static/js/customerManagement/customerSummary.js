let currentCustomerId = null;

$(document).ready(function() {

	function safeUpper(val) {
		if (val === null || val === undefined) return '';
		return String(val).trim().toUpperCase();
	}

	function resetCustomerForm() {
		$("#id").val("");
		$("#customerCode").val("");
		$("#customerAccountNo").val("");
		$("#customerName").val("");
		$("#singupDate").val("");
		$("#guardianName").val("");
		$("#customerAddress").val("");
		$("#pinCode").val("");
		$("#state").val("");
		$("#contactNo").val("");
		$("#aadharNo").val("");
		$("#pan").val("");
		$("#nomineeName").val("");
		$("#emailId").val("");
		$("#dob").val("");
		$("#customerAge").val("");
		$("#branchName").val("");
		$("#customerGender").val("");

		$("#photoPreview").attr("src", "Uploads/upload.png");
		$("#photoPreview").removeAttr("style");
		$("#photoHidden").val("");

		$("#customerSignaturePreview").attr("src", "Uploads/upload.png");
		$("#customerSignaturePreview").removeAttr("style");
		$("#customerSignatureHidden").val("");

		currentCustomerId = null;
		$("#customerImageUploadSection").hide();
		$("#storedImages").html("");
	}

	// Fetch all customers for the dropdown
	$.ajax({
		url: "api/customermanagement/getAllCustomer",
		type: "GET",
		success: function(response) {
			let customerList = [];
			if (Array.isArray(response)) {
				customerList = response;
			} else if (response && response.data && Array.isArray(response.data)) {
				customerList = response.data;
			}

			$("#selectMember").empty();
			$("#selectMember").append("<option value=''>-- SEARCH CUSTOMER CODE --</option>");

			let customerOptions = [{ id: '', text: '-- SEARCH CUSTOMER CODE --' }];

			customerList.forEach(function(customer) {
				let fullName = [
					customer.firstName || '',
					customer.middleName || '',
					customer.lastName || ''
				].filter(Boolean).join(" ");
				if (!fullName) {
					fullName = customer.customerName || '';
				}
				let displayText = (customer.memberCode || '') + " - " + fullName.toUpperCase();
				$("#selectMember").append(`<option value="${customer.memberCode}">${displayText}</option>`);

				customerOptions.push({
					id: customer.memberCode,
					text: displayText
				});
			});

			// Initialize Select2 if available
			if ($.fn.select2) {
				$("#selectMember").select2({
					placeholder: '-- SEARCH CUSTOMER CODE --',
					allowClear: true,
					width: '100%',
					matcher: function(params, data) {
						if ($.trim(params.term) === '') return data;
						if (typeof data.text === 'undefined') return null;
						const term = params.term.toLowerCase();
						const text = data.text.toLowerCase();
						return text.includes(term) ? data : null;
					}
				});
			}
		},
		error: function(xhr) {
			console.error("Error loading customers:", xhr.responseText);
			// Fallback to approved endpoint if getAllCustomer fails
			$.ajax({
				url: "api/customermanagement/approved",
				type: "GET",
				success: function(res) {
					let list = (res && res.data) ? res.data : [];
					$("#selectMember").empty();
					$("#selectMember").append("<option value=''>-- SEARCH CUSTOMER CODE --</option>");
					list.forEach(function(c) {
						let fullName = [c.firstName, c.middleName, c.lastName].filter(Boolean).join(" ") || c.customerName || '';
						let text = (c.memberCode || '') + " - " + fullName.toUpperCase();
						$("#selectMember").append(`<option value="${c.memberCode}">${text}</option>`);
					});
				}
			});
		}
	});


	// Trigger on dropdown selection change
	$("#selectMember").on("change select2:select", function() {
		let customerCode = $(this).val();

		if (!customerCode || customerCode.trim() === "") {
			resetCustomerForm();
			return;
		}

		fetchCustomerDetails(customerCode);
	});

	function fetchCustomerDetails(customerCode) {
		$.ajax({
			type: "POST",
			url: "api/customershareholdingcontroller/fetchByCustomerCode",
			data: { memberCode: customerCode },
			success: function(response) {
				let customerData = null;

				if (response && response.data && Array.isArray(response.data) && response.data.length > 0) {
					customerData = response.data[0];
				} else if (response && response.data && !Array.isArray(response.data)) {
					customerData = response.data;
				} else if (Array.isArray(response) && response.length > 0) {
					customerData = response[0];
				} else if (response && response.memberCode) {
					customerData = response;
				}

				if (customerData) {
					populateForm(customerData);
				} else {
					// Fallback to fetchBySelectedCustomer
					fallbackFetch(customerCode);
				}
			},
			error: function() {
				fallbackFetch(customerCode);
			}
		});
	}

	function fallbackFetch(customerCode) {
		$.ajax({
			type: "POST",
			url: "api/customermanagement/fetchBySelectedCustomer",
			contentType: "application/json",
			data: JSON.stringify({ memberCode: customerCode }),
			success: function(dataList) {
				if (dataList && dataList.length > 0) {
					populateForm(dataList[0]);
				} else {
					alert("No customer details found for code: " + customerCode);
					resetCustomerForm();
				}
			},
			error: function() {
				alert("Error fetching customer details for code: " + customerCode);
				resetCustomerForm();
			}
		});
	}

	function populateForm(data) {
		let fullName = [
			data.firstName || '',
			data.middleName || '',
			data.lastName || ''
		].filter(Boolean).join(" ");
		if (!fullName) {
			fullName = data.customerName || '';
		}

		$("#id").val(data.id || '');
		$("#customerCode").val(safeUpper(data.memberCode));
		$("#customerAccountNo").val("LOADING...");
		$.ajax({
                url: "api/customersavings/getAccountNumbersByCode",
                type: "GET",
                data: {
                    selectByCustomer: data.memberCode
                },
                success: function(response) {

                    if (response.status === "FOUND"
                            && response.data
                            && response.data.length > 0) {

                        let account = response.data.find(function(item) {
                            return item.accountNumber;
                        });

                        $("#customerAccountNo").val(
                            account ? account.accountNumber : "N/A"
                        );

                    } else {

                        $("#customerAccountNo").val("N/A");
                    }
                },
                error: function() {

                    $("#customerAccountNo").val("N/A");
                }
            });
		$("#customerName").val(safeUpper(fullName));
		$("#singupDate").val(data.signupDate || '');
		$("#guardianName").val(safeUpper(data.guardianName));
		$("#customerAddress").val(safeUpper(data.customerAddress));
		$("#pinCode").val(safeUpper(data.pinCode));
		$("#state").val(safeUpper(data.state));
		$("#contactNo").val(safeUpper(data.contactNo));
		$("#aadharNo").val(safeUpper(data.aadharNo));
		$("#pan").val(safeUpper(data.panNo));
		$("#nomineeName").val(safeUpper(data.nomineeName));
		$("#emailId").val(safeUpper(data.emailId));
		$("#dob").val(data.dob || '');
		$("#customerAge").val(safeUpper(data.customerAge));
		$("#branchName").val(safeUpper(data.branchName));
		$("#customerGender").val(safeUpper(data.customerGender));

		// Resolve normalized image paths
		function getImgUrl(val) {
			if (!val || val.trim() === "" || val === "null" || val === "undefined") return "";
			val = val.trim();
			if (val.startsWith("http://") || val.startsWith("https://") || val.startsWith("data:")) return val;
			return "Uploads/" + val.replace(/^(\/)?Uploads\//, '');
		}

		// Customer Photo
		const resolvedPhoto = getImgUrl(data.customerPhoto);
		if (resolvedPhoto) {
			$("#photoPreview").attr("src", resolvedPhoto);
			$("#photoHidden").val(resolvedPhoto);
			$("#photoPreview").css({
				"width": "100%",
				"height": "100%",
				"object-fit": "cover",
				"border-radius": "20px"
			});
		} else {
			$("#photoPreview").attr("src", "Uploads/upload.png");
			$("#photoHidden").val("");
			$("#photoPreview").removeAttr("style");
		}

		// Customer Signature
		const resolvedSign = getImgUrl(data.customerSignature);
		if (resolvedSign) {
			$("#customerSignaturePreview").attr("src", resolvedSign);
			$("#customerSignatureHidden").val(resolvedSign);
			$("#customerSignaturePreview").css({
				"width": "100%",
				"height": "100%",
				"object-fit": "cover",
				"border-radius": "20px"
			});
		} else {
			$("#customerSignaturePreview").attr("src", "Uploads/upload.png");
			$("#customerSignatureHidden").val("");
			$("#customerSignaturePreview").removeAttr("style");
		}

		currentCustomerId = data.id;
		$("#customerImageUploadSection").show();
		loadCustomerImages(currentCustomerId);
	}

	// =================================================
	// CUSTOMER IMAGE UPLOAD EVENT LISTENERS
	// =================================================
	$("#addFieldBtn").click(function(e) {
		e.preventDefault();
		createNewField();
	});

	function createNewField() {
		const fieldHtml = `
            <div class="textUploadSet mb-4">
                <input style="text-transform: uppercase;" type="text" class="form-control nameField" placeholder="ENTER IMAGE NAME...">
                <div class="uploadContainer"></div>
            </div>`;
		$("#fieldContainer").append(fieldHtml);
	}

	$(document).on("input", ".nameField", function() {
		const val = $(this).val().trim();
		const box = $(this).closest(".textUploadSet").find(".uploadContainer");

		if (val.length === 0) { box.html(""); return; }

		const uniqueId = "file-" + Date.now();

		const html = `
            <div class="uploadField mt-2">
                <label>${val.toUpperCase()} *</label>
                <label for="${uniqueId}">
                    <input type="file" id="${uniqueId}" hidden accept="image/*" onchange="previewImage('${uniqueId}')">
                    <div>
                        <img src="Uploads/upload.png" id="preview-${uniqueId}" style="width:120px;">
                    </div>
                </label>
            </div>
        `;

		box.html(html);
	});

	$("#uploadAllBtn").click(function() {
		if (!currentCustomerId) {
			alert("Please select a customer first.");
			return;
		}

		let uploadFields = $(".uploadField");
		let uploadCount = uploadFields.length;
		if (uploadCount === 0) {
			alert("No fields added to upload.");
			return;
		}

		let completed = 0;
		uploadFields.each(function() {
			const fieldName = $(this).find("label:first").text().replace("*", "").trim();
			const input = $(this).find("input[type=file]")[0];
			const file = input.files[0];

			if (!file) {
				alert("Select file for " + fieldName);
				return;
			}

			let fd = new FormData();
			fd.append("fieldName", fieldName);
			fd.append("file", file);

			$.ajax({
				url: "api/customermanagement/upload/" + currentCustomerId,
				type: "POST",
				data: fd,
				processData: false,
				contentType: false,
				success: function() {
					$(input).closest(".uploadField").css("border", "2px solid green");
					completed++;
					if (completed === uploadCount) {
						alert("All images uploaded successfully!");
						loadCustomerImages(currentCustomerId);
					}
				},
				error: function() {
					$(input).closest(".uploadField").css("border", "2px solid red");
					alert("Failed to upload " + fieldName);
				}
			});
		});
	});

	$("#reloadDataBtn").click(function() {
		if (currentCustomerId) {
			loadCustomerImages(currentCustomerId);
		}
	});

	function loadCustomerImages(customerId) {
		$("#storedImages").html(`<h5>Loading...</h5>`);

		$.ajax({
			url: "api/customermanagement/images/" + customerId,
			type: "GET",
			success: function(data) {
				let html = "<h4>STORED IMAGES</h4><div class='row'>";
				if (!data || data.length === 0) {
					html += "<p class='col-12 text-muted'>No stored images for this customer.</p>";
				} else {
					data.forEach(img => {
						html += `
							<div class="col-lg-3 text-center mb-4">
								<div class="img-box" style="position:relative; display:inline-block;">
									<img src="Uploads/customer/${customerId}/${img.fileName}" 
										 width="150" height="150" 
										 style="object-fit:contain;border:1px solid #ccc;border-radius:8px;padding:4px;">
									<button type="button" class="deleteImg btn btn-danger btn-sm" data-id="${customerId}-${img.id}" 
										style="position:absolute; top:5px; right:5px; border-radius:50%; width:24px; height:24px; padding:0; line-height:20px;">&times;</button>
								</div>
								<p class="mt-1 font-weight-bold">${safeUpper(img.name)}</p>
								<p class="text-muted small" style="font-size: 11px;">Uploaded: ${img.uploadDate || 'N/A'}</p>
							</div>
						`;
					});
				}
				html += "</div>";
				$("#storedImages").html(html);
			},
			error: function() {
				$("#storedImages").html("<p class='text-danger'>Failed to load stored images.</p>");
			}
		});
	}

	$(document).on("click", ".deleteImg", function() {
		const id = $(this).data("id");
		if (confirm("Are you sure you want to delete this image?")) {
			$.ajax({
				url: "api/customermanagement/delete/" + id,
				type: "POST",
				success: function() {
					alert("Image deleted!");
					if (currentCustomerId) {
						loadCustomerImages(currentCustomerId);
					}
				},
				error: function() {
					alert("Error deleting image.");
				}
			});
		}
	});

});

function photoUpload() {
	const file = document.getElementById("photo").files[0];
	if (file && file.type.startsWith("image/")) {
		const reader = new FileReader();
		reader.onload = function(e) {
			photoSizeEdit(e);
			$("#photoHidden").val("");
		};
		reader.readAsDataURL(file);
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

function newlyAddedImageSizeEdit(e) {
	const previewimg = document.getElementById("customerSignaturePreview");
	previewimg.src = e.target.result;
	previewimg.style.width = "100%";
	previewimg.style.height = "100%";
	previewimg.style.objectFit = "cover";
	previewimg.style.overflow = "hidden";
	previewimg.style.borderRadius = "20px";
}

function previewImage(id) {
	const file = document.getElementById(id).files[0];
	const preview = document.getElementById("preview-" + id);

	if (file) {
		const reader = new FileReader();
		reader.onload = e => preview.src = e.target.result;
		reader.readAsDataURL(file);
	}
}

$("#summaryDownloadPDF").on("click", function() {

    if (!currentCustomerId) {
        alert("Please select a customer first.");
        return;
    }

    window.location.href =
        "api/customermanagement/export/"
        + currentCustomerId
        + "/pdf";
});


$("#summaryDownloadWord").on("click", function() {

    if (!currentCustomerId) {
        alert("Please select a customer first.");
        return;
    }

    window.location.href =
        "api/customermanagement/export/"
        + currentCustomerId
        + "/word";
});