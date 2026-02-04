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
                    $('#currentBalance').val(acc.balance || 0);

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
	    let interestType = $('#interestType').val().toLowerCase();

	    let fromDateVal = $('#fromDate').val();
	    let toDateVal = $('#toDate').val();

	    if (!balance || !rate || !interestType || !fromDateVal || !toDateVal) {
	        alert("Please fill all required fields");
	        return;
	    }

	    let fromDate = new Date(fromDateVal);
	    let toDate = new Date(toDateVal);

	    if (fromDate > toDate) {
	        alert("From Date cannot be greater than To Date");
	        return;
	    }

	    /* ---- Total Days ---- */
	    let timeDiff = toDate - fromDate;
	    let totalDays = Math.floor(timeDiff / (1000 * 60 * 60 * 24)) + 1;
	    $('#totalDays').val(totalDays);

	    /* ---- Interest Type Days ---- */
	    let periodDays;

	    switch (interestType) {
	        case "monthly":
	            periodDays = 30;
	            break;
	        case "quaterly":
	            periodDays = 90;
	            break;
	        case "yearly":
	            periodDays = 365;
	            break;
	        default:
	            alert("Invalid interest type");
	            return;
	    }

	    /* ---- Interest Calculation ---- */
	    let interestAmount =
	        (balance * rate * totalDays) / (periodDays * 100);

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

document.addEventListener("DOMContentLoaded", function () {

    const fromDate = document.getElementById("fromDate");
    const toDate = document.getElementById("toDate");
    const totalDays = document.getElementById("totalDays");

    function calculateTotalDays() {
        if (!fromDate.value || !toDate.value) {
            totalDays.value = "";
            return;
        }

        const startDate = new Date(fromDate.value);
        const endDate = new Date(toDate.value);

        // Validate date order
        if (endDate < startDate) {
            alert("TO DATE cannot be earlier than FROM DATE");
            totalDays.value = "";
            toDate.value = "";
            return;
        }

        // Difference in milliseconds
        const diffTime = endDate.getTime() - startDate.getTime();

        // Convert to days (+1 for inclusive count)
        const diffDays = Math.floor(diffTime / (1000 * 60 * 60 * 24)) + 1;

        totalDays.value = diffDays;
    }

    fromDate.addEventListener("change", calculateTotalDays);
    toDate.addEventListener("change", calculateTotalDays);

});

$(document).ready(function () {

    $('#interestType, #fromDate').on('change', function () {

        let interestType = $('#interestType').val();
        let fromDateVal = $('#fromDate').val();

        if (!interestType || !fromDateVal) {
            return;
        }

        let fromDate = new Date(fromDateVal);
        let minToDate = new Date(fromDate);
        let maxToDate = new Date(fromDate);

        if (interestType === "monthly") {
            // +1 month
            maxToDate.setMonth(fromDate.getMonth() + 1);

        } else if (interestType === "quaterly") {
            // +3 months
            maxToDate.setMonth(fromDate.getMonth() + 3);

        } else if (interestType === "yearly") {
            // +1 year
            maxToDate.setFullYear(fromDate.getFullYear() + 1);
        }

        // format YYYY-MM-DD
        function formatDate(date) {
            let d = new Date(date),
                month = '' + (d.getMonth() + 1),
                day = '' + d.getDate(),
                year = d.getFullYear();

            if (month.length < 2) month = '0' + month;
            if (day.length < 2) day = '0' + day;

            return [year, month, day].join('-');
        }

        $('#toDate').attr('min', formatDate(minToDate));
        $('#toDate').attr('max', formatDate(maxToDate));
        $('#toDate').val(""); // force reselect

    });

    /* ---- Extra Safety: Validate on ToDate Change ---- */
    $('#toDate').on('change', function () {

        let toDate = new Date($(this).val());
        let maxDate = new Date($(this).attr('max'));

        if (toDate > maxDate) {
            alert("Selected date is not allowed for selected interest type");
            $(this).val("");
        }
    });

});
