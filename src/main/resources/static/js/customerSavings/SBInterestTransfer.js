$(document).ready(function () {

    /* =========================
       1. LOAD ACCOUNT NUMBERS
    ========================= */
    function loadAccountNumbers() {
        $.ajax({
            url: "api/customersavings/getAllSavingAccountData",
            type: "GET",
            dataType: "json",
            success: function (response) {
                let dropdown = $('#accountNumber');
                dropdown.empty();
                dropdown.append('<option value="">SELECT ACCOUNT NO</option>');

                if ((response.status === "OK" || response.status === "FOUND") && response.data?.length > 0) {
                    $.each(response.data, function (i, acc) {
                        dropdown.append(`<option value="${acc.accountNumber}">${acc.accountNumber}</option>`);
                    });
                }
            },
            error: function (xhr) {
                console.error("Account load error:", xhr.responseText);
            }
        });
    }

    loadAccountNumbers();

    /* =================================
       2. FETCH CUSTOMER DETAILS
    ================================= */
    $('#accountNumber').on('change', function () {

        let accNo = $(this).val();

        $('#customerName, #accountType, #currentBalance').val('');

        if (!accNo) return;

        $.ajax({
            url: "api/customersavings/getallbyaccountnumber",
            type: "GET",
            data: { accountNumber: accNo },
            dataType: "json",
            success: function (response) {

                if ((response.status === "OK" || response.status === "FOUND") && response.data?.length > 0) {

                    let acc = response.data[0];

                    $('#customerName').val(acc.enterCustomerName || '');
                    $('#accountType').val(acc.accountType || 'SAVING');
                    $('#currentBalance').val(acc.averageBalance || acc.openingFees || 0);

                } else {
                    alert("Account details not found");
                }
            },
            error: function () {
                alert("Failed to fetch account details");
            }
        });
    });

    /* =========================
       3. GENERATE INTEREST
    ========================= */
    $('#generateInterestBtn').on('click', function (e) {
        e.preventDefault();

        let balance = parseFloat($('#currentBalance').val());
        let rate = parseFloat($('#interestRate').val());
        let interestType = $('#interestType').val();

        let fromDateVal = $('#fromDate').val();
        let toDateVal = $('#toDate').val();

        if (!balance || !rate || !interestType || !fromDateVal || !toDateVal) {
            alert("Please fill all required fields");
            return;
        }

        let fromDate = new Date(fromDateVal);
        let toDate = new Date(toDateVal);

        if (isNaN(fromDate.getTime()) || isNaN(toDate.getTime())) {
            alert("Invalid date selected");
            return;
        }

        if (fromDate > toDate) {
            alert("From Date cannot be greater than To Date");
            return;
        }

        /* ---- Calculate Total Days ---- */
        let timeDiff = toDate - fromDate;
        let totalDays = Math.floor(timeDiff / (1000 * 60 * 60 * 24)) + 1;
        $('#totalDays').val(totalDays);

        /* ---- Interest Calculation ---- */
        let interestAmount = 0;

        if (interestType === "MONTHLY") {
            if (rate > 5) {
                alert("Monthly interest rate seems too high");
                return;
            }
            interestAmount = (balance * rate) / 100;

        } else { // YEARLY
            if (rate > 20) {
                alert("Yearly interest rate seems too high");
                return;
            }
            interestAmount = (balance * rate * totalDays) / 36500;
        }

        interestAmount = parseFloat(interestAmount.toFixed(2));

        if (interestAmount <= 0) {
            alert("Calculated interest is invalid");
            return;
        }

        $('#interestAmount').val(interestAmount);
        $('#newBalance').val((balance + interestAmount).toFixed(2));
    });

    /* =========================
       4. TRANSFER INTEREST
    ========================= */
    $('#searchDataBtn').on('click', function (e) {
        e.preventDefault();

        let accountNumber = $('#accountNumber').val();
        let interestType = $('#interestType').val();
        let interestAmount = parseFloat($('#interestAmount').val());
        let newBalance = parseFloat($('#newBalance').val());

        if (!accountNumber || !interestType || !interestAmount || interestAmount <= 0) {
            alert("Please generate interest first");
            return;
        }

        let payload = {
            accountNumber: accountNumber,
            interestType: interestType,
            interestAmount: interestAmount,
            newBalance: newBalance
        };

        $.ajax({
            url: "api/customersavings/transferInterest",
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(payload),
            success: function (response) {

                if (response.status === "OK" || response.status === "SUCCESS") {
                    alert("Interest transferred successfully");

                    $('#currentBalance').val(newBalance.toFixed(2));
                    $('#interestAmount, #newBalance, #totalDays, #interestRate').val('');

                } else {
                    alert(response.message || "Transfer failed");
                }
            },
            error: function () {
                alert("Error transferring interest");
            }
        });
    });

});
