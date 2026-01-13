let allmessageSendData = [];

// SEARCH BUTTON CLICK
$("#searchBtn").click(function () {
    const selected = $("#byDate").val();

    if (!selected) {
        alert("Please select a date option.");
        return;
    }

    const { startDate, endDate } = getDateRange(selected);
    searchInThemessageSend(startDate, endDate);
});

// DATE RANGE FUNCTION
function getDateRange(type) {
    const today = new Date();
    let start = new Date(today);
    let end = new Date(today);

    switch (type) {
        case "today":
            end.setHours(23, 59, 59, 999);
            break;
        case "yesterday":
            start.setDate(today.getDate() - 1);
            end.setDate(today.getDate() - 1);
            end.setHours(23, 59, 59, 999);
            break;
        case "last7":
            start.setDate(today.getDate() - 6);
            break;
        case "last30":
            start.setDate(today.getDate() - 29);
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

// FETCH DATA FROM API
function searchInThemessageSend(startDate, endDate) {
    $.ajax({
        url: "api/customersavings/getSavingAccountDataSMSEnable",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ startDate, endDate }),
        success: function (response) {
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

// RENDER TABLE
function renderTable(data) {
    const tbody = $("#tbody");
    tbody.empty();

    data.forEach((item, index) => {
        const balance = item.balance ?? item.accountBalance ?? '-';
        const row = `
        <tr>
            <td><input type="checkbox" value="${item.id}"></td>
            <td>${index + 1}</td>
            <td>${item.accountNumber ?? '-'}</td>
            <td>${item.openingDate ?? '-'}</td>
            <td>${balance}</td>
            <td>${item.messageSend === "1" ? "Enabled" : "Disabled"}</td>
        </tr>`;
        tbody.append(row);
    });
}

// APPLY BUTTON CLICK
$("#applyBtn").click(function () {
    const amount = parseFloat($("#amount").val());
    if (isNaN(amount) || amount <= 0) {
        alert("Please enter a valid amount to deduct.");
        return;
    }

    const selectedIds = $("#tbody input[type=checkbox]:checked")
        .map(function () { return $(this).val(); }).get();

    if (selectedIds.length === 0) {
        alert("Please select at least one account.");
        return;
    }

    if (!confirm(`Are you sure you want to deduct ${amount} from selected accounts?`)) return;

    selectedIds.forEach(id => applySmsCharges(id, amount));
});

// DEDUCT SMS CHARGES
function applySmsCharges(id, amount) {
    const account = allmessageSendData.find(a => a.id == id);

    if (!account) {
        alert("Account not found.");
        return;
    }

    $.ajax({
        url: "api/customersavings/deduct-sms-charges",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({
            id: account.id,
            balance: account.balance ?? account.accountBalance,
            amount: amount // <-- send the amount to backend
        }),
        success: function (response) {
            if (response.status === "OK") {
                const newBalance = response.newBalance;
                account.balance = newBalance;
                renderTable(allmessageSendData);
                alert(`SMS Charges Deducted Successfully\nAccount: ${account.accountNumber}\nDeducted: ${amount}\nNew Balance: ${newBalance}`);
            } else {
                alert("Failed to deduct SMS charges for account: " + account.accountNumber);
            }
        },
        error: function () {
            alert("Failed to deduct SMS charges for account: " + account.accountNumber);
        }
    });
}
