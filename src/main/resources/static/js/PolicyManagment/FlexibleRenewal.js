$(document).ready(function() {

	// =========================================================
	// 1. LOAD APPROVED FD POLICIES
	// =========================================================

	$.ajax({

		url: "api/Policymangment/getAllFDPolicies",
		type: "GET",

		success: function(response) {

			if (response && response.data && response.data.length > 0) {

				const policySelect = $("#policyCode");

				// Clear existing options except first/default option
				policySelect.find("option:not(:first)").remove();

				response.data.forEach(function(policy) {

					const customerName =
						policy.customerName
							? policy.customerName.toUpperCase()
							: "";

					const optionText =
						`${policy.policyCode} - ${customerName}`;

					policySelect.append(
						`<option value="${policy.policyCode}">
							${optionText}
						</option>`
					);

				});
			}
		},

		error: function(xhr) {

			console.error(
				"Failed to load FD policies:",
				xhr
			);

			alert("Failed to load FD policies.");
		}
	});


	// =========================================================
	// 2. POLICY CODE CHANGE
	// =========================================================

	$("#policyCode").on("change", function() {

		const selectedPolicyCode = $(this).val();

		if (!selectedPolicyCode) {
			return;
		}

		$.ajax({

			url: "api/Policymangment/getPolicyByPolicyCode",
			type: "GET",

			data: {
				policyCode: selectedPolicyCode
			},

			success: function(response) {

				console.log(
					"FD Policy Response:",
					response
				);

				if (!response || !response.data) {

					alert("FD Policy data not found.");
					return;
				}

				const data = response.data;


				// =================================================
				// FD RENEWAL DATE
				// =================================================
				//
				// FD is one-time payment.
				// Therefore renewal/payment date is not
				// calculated like RD monthly installments.
				//
				// Keep renewalDate blank here.
				// =================================================

				let renewalDate = "";


				// =================================================
				// POLICY BASIC DETAILS
				// =================================================

				$("#policyDate")
					.val(data.policyStartDate || "");

				$("#maturityDate")
					.val(data.maturityDate || "");


				// =================================================
				// CUSTOMER DETAILS
				// =================================================

				$("#customerCode")
					.val(data.memberSelection || "");

				$("#clientName")
					.val(data.customerName || "");

				$("#contactNo")
					.val(data.contactNo || "");


				// =================================================
				// FD AMOUNT DETAILS
				// =================================================

				$("#policyAmount")
					.val(data.policyAmount || 0);

				$("#netDeposite")
					.val(data.depositAmount || 0);

				$("#policyType")
					.val(data.schemeType || "FD");

				$("#branchName")
					.val(data.branchName || "");

				$("#policyTerm")
					.val(data.schemeTerm || "");

				$("#maturityAmount")
					.val(data.maturityAmount || 0);

				$("#totalDeposit")
					.val(data.depositAmount || 0);


				// =================================================
				// FD PAYMENT DUE
				// =================================================
				//
				// For FD:
				//
				// First payment:
				//     balance = depositAmount
				//
				// After payment:
				//     balance = 0
				//
				// =================================================

				let paymentDue = parseFloat(data.balance) || 0;

				// If balance is not available,
				// calculate it from depositAmount - paidAmount.
				if (paymentDue <= 0) {

					const depositAmount =
						parseFloat(data.depositAmount) || 0;

					const paidAmount =
						parseFloat(data.paidAmount) || 0;

					if (depositAmount > paidAmount) {

						paymentDue =
							depositAmount - paidAmount;
					}
				}

				$("#paymentDue")
					.val(paymentDue.toFixed(2));


				// =================================================
				// OTHER POLICY DETAILS
				// =================================================

				$("#financialCode")
					.val(data.introMCode || "");

				$("#lastInstPaid")
					.val(data.lastInstPaid || "0");

				// FD maturity date is the final/due date
				$("#dueDate")
					.val(data.maturityDate || "");


				// =================================================
				// FD INSTALLMENT
				// =================================================
				//
				// FD has only ONE installment.
				//
				// Before payment:
				//     0
				//
				// After payment:
				//     1
				//
				// =================================================

				$("#noOfInstPaid")
					.val(data.noOfInstallments || "0");


				// =================================================
				// PAYMENT DETAILS
				// =================================================

				$("#paymentMode")
					.val(data.paymentBy || "");

				$("#nomineeName")
					.val(data.suggestedNominee || "");

				$("#comment")
					.val(data.remark || "");

				$("#agentName")
					.val(data.agent || "");

				$("#modeOfPayment")
					.val(data.modeOfPayment || "");

				$("#lastPaymentDate")
					.val(data.lastPaymentDate || "");


				// =================================================
				// PHOTO
				// =================================================

				if (data.image1) {

					const photoPath =
						`Uploads/${data.image1}`;

					$("#photoPreview")
						.attr("src", photoPath);

					$("#photoHidden")
						.val(photoPath);

					photoSizeEdit({
						target: {
							result: photoPath
						}
					});

				} else {

					$("#photoPreview")
						.attr(
							"src",
							"Uploads/default-placeholder.jpg"
						);

					$("#photoHidden")
						.val("");
				}


				// =================================================
				// SIGNATURE
				// =================================================

				if (data.image2) {

					const signPath =
						`Uploads/${data.image2}`;

					$("#signaturePreview")
						.attr("src", signPath);

					$("#signatureHidden")
						.val(signPath);

					signatureSizeEdit({
						target: {
							result: signPath
						}
					});

				} else {

					$("#signaturePreview")
						.attr(
							"src",
							"Uploads/default-placeholder.jpg"
						);

					$("#signatureHidden")
						.val("");
				}

			},

			error: function(xhr) {

				console.error(
					"FD Policy Fetch Error:",
					xhr
				);

				alert("FD Policy not found!");
			}
		});
	});


	// =========================================================
	// 3. SAVE FD PAYMENT
	// =========================================================

	$("#btnSave").click(function(e) {

		e.preventDefault();


		// =====================================================
		// GET VALUES
		// =====================================================

		const policyCode =
			$("#policyCode").val();

		const policyAmount =
			parseFloat(
				$("#policyAmount").val()
			) || 0;

		const paymentDue =
			parseFloat(
				$("#paymentDue").val()
			) || 0;

		const modeOfPayment =
			$("#modeOfPayment").val() || "";

		const paymentDate =
			new Date()
				.toISOString()
				.split("T")[0];


		// =====================================================
		// VALIDATION
		// =====================================================

		if (!policyCode) {

			alert(
				"Please select a Policy Code."
			);

			return;
		}


		if (policyAmount <= 0) {

			alert(
				"Invalid Policy Amount."
			);

			return;
		}


		if (paymentDue <= 0) {

			alert(
				"No payment is due for this FD."
			);

			return;
		}


		// =====================================================
		// FD ONE-TIME PAYMENT
		// =====================================================
		//
		// FD has only one payment.
		// Therefore payment amount = complete amount due.
		//
		// =====================================================

		const paymentAmount =
			paymentDue;

		const penaltyAmount = 0;


		// =====================================================
		// CONFIRM PAYMENT
		// =====================================================

		const confirmPayment = confirm(

			"Please confirm FD payment details:\n\n" +

			"Policy Code : " +
			policyCode +

			"\nPolicy Amount : ₹" +
			policyAmount.toFixed(2) +

			"\nPayment Amount : ₹" +
			paymentAmount.toFixed(2) +

			"\nPayment Due : ₹" +
			paymentDue.toFixed(2) +

			"\nPenalty Amount : ₹" +
			penaltyAmount.toFixed(2) +

			"\n\nDo you want to save this FD payment?"
		);


		if (!confirmPayment) {
			return;
		}


		// =====================================================
		// DISABLE BUTTON
		// =====================================================

		$("#btnSave")
			.prop("disabled", true);


		// =====================================================
		// PAYMENT DATA
		// =====================================================

		const policyPaymentData = {

			policyCode:
				policyCode,

			paymentAmount:
				paymentAmount.toFixed(2),

			paymentDate:
				paymentDate,

			modeOfPayment:
				modeOfPayment,

			remark:
				$("#comment").val() || "",

			penaltyAmount:
				penaltyAmount.toFixed(2)
		};


		console.log(
			"FD Payment Data:",
			policyPaymentData
		);


		// =====================================================
		// SAVE FD PAYMENT API
		// =====================================================

		$.ajax({

			url:
				"api/Policymangment/saveFDPayment",

			type:
				"POST",

			contentType:
				"application/json",

			dataType:
				"json",

			data:
				JSON.stringify(
					policyPaymentData
				),

			success: function(response) {

				console.log(
					"FD Payment Response:",
					response
				);


				if (
					response &&
					response.status === "CREATED"
				) {

					alert(
						"✅ " +
						(
							response.message ||
							"FD payment saved successfully."
						)
					);

					location.reload();

				} else {

					alert(
						"⚠️ " +
						(
							response &&
								response.message
								?
								response.message
								:
								"FD payment could not be saved."
						)
					);

					$("#btnSave")
						.prop(
							"disabled",
							false
						);
				}
			},

			error: function(xhr) {

				console.error(
					"FD Payment Error:",
					xhr
				);


				let message =
					"Failed to save FD payment.";


				if (
					xhr.responseJSON &&
					xhr.responseJSON.message
				) {

					message =
						xhr.responseJSON.message;
				}


				alert(
					"❌ " + message
				);


				$("#btnSave")
					.prop(
						"disabled",
						false
					);
			}
		});

	});


	// =========================================================
	// 4. VIEW FD PAYMENT DETAILS
	// =========================================================

	$("#viewBtn").on("click", function() {

		const selectedPolicyCode = $("#policyCode").val();

		// =========================================================
		// VALIDATE POLICY CODE
		// =========================================================

		if (!selectedPolicyCode) {

			alert("Please select a policy code first!");

			$("#installmentModal").modal("hide");

			$("#installmentModal").removeClass("show");

			$("#installmentModal").css("display", "none");

			$("body").removeClass("modal-open");

			$(".modal-backdrop").remove();

			return;
		}


		// =========================================================
		// GET FD MATURITY DATE FROM FETCHED POLICY DATA
		// =========================================================

		const maturityDateValue = $("#maturityDate").val();


		// =========================================================
		// AJAX - GET FD PAYMENT HISTORY
		// =========================================================

		$.ajax({

			url: "api/Policymangment/getPolicyPayments/"
				+ encodeURIComponent(selectedPolicyCode),

			type: "GET",

			dataType: "json",


			// =====================================================
			// SUCCESS
			// =====================================================

			success: function(response) {

				console.log(
					"FD Policy Payment Response:",
					response
				);


				const $tbody =
					$("#installmentModal tbody");


				let rowsHtml = "";


				let payments = [];


				// =================================================
				// HANDLE API RESPONSE
				// =================================================

				if (
					response &&
					response.status === "OK" &&
					Array.isArray(response.data)
				) {

					payments = response.data;

				}
				else if (
					response &&
					response.data
				) {

					payments = [response.data];

				}


				// =================================================
				// DATE FORMAT FUNCTION
				// =================================================

				const formatDate = function(dateValue) {

					if (
						!dateValue ||
						dateValue === null ||
						dateValue === undefined
					) {

						return "-";
					}


					const dateObj =
						new Date(dateValue);


					if (
						isNaN(
							dateObj.getTime()
						)
					) {

						return dateValue;
					}


					const day =
						String(
							dateObj.getDate()
						).padStart(2, "0");


					const month =
						String(
							dateObj.getMonth() + 1
						).padStart(2, "0");


					const year =
						dateObj.getFullYear();


					return (
						day +
						"-" +
						month +
						"-" +
						year
					);
				};


				// =================================================
				// FD PAYMENT HISTORY FOUND
				// =================================================

				if (payments.length > 0) {

					/*
					 * =================================================
					 * FD IS ONE-TIME PAYMENT
					 * =================================================
					 *
					 * Normally FD will have only ONE payment record.
					 *
					 * We still use forEach so that if payment history
					 * contains more than one record, it will display
					 * all records.
					 */

					payments.forEach(
						function(payment, index) {

							// =========================================
							// INSTALLMENT NUMBER
							// =========================================

							const installmentNo =
								payment.installmentNo
									? payment.installmentNo
									: "1";


							// =========================================
							// PAYMENT DATE
							// =========================================

							const paymentDate =
								payment.paymentDate
									? formatDate(
										payment.paymentDate
									)
									: "-";


							// =========================================
							// MATURITY / DUE DATE
							// =========================================
							//
							// PolicyPayment model does not contain
							// maturityDate.
							//
							// Therefore use maturityDate already
							// fetched into the form.
							//

							const maturityDate =
								maturityDateValue
									? formatDate(
										maturityDateValue
									)
									: "-";


							// =========================================
							// PAYMENT AMOUNT
							// =========================================
							//
							// PolicyPayment model:
							// private String paymentAmount;
							//

							const amountValue =
								parseFloat(
									payment.paymentAmount
								) || 0;


							const amount =
								"INR " +
								amountValue.toLocaleString(
									"en-IN",
									{
										minimumFractionDigits: 2,
										maximumFractionDigits: 2
									}
								);


							// =========================================
							// PENALTY AMOUNT
							// =========================================
							//
							// PolicyPayment model:
							// private String penaltyAmount;
							//

							const penaltyValue =
								parseFloat(
									payment.penaltyAmount
								) || 0;


							const penalty =
								"INR " +
								penaltyValue.toLocaleString(
									"en-IN",
									{
										minimumFractionDigits: 2,
										maximumFractionDigits: 2
									}
								);


							// =========================================
							// BALANCE
							// =========================================
							//
							// IMPORTANT:
							//
							// Balance is NOT calculated here.
							//
							// It is directly taken from database:
							//
							// payment.balance
							//

							const balanceValue =
								parseFloat(
									payment.balance
								) || 0;


							const balance =
								"INR " +
								balanceValue.toLocaleString(
									"en-IN",
									{
										minimumFractionDigits: 2,
										maximumFractionDigits: 2
									}
								);


							// =========================================
							// STATUS
							// =========================================
							//
							// If payment record exists and paymentDate
							// is available => PAID
							//

							let status;


							if (
								payment.paymentDate &&
								String(
									payment.paymentDate
								).trim() !== ""
							) {

								status =
									`
	                                <span class="text-success font-weight-bold">
	                                    PAID
	                                </span>
	                                `;

							}
							else {

								status =
									`
	                                <span class="text-danger font-weight-bold">
	                                    UNPAID
	                                </span>
	                                `;
							}


							// =========================================
							// CREATE TABLE ROW
							// =========================================

							rowsHtml +=
								`
	                            <tr>

	                                <td>
	                                    ${installmentNo}
	                                </td>

	                                <td>
	                                    ${maturityDate}
	                                </td>

	                                <td>
	                                    ${amount}
	                                </td>

	                                <td>
	                                    ${penalty}
	                                </td>

	                                <td>
	                                    ${status}
	                                </td>

	                                <td>
	                                    ${paymentDate}
	                                </td>

	                                <td>
	                                    ${balance}
	                                </td>

	                            </tr>
	                            `;
						}
					);

				}


				// =================================================
				// NO PAYMENT HISTORY
				// =================================================

				else {

					/*
					 * FD payment abhi save nahi hua hai.
					 *
					 * Is case mein table mein ek UNPAID row
					 * show kar sakte hain.
					 */

					const maturityDate =
						maturityDateValue
							? formatDate(
								maturityDateValue
							)
							: "-";


					const policyAmount =
						parseFloat(
							$("#policyAmount").val()
						) || 0;


					const paymentDue =
						parseFloat(
							$("#paymentDue").val()
						) || 0;


					rowsHtml =
						`
	                    <tr>

	                        <td>
	                            1
	                        </td>

	                        <td>
	                            ${maturityDate}
	                        </td>

	                        <td>
	                            INR ${paymentDue.toLocaleString(
							"en-IN",
							{
								minimumFractionDigits: 2,
								maximumFractionDigits: 2
							}
						)}
	                        </td>

	                        <td>
	                            INR 0.00
	                        </td>

	                        <td>
	                            <span class="text-danger font-weight-bold">
	                                UNPAID
	                            </span>
	                        </td>

	                        <td>
	                            -
	                        </td>

	                        <td>
	                            INR ${paymentDue.toLocaleString(
							"en-IN",
							{
								minimumFractionDigits: 2,
								maximumFractionDigits: 2
							}
						)}
	                        </td>

	                    </tr>
	                    `;
				}


				// =================================================
				// PUT ROWS INTO TABLE
				// =================================================

				$tbody.html(rowsHtml);


				// =================================================
				// SHOW BOOTSTRAP 4 MODAL
				// =================================================
				//
				// Aapke HTML mein:
				// data-toggle="modal"
				//
				// Isliye Bootstrap 4 syntax use kar rahe hain.
				//

				$("#installmentModal").modal("show");

			},


			// =====================================================
			// ERROR
			// =====================================================

			error: function(xhr) {

				console.error(
					"Failed to fetch FD payment history:",
					xhr
				);


				let message =
					"Failed to fetch FD payment data.";


				if (
					xhr.responseJSON &&
					xhr.responseJSON.message
				) {

					message =
						xhr.responseJSON.message;
				}


				alert(
					"❌ " + message
				);


				// Hide modal if opened

				$("#installmentModal").modal("hide");

				$("#installmentModal")
					.removeClass("show");

				$("#installmentModal")
					.css("display", "none");

				$("body")
					.removeClass("modal-open");

				$(".modal-backdrop")
					.remove();

			}

		});

	});

});


// =========================================================
// 5. SIGNATURE IMAGE SIZE
// =========================================================

function signatureSizeEdit(e) {

	const previewimg =
		document.getElementById(
			"signaturePreview"
		);


	previewimg.src =
		e.target.result;


	previewimg.style.width =
		"100%";


	previewimg.style.height =
		"100%";


	previewimg.style.objectFit =
		"cover";


	previewimg.style.overflow =
		"hidden";


	previewimg.style.borderRadius =
		"20px";
}


// =========================================================
// 6. PHOTO IMAGE SIZE
// =========================================================

function photoSizeEdit(e) {

	const previewimg =
		document.getElementById(
			"photoPreview"
		);


	previewimg.src =
		e.target.result;


	previewimg.style.width =
		"100%";


	previewimg.style.height =
		"100%";


	previewimg.style.objectFit =
		"cover";


	previewimg.style.overflow =
		"hidden";


	previewimg.style.borderRadius =
		"20px";
}