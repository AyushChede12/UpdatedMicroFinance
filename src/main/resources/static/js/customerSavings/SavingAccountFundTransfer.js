//janvi : Customer Account no. list fetch
$(document).ready(function() {
    $.ajax({
        url: "api/reports/getApprovedSavingAccount",
        type: "GET",
        success: function(response) {
			console.log("API response:", response);
            var dropdown1 = $('#debitAccountNumber');
			var dropdown2 = $('#creditAccountNumber');
            dropdown1.empty();
            dropdown1.append('<option value="">--SELECT ACCOUNT NO--</option>');
			dropdown2.empty();
			dropdown2.append('<option value="">--SELECT ACCOUNT NO--</option>');


            if (response.status === "OK" && response.data) {
                $.each(response.data, function(index, item) {
                   dropdown1.append('<option value="' + item.accountNumber+ '">' + item.accountNumber + '</option>');
				   dropdown2.append('<option value="' + item.accountNumber+ '">' + item.accountNumber + '</option>');
                });
            } else {
                dropdown1.append('<option value="">No Account Number found</option>');
				dropdown2.append('<option value="">No Account Number found</option>');
            }
        },
        error: function() {
            alert("Failed to fetch Policyname.");
        }
    });
});


$('#debitAccountNumber').on('change', function () {
    let accountNumber = $(this).val();

    if (accountNumber !== "") {
        $.ajax({
            url: 'api/customersavings/getallbyaccountnumber', // Pass as query param
            type: 'GET',
            data: { accountNumber: accountNumber },
            success: function (response) {
                if (response.data && response.data.length > 0) {
                    let customer = response.data[0];
                    $('#debitCustomerCode').val(customer.selectByCustomer);
					$('#debitAccountBranch').val(customer.branchName);
					$('#debitAverageBalance').val(customer.balance);
					$('#debitContactNumber').val(customer.contactNumber);
                } else {
                    alert('No data found!');
                    $('#debitCustomerCode').val('');
                }
            },
            error: function () {
                alert('Error while fetching data!');
                $('#debitCustomerCode').val('');
            }
        });
    } else {
        $('#debitCustomerCode').val('');
    }
});

$('#creditAccountNumber').on('change', function () {
    let accountNumber = $(this).val();

    if (accountNumber !== "") {
        $.ajax({
            url: 'api/customersavings/getallbyaccountnumber', // Pass as query param
            type: 'GET',
            data: { accountNumber: accountNumber },
            success: function (response) {
                if (response.data && response.data.length > 0) {
                    let customer = response.data[0];
                    $('#creditCustomerCode').val(customer.selectByCustomer);
					$('#creditAccountBranch').val(customer.branchName);
					$('#creditAverageBalance').val(customer.balance);
					$('#creditContactNumber').val(customer.contactNumber);
                } else {
                    alert('No data found!');
                    $('#debitCustomerCode').val('');
                }
            },
            error: function () {
                alert('Error while fetching data!');
                $('#debitCustomerCode').val('');
            }
        });
    } else {
        $('#debitCustomerCode').val('');
    }
});

$(document).ready(function () {
    $('#saveBtn').click(function (e) {
        e.preventDefault();

        const accountData = {
            debitAccountNumber: $('#debitAccountNumber').val(),
            debitCustomerCode: $('#debitCustomerCode').val(),
            debitAccountBranch: $('#debitAccountBranch').val(),
            debitAverageBalance: $('#debitAverageBalance').val(),
            debitContactNumber: $('#debitContactNumber').val(),
            creditAccountNumber: $('#creditAccountNumber').val(),
            creditCustomerCode: $('#creditCustomerCode').val(),
            creditAccountBranch: $('#creditAccountBranch').val(),
            creditAverageBalance: $('#creditAverageBalance').val(),
            creditAverageBalance: $('#creditContactNumber').val(),
            transferDate: $('#transferDate').val(),
            amount: $('#amount').val(),
            comment: $('#comment').val()
        };

        console.log("Sending Data:", accountData);

        $.ajax({
            url: 'api/customersavings/transferAmount',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(accountData),
            success: function (response) {
                alert("Transfer successful");
                location.reload();
            },
            error: function (xhr, status, error) {
                let errorMessage = xhr.responseJSON?.message || 'Transfer failed!!! Approve previous Transaction.';
                alert(errorMessage);
            }
        });
    });
});


