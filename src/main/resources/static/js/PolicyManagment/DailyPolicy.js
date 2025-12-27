$(document).ready(function() {
	// 1. Populate dropdown with approved RD policies
	$.ajax({
		url: "api/Policymangment/getAllDDPolicies",
		type: "GET",
		success: function(response) {
			if (response.data && response.data.length > 0) {
				const policySelect = $("#policyCode");
				response.data.forEach(policy => {
					const optionText = `${policy.policyCode} - ${policy.customerName}`;
					policySelect.append(`<option value="${policy.policyCode}">${optionText}</option>`);
				});
			}
		},
		error: function() {
			alert("Failed to load policies.");
		}
	});

	// 2. On policyCode change, fetch full policy data
	$("#policyCode").on("change", function() {
		const selectedPolicyCode = $(this).val();
		if (selectedPolicyCode) {
			$.ajax({
				url: "api/Policymangment/getPolicyByPolicyCode",
				type: "GET",
				data: { policyCode: selectedPolicyCode },
				success: function(response) {
					if (response.data) {
						const data = response.data;

						// 2a. Calculate renewal date (for RD = add 1 month to policyStartDate)
						let renewalDate = "";
						if (data.policyStartDate && data.schemeType === "RD") {
							const startDate = new Date(data.policyStartDate);
							startDate.setMonth(startDate.getMonth() + 1);
							const yyyy = startDate.getFullYear();
							const mm = String(startDate.getMonth() + 1).padStart(2, '0');
							const dd = String(startDate.getDate()).padStart(2, '0');
							renewalDate = `${yyyy}-${mm}-${dd}`;
						}

						// 2b. Populate form fields (update IDs as needed)
						$("#policyDate").val(data.policyStartDate);
						$("#renewalDate").val(renewalDate);
						$("#maturityDate").val(data.maturityDate);
						$("#customerCode").val(data.memberSelection);
						$("#clientName").val(data.customerName);
						$("#contactNo").val(data.contactNo);
						$("#policyAmount").val(data.policyAmount);
						$("#policyType").val(data.schemeType);
						$("#branchname").val(data.branchName);
						$("#policyTerm").val(data.schemeTerm);
						$("#maturityAmount").val(data.maturityAmount);
						$("#totalDeposit").val(data.depositAmount);
						$("#paymentDue").val(data.amountDue);
						$("#financialCode").val(data.introMCode);
						$("#lastPaymentDate").val(data.lastInstPaid);
						$("#dueDate").val(data.maturityDate);
						$("#noOfInstPaid").val(data.lastInstPaid);
						$("#installmentsCompleted").val(data.lastInstPaid);
						$("#paymentMode").val(data.paymentBy);
						$("#nomineeName").val(data.suggestedNominee);
						$("#comment").val(data.remark);
						$("#agentName").val(data.agent);

						if (data.customerPhoto) {
							const photoPath = `Uploads/${data.customerPhoto}`;
							$("#photoPreview").attr("src", photoPath);
							$("#photoHidden").val(photoPath);
							photoSizeEdit({ target: { result: photoPath } });
						} else {
							$("#photoPreview").attr("src", "Uploads/default-placeholder.jpg");
							$("#photoHidden").val("");
						}

						// Signature
						if (data.customerSignature) {
							const signPath = `Uploads/${data.customerSignature}`;
							$("#signaturePreview").attr("src", signPath);
							$("#signatureHidden").val(signPath);
							signatureSizeEdit({ target: { result: signPath } });
						} else {
							$("#signaturePreview").attr("src", "Uploads/default-placeholder.jpg");
							$("#signatureHidden").val("");
						}
					}
				},
				error: function() {
					alert("Policy not found!");
				}
			});
		}
	});
});

$(document).ready(function() {
	$("#buttonSave").click(function(e) {
		e.preventDefault(); // Stop default form submission

		// Collect form values
		const policyCode = $("#policyCode").val()?.trim();
		const policyAmount = $("#policyAmount").val()?.trim();
		const noOfInstallments = $("#noOfInst").val()?.trim();

		// ✅ Basic validation
		if (!policyCode) {
			alert("❌ Policy Code is required.");
			return;
		}
		if (!policyAmount || isNaN(policyAmount) || parseFloat(policyAmount) <= 0) {
			alert("❌ Policy Amount must be a number greater than 0.");
			return;
		}
		if (!noOfInstallments || isNaN(noOfInstallments) || parseInt(noOfInstallments) <= 0) {
			alert("❌ Number of Installments must be a number greater than 0.");
			return;
		}

		// ✅ Prepare payload
		const payload = {
			policyCode: policyCode,
			policyAmount: parseFloat(policyAmount),
			noOfInstallments: parseInt(noOfInstallments)
		};

		// ✅ Send AJAX request
		$.ajax({
			url: "api/Policymangment/updateDDDueAndInstallment", // note the leading slash
			type: "POST",
			data: JSON.stringify(payload),
			contentType: "application/json; charset=utf-8",
			dataType: "json",
			success: function(response) {
				console.log("✅ Success Response:", response);

				// ApiResponse wrapper → use response.message
				const msg = response.message || "Update successful!";
				alert("✅ " + msg);

				// refresh page if needed
				location.reload();
			},
			error: function(xhr) {
				console.error("❌ AJAX Error:", xhr);

				let errMsg = "Something went wrong.";
				if (xhr.responseJSON) {
					errMsg = xhr.responseJSON.message || JSON.stringify(xhr.responseJSON);
				}
				alert("❌ Error: " + errMsg);
			}
		});
	});



});

$("#viewBtn").on("click", function() {
	const selectedPolicyCode = $("#policyCode").val();

	if (!selectedPolicyCode) {
		alert("Please select a policy code first!");
		return;
	}

	$.ajax({
		url: "api/Policymangment/getFullMaturityByPolicyCode",
		type: "GET",
		dataType: "json",
		data: { policyCode: selectedPolicyCode },
		success: function(response) {
			console.log("✅ Full Response:", response);

			const $tbody = $("#installmentModal tbody");
			let rowsHtml = "";
			let installments = [];

			if (response && response.status === "OK") {
				if (Array.isArray(response.data)) {
					installments = response.data;
				} else if (response.data) {
					installments = [response.data];
				}
			}

			if (installments.length > 0) {
				// ✅ Base date (policyStartDate → agar available ho)
				let baseDate = installments[0].policyStartDate
					? new Date(installments[0].policyStartDate)
					: new Date();

				installments.forEach((inst, index) => {
					const srNo = index + 1;

					// ✅ Har installment ka dueDate = baseDate + index days
					let dueDate = new Date(baseDate);
					dueDate.setDate(dueDate.getDate() + index);

					// Format function
					const formatDate = (dateObj) => {
						const day = String(dateObj.getDate()).padStart(2, "0");
						const month = String(dateObj.getMonth() + 1).padStart(2, "0");
						const year = dateObj.getFullYear();
						return `${day}-${month}-${year}`;
					};

					const dueDateFormatted = formatDate(dueDate);
					const paymentDateStr = inst.paymentDate
						? formatDate(new Date(inst.paymentDate))
						: "-";

					// ✅ Status Logic
					const status = inst.paymentDate && inst.paymentDate.trim() !== ""
						? `<span class="text-success fw-bold">Paid</span>`
						: `<span class="text-danger fw-bold">Unpaid</span>`;

					const amount = inst.amount
						? `INR ${Number(inst.amount).toLocaleString("en-IN")}`
						: "INR 0";

					rowsHtml += `
						<tr>
						  <td>${srNo}</td>
						  <td>${dueDateFormatted}</td>   <!-- ✅ Daily Due Date -->
						  <td>${amount}</td>
						  <td>${status}</td>
						  <td>${paymentDateStr}</td>
						</tr>
					`;
				});
			} else {
				rowsHtml = `
					<tr>
					  <td colspan="5" class="text-center text-danger">
						No installment data found for this policy.
					  </td>
					</tr>
				`;
			}

			$tbody.html(rowsHtml);
		},
		error: function(xhr) {
			console.error("❌ Error:", xhr);
			alert("❌ Failed to fetch installment data.");
		}
	});
});


