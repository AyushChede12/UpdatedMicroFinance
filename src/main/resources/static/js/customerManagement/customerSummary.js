$(document).ready(function() {
	/*$.ajax({
		url: 'api/customermanagement/approved',
		type: 'GET',
		success: function(response) {
			alert("success");
			// response is a list of addCustomer objects
			let customerOptions = response.data.map(function(item) {
				let fullName = [
					item.firstName,
					item.middleName,
					item.lastName
				].filter(Boolean).join(" ");

				return {
					id: item.memberCode,
					text: item.memberCode + " - " + fullName
				};
			});

			$('#selectMember').select2({
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
		},
		error: function(xhr, status, error) {
			console.error("Error fetching customers:", error);
			alert("Failed to load customer codes.");
		}
	});*/

	$.ajax({
		url: "api/customermanagement/approved",
		type: "GET",
		success: function(response) {
			if (response.status === "OK") {
				const customerList = response.data;
				$("#selectMember").empty(); // Clear existing options
				$("#selectMember").append("<option value=''>-- Select Code --</option>");

				// Bind approved customers to dropdown
				customerList.forEach(function(customer) {
					let fullName = [
						customer.firstName || '',
						customer.middleName || '',
						customer.lastName || ''
					].filter(Boolean).join(" ");
					let displayText = customer.memberCode + " - " + fullName;
					let option = `<option value="${customer.memberCode}">${displayText}</option>`;
					$("#selectMember").append(option);
				});
			} else {
				alert("Error: " + (response.message || "No customers found"));
			}
		},
		error: function(xhr) {
			console.error("Error loading approved customers:", xhr.responseText);
			alert("Failed to load approved customers.");
		}
	});

	$("#selectMember").change(function() {
		let customerCode = $("#selectMember").val();
		if (customerCode !== "") {
			$.ajax({
				type: "POST",
				url: "api/customershareholdingcontroller/fetchByCustomerCode",
				data: { memberCode: customerCode },
				success: function(response) {
					if (response.status == "FOUND") {
						let data = response.data[0];
						let fullName = [
							data.firstName || '',
							data.middleName || '',
							data.lastName || ''
						].filter(Boolean).join(" ");
						$("#id").val(data.id);
						$("#customerCode").val(data.memberCode);
						$("#customerName").val(fullName.toUpperCase());
						$("#singupDate").val(data.signupDate.toUpperCase());
						$("#guardianName").val(data.relationToApplicant.toUpperCase());
						$("#customerAddress").val(data.customerAddress.toUpperCase());
						$("#pinCode").val(data.pinCode);
						$("#state").val(data.state);
						$("#contactNo").val(data.contactNo.toUpperCase());
						$("#aadharNo").val(data.aadharNo.toUpperCase());
						$("#pan").val(data.panNo.toUpperCase());
						$("#nomineeName").val(data.nomineeName.toUpperCase());
						$("#emailId").val(data.emailId.toUpperCase());
						$("#dob").val(data.dob.toUpperCase());
						$("#customerAge").val(data.customerAge.toUpperCase());
						$("#branchName").val(data.branchName.toUpperCase());
						$("#customerGender").val(data.customerGender.toUpperCase());

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