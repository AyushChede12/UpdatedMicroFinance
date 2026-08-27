/**
 * Customer ShareHolding - Generate Share Certificate
 */

$(document).ready(function () {
    loadReferralDropdown();

    // Handle dropdown change
    $('#referralCodeEntry').on('change', function () {
        const selectedCode = $(this).val();
        loadShareRecords(selectedCode);
    });

    // View Certificate button click
    $('#printCertificateBtn').on('click', function () {
        const selectedCheckbox = $('#shareholdingTableBody input[type="radio"]:checked, #shareholdingTableBody input[type="checkbox"]:checked');

        if (selectedCheckbox.length === 0) {
            alert("Please select a customer share row to view the certificate.");
            $('#certificateSection').hide();
            return;
        }

        // Get the selected row model
        const selectedRow = selectedCheckbox.closest('tr').data('model');
        if (!selectedRow) {
            alert("Unable to read share record details.");
            return;
        }

        // Fill certificate fields
        $('#customeridandName').text((selectedRow.findByCode || '') + " - " + (selectedRow.customerName || ''));
        $('#certificateno').text(selectedRow.certificateNo || 'SCF/SAMITHA_URBAN/' + new Date().getFullYear() + '/00000' + (selectedRow.id || '1'));
        $('#numberofshare').text(selectedRow.noOfShare || '0');
        $('#amounttransferred').text(selectedRow.amountTransferred || '0.00');
        $('#branchname').text(selectedRow.branch || 'N/A');
        $('#startdate').text(selectedRow.startDate || 'N/A');
        $('#balanceshare').text(selectedRow.balanceShares || selectedRow.noOfShare || '0');
        $('#shareissuedby').text(selectedRow.shareIssuedBy || 'BANK');
        $('#dataoftransfer').text(selectedRow.dateOfTransfer || 'N/A');
        $('#modeofpayement').text(selectedRow.modeOfPayment || 'CASH');

        $('#certificateSection').slideDown();

        // Smooth scroll to certificate
        $('html, body').animate({
            scrollTop: $("#certificateSection").offset().top - 50
        }, 500);
    });

    // Print Button
    $("#printBtn").on("click", function (e) {
        e.preventDefault();
        const $formClone = $("#cetificateId").clone();

        const printWindow = window.open("", "_blank");
        if (printWindow) {
            printWindow.document.open();
            printWindow.document.write(`
                <!DOCTYPE html>
                <html>
                <head>
                    <title>Share Certificate</title>
                    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
                    <style>
                        body { font-family: 'Segoe UI', Arial, sans-serif; padding: 40px; }
                        .card { border: 2px solid #28a745 !important; border-radius: 8px; }
                    </style>
                </head>
                <body onload="window.print();">
                    ${$formClone[0].outerHTML}
                </body>
                </html>
            `);
            printWindow.document.close();
        } else {
            alert("Popup blocked. Please allow popups for this site.");
        }
    });

    // Download Button
    $("#downloadBtn").on("click", function (e) {
        e.preventDefault();
        const certHtml = $("#cetificateId")[0].outerHTML;
        const fullHtml = `
            <!DOCTYPE html>
            <html>
            <head>
                <title>Share Certificate</title>
                <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css">
                <style>
                    body { font-family: 'Segoe UI', Arial, sans-serif; padding: 40px; }
                </style>
            </head>
            <body>
                ${certHtml}
            </body>
            </html>
        `;

        const blob = new Blob([fullHtml], { type: "text/html" });
        const link = document.createElement("a");
        link.href = URL.createObjectURL(blob);
        link.download = "Share_Certificate_" + ($("#certificateno").text().replace(/\//g, "_") || "Document") + ".html";
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
    });
});

// Load dropdown data
// Load dropdown data
function loadReferralDropdown() {
    $.ajax({
        url: "api/customershareholdingcontroller/getAllTransferShare",
        type: "GET",
        success: function (response) {
            const dropdown = $('#referralCodeEntry');
            dropdown.empty();
            dropdown.append('<option value="">-- ALL CUSTOMERS / SELECT --</option>');

            if ((response.status === "OK" || response.status === "FOUND") && response.data) {
                const seenCodes = new Set();
                $.each(response.data, function (index, item) {
                    if (item.findByCode && !seenCodes.has(item.findByCode)) {
                        seenCodes.add(item.findByCode);
                        dropdown.append('<option value="' + item.findByCode + '">' + item.findByCode + " - " + (item.customerName || '') + '</option>');
                    }
                });
            }
            // Load all by default
            loadShareRecords("");
        },
        error: function (error) {
            console.error("Dropdown Load Error:", error);
        }
    });
}

// Load share records
// Load share records
function loadShareRecords(selectedCode) {
    const tbody = $('#shareholdingTableBody');
    tbody.html('<tr><td colspan="7" class="text-center py-3">Loading share records...</td></tr>');

    const url = selectedCode 
        ? "api/customershareholdingcontroller/fetchByCertificateNo" 
        : "api/customershareholdingcontroller/getAllTransferShare";

    const ajaxOptions = {
        type: selectedCode ? "POST" : "GET",
        url: url,
        success: function (response) {
            tbody.empty();
            const list = response.data || [];

            if (list.length > 0) {
                $.each(list, function (index, share) {
                    const row = $(`
                        <tr>
                            <td><input type="radio" name="selectedShare" value="${share.id}" /></td>
                            <td>${index + 1}</td>
                            <td>${share.findByCode || ''}</td>
                            <td>${share.customerName || ''}</td>
                            <td>${share.amountTransferred || share.balanceShares || '0.00'}</td>
                            <td>${share.noOfShare || '0'}</td>
                            <td>${share.certificateNo || 'N/A'}</td>
                        </tr>
                    `);
                    row.data('model', share);
                    tbody.append(row);
                });
            } else {
                tbody.html('<tr><td colspan="7" class="text-center py-3">No share records found</td></tr>');
            }
        },
        error: function () {
            tbody.html('<tr><td colspan="7" class="text-center text-danger">Error fetching share records</td></tr>');
        }
    };

    if (selectedCode) {
        ajaxOptions.data = { findByCode: selectedCode };
    }

    $.ajax(ajaxOptions);
}
