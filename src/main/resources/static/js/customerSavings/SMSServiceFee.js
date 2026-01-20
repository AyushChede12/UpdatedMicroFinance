$(document).ready(function () {

    let allmessageSendData = [];

    /* =========================
       SEARCH BUTTON
    ========================= */
    $("#searchBtn").click(function () {

        const selected = $("#byDate").val();

        if (!selected) {
            alert("Please select date");
            return;
        }

        const { startDate, endDate } = getDateRange(selected);
        fetchData(startDate, endDate);
    });

    /* =========================
       DATE RANGE
    ========================= */
    function getDateRange(type) {

        const today = new Date();
        let start = new Date(today);
        let end = new Date(today);

        switch (type) {
            case "today":
                break;

            case "yesterday":
                start.setDate(today.getDate() - 1);
                end.setDate(today.getDate() - 1);
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

        const format = d =>
            d.toISOString().split("T")[0];

        return {
            startDate: format(start),
            endDate: format(end)
        };
    }

    /* =========================
       FETCH DATA
    ========================= */
    function fetchData(startDate, endDate) {

        $.ajax({
            url: "/api/customersavings/getSavingAccountDataSMSEnable",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({ startDate, endDate }),
            success: function (res) {

                if (res && res.data.length > 0) {
                    allmessageSendData = res.data;
                    renderTable(allmessageSendData);
                } else {
                    $("#tbody").empty();
                    alert("No data found");
                }
            },
            error: function () {
                alert("Server error");
            }
        });
    }

    /* =========================
       RENDER TABLE
    ========================= */
    function renderTable(data) {

        $("#tbody").empty();

        $.each(data, function (i, item) {

            $("#tbody").append(`
                <tr>
                    <td><input type="checkbox" value="${item.id}"></td>
                    <td>${i + 1}</td>
                    <td>${item.accountNumber}</td>
                    <td>${item.openingDate}</td>
                    <td>${item.openingFees}</td>
                    <td>${item.messageSend == 1 ? "Enabled" : "Disabled"}</td>
                </tr>
            `);
        });
    }

    /* =========================
       APPLY BUTTON
    ========================= */
    $("#applyBtn").click(function () {

        const amount = parseFloat($("#amount").val());

        if (!amount || amount <= 0) {
            alert("Enter valid amount");
            return;
        }

        const ids = $("#tbody input:checked")
            .map(function () { return $(this).val(); }).get();

        if (ids.length === 0) {
            alert("Select at least one account");
            return;
        }

        if (!confirm("Deduct ₹" + amount + "?")) return;

        ids.forEach(id => deductCharge(id, amount));
    });

    /* =========================
       DEDUCT CHARGE
    ========================= */
    function deductCharge(id, amount) {

        const acc = allmessageSendData.find(a => a.id == id);

        $.ajax({
            url: "/api/customersavings/deduct-sms-charges",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify({
                id: acc.id,
                balance: acc.balance,
                smsCharge: amount
            }),
            success: function (res) {
                acc.balance = res.newBalance;
                renderTable(allmessageSendData);
            }
        });
    }
});
