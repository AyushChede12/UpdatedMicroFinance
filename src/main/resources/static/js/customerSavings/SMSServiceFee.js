$(document).ready(function () {

    let allmessageSendData = [];

    /* ============================
       SEARCH BUTTON CLICK
    ============================ */
    $("#searchBtn").on("click", function () {
        const selected = $("#byDate").val();

        if (!selected) {
            alert("Please select a date option.");
            return;
        }

        const { startDate, endDate } = getDateRange(selected);
        searchInThemessageSend(startDate, endDate);
    });

    /* ============================
       DATE RANGE FUNCTION
    ============================ */
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

    /* ============================
       FETCH DATA FROM API
    ============================ */
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
                        alert("No records found.");
                    }
                } else {
                    $("#tbody").empty();
                    alert("No records found.");
                }
            },
            error: function () {
                alert("Failed to load data.");
            }
        });
    }

    /* ============================
       RENDER TABLE
    ============================ */
    function renderTable(data) {
        const tbody = $("#tbody");
        tbody.empty();

        $.each(data, function (index, item) {

            const balance = item.balance ?? item.accountBalance ?? "-";
            const smsStatus = item.messageSend === "1" ? "Enabled" : "Disabled";

            const row = `
                <tr>
                    <td><input type="checkbox" value="${item.id}"></td>
                    <td>${index + 1}</td>
                    <td>${item.accountNumber ?? "-"}</td>
                    <td>${item.openingDate ?? "-"}</td>
                    <td>${balance}</td>
                    <td>${smsStatus}</td>
                </tr>
            `;

            tbody.append(row);
        });
    }

    /* ============================
       APPLY BUTTON CLICK
    ============================ */
    $("#applyBtn").on("click", function () {

        const amount = parseFloat($("#amount").val());

        if (isNaN(amount) || amount <= 0) {
            alert("Please enter a valid amount.");
            return;
        }

        const selectedIds = $("#tbody input[type=checkbox]:checked")
            .map(function () { return $(this).val(); })
            .get();

        if (selectedIds.length === 0) {
            alert("Please select at least one account.");
            return;
        }

        if (!confirm(`Are you sure you want to deduct ₹${amount}?`)) return;

        $.each(selectedIds, function (i, id) {
            applySmsCharges(id, amount);
        });
    });

    /* ============================
       DEDUCT SMS CHARGES API
    ============================ */
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
                smsCharge: amount   // ✅ BACKEND MATCH
            }),
            success: function (response) {

                if (response && response.status === "OK") {
                    account.balance = response.newBalance;
                    renderTable(allmessageSendData);
                } else {
                    alert("Failed to deduct SMS charge for account: " + account.accountNumber);
                }
            },
            error: function () {
                alert("Server error while deducting SMS charge.");
            }
        });
    }

});
