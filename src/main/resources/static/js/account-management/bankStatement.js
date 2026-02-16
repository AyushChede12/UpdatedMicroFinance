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
});