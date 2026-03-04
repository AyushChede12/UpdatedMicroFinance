$(document).ready(function () {

    // ==============================
    // Load Branch Dropdown
    // ==============================
    $.ajax({
        url: "api/datacorrection/fetchAllApprovedLoanApplications",
        type: "GET",
        success: function (response) {
            if (response.status === "OK") {

                const uniqueBranches = new Set();
                response.data.forEach(item => {
                    if (item.branchName) {
                        uniqueBranches.add(item.branchName.trim());
                    }
                });

                $("#branchName1").empty();
                $("#branchName1").append("<option value=''>-- Select Branch Name --</option>");

                uniqueBranches.forEach(branchName => {
                    $("#branchName1").append(
                        `<option value="${branchName}">${branchName}</option>`
                    );
                });

            } else {
                alert("Error: " + response.message);
            }
        },
        error: function (xhr) {
            console.error("Error loading branches:", xhr.responseText);
            alert("Failed to load dropdown data.");
        }
    });


    // ==============================
    // Load Loan Plan Dropdown
    // ==============================
    $.ajax({
        url: "api/datacorrection/fetchAllApprovedLoanApplications",
        type: "GET",
        success: function (response) {
            if (response.status === "OK") {

                const uniquePlans = new Set();
                response.data.forEach(item => {
                    if (item.loanPlanName) {
                        uniquePlans.add(item.loanPlanName.trim());
                    }
                });

                $("#loanPlanName").empty();
                $("#loanPlanName").append("<option value=''>-- Select Loan Name --</option>");

                uniquePlans.forEach(planName => {
                    $("#loanPlanName").append(
                        `<option value="${planName}">${planName}</option>`
                    );
                });

            } else {
                alert("Error: " + response.message);
            }
        }
    });


    // ==============================
    // Load Data On Page Load
    // ==============================
    loadApprovedLoanApplications();


    // ==============================
    // Find Button Click
    // ==============================
    $('#findBtn').click(function (e) {
        e.preventDefault();

        let branch = $('#branchName1').val();
        let policy = $('#loanPlanName').val();
        let financialCode = $('#financialCode').val().trim().toUpperCase();
        let toDate = $('#toDate').val();

        loadApprovedLoanApplications(branch, policy, financialCode, toDate);
    });

});


// =============================================
// Fetch & Filter Data
// =============================================
function loadApprovedLoanApplications(branch = '', policy = '', financialCode = '', toDate = '') {

    $.ajax({
        url: 'api/datacorrection/fetchAllApprovedLoanApplications',
        method: 'GET',
        dataType: 'json',
        success: function (response) {

            if (response && response.data) {

                let loans = response.data;

                // Filters
                if (branch) {
                    loans = loans.filter(item => item.branchName === branch);
                }

                if (policy) {
                    loans = loans.filter(item => item.loanPlanName === policy);
                }

                if (financialCode) {
                    loans = loans.filter(item =>
                        item.financialConsultantId &&
                        item.financialConsultantId.toUpperCase().includes(financialCode)
                    );
                }

                if (toDate) {
                    loans = loans.filter(item => {
                        let loanDate = parseDate(item.loanDate);
                        let tDate = parseDate(toDate);
                        return loanDate <= tDate;
                    });
                }

                bindLoanTable(loans);

            } else {
                bindLoanTable([]);
            }
        },
        error: function () {
            $('table tbody').html(
                `<tr><td colspan="15" class="text-center text-danger">Error fetching data.</td></tr>`
            );
        }
    });
}


// =============================================
// Bind Data To Table
// =============================================
function bindLoanTable(data) {

    let tbody = $('.datatable tbody');
    tbody.empty();

    if (!data || data.length === 0) {
        tbody.append(`<tr><td colspan="15" class="text-center text-danger">No Records Found</td></tr>`);
        return;
    }

    let sn = 1;

    data.forEach(item => {

        let loanAmount = parseFloat(item.loanAmount || 0);
        let roi = parseFloat(item.rateOfInterest || 0);
        let loanTerm = parseInt(item.loanTerm || 1);

        let monthlyInterest = (loanAmount * roi / 100) / loanTerm;
        let installmentAmount = (loanAmount / loanTerm) + monthlyInterest;

        let totalInstallments = loanTerm;
        let paidInstallments = (item.paymentStatus === "Paid")
            ? totalInstallments
            : Math.floor(totalInstallments / 2);

        let pendingInstallments = totalInstallments - paidInstallments;
        let outstandingBalance = pendingInstallments * installmentAmount;

        let lastPaymentDate = item.paymentDate || "-";

        let row = `
            <tr>
                <td>${sn++}</td>
                <td>${item.loanId || ''}</td>
                <td>${item.branchName || ''}</td>
                <td>${item.memberName || ''}</td>
                <td>${item.financialConsultantId || ''}</td>
                <td>${loanAmount.toFixed(2)}</td>
                <td>${installmentAmount.toFixed(2)}</td>
                <td>${totalInstallments}</td>
                <td>${paidInstallments}</td>
                <td>${pendingInstallments}</td>
                <td>${outstandingBalance.toFixed(2)}</td>
                <td>${lastPaymentDate}</td>
                <td>${item.loanStatus || ''}</td>
                <td>${item.remarks || ''}</td>
                <td><button class="btn btn-sm btn-primary printBtn">Print</button></td>
            </tr>
        `;

        tbody.append(row);
    });
}


// =============================================
// PRINT BUTTON (Working Properly)
// =============================================
$(document).on("click", ".printBtn", function () {

    let row = $(this).closest("tr");

    let printContents = `
        <html>
        <head>
            <title>Loan Installment Pending Report</title>
            <style>
                body { font-family: Arial; padding: 20px; }
                table { width: 100%; border-collapse: collapse; }
                th, td { border: 1px solid #000; padding: 8px; text-align: left; }
                h2 { text-align: center; }
            </style>
        </head>
        <body>
            <h2>Loan Installment Pending Report</h2>
            <table>
                <tr><th>Loan ID</th><td>${row.find("td:eq(1)").text()}</td></tr>
                <tr><th>Branch</th><td>${row.find("td:eq(2)").text()}</td></tr>
                <tr><th>Customer</th><td>${row.find("td:eq(3)").text()}</td></tr>
                <tr><th>Financial Code</th><td>${row.find("td:eq(4)").text()}</td></tr>
                <tr><th>Loan Amount</th><td>${row.find("td:eq(5)").text()}</td></tr>
                <tr><th>Installment Amount</th><td>${row.find("td:eq(6)").text()}</td></tr>
                <tr><th>Pending Installments</th><td>${row.find("td:eq(9)").text()}</td></tr>
                <tr><th>Outstanding Balance</th><td>${row.find("td:eq(10)").text()}</td></tr>
            </table>
        </body>
        </html>
    `;

    let printWindow = window.open('', '', 'width=800,height=600');
    printWindow.document.write(printContents);
    printWindow.document.close();
    printWindow.focus();
    printWindow.print();
    printWindow.close();
});


// =============================================
// Date Parser
// =============================================
function parseDate(dateStr) {
    if (!dateStr) return new Date(0);
    let parts = dateStr.split('-');
    return new Date(parts[0], parts[1] - 1, parts[2]);
}