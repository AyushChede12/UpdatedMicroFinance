// ✅ Js for populating the loanid in the dropdown (Vaibhav)
$(document).ready(function() {
	populateLoanIdDropdown();
});

function populateLoanIdDropdown() {
    $.ajax({
        url: "api/loanmanegment/getAllNotApprovedLoanCustomer",
        type: "GET",
        dataType: "json",
        success: function(response) {
            console.log("Loan response:", response);

            // ✅ status may come as "OK"
            if (response.status === "OK" && Array.isArray(response.data)) {

                const $dropdown = $("#findByLoanId");
                $dropdown.empty();

                $dropdown.append(
                    '<option value="" disabled selected>SELECT LOAN ID</option>'
                );

                response.data.forEach(function(loan) {
                    if (loan.loanId) {
                        $dropdown.append(
                            `<option value="${loan.loanId}">
                                ${loan.loanId}
                             </option>`
                        );
                    }
                });

            } else {
                console.warn("No unapproved loan data found");
            }
        },
        error: function(xhr, status, error) {
            console.error("Error fetching Loan IDs:", xhr.responseText);
        }
    });
}


// Js for binding data in textfields (Vaibhav)
$(document).ready(function() {
	$("#findByLoanId").on("change", function() {
		const selectedLoanId = $(this).val();

		if (selectedLoanId) {
			$.ajax({
				url: "api/loanmanegment/getLoanById", // your GET API
				type: "GET",
				data: { loanId: selectedLoanId }, // sending as query param
				dataType: "json",
				success: function(response) {
					if (response.status === "OK" && response.data) {
						const data = response.data;

						// Now populate the form fields with received data
						$("#memberId").val(`${data.memberId} - ${data.memberName || "-"}`);
						$("#relativeDetails").val(data.relativeDetails);
						$("#dateOfBirth").val(data.dateOfBirth);
						$("#age").val(data.age);
						$("#contactNo").val(data.contactNo);
						$("#messageStatus").val(data.messageStatus);
						$("#address").val(data.address);
						$("#pinCode").val(data.pinCode);
						$("#branchName").val(data.branchName);

						$("#loanPlanName").val(data.loanPlanName);
						$("#typeOfLoan").val(data.typeOfLoan);
						$("#loanMode").val(data.loanMode);
						$("#loanTerm").val(data.loanTerm);
						$("#rateOfInterest").val(data.rateOfInterest);
						$("#loanAmount").val(data.loanAmount);
						$("#interestType").val(data.interestType);
						$("#emiPayment").val(data.emiPayment);
						$("#purposeOfLoan").val(data.purposeOfLoan);

						// Guarantor Details
						$("#guarantorMemberId").val(data.guarantorMemberId);
						$("#guarantorIdentity").val(data.guarantorIdentity);
						$("#guarantorAddress").val(data.guarantorAddress);
						$("#guarantorPinCode").val(data.guarantorPinCode);
						$("#guarantorContactNo").val(data.guarantorContactNo);
						$("#guarantorSecurityType").val(data.guarantorSecurityType);

						// Co-Applicant Details
						$("#coApplicantMemberId").val(data.coApplicantMemberId);
						$("#coApplicantIdentity").val(data.coApplicantIdentity);
						$("#coApplicantAddress").val(data.coApplicantAddress);
						$("#coApplicantPinCode").val(data.coApplicantPinCode);
						$("#coApplicantContactNo").val(data.coApplicantContactNo);
						$("#coApplicantSecurityType").val(data.coApplicantSecurityType);

						// Deductions
						$("#processingFee").val(data.processingFee);
						$("#legalCharges").val(data.legalCharges);
						$("#insuranceFee").val(data.insuranceFee);
						$("#financialConsultantId").val(data.financialConsultantId);
						$("#financialConsultantName").val(data.financialConsultantName);

						if (data.approvalStatus === true || data.approvalStatus === 1 || data.approvalStatus === "1") {
							$('#approvalStatus').val("Approved").css('color', 'red');
						} else {
							$('#approvalStatus').val("Not Approved").css('color', 'green');
						}

						// ✅ PHOTO block
						if (data.photo) {

							const fileName = data.photo;
							const photoPath = `/Uploads/${encodeURIComponent(fileName)}`;

							$("#photoPreview").attr("src", photoPath);  // ✅ Shows preview
							$("#photoHidden").val(fileName);            // ✅ Save only the filename, not full path
							photoSizeEdit({ target: { result: photoPath } }); // ✅ Resizes preview
						} else {
							$("#photoPreview").attr("src", "/Uploads/default-placeholder.jpg");
							$("#photoHidden").val("");
							photoSizeEdit({ target: { result: "/Uploads/default-placeholder.jpg" } });
						}

						// ✅ SIGNATURE block
						if (data.signature) {

							const fileName = data.signature;
							const signPath = `/Uploads/${encodeURIComponent(fileName)}`;

							$('#signaturePreview').attr('src', signPath);
							$('#signatureHidden').val(fileName);
							signatureSizeEdit({ target: { result: signPath } }); // ✅ Resize preview
						} else {
							$('#signaturePreview').attr('src', '/Uploads/default-placeholder.jpg');
							$('#signatureHidden').val("");
							signatureSizeEdit({ target: { result: "/Uploads/default-placeholder.jpg" } });
						}


					} else {
						alert("Loan data not found.");
					}
				},
				error: function(xhr) {
					alert("Error fetching data: " + xhr.responseText);
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

function signatureSizeEdit(e) {
	const previewimg = document.getElementById("signaturePreview");
	previewimg.src = e.target.result;
	previewimg.style.width = "100%";
	previewimg.style.height = "100%";
	previewimg.style.objectFit = "cover";
	previewimg.style.overflow = "hidden";
	previewimg.style.borderRadius = "20px";
}

$('#approveBtn').click(function(event) {
    event.preventDefault(); // Prevent the form from submitting

    const loanId = $('#findByLoanId').val();
    const approvalDate = $('#approvalDate').val();
	/*alert(loanId);
	alert(approvalDate);*/
	if (!loanId) {
	    alert("Please select Loan ID");
	    $("#findByLoanId").focus();
	    return;
	}


    const requestData = {
        loanId: loanId,
        approvalStatus: true,
        approvalDate: approvalDate
    };

    $.ajax({
        type: "POST",
        url: "api/loanmanegment/approve",
        contentType: "application/json",
        data: JSON.stringify(requestData),
        success: function(response) {
            alert(response.message);
            location.reload();
        },
        error: function(xhr) {
            alert("Error: " + xhr.responseText);
        }
    });
});
