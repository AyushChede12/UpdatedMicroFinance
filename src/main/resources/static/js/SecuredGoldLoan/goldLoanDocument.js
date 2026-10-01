// Gold Loan Document Print & Generation Management Script (Full End-to-End Implementation)

$(document).ready(function() {
    initGoldLoanIdDropdown();
    initEventHandlers();
});

function initGoldLoanIdDropdown() {
    $.ajax({
        url: "api/gold-loans/printable-loan-ids",
        type: "GET",
        dataType: "json",
        success: function(response) {
            if (response && response.data && Array.isArray(response.data) && response.data.length > 0) {
                const $dropdown = $("#findByGoldLoanId");
                $dropdown.empty();
                $dropdown.append('<option value="" disabled selected>-- SEARCH GOLD ID / CLIENT NAME --</option>');

                let options = [];
                response.data.forEach(function(item) {
                    if (typeof item === 'object' && item !== null) {
                        let goldId = (item.goldID || item.goldId || item.id || "").trim();
                        let clientName = (item.customerName || item.clientName || "").trim();
                        if (goldId) {
                            let text = goldId + (clientName ? " - " + clientName.toUpperCase() : "");
                            options.push({ id: goldId, text: text });
                        }
                    } else if (typeof item === 'string' && item.trim() !== "") {
                        options.push({ id: item.trim(), text: item.trim() });
                    }
                });

                initSelect2Dropdown(options);
            } else {
                fallbackLoadGoldLoans();
            }
        },
        error: function(xhr) {
            console.warn("Could not load printable gold loan IDs from new API, trying fallback...", xhr);
            fallbackLoadGoldLoans();
        }
    });
}

function fallbackLoadGoldLoans() {
    $.ajax({
        url: "api/securedGoldLoan/getAllGoldLoanCustomer",
        type: "GET",
        dataType: "json",
        success: function(response) {
            if (response && response.data && Array.isArray(response.data)) {
                let distinctMap = new Map();
                response.data.forEach(function(item) {
                    let goldId = item.goldID || item.goldId;
                    if (goldId && goldId.trim() !== "") {
                        let cName = (item.customerName || item.clientName || "").toUpperCase();
                        distinctMap.set(goldId.trim(), cName);
                    }
                });

                let options = [];
                distinctMap.forEach(function(customerName, goldId) {
                    options.push({
                        id: goldId,
                        text: goldId + (customerName ? " - " + customerName : "")
                    });
                });

                initSelect2Dropdown(options);
            }
        },
        error: function(xhr) {
            console.error("Failed to load Gold Loan IDs in fallback:", xhr);
        }
    });
}

function initSelect2Dropdown(dataOptions) {
    const $dropdown = $('#findByGoldLoanId');
    $dropdown.empty().append('<option value="" disabled selected>-- Search Gold ID or Client Name --</option>');

    $dropdown.select2({
        placeholder: '-- Search Gold ID or Client Name --',
        data: dataOptions,
        matcher: function(params, data) {
            if ($.trim(params.term) === '') return data;
            if (typeof data.text === 'undefined') return null;

            const term = params.term.toLowerCase();
            const text = data.text.toLowerCase();
            return text.includes(term) ? data : null;
        }
    });
}

function initEventHandlers() {
    // 1. On Gold Loan ID Selection
    $("#findByGoldLoanId").on("change", function() {
        const selectedGoldId = $(this).val();
        if (!selectedGoldId) return;

        $("#previewDocBtn").prop("disabled", true);
        $("#generateDocBtn").prop("disabled", true);
        $("#loanDocument").prop("disabled", true).html('<option value="" disabled selected>Loading available documents...</option>');
        $("#docTypeError").hide();

        loadGoldLoanDetails(selectedGoldId);
        loadAvailableDocuments(selectedGoldId);
        loadDocumentLogs(selectedGoldId);
    });

    // 2. On Document Type Selection
    $("#loanDocument").on("change", function() {
        const docType = $(this).val();
        if (docType) {
            $("#docTypeError").hide();
            $("#previewDocBtn").prop("disabled", false);
            $("#generateDocBtn").prop("disabled", false);
        } else {
            $("#previewDocBtn").prop("disabled", true);
            $("#generateDocBtn").prop("disabled", true);
        }
    });

    // 3. On Preview Button Click
    $("#previewDocBtn").on("click", function(e) {
        e.preventDefault();
        const goldId = $("#findByGoldLoanId").val();
        const docType = $("#loanDocument").val();

        if (!goldId) {
            alert("Please select a Gold Loan ID first.");
            return;
        }
        if (!docType) {
            $("#docTypeError").show();
            alert("Please select a Document Type to preview.");
            return;
        }

        openDocumentPreview(goldId, docType);
    });

    // 4. On Generate Doc Button Click (Main, Modal, and legacy button)
    $("#generateDocBtn, #modalGenerateBtn, #generateDoc").on("click", function(e) {
        e.preventDefault();
        const goldId = $("#findByGoldLoanId").val();
        const docType = $("#loanDocument").val();

        if (!goldId) {
            alert("Please select a Gold Loan ID first.");
            return;
        }
        if (!docType) {
            $("#docTypeError").show();
            alert("Please select a Document Type to generate.");
            return;
        }

        generateAndDownloadPdf(goldId, docType);
    });

    // 5. On Modal Print Preview Click
    $("#modalPrintBtn").on("click", function(e) {
        e.preventDefault();
        printDocument();
    });

    // 6. Reset Button
    $("#resetBtn").on("click", function(e) {
        e.preventDefault();
        $("#formid")[0].reset();
        $("#findByGoldLoanId").val("").trigger("change.select2");
        $("#loanDocument").prop("disabled", true).html('<option value="" disabled selected>-- Select Gold ID First --</option>');
        $("#previewDocBtn").prop("disabled", true);
        $("#generateDocBtn").prop("disabled", true);
        $("#ornamentsCard").hide();
        $("#ornamentsBody").empty();
        $("#docLogsBody").html('<tr><td colspan="6" class="text-center py-4 text-muted">Please select a Gold Loan ID to view generated document history.</td></tr>');
        $("#auditCountBadge").text("0 Documents");
        $("#receiptArea").empty();
    });
}

function loadGoldLoanDetails(goldId) {
    $.ajax({
        url: "api/gold-loans/" + encodeURIComponent(goldId) + "/details",
        type: "GET",
        dataType: "json",
        success: function(response) {
            if (response && response.data) {
                const d = response.data;
                $("#loanDate").val(d.loanDate || "--");
                $("#customerCode").val(d.memberCode || "--");
                $("#customerName").val(d.customerName || d.clientName || "--");
                $("#contactNo").val(d.contactNo || "--");
                $("#loanPlanName").val(d.loanPlanName || "--");
                $("#loanAmount").val(d.loanAmount ? formatCurrency(d.loanAmount) : "--");
                $("#rateOfInterest").val(d.rateOfInterest ? d.rateOfInterest + "% p.a." : "--");
                $("#loanTerm").val(d.loanTerm ? d.loanTerm + " Months" : "--");
                $("#interestType").val(d.interestType || "--");
                $("#loanMode").val(d.loanMode || "--");
                $("#emiPayment").val(d.emiPayment ? formatCurrency(d.emiPayment) : "--");
                $("#goldLoanStatus").val(d.loanStatus || "--");
                $("#netDisbursement").val(d.netDisbursementAmount ? formatCurrency(d.netDisbursementAmount) : "--");
                $("#totalDeductions").val(d.totalDeductions ? formatCurrency(d.totalDeductions) : "--");
                $("#totalInterest").val(d.totalInterest ? formatCurrency(d.totalInterest) : "--");
                $("#totalPayableAmount").val(d.totalPayableAmount ? formatCurrency(d.totalPayableAmount) : "--");
                $("#totalNetWt").val(d.totalNetWt ? d.totalNetWt + " g" : "--");
                $("#marketValuation").val(d.totalMarketValuation ? formatCurrency(d.totalMarketValuation) : "--");
                $("#itemName").val(d.itemName || "--");

                let gInfo = "--";
                if (d.guarantorIdentity) {
                    gInfo = d.guarantorIdentity + (d.guarantorCustomerCode ? " (" + d.guarantorCustomerCode + ")" : "");
                } else if (d.coApplicantIdentity) {
                    gInfo = "Co-App: " + d.coApplicantIdentity;
                }
                $("#guarantorName").val(gInfo);

                // Populate Ornaments Table
                renderOrnamentsTable(d);
            }
        },
        error: function(xhr) {
            console.error("Error fetching gold loan details:", xhr);
            // Fallback to legacy getByGoldIDforApproval
            fallbackLoadGoldDetails(goldId);
        }
    });
}

function fallbackLoadGoldDetails(goldId) {
    $.ajax({
        url: "api/securedGoldLoan/getByGoldIDforApproval",
        type: "POST",
        contentType: "application/json",
        data: JSON.stringify({ goldID: goldId }),
        success: function(response) {
            if (response.status === "OK" && response.data && response.data.length > 0) {
                const data = response.data[0];
                $("#loanDate").val(data.loanDate || "--");
                $("#customerCode").val(data.memberCode || "--");
                $("#customerName").val((data.customerName || data.clientName || "--").toUpperCase());
                $("#contactNo").val(data.contactNo || "--");
                $("#loanPlanName").val(data.loanPlanName || "--");
                $("#loanAmount").val(data.loanAmount ? formatCurrency(data.loanAmount) : "--");
                $("#rateOfInterest").val(data.rateOfInterest ? data.rateOfInterest + "%" : "--");
                $("#loanTerm").val(data.loanTerm ? data.loanTerm + " Months" : "--");
                $("#interestType").val(data.interestType || "--");
                $("#loanMode").val(data.loanMode || "--");
                $("#emiPayment").val(data.emiPayment ? formatCurrency(data.emiPayment) : "--");
                $("#goldLoanStatus").val(data.goldLoanStatus || (data.approvalStatus ? "APPROVED" : "PENDING"));
                $("#netDisbursement").val(data.netDisbursement ? formatCurrency(data.netDisbursement) : (data.loanAmount ? formatCurrency(data.loanAmount) : "--"));
                $("#totalDeductions").val(data.totalDeductions ? formatCurrency(data.totalDeductions) : "--");
                $("#totalInterest").val(data.totalInterest ? formatCurrency(data.totalInterest) : "--");
                $("#totalPayableAmount").val(data.totalPayableAmount ? formatCurrency(data.totalPayableAmount) : "--");
                $("#totalNetWt").val(data.netWt ? data.netWt + " g" : "--");
                $("#marketValuation").val(data.marketValuation ? formatCurrency(data.marketValuation) : "--");
                $("#itemName").val(data.itemName || "--");

                let gInfo = data.guarantorIdentity || data.coApplicantIdentity || "--";
                $("#guarantorName").val(gInfo);
            }
        }
    });
}

function renderOrnamentsTable(d) {
    const $card = $("#ornamentsCard");
    const $tbody = $("#ornamentsBody");
    $tbody.empty();

    if (d.items && Array.isArray(d.items) && d.items.length > 0) {
        $card.show();
        d.items.forEach(function(item, idx) {
            const row = `
                <tr>
                    <td class="text-center font-weight-bold text-muted">${idx + 1}</td>
                    <td><b>${item.itemName || 'Gold Ornament'}</b></td>
                    <td>${item.karat ? item.karat + 'K' : '22K'} (${item.itemType || 'Ornament'})</td>
                    <td class="text-right">${item.grossWt ? Number(item.grossWt).toFixed(3) : '0.000'}</td>
                    <td class="text-right font-weight-bold text-teal">${item.netWt ? Number(item.netWt).toFixed(3) : '0.000'}</td>
                    <td class="text-right">${item.custgoldRate ? formatCurrency(item.custgoldRate) : '--'}</td>
                    <td class="text-right font-weight-bold text-success">${item.marketValuation ? formatCurrency(item.marketValuation) : '--'}</td>
                </tr>
            `;
            $tbody.append(row);
        });

        // Totals Row
        const totalsRow = `
            <tr style="background-color: #f8fafc; font-weight: bold;">
                <td colspan="3" class="text-right">TOTAL:</td>
                <td class="text-right">${d.totalGrossWt || '0.000'} g</td>
                <td class="text-right text-teal" style="color: #0f766e;">${d.totalNetWt || '0.000'} g</td>
                <td></td>
                <td class="text-right text-success" style="color: #059669;">${d.totalMarketValuation ? formatCurrency(d.totalMarketValuation) : '₹ 0.00'}</td>
            </tr>
        `;
        $tbody.append(totalsRow);
    } else {
        $card.hide();
    }
}

function loadAvailableDocuments(goldId) {
    $.ajax({
        url: "api/gold-loans/" + encodeURIComponent(goldId) + "/available-documents",
        type: "GET",
        dataType: "json",
        success: function(response) {
            const $dropdown = $("#loanDocument");
            $dropdown.empty();
            $dropdown.append('<option value="" disabled selected>SELECT DOCUMENT TO PRINT</option>');

            if (response && response.data && Array.isArray(response.data)) {
                response.data.forEach(function(doc) {
                    if (doc.available) {
                        $dropdown.append(`<option value="${doc.docType}">✓ ${doc.name}</option>`);
                    } else {
                        $dropdown.append(`<option value="${doc.docType}" disabled style="color:#888;">✕ ${doc.name} (Gated: ${doc.reason})</option>`);
                    }
                });
                $dropdown.prop("disabled", false);
            }
        },
        error: function(xhr) {
            console.error("Error loading available documents:", xhr);
            $("#loanDocument").html('<option value="" disabled selected>Error loading documents</option>');
        }
    });
}

function loadDocumentLogs(goldId) {
    $.ajax({
        url: "api/gold-loans/" + encodeURIComponent(goldId) + "/document-logs",
        type: "GET",
        dataType: "json",
        success: function(response) {
            const $tbody = $("#docLogsBody");
            $tbody.empty();

            if (response && response.data && response.data.length > 0) {
                $("#auditCountBadge").text(response.data.length + " Documents");
                response.data.forEach(function(log, idx) {
                    const row = `
                        <tr>
                            <td class="ps-3 font-weight-bold text-muted">${idx + 1}</td>
                            <td><i class="bi bi-calendar3 mr-1 text-muted"></i> ${log.generatedAt || '--'}</td>
                            <td><span class="badge badge-light border text-primary">${log.documentName || log.documentType}</span></td>
                            <td><i class="bi bi-person mr-1 text-muted"></i> ${log.generatedByUserId || 'ADMIN'}</td>
                            <td><code>${log.fileReference || '--'}</code></td>
                            <td class="text-center">
                                <button type="button" class="btn btn-sm btn-outline-primary py-0 px-2" 
                                    onclick="generateAndDownloadPdf('${log.loanId}', '${log.documentType}')" title="Re-download PDF">
                                    <i class="bi bi-download mr-1"></i> Download
                                </button>
                            </td>
                        </tr>
                    `;
                    $tbody.append(row);
                });
            } else {
                $("#auditCountBadge").text("0 Documents");
                $tbody.html('<tr><td colspan="6" class="text-center py-4 text-muted">No documents have been generated yet for this Gold Loan.</td></tr>');
            }
        },
        error: function(xhr) {
            console.error("Error fetching document logs:", xhr);
        }
    });
}

function showModalCompat() {
    if (typeof $ !== 'undefined' && $('#docPreviewModal').modal) {
        $('#docPreviewModal').modal('show');
    } else if (window.bootstrap && bootstrap.Modal) {
        var m = bootstrap.Modal.getOrCreateInstance(document.getElementById('docPreviewModal'));
        m.show();
    } else {
        $('#docPreviewModal').show().addClass('show').css('display', 'block');
    }
}

function hideModalCompat() {
    if (typeof $ !== 'undefined' && $('#docPreviewModal').modal) {
        $('#docPreviewModal').modal('hide');
    } else if (window.bootstrap && bootstrap.Modal) {
        var m = bootstrap.Modal.getInstance(document.getElementById('docPreviewModal'));
        if (m) m.hide();
    } else {
        $('#docPreviewModal').hide().removeClass('show').css('display', 'none');
    }
}

function openDocumentPreview(goldId, docType) {
    const previewUrl = "api/gold-loans/" + encodeURIComponent(goldId) + "/documents/" + encodeURIComponent(docType) + "/preview";
    const $container = $("#previewContainer");

    $container.html(`
        <div class="text-center p-5">
            <div class="spinner-border text-teal" style="color: #0f766e; width: 2.5rem; height: 2.5rem;" role="status"></div>
            <p class="mt-3 text-muted">Rendering Gold Loan document preview...</p>
        </div>
    `);

    showModalCompat();

    $.ajax({
        url: previewUrl,
        type: "GET",
        dataType: "html",
        success: function(htmlContent) {
            $container.html(htmlContent);
            // Also update legacy container for print fallback
            $("#receiptArea").html(htmlContent);
            $("#generateDocBtn").prop("disabled", false);
        },
        error: function(xhr) {
            $container.html(`
                <div class="alert alert-danger m-4">
                    <h5 class="font-weight-bold"><i class="bi bi-exclamation-triangle-fill mr-2"></i> Preview Error</h5>
                    <p>${xhr.responseText || "Unable to render gold loan document preview."}</p>
                </div>
            `);
        }
    });
}

function generateAndDownloadPdf(goldId, docType) {
    const $btn = $("#generateDocBtn");
    const $spinner = $("#generateSpinner");
    const $icon = $("#generateIcon");

    $btn.prop("disabled", true);
    $spinner.removeClass("d-none");
    $icon.addClass("d-none");

    const generateUrl = "api/gold-loans/" + encodeURIComponent(goldId) + "/documents/" + encodeURIComponent(docType) + "/generate";

    fetch(generateUrl, {
        method: "POST"
    })
    .then(function(response) {
        if (!response.ok) {
            return response.text().then(function(text) {
                throw new Error(text || "Failed to generate gold loan document");
            });
        }
        return response.blob();
    })
    .then(function(blob) {
        const url = window.URL.createObjectURL(blob);
        const a = document.createElement("a");
        a.style.display = "none";
        a.href = url;
        a.download = docType + "_" + goldId + ".pdf";
        document.body.appendChild(a);
        a.click();
        window.URL.revokeObjectURL(url);
        a.remove();

        hideModalCompat();
        loadDocumentLogs(goldId);
        showToastAlert("Gold Loan PDF document generated and downloaded successfully!", "success");
    })
    .catch(function(err) {
        console.error("Gold Loan PDF generation failed:", err);
        alert("Error generating document: " + err.message);
    })
    .finally(function() {
        $spinner.addClass("d-none");
        $icon.removeClass("d-none");
        $btn.prop("disabled", false);
    });
}

function printDocument() {
    const previewContent = document.getElementById("previewContainer")?.innerHTML || document.getElementById("receiptArea")?.innerHTML;
    if (!previewContent || previewContent.trim() === "") {
        alert("Please preview a document first before printing.");
        return;
    }

    const printWindow = window.open("", "", "height=750,width=950");
    printWindow.document.write("<html><head><title>Print Gold Loan Document</title>");
    printWindow.document.write("<style>body{margin:20px; font-family:Arial,sans-serif;}</style>");
    printWindow.document.write("</head><body>");
    printWindow.document.write(previewContent);
    printWindow.document.write("</body></html>");
    printWindow.document.close();

    setTimeout(function() {
        printWindow.focus();
        printWindow.print();
    }, 250);
}

function formatCurrency(val) {
    if (!val) return '₹ 0.00';
    const num = Number(String(val).replace(/[^0-9.-]/g, "")) || 0;
    return '₹ ' + num.toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

function showToastAlert(msg, type) {
    const alertDiv = $(`
        <div class="alert alert-${type === 'success' ? 'success' : 'danger'} alert-dismissible fade show shadow position-fixed" 
             style="top: 20px; right: 20px; z-index: 99999; min-width: 320px;" role="alert">
            <i class="bi bi-check-circle-fill mr-2"></i> ${msg}
            <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                <span aria-hidden="true">&times;</span>
            </button>
        </div>
    `);
    $("body").append(alertDiv);
    setTimeout(function() {
        alertDiv.alert('close');
    }, 4000);
}