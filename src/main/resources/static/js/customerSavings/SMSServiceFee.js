let allmessageSendData = [];


$("#searchBtn").click(function () {
    const selected = $("#byDate").val();

    if (!selected) {
        alert("Please select a date option.");
        return;
    }

    const { startDate, endDate } = getDateRange(selected);
    console.log("Fetching data from", startDate, "to", endDate); // debug
    searchInThemessageSend(startDate, endDate);
});


function getDateRange(type) {
    const today = new Date();
    let start = new Date(today);
    let end = new Date(today);

    switch (type) {
        case "today":
            break;

        case "yesterday":
            start.setDate(today.getDate() - 1);
            // End = yesterday 23:59:59.999
            end.setDate(today.getDate() - 1);
            end.setHours(23, 59, 59, 999);
            break;

        case "last7":
            start.setDate(today.getDate() - 6); // last 7 days including today
            break;

        case "last30":
            start.setDate(today.getDate() - 29); // last 30 days including today
            break;

        case "thisMonth":
            start = new Date(today.getFullYear(), today.getMonth(), 1);
            end = new Date(today.getFullYear(), today.getMonth() + 1, 0);
            break;

        case "lastMonth":
            start = new Date(today.getFullYear(), today.getMonth() - 1, 1);
            end = new Date(today.getFullYear(), today.getMonth(), 0);
            break;
    }

   
    const formatLocalDate = (d) => {
        const local = new Date(d.getTime() - d.getTimezoneOffset() * 60000);
        const month = (local.getMonth() + 1).toString().padStart(2, '0');
        const day = local.getDate().toString().padStart(2, '0');
        return `${local.getFullYear()}-${month}-${day}`;
    };

    return {
        startDate: formatLocalDate(start),
        endDate: formatLocalDate(end)
    };
}


function searchInThemessageSend(startDate, endDate) {
    $.ajax({
        url: "api/customersavings/getSavingAccountDataSMSEnable",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ startDate, endDate }),
        success: function (response) {
            console.log("API Response:", response);

            if (response && response.status === "OK" && Array.isArray(response.data)) {
                allmessageSendData = response.data;

                if (allmessageSendData.length > 0) {
                    renderTable(allmessageSendData);
                } else {
                    $("#tbody").empty();
                    alert("No records found for selected date.");
                }
            } else {
                $("#tbody").empty();
                alert("No records found for selected date.");
            }
        },
        error: function () {
            alert("Failed to load data.");
        }
    });
}


function renderTable(data) {
    const tbody = $("#tbody");
    tbody.empty();

    data.forEach((item, index) => {
        const row = `
        <tr>
            <td><input type="checkbox" value="${item.id}"></td>
            <td>${index + 1}</td>
            <td>${item.accountNumber ?? '-'}</td>
            <td>${item.openingDate ?? '-'}</td>
            <td>${item.balance ?? '-'}</td>
            <td>${item.messageSend === "1" ? "Enabled" : "Disabled"}</td>
            <td><button class="btn btn-primary btn-sm apply-btn" data-id="${item.id}">Apply</button></td>
        </tr>`;
        tbody.append(row);
    });
}


$(document).on("click", ".apply-btn", function () {
    const id = $(this).data("id");
    applySmsCharges(id);
});

function applySmsCharges(id) {

    const account = allmessageSendData.find(a => a.id === id);

    if (!account) {
        alert("Account not found.");
        return;
    }

    if (!confirm("Are you sure you want to deduct SMS charges?")) return;

	$.ajax({
		url: "api/customersavings/deduct-sms-charges",
		type: "POST",
		contentType: "application/json",
		data: JSON.stringify({
			id: account.id,
			balance: account.balance
		}),
		success: function(response) {
			if (response.status === "OK") {
				const newBalance = response.newBalance;

				alert("SMS Charges Deducted Successfully\nNew Balance: " + newBalance);


				account.balance = newBalance;


				renderTable(allmessageSendData);
			} else {
				alert("Failed to deduct SMS charges.");
			}
		},
		error: function() {
			alert("Failed to deduct SMS charges.");
		}
	});
}



