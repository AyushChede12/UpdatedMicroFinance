/**
 * Customer ShareHolding - Regenerate DNO (Distinctive Numbers)
 */

$(document).ready(function () {
    loadDnoCustomerDropdown();
    loadDnoRecords("");

    // Search button
    $("#searchBtn").on("click", function () {
        const selectedCode = $("#selectDecisionMaker").val();
        loadDnoRecords(selectedCode);
    });

    // Print button
    $("#printbtn").on("click", function (e) {
        e.preventDefault();
        const printContent = $("#dnoPrintSection").clone();

        const printWindow = window.open("", "_blank");
        if (printWindow) {
            printWindow.document.open();
            printWindow.document.write(`
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Customer Shareholding - Distinctive Number (DNO) Report</title>
                    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
                    <style>
                        body { font-family: 'Segoe UI', Arial, sans-serif; padding: 30px; }
                        h3, h5 { text-align: center; }
                        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
                        th, td { border: 1px solid #dee2e6; padding: 8px; text-align: left; }
                        th { background-color: #f8f9fa; }
                    </style>
                </head>
                <body onload="window.print();">
                    <h3>MICROFINANCE PVT. LTD.</h3>
                    <h5>Customer Share Distinctive Numbers (DNO) Report</h5>
                    <hr/>
                    ${printContent[0].outerHTML}
                </body>
                </html>
            `);
            printWindow.document.close();
        } else {
            alert("Popup blocked. Please allow popups for this site.");
        }
    });
});

function loadDnoCustomerDropdown() {
    $.ajax({
        url: "api/customershareholdingcontroller/getAllTransferShare",
        type: "GET",
        success: function (response) {
            const dropdown = $("#selectDecisionMaker");
            dropdown.empty().append('<option value="">-- ALL CUSTOMERS --</option>');

            if ((response.status === "OK" || response.status === "FOUND") && response.data) {
                const uniqueCodes = new Set();
                $.each(response.data, function (i, item) {
                    if (item.findByCode && !uniqueCodes.has(item.findByCode)) {
                        uniqueCodes.add(item.findByCode);
                        dropdown.append(`<option value="${item.findByCode}">${item.findByCode} - ${item.customerName || ''}</option>`);
                    }
                });
            }
        },
        error: function () {
            console.error("Error loading DNO customer dropdown");
        }
    });
}

function loadDnoRecords(customerCode) {
    const tbody = $("#dnoTableBody");
    tbody.html('<tr><td colspan="8" class="text-center py-3">Loading DNO records...</td></tr>');

    const url = customerCode 
        ? "api/customershareholdingcontroller/fetchByFindByCode"
        : "api/customershareholdingcontroller/getAllTransferShare";

    const ajaxOptions = {
        type: customerCode ? "POST" : "GET",
        url: url,
        success: function (response) {
            tbody.empty();
            const list = response.data || [];

            if (list.length > 0) {
                let cumulativeShares = 0;
                $.each(list, function (index, item) {
                    const shares = parseInt(item.noOfShare) || 1;
                    const fromDno = cumulativeShares + 1;
                    const toDno = cumulativeShares + shares;
                    cumulativeShares = toDno;

                    const dnoRange = `DNO-${fromDno.toString().padStart(6, '0')} TO DNO-${toDno.toString().padStart(6, '0')}`;

                    const row = `
                        <tr>
                            <td>${index + 1}</td>
                            <td>${item.findByCode || ''}</td>
                            <td>${item.customerName || ''}</td>
                            <td>${item.dateOfTransfer || item.startDate || ''}</td>
                            <td>${item.noOfShare || '0'}</td>
                            <td>${item.amountTransferred || item.balanceShares || '0.00'}</td>
                            <td>${item.certificateNo || 'N/A'}</td>
                            <td><span class="badge bg-light text-dark border">${dnoRange}</span></td>
                        </tr>
                    `;
                    tbody.append(row);
                });
            } else {
                tbody.html('<tr><td colspan="8" class="text-center py-3">No share records found for DNO generation</td></tr>');
            }
        },
        error: function () {
            tbody.html('<tr><td colspan="8" class="text-center text-danger">Error fetching share records</td></tr>');
        }
    };

    if (customerCode) {
        ajaxOptions.data = { findByCode: customerCode };
    }

    $.ajax(ajaxOptions);
}
