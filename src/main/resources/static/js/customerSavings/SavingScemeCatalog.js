$(document).ready(function () {
    // ------------------- SAVE -------------------
    $("#saveBtn").on("click", function (e) {
        e.preventDefault();

        const formData = {
            policyName: $("#policyName").val(),
            yearlyROI: $("#yearlyROI").val(),
            customerName: $("#customerName").val(),
            initialDeposite: $("#initialDeposite").val(),
            monthlyMinimumBalance: $("#monthlyMinimumBalance").val(),
            reservedFunds: $("#reservedFunds").val(),
            messagingFees: $("#messagingFees").val(),
            messagingInterval: $("#messagingInterval").val(),
            monthlyFreeIFSCTransactions: $("#monthlyFreeIFSCTransactions").val(),
            freeMoneyTransfers: $("#freeMoneyTransfers").val(),
            limitperTransaction: $("#limitperTransaction").val(),
            dailyLimit: $("#dailyLimit").val(),
            weeklyLimit: $("#weeklyLimit").val(),
            monthlyLimit: $("#monthlyLimit").val(),
            serviceFee: $("#serviceFee").val(),
            billingCycle: $("#billingCycle").val(),
            cardFee: $("#cardFee").val(),
            monthlyCardLimit: $("#monthlyCardLimit").val(),
            yearlyCardLimit: $("#yearlyCardLimit").val()
        };

        $.ajax({
            type: "POST",
            url: "/api/customersavings/savescheme",
            contentType: "application/json",
            data: JSON.stringify(formData),
            success: function () {
                alert("Data saved successfully!");
                $("#savingForm")[0].reset();
                fetchAllData();
            },
            error: function () {
                alert("Save failed");
            }
        });
    });

	// ------------------- UPDATE -------------------
	$("#updateBtn").on("click", function (e) {
	    e.preventDefault();

	    const id = $("#savingAccountId").val();
	    console.log("UPDATE ID =", id);

	    if (!id) {
	        alert("Please select a record to update!");
	        return;
	    }

	    const formData = {
	        policyName: $("#policyName").val(),
	        yearlyROI: $("#yearlyROI").val(),
	        customerName: $("#customerName").val(),
	        initialDeposite: $("#initialDeposite").val(),
	        monthlyMinimumBalance: $("#monthlyMinimumBalance").val(),
	        reservedFunds: $("#reservedFunds").val(),
	        messagingFees: $("#messagingFees").val(),
	        messagingInterval: $("#messagingInterval").val(),
	        monthlyFreeIFSCTransactions: $("#monthlyFreeIFSCTransactions").val(),
	        freeMoneyTransfers: $("#freeMoneyTransfers").val(),
	        limitperTransaction: $("#limitperTransaction").val(),
	        dailyLimit: $("#dailyLimit").val(),
	        weeklyLimit: $("#weeklyLimit").val(),
	        monthlyLimit: $("#monthlyLimit").val(),
	        serviceFee: $("#serviceFee").val(),
	        billingCycle: $("#billingCycle").val(),
	        cardFee: $("#cardFee").val(),
	        monthlyCardLimit: $("#monthlyCardLimit").val(),
	        yearlyCardLimit: $("#yearlyCardLimit").val()
	    };

	    $.ajax({
	        url: window.location.origin + "/api/customersavings/update/" + id,
	        type: "PUT",
	        contentType: "application/json",
	        dataType: "text",
	        data: JSON.stringify(formData),

	        success: function (res) {
	            console.log("Update response:", res);
	            alert("Record updated successfully!");
	            $("#savingAccountId").val("");
	            $("#savingForm")[0].reset();
	            fetchAllData();
	        },

	        error: function (xhr) {
	            console.error("Update error:", xhr);
	            alert("Update failed! Status: " + xhr.status);
	        }
	    });
	});

    // ------------------- FETCH ALL -------------------
    function fetchAllData() {
        $.ajax({
            type: "GET",
            url: "/api/customersavings/fetchalllll",
            success: function (response) {
                const tableBody = $(".datatable tbody");
                tableBody.empty();

                if (response.status === "FOUND") {
                    response.data.forEach((item, index) => {
                        const row = `
                            <tr>
                                <td>${index + 1}</td>
                                <td>${(item.policyName).toUpperCase()}</td>
                                <td>${(item.customerName).toUpperCase()}</td>
                                <td>${item.initialDeposite}</td>
                                <td>${item.monthlyMinimumBalance}</td>
                                <td>${item.dailyLimit}</td>
                                <td>${item.monthlyCardLimit}</td>
                                <td>${item.yearlyCardLimit}</td>
                                <td>
                                    <button class="iconbutton" onclick="viewData('${item.id}')">
                                        <i class="fa-solid fa-pen-to-square text-primary"></i>
                                    </button>
                                </td>
                                <td>
                                    <button class="iconbutton" onclick="deleteData('${item.id}')">
                                        <i class="fa-solid fa-trash text-danger"></i>
                                    </button>
                                </td>
                            </tr>`;
                        tableBody.append(row);
                    });
                } else {
                    tableBody.html(`<tr><td colspan="10" class="text-center">No data found</td></tr>`);
                }
            }
        });
    }

    // Initial load
    fetchAllData();
});


// ------------------- VIEW (EDIT) -------------------
function viewData(id) {
    console.log("EDIT CLICKED ID =", id);

    $.ajax({
        url: "/api/customersavings/getSavingSchemeCatalogById",
        type: "GET",
        data: { id: id },
        success: function (response) {
            console.log("VIEW RESPONSE =", response);

            if (response.status === "FOUND") {
                const d = response.data;

                $("#savingAccountId").val(d.id);   // 🔥 MOST IMPORTANT LINE

                $("#policyName").val(d.policyName);
                $("#yearlyROI").val(d.yearlyROI);
                $("#customerName").val(d.customerName);
                $("#initialDeposite").val(d.initialDeposite);
                $("#monthlyMinimumBalance").val(d.monthlyMinimumBalance);
                $("#reservedFunds").val(d.reservedFunds);
                $("#messagingFees").val(d.messagingFees);
                $("#messagingInterval").val(d.messagingInterval);
                $("#monthlyFreeIFSCTransactions").val(d.monthlyFreeIFSCTransactions);
                $("#freeMoneyTransfers").val(d.freeMoneyTransfers);
                $("#limitperTransaction").val(d.limitperTransaction);
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


// ------------------- DELETE -------------------
function deleteData(id) {
    if (!confirm("Are you sure you want to delete this Scheme?")) return;

    $.ajax({
        url: "/api/customersavings/deleteSavingSchemeCatalogDataById?id=" + id,
        type: "POST",
        success: function (response) {
            if (response.data === "success") {
                alert("Deleted successfully!");
                location.reload(); // safe refresh
            } else {
                alert("Delete failed");
            }
        },
        error: function () {
            alert("Delete error");
        }
    });
}
