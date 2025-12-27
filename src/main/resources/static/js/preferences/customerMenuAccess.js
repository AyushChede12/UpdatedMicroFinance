$(document).ready(function() {
	$.ajax({
		url: 'api/preference/getAllUserCreations',
		type: 'GET',
		success: function(response) {
			// Check if response has data array inside `data`
			if (response.status == "FOUND") {
				alert("if");
				let customerOptions = response.data.map(function(item) {
					return {
						id: item.customerId,
						text: item.customerId
					};
				});

				$('#customerId').select2({
					placeholder: '-- Search Customer ID --',
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
				alert("No customers ID data found.");
			}
		},
		error: function(xhr, status, error) {
			console.error("Error fetching customers:", error);
			alert("Failed to load customer codes.");
		}
	});

	$("#customerId").change(function() {
		const customerId = $(this).val();
		if (!customerId) return;

		$.ajax({
			url: "api/preference/menuAccess/" + customerId,
			type: "GET",
			success: function(res) {
				if (res.status === "FOUND") {
					const accessList = res.data;

					// Uncheck all first
					$("input[type='checkbox']").prop("checked", false);

					// Check saved ones
					accessList.forEach((a) => {
						$("input[data-menuname='" + a.menuName + "']").prop("checked", a.hasAccess);
					});
				}
			}
		});

	});

	$("#saveAccessBtn").click(function(e) {
		e.preventDefault();

		const customerId = $("#customerId").val();
		if (!customerId) {
			alert("Please select a Customer ID first!");
			return;
		}

		const menuAccess = [];
		$("input[type='checkbox']").each(function() {
			menuAccess.push({
				menuName: $(this).data("menuname"),
				hasAccess: $(this).is(":checked")
			});
		});

		const payload = {
			user: { customerId: customerId }, // link via customerId only
			menuAccess: menuAccess
		};

		$.ajax({
			url: "api/preference/saveUserCreation",
			type: "POST",
			data: JSON.stringify(payload),
			contentType: "application/json",
			success: function(res) {
				if (res.status === "OK") {
					alert("Access saved successfully!");
				} else {
					alert("Error: " + res.message);
				}
			}
		});
	});

});