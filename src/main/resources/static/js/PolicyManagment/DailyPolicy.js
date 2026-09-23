$(document).ready(function() {
	
	$("#policyAmount, #noOfInst").on("keyup change input", function () {
			calculateNetDeposit();
		});

		function calculateNetDeposit() {

			const policyAmount = parseFloat($("#policyAmount").val()) || 0;
			const noOfInst = parseInt($("#noOfInst").val(), 10) || 0;

			// 🔴 ADD THESE TWO LINES
			const totalTerm = parseInt($("#policyTerm").val(), 10) || 0;       // total installments (e.g. 34)
			const alreadyPaid = parseInt($("#noOfInstPaid").val(), 10) || 0;   // already paid (e.g. 20)

			// ❌ VALIDATION: user cannot pay more than remaining installments
			if (alreadyPaid + noOfInst > totalTerm) {
				alert(
					`❌ Installment limit exceeded!\n\n` +
					`Total Term : ${totalTerm}\n` +
					`Already Paid : ${alreadyPaid}\n` +
					`Remaining : ${totalTerm - alreadyPaid}`
				);

				$("#noOfInst").val("");       // reset input
				$("#netDeposite").val("");    // reset net amount
				return;
			}

			// ✅ CALCULATION
			const net = noOfInst * policyAmount;
			$("#netDeposite").val(net.toFixed(2));
		}

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
						$("#totalDeposit").val(data.paidAmount);
												
						let fetchedDeposit = parseFloat(data.depositAmount) || 0;
						let userTotalDeposit = parseFloat($("#totalDeposit").val()) || 0;
						let paymentDue = fetchedDeposit - userTotalDeposit;
												
						$("#paymentDue").val(paymentDue);
						$("#financialCode").val(data.introMCode);
						$("#lastPaymentDate").val(data.lastInstPaid);
						$("#dueDate").val(data.maturityDate);
						$("#noOfInstPaid").val(data.lastInstPaid);
						$("#installmentsCompleted").val(data.lastInstPaid);
						$("#modeOfPayment").val(data.paymentBy);
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
			noOfInstallments: parseInt(noOfInstallments),			
			totalDeposit: parseFloat($("#totalDeposit").val()),
			paymentDue: parseFloat($("#paymentDue").val()),
			noOfInstPaid: parseInt($("#noOfInstPaid").val())
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

			const $tbody = $("#installmentTable tbody, #installmentModal table tbody");
			let rowsHtml = "";
			let installments = [];

			if (response && (response.status === "OK" || response.status === "200")) {
				if (Array.isArray(response.data)) {
					installments = response.data;
				} else if (response.data) {
					installments = [response.data];
				}
			}

			if (installments.length > 0) {
				const firstInst = installments[0];
				let baseDateRaw = firstInst.paymentDate || firstInst.renewalDate || firstInst.policyDate || firstInst.policyStartDate;
				let baseDate = baseDateRaw ? new Date(baseDateRaw) : new Date();

				installments.forEach((inst, index) => {
					const srNo = index + 1;

					// Daily Deposit: each installment is 1 day after
					let dueDate = new Date(baseDate);
					dueDate.setDate(dueDate.getDate() + index);

					const formatDate = (dateObj) => {
						if (!dateObj || isNaN(dateObj.getTime())) return "-";
						const day = String(dateObj.getDate()).padStart(2, "0");
						const month = String(dateObj.getMonth() + 1).padStart(2, "0");
						const year = dateObj.getFullYear();
						return `${day}-${month}-${year}`;
					};

					const dueDateFormatted = formatDate(dueDate);
					const pDateRaw = inst.paymentDate || inst.renewalDate || inst.lastPaymentDate;
					const paymentDateStr = pDateRaw ? formatDate(new Date(pDateRaw)) : "-";

					const status = pDateRaw && String(pDateRaw).trim() !== ""
						? `<span class="text-success fw-bold">Paid</span>`
						: `<span class="text-danger fw-bold">Unpaid</span>`;

					const amtVal = inst.amount || inst.netDeposit || inst.policyAmount;
					const amount = amtVal
						? `INR ${Number(amtVal).toLocaleString("en-IN")}`
						: "INR 0";

					rowsHtml += `
						<tr>
						  <td>${srNo}</td>
						  <td>${dueDateFormatted}</td>
						  <td>${amount}</td>
						  <td>${status}</td>
						  <td>${paymentDateStr}</td>
						</tr>
					`;
				});
			} else {
				rowsHtml = `
					<tr>
					  <td colspan="5" class="text-center text-danger font-weight-bold">
						No installment data found for this policy.
					  </td>
					</tr>
				`;
			}

			$tbody.html(rowsHtml);
		},
		error: function(xhr) {
			console.error("❌ Error:", xhr);
			const errMsg = xhr.responseJSON?.message || "Failed to fetch installment data.";
			alert("❌ " + errMsg);
		}
	});
});


