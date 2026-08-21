$(document).ready(function () {
	// Populate customer dropdown from backend
	loadDecisionMakerDropdown();
	loadUnallotedShares("");

	// Handle Search button click
	$("#searchBtn").click(function () {
		let selectedCode = $("#selectDecisionMaker").val();
		loadUnallotedShares(selectedCode);
	});
});

function loadDecisionMakerDropdown() {
	$.ajax({
		url: "api/customershareholdingcontroller/findAllTransferShare",
		type: "GET",
		success: function (response) {
			let dropdown = $("#selectDecisionMaker");
			dropdown.empty().append('<option value="">-- ALL CUSTOMERS --</option>');

			if ((response.status === "OK" || response.status === "FOUND") && response.data) {
				const uniqueCodes = new Set();
				$.each(response.data, function (i, item) {
					if (item.findByCode && !uniqueCodes.has(item.findByCode)) {
						uniqueCodes.add(item.findByCode);
						dropdown.append(`<option value="${item.findByCode}">${item.findByCode} - ${item.customerName || ''}</option>`);
					}
				});
			}
		},
		error: function () {
			console.error("Error loading dropdown data");
		}
	});
}

function loadUnallotedShares(customerCode) {
	const tbody = $("#unallotedTableBody");
	tbody.html('<tr><td colspan="7" class="text-center py-3">Loading...</td></tr>');

	if (customerCode) {
		$.ajax({
			url: "api/customershareholdingcontroller/fetchByFindByCode",
			type: "POST",
			data: { findByCode: customerCode },
			success: function (response) {
				renderTableRows(response.data);
			},
			error: function () {
				tbody.html('<tr><td colspan="7" class="text-center text-danger">Error fetching share data</td></tr>');
			}
		});
	} else {
		$.ajax({
			url: "api/customershareholdingcontroller/findAllTransferShare",
			type: "GET",
			success: function (response) {
				renderTableRows(response.data);
			},
			error: function () {
				tbody.html('<tr><td colspan="7" class="text-center text-danger">Error fetching share data</td></tr>');
			}
		});
	}
}

function renderTableRows(data) {
	const tbody = $("#unallotedTableBody");
	tbody.empty();

	if (data && data.length > 0) {
		$.each(data, function (i, item) {
			let row = `<tr>
				<td>${i + 1}</td>
				<td>${item.customerName || ""}</td>
				<td>${item.findByCode || ""}</td>
				<td>${item.startDate || ""}</td>
				<td>${item.dateOfTransfer || ""}</td>
				<td>${item.noOfShare || ""}</td>
				<td>${item.amountTransferred || item.balanceShares || ""}</td>
			</tr>`;
			tbody.append(row);
		});
	} else {
		tbody.append('<tr><td colspan="7" class="text-center py-3">No share records found</td></tr>');
	}
}
