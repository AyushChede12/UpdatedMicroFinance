var allCustomers = []; // store full data

$(document).ready(function () {

    // 1️⃣ Load all customers once
    $.ajax({
        url: "api/customermanagement/getAllCustomer",
        type: "GET",
        success: function (data) {
            allCustomers = data;
            renderTable(allCustomers);
        },
        error: function () {
            alert("Failed to fetch customer data.");
        }
    });

    // 2️⃣ Filter on branch change
    $('#branchName').on('change', function () {
        filterCustomers();
    });

    // 3️⃣ Filter on customer name typing
    $('#customerName').on('keyup', function () {
        filterCustomers();
    });

});

// 🔍 Filtering Logic
function filterCustomers() {

    var selectedBranch = $('#branchName').val().toLowerCase();
    var customerName = $('#customerName').val().toLowerCase();

    var filteredData = allCustomers.filter(function (customer) {

        var branchMatch = !selectedBranch ||
            (customer.branchName && customer.branchName.toLowerCase().includes(selectedBranch));

        var nameMatch = !customerName ||
            (customer.customerName && customer.customerName.toLowerCase().includes(customerName));

        return branchMatch && nameMatch;
    });

    renderTable(filteredData);
}

// 📋 Table Rendering
function renderTable(data) {

    var tbody = $("table tbody");
    tbody.empty();

    if (data.length === 0) {
        tbody.append("<tr><td colspan='9' class='text-center'>No Records Found</td></tr>");
        return;
    }

    $.each(data, function (i, customer) {

        var row = "<tr>" +
            "<td>" + (i + 1) + "</td>" +
            "<td>" + (customer.memberCode || '') + "</td>" +
			"<td>" + (customer.customerName || '') + "</td>" +
            "<td>" + (customer.customerGender || '') + "</td>" +
            "<td>" + (customer.dob || '') + "</td>" +
			"<td>" + (customer.branchName || '') + "</td>" +
            "<td>" + (customer.contactNo || '') + "</td>" +
			"<td>" + (customer.nomineeName || '') + "</td>" +
            "<td>" + (customer.customerAddress || '') + "</td>" +
            "</tr>";

        tbody.append(row);
    });
}
