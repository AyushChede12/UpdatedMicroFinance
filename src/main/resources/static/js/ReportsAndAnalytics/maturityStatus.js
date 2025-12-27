$(document).ready(function() {
	$.ajax({
		url: "api/Maturitymanagement/getApplymaturitydetails",
		type: "GET",
		success: function(response) {
			if (response.status === "OK") {
				const branchList = response.data;

				// Use Set to store unique branch names
				const uniqueBranches = new Set();
				branchList.forEach(item => {
					if (item.branchName) {
						uniqueBranches.add(item.branchName.trim());
					}
				});

				// Clear existing options and add default
				$("#branchName").empty();
				$("#branchName").append("<option value=''>-- Select Branch --</option>");

				// Append unique branch names
				uniqueBranches.forEach(branchName => {
					$("#branchName").append(
						`<option value="${branchName}">${branchName}</option>`
					);
				});
			} else {
				alert("Error: " + response.message);
			}
		},
		error: function(xhr) {
			console.error("Error loading branches:", xhr.responseText);
			alert("Failed to load dropdown data.");
		}
	});

});

function loadAllData() {
	$.ajax({
		url: "api/Maturitymanagement/getApplymaturitydetails",
		type: "GET",
		contentType: "application/json",
		success: function(response) {
			if (response.status === "OK") {
				allMaturityData = response.data;  // store data globally
				renderTable(allMaturityData);    // render full data on load
			} else {
				alert("⚠️ " + response.message);
			}
		},
		error: function(xhr, status, error) {
			console.error("❌ Error fetching data:", error);
			alert("Failed to load maturity data.");
		}
	});
}

function renderTable(data) {
	let tbody = $(".datatable tbody");
	tbody.empty();

	if (data.length === 0) {
		tbody.append(`<tr><td colspan="10" class="text-center">No Records Found</td></tr>`);
		return;
	}

	$.each(data, function(index, item) {
		var row = `<tr style="font-family: 'Poppins', sans-serif;">
            <th scope="row"><a href="#">${index + 1}</a></th>
            <td>${item.customerName || ''}</td>
            <td>${item.branchName || ''}</td>
            <td>${item.policyCode || ''}</td>
            <td>${item.policyAmount || ''}</td>
            <td>${item.maturityDate || ''}</td>
            <td>${item.maturityAmount || ''}</td>
            <td>${item.depositAmount || ''}</td>
            <td>${item.schemeName || ''}</td>
            <td>
                <button class="iconbutton" onclick="viewData(${item.id})" title="View">
                    <i class="bi bi-printer" style="color: green;"></i>
                </button>
            </td>
        </tr>`;
		tbody.append(row);
	});
}

function applyFilters() {
	let branchName = $("#branchName").val();
	let fromDate = $("#fromDate").val();
	let toDate = $("#toDate").val();

	// Filter frontend pe hi karna hai
	let filteredData = allMaturityData.filter(item => {
		let match = true;

		// branch filter
		if (branchName && item.branchName !== branchName) {
			match = false;
		}

		// date filter (maturityDate string ko compare karna hai)
		if (fromDate) {
			let itemDate = new Date(item.maturityDate);
			let startDate = new Date(fromDate);
			if (itemDate < startDate) match = false;
		}
		if (toDate) {
			let itemDate = new Date(item.maturityDate);
			let endDate = new Date(toDate);
			if (itemDate > endDate) match = false;
		}

		return match;
	});

	renderTable(filteredData);
}

$(document).ready(function() {
	loadAllData();  // Load everything once

	$("#findBtn").click(function() {
		applyFilters();  // Apply filter on click
	});
});
