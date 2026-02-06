$(document).ready(function () {

    // ================= SAVE =================
    $("#saveBtn").on("click", function (e) {
        e.preventDefault();

        if (!validateForm()) return;

        const formData = getFormData();
        console.log("SAVE DATA =", formData);

        $.ajax({
            type: "POST",
            url: "api/customersavings/savescheme",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function () {
                alert("Data saved successfully!");
                $("#savingForm")[0].reset();
                fetchAllData();
            },
            error: function (xhr) {
                console.error(xhr.responseText);
                alert("Save failed");
            }
        });
    });


    // ================= UPDATE =================
    $("#updateBtn").on("click", function (e) {
        e.preventDefault();

        const id = $("#savingAccountId").val();
        console.log("UPDATE ID =", id);

        if (!id) {
            alert("Please select a record to update!");
            return;
        }

        if (!validateForm()) return;

        const formData = getFormData();

        $.ajax({
            type: "PUT",
            url: "api/customersavings/update/" + id,
            contentType: "application/json",
            data: JSON.stringify(formData),

            success: function () {
                alert("Record updated successfully!");
                $("#savingAccountId").val("");
                $("#savingForm")[0].reset();
                fetchAllData();
            },

            error: function (xhr) {
                console.error(xhr.responseText);
                alert("Update failed!");
            }
        });
    });


    // ================= FETCH ALL =================
    function fetchAllData() {
        $.ajax({
            type: "GET",
            url: "api/customersavings/fetchalllll",

            success: function (response) {
                const tableBody = $(".datatable tbody");
                tableBody.empty();

                if (response.status === "FOUND") {
                    response.data.forEach((item, index) => {
                        const row = `
                            <tr>
                                <td>${index + 1}</td>
                                <td>${item.policyName}</td>
                                <td>${item.customerName}</td>
                                <td>${item.initialDeposite}</td>
                                <td>${item.monthlyMinimumBalance}</td>
                                <td>${item.dailyLimit}</td>
                                <td>${item.monthlyCardLimit}</td>
                                <td>${item.yearlyCardLimit}</td>
                                <td>
                                    <button class="iconbutton" onclick="viewData(${item.id})">
                                        <i class="fa-solid fa-pen-to-square text-primary"></i>
                                    </button>
                                </td>
                                <td>
                                    <button class="iconbutton" onclick="deleteData(${item.id})">
                                        <i class="fa-solid fa-trash text-danger"></i>
                                    </button>
                                </td>
                            </tr>`;
                        tableBody.append(row);
                    });
                } else {
                    tableBody.html(
                        `<tr><td colspan="10" class="text-center">No data found</td></tr>`
                    );
                }
            },

            error: function (xhr) {
                console.error(xhr.responseText);
            }
        });
    }

    // initial load
    fetchAllData();
});


// ================= FORM DATA (ENTITY MATCHING) =================
function getFormData() {
    return {
        policyName: $("#policyName").val(),
        yearlyROI: $("#yearlyROI").val(),
        customerName: $("#customerName").val(),

        initialDeposite: $("#initialDeposit").val(),
        monthlyMinimumBalance: $("#minimumOpeningBalance").val(),

        reservedFunds: $("#reservedFunds").val(),
        messagingFees: $("#messagingFees").val(),
        messagingInterval: $("#messagingInterval").val(),

        monthlyFreeIFSCTransactions: $("#monthlyFreeIFSC").val(),
        FreeMoneyTransfers: $("#freeMoneyTransfers").val(),

        limitperTransaction: $("#limitPerTransaction").val(),
        dailyLimit: $("#dailyLimit").val(),
        weeklyLimit: $("#weeklyLimit").val(),
        monthlyLimit: $("#monthlyLimit").val(),

        serviceFee: $("#serviceFee").val(),
        billingCycle: $("#billingCycle").val(),
        cardFee: $("#cardFee").val(),
        monthlyCardLimit: $("#monthlyCardLimit").val(),
        yearlyCardLimit: $("#yearlyCardLimit").val()
    };
}


// ================= VALIDATION =================
function validateForm() {

    if ($("#policyName").val().trim() === "") {
        alert("Policy Name is required");
        $("#policyName").focus();
        return false;
    }

    if ($("#customerName").val().trim() === "") {
        alert("Customer Name is required");
        $("#customerName").focus();
        return false;
    }

    if ($("#initialDeposit").val() === "" || $("#initialDeposit").val() <= 0) {
        alert("Initial Deposit must be greater than 0");
        $("#initialDeposit").focus();
        return false;
    }

    if ($("#minimumOpeningBalance").val() === "" || $("#minimumOpeningBalance").val() <= 0) {
        alert("Monthly Minimum Balance must be greater than 0");
        $("#minimumOpeningBalance").focus();
        return false;
    }

    if ($("#dailyLimit").val() === "" || $("#dailyLimit").val() <= 0) {
        alert("Daily Limit must be greater than 0");
        $("#dailyLimit").focus();
        return false;
    }

    if ($("#monthlyCardLimit").val() === "" || $("#yearlyCardLimit").val() === "") {
        alert("Monthly & Yearly Card Limit are required");
        return false;
    }

    return true;
}


// ================= VIEW / EDIT =================
function viewData(id) {
    console.log("EDIT ID =", id);

    $.ajax({
        type: "GET",
        url: "api/customersavings/getSavingSchemeCatalogById",
        data: { id: id },

        success: function (response) {
            if (response.status === "FOUND") {
                const d = response.data;

                $("#savingAccountId").val(d.id);

                $("#policyName").val(d.policyName);
                $("#yearlyROI").val(d.yearlyROI);
                $("#customerName").val(d.customerName);

                $("#initialDeposit").val(d.initialDeposite);
                $("#minimumOpeningBalance").val(d.monthlyMinimumBalance);

                $("#reservedFunds").val(d.reservedFunds);
                $("#messagingFees").val(d.messagingFees);
                $("#messagingInterval").val(d.messagingInterval);

                $("#monthlyFreeIFSC").val(d.monthlyFreeIFSCTransactions);
                $("#freeMoneyTransfers").val(d.freeMoneyTransfers);

                $("#limitPerTransaction").val(d.limitperTransaction);
                $("#dailyLimit").val(d.dailyLimit);
                $("#weeklyLimit").val(d.weeklyLimit);
                $("#monthlyLimit").val(d.monthlyLimit);

                $("#serviceFee").val(d.serviceFee);
                $("#billingCycle").val(d.billingCycle);
                $("#cardFee").val(d.cardFee);
                $("#monthlyCardLimit").val(d.monthlyCardLimit);
                $("#yearlyCardLimit").val(d.yearlyCardLimit);
            } else {
                alert("Record not found");
            }
        },

        error: function () {
            alert("Failed to load record");
        }
    });
}


// ================= DELETE =================
function deleteData(id) {
    if (!confirm("Are you sure you want to delete this Scheme?")) return;

    $.ajax({
        type: "POST",
        url: "api/customersavings/deleteSavingSchemeCatalogDataById?id=" + id,

        success: function (response) {
            if (response.data === "success") {
                alert("Deleted successfully!");
                location.reload();
            } else {
                alert("Delete failed");
            }
        },

        error: function () {
            alert("Delete error");
        }
    });
}
