$(document).ready(function() {
	// 1. Populate dropdown with approved RD policies
	$.ajax({
		url: "api/Policymangment/getAllRDPolicies",
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

						// --- 2. Calculate No of Installments ---
						let noOfInst = 1; // default for FD
						if (data.schemeType === "RD") {
							if (data.schemeTerm) {
								// if schemeTerm is given in months already
								noOfInst = parseInt(data.schemeTerm, 10);
							} else if (data.policyStartDate && data.maturityDate) {
								// fallback: calculate months difference
								const start = new Date(data.policyStartDate);
								const end = new Date(data.maturityDate);
								noOfInst = (end.getFullYear() - start.getFullYear()) * 12
									+ (end.getMonth() - start.getMonth());
							}
						}

						// 2b. Populate form fields (update IDs as needed)
						$("#policyDate").val(data.policyStartDate);
						$("#renewalDate").val(renewalDate);
						$("#maturityDate").val(data.maturityDate);
						$("#customerCode").val(data.memberSelection);
						$("#customerName").val(data.customerName);
						$("#contactNo").val(data.contactNo);
						$("#policyAmount").val(data.policyAmount);
						$("#policyType").val(data.schemeType);
						$("#branchName").val(data.branchName);
						$("#policyTerm").val(data.schemeTerm);
						$("#maturityAmount").val(data.maturityAmount);
						$("#totalDeposit").val(data.depositAmount);
						$("#paymentDue").val(data.amountDue);
						$("#financialCode").val(data.introMCode);
						$("#lastInstPaid").val(data.lastInstPaid);
						$("#dueDate").val(data.maturityDate);
						$("#noOfInst").val(noOfInst);
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
	$("#saveBtn").click(function(e) {
		e.preventDefault(); // Prevent default form submission

		// Collect only required data for the API
		const formData = {
			policyCode: $("#policyCode").val()?.trim(),
			policyAmount: $("#policyAmount").val()?.trim(),
			noOfInstallments: $("#noOfInst").val()?.trim()
		};

		// Basic validation before sending
		if (!formData.policyCode || !formData.policyAmount || !formData.noOfInstallments) {
			alert("⚠️ Please fill all required fields (Policy Code, Amount, No. of Installments).");
			return;
		}

		// Send to backend
		$.ajax({
			url: "api/Policymangment/updateFDDueAndInstallment", // ✅ match controller endpoint
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify(formData),
			success: function(response) {
				alert("✅ " + response.message);

				// Refresh page or reload data table
				location.reload();

				// Optionally reset form (if you don't want reload)
				// $("#formid")[0].reset();
			},
			error: function(xhr) {
				alert("❌ Error: " + (xhr.responseJSON?.message || "Something went wrong."));
				console.error(xhr);
			}
		});
	});

});

$(document).ready(function() {
	const $policyDropdown = $('#findByPolicyNumber');

	// Clear and set default option
	$policyDropdown.empty().append('<option value="">Select Branch Name</option>');

	// Fetch approved policy data
	fetchApprovedPolicies();

	function fetchApprovedPolicies() {
		$.ajax({
			url: 'api/Policymangment/getApprovedPolicies',
			method: 'GET',
			success: function(response) {
				if (response.status === 'OK' && Array.isArray(response.data)) {
					response.data.forEach(item => {
						const policyNumber = (item.policyCode || item.policyNumber || '').trim();
						const clientName = (item.clientName || item.customerName || 'Unknown').trim();


						if (policyNumber) {
							$policyDropdown.append(
								`<option value="${policyNumber}">
                                    ${policyNumber} - ${clientName}
                                </option>`
							);
						}
					});
				} else {
					console.warn('No approved policies found.');
				}
			},
			error: function(xhr, status, error) {
				console.error('Error fetching approved policies:', error);
			}
		});
	}
});


function toggleTransaction() {
	const policyCode = document.getElementById("findByPolicyNumber").value;

	if (!policyCode) {
		alert("Please select a Policy Code first.");
		return;
	}

	fetch(`api/Policymangment/getPolicyByPolicyCode?policyCode=${policyCode}`)
		.then(response => {
			if (!response.ok) {
				throw new Error("Policy not found");
			}
			return response.json();
		})
		.then(data => {
			const policy = data.data;

			// Fill all the spans with policy data
			document.getElementById("branchCodeSpan").textContent = policy.branchName || "";
			document.getElementById("docSpan").textContent = policy.policyStartDate || "";
			document.getElementById("policyNoSpan").textContent = policy.policyCode || "";
			document.getElementById("memberCodeSpan").textContent = policy.memberSelection || "";
			document.getElementById("applicantNameSpan").textContent = policy.customerName || "";
			document.getElementById("fatherNameSpan").textContent = policy.relationDetails || "";
			document.getElementById("nomineeNameSpan").textContent = policy.suggestedNominee || "";
			document.getElementById("addressSpan").textContent = policy.address || "";
			document.getElementById("schemeSpan").textContent = policy.schemeType || "";
			document.getElementById("planSpan").textContent = policy.schemeCode || "";
			document.getElementById("relationshipSpan").textContent = policy.relation || "";
			document.getElementById("roiSpan").textContent = policy.roi || "";
			document.getElementById("modeSpan").textContent = policy.schemeMode || "";
			document.getElementById("maturitySpan").textContent = policy.maturityAmount || "";
			document.getElementById("renewalAmountSpan").textContent = policy.paidAmount || "";
			document.getElementById("totalValueSpan").textContent = policy.depositAmount || "";
			document.getElementById("termSpan").textContent = policy.schemeTerm || "";
			document.getElementById("maturityDateSpan").textContent = policy.maturityDate || "";
			document.getElementById("mobileSpan").textContent = policy.contactNo || "";
			document.getElementById("collectorSpan").textContent = policy.agent || "";

			// Show the transaction section
			document.getElementById("transactionSection").style.display = "block";
		})
		.catch(error => {
			alert("Error fetching policy data: " + error.message);
			console.error("Error:", error);
		});
}



function printTransactionSection() {
	const content = document.getElementById("transactionSection").innerHTML;

	const printWindow = window.open('', '', 'height=800,width=1000');
	printWindow.document.write('<html><head><title>Transaction Receipt</title>');

	// Optional styling for print
	printWindow.document.write(`
        <style>
            body {
                font-family: Arial, sans-serif;
                padding: 20px;
            }
            p {
                margin: 5px 0;
            }
            h1 {
                text-align: center;
            }
            hr {
                margin: 10px 0;
                border: 1px solid black;
            }
            .d-flex {
                display: flex;
                justify-content: space-between;
            }
        </style>
    `);

	printWindow.document.write('</head><body>');
	printWindow.document.write(content);
	printWindow.document.write('</body></html>');

	printWindow.document.close();
	printWindow.focus();

	printWindow.onload = function() {
		printWindow.print();
		printWindow.close();
	};
}

$("#viewBtn").on("click", function() {
	const selectedPolicyCode = $("#policyCode").val();

	if (!selectedPolicyCode) {
		alert("Please select a policy code first!");
		return;
	}

	$.ajax({
		url: "/api/Policymangment/getFullMaturityByPolicyCode", // ✅ leading slash
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
				// ✅ Base date (agar paymentDate available nahi hai to policyStartDate use karo)
				let baseDate = installments[0].paymentDate
					? new Date(installments[0].paymentDate)
					: (installments[0].policyStartDate
						? new Date(installments[0].policyStartDate)
						: new Date());

				installments.forEach((inst, index) => {
					const srNo = index + 1;

					// ✅ Daily Deposit ke liye: har installment ek din aage
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

					// ✅ Status check
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






