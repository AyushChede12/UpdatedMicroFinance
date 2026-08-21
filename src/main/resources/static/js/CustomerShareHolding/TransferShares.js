/**
 * Customer ShareHolding - Transfer Shares
 */

$(document).ready(function () {
    // Initial states
    transferTypeFunc();
    loadCustomers();
    loadBranches();
    loadCompanyBaseValue();
    TransferShareTable();

    // Default today's date
    const today = new Date().toISOString().split('T')[0];
    if (!$("#dateOfTransfer").val()) {
        $("#dateOfTransfer").val(today);
    }

    // Auto calculate on input
    $("#noOfShare, #baseValue").on("input change", function () {
        calculateShareTotals();
    });
});

// Toggle fields based on transfer type
function transferTypeFunc() {
    const tType = $("#transferType").val();
    if (tType === "C2C") {
        $("#fCustomer").show();
        $("#availShare").show();
        $("#pDetails").hide();
        $("#paymentDetailsRow").hide();
    } else {
        $("#fCustomer").hide();
        $("#availShare").hide();
        $("#availableShares").val("");
        $("#fromCustomerCode").val("");
        $("#pDetails").show();
        $("#paymentDetailsRow").show();
    }
    calculateShareTotals();
}

// Load company base value
function loadCompanyBaseValue() {
    $.ajax({
        url: "api/preference/fetchAllCompanyAdministration",
        type: "GET",
        success: function (response) {
            if ((response.status === "FOUND" || response.status === "OK") && response.data && response.data.length > 0) {
                const declaredVal = response.data[0].declaredValue;
                if (declaredVal && parseFloat(declaredVal) > 0) {
                    $("#baseValue").val(declaredVal);
                    calculateShareTotals();
                }
            }
        },
        error: function () {
            console.log("Using default base value 10");
        }
    });
}

// Load branches
function loadBranches() {
    $.ajax({
        url: "api/customershareholdingcontroller/findAllBranch",
        type: "GET",
        success: function (response) {
            const dropdown = $('#branch');
            dropdown.empty();
            dropdown.append('<option value="">SELECT BRANCH</option>');

            if ((response.status === "OK" || response.status === "FOUND") && response.data) {
                $.each(response.data, function (index, b) {
                    const code = b.branchCode || b.branchName;
                    const name = b.branchName || b.branchCode;
                    dropdown.append('<option value="' + code + '">' + name + '</option>');
                });
            }
        },
        error: function () {
            console.error("Failed to load branches");
        }
    });
}

// Load all customers for From and To dropdowns
function loadCustomers() {
    $.ajax({
        url: "api/customershareholdingcontroller/findAllCustomerCode",
        type: "GET",
        success: function (response) {
            const fromDropdown = $('#fromCustomerCode');
            const toDropdown = $('#toCustomerCode');

            fromDropdown.empty().append('<option value="">SELECT FROM CUSTOMER</option>');
            toDropdown.empty().append('<option value="">SELECT TO CUSTOMER</option>');

            if ((response.status === "OK" || response.status === "FOUND") && response.data) {
                $.each(response.data, function (index, cust) {
                    const fullName = cust.customerName || [cust.firstName, cust.middleName, cust.lastName].filter(Boolean).join(" ");
                    const label = cust.memberCode + " - " + (fullName || "N/A");
                    fromDropdown.append('<option value="' + cust.memberCode + '" data-shares="' + (cust.noOfShare || 0) + '">' + label + '</option>');
                    toDropdown.append('<option value="' + cust.memberCode + '" data-shares="' + (cust.noOfShare || 0) + '" data-name="' + (fullName || "") + '" data-date="' + (cust.signupDate || "") + '" data-branch="' + (cust.branchName || "") + '">' + label + '</option>');
                });
            }
        },
        error: function () {
            console.error("Failed to fetch customer list.");
        }
    });

    // Handle To Customer selection
    $('#toCustomerCode').on('change', function () {
        const selectedCode = $(this).val();
        if (!selectedCode) {
            $('#customerName').val('');
            $('#startDate').val('');
            $('#toAvailableShares').val('');
            return;
        }

        const selectedOption = $(this).find('option:selected');
        const optName = selectedOption.data('name');
        const optDate = selectedOption.data('date');
        const optBranch = selectedOption.data('branch');

        if (optName) $('#customerName').val(optName);
        if (optDate) $('#startDate').val(optDate);
        if (optBranch && !$('#branch').val()) $('#branch').val(optBranch);

        // Fetch latest customer details
        $.ajax({
            url: 'api/customershareholdingcontroller/fetchByCustomerCode',
            type: 'POST',
            data: { memberCode: selectedCode },
            success: function (response) {
                if ((response.status === "OK" || response.status === "FOUND") && response.data && response.data.length > 0) {
                    const customer = response.data[0];
                    const fullName = customer.customerName || [customer.firstName, customer.middleName, customer.lastName].filter(Boolean).join(" ");
                    $('#customerName').val(fullName);
                    if (customer.signupDate) $('#startDate').val(customer.signupDate);
                    if (customer.branchName && !$('#branch').val()) $('#branch').val(customer.branchName);
                }
            }
        });

        // Fetch TO customer's current share balance from backend
        $.ajax({
            url: 'api/customershareholdingcontroller/fetchByFindByCode',
            type: 'POST',
            data: { findByCode: selectedCode },
            success: function (response) {
                let totalShares = 0;
                if ((response.status === "OK" || response.status === "FOUND") && response.data && response.data.length > 0) {
                    response.data.forEach(function (item) {
                        const count = parseFloat(item.noOfShare) || 0;
                        totalShares += count;
                    });
                }
                if (totalShares === 0) {
                    const optionShares = parseFloat($('#toCustomerCode').find('option:selected').data('shares')) || 0;
                    totalShares = optionShares;
                }
                $('#toAvailableShares').val(totalShares);
            },
            error: function () {
                $('#toAvailableShares').val(0);
            }
        });
    });

    // Handle From Customer selection (for C2C)
    $('#fromCustomerCode').on('change', function () {
        const selectedFrom = $(this).val();
        if (!selectedFrom) {
            $('#availableShares').val('');
            calculateShareTotals();
            return;
        }

        // Fetch customer's share balance from backend
        $.ajax({
            url: 'api/customershareholdingcontroller/fetchByFindByCode',
            type: 'POST',
            data: { findByCode: selectedFrom },
            success: function (response) {
                let totalShares = 0;
                if ((response.status === "OK" || response.status === "FOUND") && response.data && response.data.length > 0) {
                    response.data.forEach(function (item) {
                        const count = parseFloat(item.noOfShare) || 0;
                        totalShares += count;
                    });
                }
                if (totalShares === 0) {
                    // Fallback to customer's profile share count if any
                    const optionShares = parseFloat($('#fromCustomerCode').find('option:selected').data('shares')) || 0;
                    totalShares = optionShares > 0 ? optionShares : 100; // Default demo value if none
                }
                $('#availableShares').val(totalShares);
                calculateShareTotals();
            },
            error: function () {
                $('#availableShares').val(100);
                calculateShareTotals();
            }
        });
    });
}

// Calculate amount transferred and balance shares
// Calculate amount transferred and balance shares
function calculateShareTotals() {
    const noOfShare = parseFloat($("#noOfShare").val()) || 0;
    const baseVal = parseFloat($("#baseValue").val()) || 10;
    const available = parseFloat($("#availableShares").val()) || 0;
    const tType = $("#transferType").val();

    const amount = noOfShare * baseVal;
    $("#amountTransferred").val(amount > 0 ? amount.toFixed(2) : "0.00");

    if (tType === "C2C" && available > 0) {
        const balance = available - noOfShare;
        $("#balanceShares").val(balance >= 0 ? balance : 0);
    } else {
        $("#balanceShares").val(noOfShare);
    }
}

// Save Shares
function saveShares() {
    const transferType = $("#transferType").val();
    const toCustomer = $("#toCustomerCode").val();
    const fromCustomer = $("#fromCustomerCode").val();
    const branch = $("#branch").val();
    const noOfShare = $("#noOfShare").val();
    const dateOfTransfer = $("#dateOfTransfer").val();

    if (!transferType) {
        alert("Please select Transfer Type.");
        $("#transferType").focus();
        return;
    }

    if (transferType === "C2C") {
        if (!fromCustomer) {
            alert("Please select From Customer.");
            $("#fromCustomerCode").focus();
            return;
        }
        if (fromCustomer === toCustomer) {
            alert("From Customer and To Customer cannot be the same!");
            return;
        }
        const available = parseFloat($("#availableShares").val()) || 0;
        if (parseFloat(noOfShare) > available) {
            alert("Transfer share count cannot exceed available shares (" + available + ").");
            return;
        }
    }

    if (!toCustomer) {
        alert("Please select To Customer.");
        $("#toCustomerCode").focus();
        return;
    }

    if (!branch) {
        alert("Please select Branch.");
        $("#branch").focus();
        return;
    }

    if (!noOfShare || parseFloat(noOfShare) <= 0) {
        alert("Please enter a valid Number of Shares.");
        $("#noOfShare").focus();
        return;
    }

    if (!dateOfTransfer) {
        alert("Please select Date of Transfer.");
        $("#dateOfTransfer").focus();
        return;
    }

    const payload = {
        findByCode: toCustomer,
        customerName: $("#customerName").val() || $("#toCustomerCode option:selected").text().split(" - ")[1] || "Customer",
        startDate: $("#startDate").val() || dateOfTransfer,
        previousAccountBalance: "0",
        previousShareCount: "0",
        baseValue: $("#baseValue").val() || "10",
        branch: branch,
        dateOfTransfer: dateOfTransfer,
        shareIssuedBy: transferType === "C2C" ? fromCustomer : "BANK",
        noOfShare: noOfShare,
        amountTransferred: $("#amountTransferred").val(),
        balanceShares: $("#balanceShares").val(),
        modeOfPayment: $("#modeOfPayment").val() || (transferType === "C2C" ? "Internal Transfer" : "Cash"),
        comments: $("#comments").val(),
        certificateNo: $("#certificateNo").val()
    };

    $.ajax({
        url: "api/customershareholdingcontroller/saveTransferShare",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(payload),
        success: function (response) {
            if (response.status === "OK" || response.status === "FOUND" || response.data) {
                alert(response.message || "Transfer Share saved successfully!");
                resetTransferForm();
                TransferShareTable();
            } else {
                alert(response.message || "Failed to save transfer share.");
            }
        },
        error: function (xhr) {
            console.error("Save error:", xhr);
            alert("Error saving transfer share: " + (xhr.responseText || "Server error"));
        }
    });
}

// Table Loader
// Table Loader
function TransferShareTable() {
    $.ajax({
        url: "api/customershareholdingcontroller/allDataFetchTransferShareInTable",
        type: "GET",
        dataType: "json",
        success: function (response) {
            let rows = "";
            const list = response.data || [];

            if (list.length > 0) {
                list.forEach(function (share, index) {
                    rows += `
                        <tr>
                            <td>${index + 1}</td>
                            <td>${share.findByCode || ''}</td>
                            <td>${share.customerName || ''}</td>
                            <td>${share.startDate || ''}</td>
                            <td>${share.branch || ''}</td>
                            <td>${share.noOfShare || ''}</td>
                            <td>${share.dateOfTransfer || ''}</td>
                            <td>
                                <button type="button" class="btn btn-sm btn-outline-primary" onclick="EditTransfershare(${share.id})" title="Edit">
                                    <i class="fa-solid fa-pen-to-square"></i>
                                </button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-sm btn-outline-danger" onclick="deleteTransfershare(${share.id})" title="Delete">
                                    <i class="fa-solid fa-trash"></i>
                                </button>
                            </td>
                        </tr>
                    `;
                });
            } else {
                rows = "<tr><td colspan='9' class='text-center py-3'>No transfer records found</td></tr>";
            }

            $("#transfersharetable").html(rows);
        },
        error: function (xhr) {
            console.error("Error loading table:", xhr);
            $("#transfersharetable").html("<tr><td colspan='9' class='text-center text-danger'>Failed to load data</td></tr>");
        }
    });
}

// Edit Record
function EditTransfershare(id) {
    $.ajax({
        url: "api/customershareholdingcontroller/getTransferShareIdEdite",
        type: "GET",
        data: { id: id },
        success: function (response) {
            if ((response.status === "OK" || response.status === "FOUND") && response.data) {
                const share = response.data;
                $("#id").val(share.id);
                $("#certificateNo").val(share.certificateNo || '');
                $("#customerName").val(share.customerName || '');
                $("#startDate").val(share.startDate || '');
                $("#toCustomerCode").val(share.findByCode);

                if (share.shareIssuedBy && share.shareIssuedBy !== "BANK") {
                    $("#transferType").val("C2C");
                    transferTypeFunc();
                    $("#fromCustomerCode").val(share.shareIssuedBy);
                } else {
                    $("#transferType").val("B2C");
                    transferTypeFunc();
                }

                $("#branch").val(share.branch);
                $("#noOfShare").val(share.noOfShare);
                $("#baseValue").val(share.baseValue || "10");
                $("#amountTransferred").val(share.amountTransferred);
                $("#balanceShares").val(share.balanceShares);
                $("#modeOfPayment").val(share.modeOfPayment);
                $("#dateOfTransfer").val(share.dateOfTransfer);
                $("#comments").val(share.comments);

                $("#updateBtn").show();
                $("#saveBtn").hide();

                // Scroll to top
                $('html, body').animate({ scrollTop: $("#formid").offset().top - 100 }, 300);
            } else {
                alert("Transfer Share not found.");
            }
        },
        error: function (xhr) {
            alert("Error fetching details: " + xhr.responseText);
        }
    });
}

// Update Record
function updateShares() {
    const id = $("#id").val();
    if (!id) {
        alert("No record selected for update.");
        return;
    }

    const transferType = $("#transferType").val();
    const toCustomer = $("#toCustomerCode").val();
    const fromCustomer = $("#fromCustomerCode").val();
    const branch = $("#branch").val();
    const noOfShare = $("#noOfShare").val();
    const dateOfTransfer = $("#dateOfTransfer").val();

    if (!toCustomer || !branch || !noOfShare || !dateOfTransfer) {
        alert("Please fill all required fields.");
        return;
    }

    const payload = {
        id: parseInt(id),
        findByCode: toCustomer,
        customerName: $("#customerName").val() || $("#toCustomerCode option:selected").text().split(" - ")[1] || "Customer",
        startDate: $("#startDate").val() || dateOfTransfer,
        baseValue: $("#baseValue").val() || "10",
        branch: branch,
        dateOfTransfer: dateOfTransfer,
        shareIssuedBy: transferType === "C2C" ? fromCustomer : "BANK",
        noOfShare: noOfShare,
        amountTransferred: $("#amountTransferred").val(),
        balanceShares: $("#balanceShares").val(),
        modeOfPayment: $("#modeOfPayment").val() || (transferType === "C2C" ? "Internal Transfer" : "Cash"),
        comments: $("#comments").val(),
        certificateNo: $("#certificateNo").val()
    };

    $.ajax({
        url: "api/customershareholdingcontroller/updateTransferShare",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify(payload),
        success: function (response) {
            if (response.status === "OK" || response.status === "FOUND" || response.data) {
                alert("Transfer Share updated successfully!");
                resetTransferForm();
                TransferShareTable();
            } else {
                alert(response.message || "Failed to update transfer share.");
            }
        },
        error: function (xhr) {
            alert("Error while updating: " + xhr.responseText);
        }
    });
}

// Delete Record
function deleteTransfershare(id) {
    if (confirm("Are you sure you want to delete this transfer share record?")) {
        $.ajax({
            url: "api/customershareholdingcontroller/deleteTransferShareById",
            type: "POST",
            data: { id: id },
            success: function (response) {
                if (response.status === "OK" || response.status === "FOUND") {
                    alert("Transfer share record deleted successfully!");
                    TransferShareTable();
                } else {
                    alert(response.message || "Delete failed.");
                }
            },
            error: function (xhr) {
                alert("Error deleting: " + xhr.responseText);
            }
        });
    }
}

// Reset Form
function resetTransferForm() {
    $("#formid")[0].reset();
    $("#id").val("");
    $("#customerName").val("");
    $("#startDate").val("");
    $("#availableShares").val("");
    $("#toAvailableShares").val("");
    $("#updateBtn").hide();
    $("#saveBtn").show();
    transferTypeFunc();
    loadCompanyBaseValue();

    const today = new Date().toISOString().split('T')[0];
    $("#dateOfTransfer").val(today);
}
