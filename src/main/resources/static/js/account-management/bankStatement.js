$(document).ready(function() {
	$.ajax({
		url: "api/customersavings/getAllSavingAccountData",
		type: "GET",
		dataType: "json",
		success: function(response) {

			let dropdown = $('#accountNumber');
			dropdown.empty();

			// default option
			dropdown.append('<option value="">--SELECT ACCOUNT NO--</option>');

			if ((response.status === "OK" || response.status === "FOUND")
				&& response.data && response.data.length > 0) {

				$.each(response.data, function(index, acc) {

					// ⚠️ backend field name confirm karo
					dropdown.append(
						`<option value="${acc.accountNumber}">
	                           ${acc.accountNumber}
	                        </option>`
					);
				});

			} else {
				alert("No Saving Account Found");
			}
		},
		error: function(xhr) {
			console.error("Account dropdown error:", xhr.responseText);
			alert("Unable to load account numbers");
		}
	});

	$("#searchbtn").click(function(e) {
		e.preventDefault(); // form submit रोकना
		searchStatement();
	});
});

function searchStatement() {

	let accountNumber = $("#accountNumber").val();
	let startDate = $("#startDate").val();
	let endDate = $("#endDate").val();

	// 🔴 Validation
	if (!accountNumber) {
		alert("Please select Account Number");
		return;
	}

	if (!startDate || !endDate) {
		alert("Please select Date Range");
		return;
	}

	$.ajax({
		url: "accountManagement/bank-statement",
		type: "GET",
		data: {
			accountNumber: accountNumber,
			startDate: startDate,
			endDate: endDate
		},
		success: function(response) {

			let tbody = $(".datatable tbody");
			tbody.empty();

			// ❌ No Data Case
			if (response.status=="NOT_FOUND") {
				tbody.append(`<tr>
                    <td colspan="8" style="text-align:center;">${response.message}</td>
                </tr>`);
				return;
			}

			let data = response.data;

			$.each(data, function(index, txn) {

				let row = `<tr>
                    <td>${index + 1}</td>
                    <td>${txn.bankName ? txn.bankName : "-"}</td>
                    <td>${txn.accountNumber}</td>
                    <td>${txn.date}</td>
                    <td>${txn.narration}</td>
                    <td>${txn.credit ? txn.credit : 0}</td>
                    <td>${txn.debit ? txn.debit : 0}</td>
                    <td>${txn.balance}</td>
                </tr>`;

				tbody.append(row);
			});
		},
		error: function(err) {
			console.error("Error fetching statement", err);

			$(".datatable tbody").html(`<tr>
                <td colspan="8" style="text-align:center; color:red;">
                    Server Error
                </td>
            </tr>`);
		}
	});
}