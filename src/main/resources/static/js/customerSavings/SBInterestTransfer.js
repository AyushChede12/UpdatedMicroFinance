$(document).ready(function () {
    // =========================
    // 1. Load Account Numbers
    // =========================
    function loadAccountNumbers() {
        $.ajax({
            url: "api/customersavings/getAllSavingAccountData",
            type: "GET",
            dataType: "json",
            success: function (response) {
                let dropdown = $('#accountNumber');
                dropdown.empty();
                dropdown.append('<option value="">SELECT ACCOUNT NO</option>');

                if ((response.status === "OK" || response.status === "FOUND") && response.data.length > 0) {
                    $.each(response.data, function (i, acc) {
                        dropdown.append(`<option value="${acc.accountNumber}">${acc.accountNumber}</option>`);
                    });
                }
            },
            error: function (xhr) {
                console.error("Error fetching account numbers:", xhr.responseText);
            }
        });
    }

    loadAccountNumbers();

    // ==========================================
    // 2. Fill Customer Details on Account Select
    // ==========================================
    $('#accountNumber').on('change', function () {
        let accNo = $(this).val();
        if (!accNo) {
            $('#customerName, #accountType, #currentBalance').val('');
            return;
        }

        $.ajax({
            url: "api/customersavings/getallbyaccountnumber",
            type: "GET",
            data: { accountNumber: accNo },
            dataType: "json",
            success: function (response) {
                if ((response.status === "OK" || response.status === "FOUND") && response.data.length > 0) {
                    let acc = response.data[0];
                    $('#customerName').val(acc.enterCustomerName || '');
                    $('#accountType').val(acc.accountType || 'SAVING');
                    $('#currentBalance').val(acc.averageBalance || acc.openingFees || 0);
                } else {
                    alert("Account data not found");
                    $('#customerName, #accountType, #currentBalance').val('');
                }
            },
            error: function (xhr) {
                console.error("Error fetching account details:", xhr.responseText);
                alert("Failed to fetch account details");
            }
        });
    });

    // =========================
    // 3. Interest Calculation
    // =========================
    $('#generateInterestBtn').on('click', function (e) {
        e.preventDefault();

        let balance = parseFloat($('#currentBalance').val()) || 0;
        let interestRate = parseFloat($('#interestRate').val()) || 0;
        let fromDate = new Date($('#fromDate').val());
        let toDate = new Date($('#toDate').val());

        if (!balance || !interestRate || !fromDate || !toDate) {
            alert("Please fill all required fields for calculation.");
            return;
        }

        // Calculate total days
        let timeDiff = toDate.getTime() - fromDate.getTime();
        let totalDays = Math.ceil(timeDiff / (1000 * 3600 * 24)) + 1; // +1 to include both days
        $('#totalDays').val(totalDays);

        // Simple interest calculation: (Principal * Rate * Time)/100
        // Assuming interestRate is yearly
        let interestAmount = (balance * interestRate * totalDays) / 36500; 
        interestAmount = parseFloat(interestAmount.toFixed(2));

        $('#interestAmount').val(interestAmount);

        let newBalance = balance + interestAmount;
        $('#newBalance').val(newBalance.toFixed(2));
    });

    // =========================
    // 4. Transfer Interest
    // =========================
    $('#searchDataBtn').on('click', function (e) {
        e.preventDefault();

        let accountNumber = $('#accountNumber').val();
        let interestType = $('#interestType').val();
        let interestAmount = parseFloat($('#interestAmount').val()) || 0;
        let newBalance = parseFloat($('#newBalance').val()) || 0;

        if (!accountNumber || !interestType || interestAmount <= 0) {
            alert("Please generate interest before transferring.");
            return;
        }

        let data = {
            accountNumber: accountNumber,
            interestType: interestType,
            interestAmount: interestAmount,
            newBalance: newBalance
        };

        $.ajax({
            url: "api/customersavings/transferInterest",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(data),
            success: function (response) {
                if (response.status === "OK" || response.status === "SUCCESS") {
                    alert("Interest transferred successfully!");
                    // Refresh balance
                    $('#currentBalance').val(newBalance.toFixed(2));
                    $('#interestAmount, #newBalance, #totalDays, #interestRate').val('');
                } else {
                    alert("Failed to transfer interest: " + response.message);
                }
            },
            error: function (xhr) {
                console.error("Error transferring interest:", xhr.responseText);
                alert("Error transferring interest");
            }
        });
    });
});
