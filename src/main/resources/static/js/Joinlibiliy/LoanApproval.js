/**
 * LoanApproval.js
 * Handles Joint Liability / Group Loan Approval & Appraisal workflow.
 * Connects directly to GroupLoanApplication entities and updates approval status,
 * remarks, approval date, and displays member-level disbursements.
 */

const getBasePath = function() {
    return (typeof globalContextPath !== 'undefined' && globalContextPath) ? globalContextPath : '';
};

let currentApplicationDetails = null;

$(document).ready(function() {
    initPage();
    bindEvents();
});

function initPage() {
    const today = new Date().toISOString().split('T')[0];
    $('#approvalDate').val(today);
    loadDropdown();
    loadApplicationsList();
}

function bindEvents() {
    // Dropdown selection change
    $('#selectApplication').on('change', function() {
        const val = $(this).val();
        if (val) {
            loadApplicationDetails(val);
        } else {
            clearForm();
        }
    });

    // Refresh directory button
    $('#refreshListBtn').on('click', function() {
        loadDropdown($('#selectApplication').val());
        loadApplicationsList();
    });

    // Approve Button click
    $('#approveBtn').on('click', function() {
        handleAction('APPROVE');
    });

    // Reject Button click
    $('#rejectBtn').on('click', function() {
        handleAction('REJECT');
    });
}

function loadDropdown(preselectIdentifier) {
    $.ajax({
        url: getBasePath() + '/api/grouploans/approvals/list',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            const dropdown = $('#selectApplication');
            dropdown.empty();
            dropdown.append('<option value="">-- SELECT APPLICATION OR GROUP --</option>');

            if (response && response.status === 'OK' && response.data && response.data.length > 0) {
                $.each(response.data, function(index, item) {
                    const opt = $('<option>', {
                        value: item.applicationNo,
                        text: item.displayName || (item.applicationNo + ' - ' + item.groupCode)
                    });
                    if (preselectIdentifier && (item.applicationNo === preselectIdentifier || item.groupCode === preselectIdentifier)) {
                        opt.prop('selected', true);
                    }
                    dropdown.append(opt);
                });
            } else {
                dropdown.append('<option value="">No applications found</option>');
            }
        },
        error: function(xhr) {
            console.error('Failed to load applications dropdown:', xhr.responseText);
        }
    });
}

function loadApplicationDetails(identifier) {
    if (!identifier) return;

    // Show loading indicator in status badge
    $('#statusBadge').removeClass('bg-secondary bg-success bg-danger bg-warning text-dark')
                     .addClass('bg-secondary text-white').text('LOADING...');

    $.ajax({
        url: getBasePath() + '/api/grouploans/approvals/details/' + encodeURIComponent(identifier),
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            if (response && response.status === 'OK' && response.data) {
                populateForm(response.data);
            } else {
                alert('Could not fetch details: ' + (response.message || 'Unknown response'));
                clearForm();
            }
        },
        error: function(xhr) {
            console.error('Error fetching application details:', xhr.responseText);
            alert('Failed to load application details.');
            clearForm();
        }
    });
}

function populateForm(data) {
    currentApplicationDetails = data;

    // Select dropdown matching
    $('#selectApplication').val(data.applicationNo);

    // Profile & Info
    $('#applicationNo').val(data.applicationNo || '');
    $('#groupCode').val(data.groupCode || '');
    $('#openingDate').val(data.openingDate || '');
    $('#communityName').val(data.communityName || '');
    $('#communityLeader').val(data.communityLeader || '');
    $('#leaderContactNumber').val(data.leaderContactNumber || '');
    $('#allocatedStaff').val(data.allocatedStaff || '');
    $('#leaderAddress').val(data.leaderAddress || '');
    $('#purposeOfLoan').val(data.purposeOfLoan || '');

    // Terms
    $('#loanAmount').val(data.loanAmount ? parseFloat(data.loanAmount).toFixed(2) : '0.00');
    $('#term').val(data.term || '0');
    $('#rateOfInterest').val(data.rateOfInterest ? parseFloat(data.rateOfInterest).toFixed(2) + '%' : '0.00%');
    $('#interestType').val(data.interestType || '');
    $('#emiFrequency').val(data.emiFrequency || '');
    $('#interestOnLoan').val(data.interestOnLoan ? parseFloat(data.interestOnLoan).toFixed(2) : '0.00');
    $('#totalAmountToPay').val(data.totalAmountToPay ? parseFloat(data.totalAmountToPay).toFixed(2) : '0.00');
    $('#emiAmount').val(data.emiAmount ? parseFloat(data.emiAmount).toFixed(2) : '0.00');
    $('#firstEmiDate').val(data.firstEmiDate || '');
    $('#totalDeduction').val(data.totalDeduction ? parseFloat(data.totalDeduction).toFixed(2) : '0.00');
    $('#netDisbursement').val(data.netDisbursement ? parseFloat(data.netDisbursement).toFixed(2) : '0.00');

    // Status Badge
    const status = (data.status || 'PENDING').toUpperCase();
    const badge = $('#statusBadge').removeClass('bg-secondary bg-success bg-danger bg-warning text-dark text-white');

    if (status === 'APPROVED') {
        badge.addClass('bg-success text-white').html('<i class="bi bi-check-circle-fill me-1"></i> APPROVED');
    } else if (status === 'REJECTED') {
        badge.addClass('bg-danger text-white').html('<i class="bi bi-x-circle-fill me-1"></i> REJECTED');
    } else {
        badge.addClass('bg-warning text-dark').html('<i class="bi bi-clock-history me-1"></i> PENDING REVIEW');
    }

    // Approval details
    if (data.approvalDate) {
        $('#approvalDate').val(data.approvalDate);
    } else {
        const today = new Date().toISOString().split('T')[0];
        $('#approvalDate').val(today);
    }

    $('#approvalRemarks').val(data.approvalRemarks || '');

    // Buttons control
    if (status === 'APPROVED') {
        $('#approveBtn').prop('disabled', true).html('<i class="bi bi-check-all me-1"></i> ALREADY APPROVED');
        $('#rejectBtn').prop('disabled', true);
        $('#approvalRemarks').prop('readonly', true);
    } else if (status === 'REJECTED') {
        $('#approveBtn').prop('disabled', true);
        $('#rejectBtn').prop('disabled', true).html('<i class="bi bi-x-circle me-1"></i> ALREADY REJECTED');
        $('#approvalRemarks').prop('readonly', true);
    } else {
        $('#approveBtn').prop('disabled', false).html('<i class="bi bi-check-circle-fill me-1"></i> APPROVE GROUP LOAN');
        $('#rejectBtn').prop('disabled', false).html('<i class="bi bi-x-circle me-1"></i> REJECT APPLICATION');
        $('#approvalRemarks').prop('readonly', false);
    }

    // Member table
    renderMemberTable(data.members || []);
}

function renderMemberTable(members) {
    const tbody = $('#memberTableBody').empty();
    let totalLoan = 0;
    let totalNet = 0;

    if (members && members.length > 0) {
        $.each(members, function(index, m) {
            const loanAmt = parseFloat(m.individualLoanAmount) || 0;
            const netAmt = parseFloat(m.netDisbursementAmount) || 0;

            totalLoan += loanAmt;
            totalNet += netAmt;

            const tr = $('<tr>');
            tr.append($('<td>').html('<strong>' + (m.memberCode || '') + '</strong>'));
            tr.append($('<td>').text(m.memberName || ''));
            tr.append($('<td>').text('₹' + loanAmt.toFixed(2)));
            tr.append($('<td>').html('<span class="fw-bold text-success">₹' + netAmt.toFixed(2) + '</span>'));
            tbody.append(tr);
        });

        $('#totalMemberLoan').text('₹' + totalLoan.toFixed(2));
        $('#totalMemberNetDisb').text('₹' + totalNet.toFixed(2));
        $('#memberTableFoot').show();
    } else {
        tbody.html('<tr><td colspan="4" class="text-center text-muted py-3">No members recorded for this loan.</td></tr>');
        $('#memberTableFoot').hide();
    }
}

function clearForm() {
    currentApplicationDetails = null;
    $('#selectApplication').val('');
    $('#approvalForm')[0].reset();
    $('#statusBadge').removeClass('bg-success bg-danger bg-warning text-dark text-white')
                     .addClass('bg-secondary text-white').text('NONE SELECTED');
    $('#approveBtn').prop('disabled', true).html('<i class="bi bi-check-circle-fill me-1"></i> APPROVE GROUP LOAN');
    $('#rejectBtn').prop('disabled', true).html('<i class="bi bi-x-circle me-1"></i> REJECT APPLICATION');
    $('#memberTableBody').html('<tr><td colspan="4" class="text-center text-muted py-3">Select an application to view member breakdown</td></tr>');
    $('#memberTableFoot').hide();
    const today = new Date().toISOString().split('T')[0];
    $('#approvalDate').val(today);
}

function handleAction(action) {
    if (!currentApplicationDetails) {
        alert('Please select a group loan application first.');
        return;
    }

    const appNo = currentApplicationDetails.applicationNo;
    const groupCode = currentApplicationDetails.groupCode;
    const approvalDate = $('#approvalDate').val();
    const remarks = $('#approvalRemarks').val().trim();

    if (!approvalDate) {
        alert('Please specify the Date of Approval.');
        $('#approvalDate').focus();
        return;
    }

    const confirmMsg = action === 'APPROVE'
        ? 'Are you sure you want to APPROVE group loan application ' + appNo + ' for group ' + groupCode + '?'
        : 'Are you sure you want to REJECT group loan application ' + appNo + ' for group ' + groupCode + '?';

    if (!confirm(confirmMsg)) {
        return;
    }

    const payload = {
        applicationNo: appNo,
        groupCode: groupCode,
        action: action,
        approvalDate: approvalDate,
        remarks: remarks
    };

    const targetBtn = action === 'APPROVE' ? $('#approveBtn') : $('#rejectBtn');
    const originalText = targetBtn.html();
    targetBtn.prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-1"></span> Processing...');

    $.ajax({
        url: getBasePath() + '/api/grouploans/approvals/process',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(payload),
        success: function(response) {
            targetBtn.prop('disabled', false).html(originalText);
            if (response && response.status === 'OK') {
                alert('SUCCESS: Group Loan Application ' + appNo + ' has been ' + action + 'D successfully!');
                location.reload();
            } else {
                alert('Response: ' + (response.message || 'Action executed.'));
            }
        },
        error: function(xhr) {
            targetBtn.prop('disabled', false).html(originalText);
            let errMsg = 'Failed to process ' + action;
            try {
                const res = JSON.parse(xhr.responseText);
                if (res.message) errMsg = res.message;
            } catch (e) {
                if (xhr.responseText) errMsg = xhr.responseText;
            }
            alert('ERROR: ' + errMsg);
        }
    });
}

function loadApplicationsList() {
    $.ajax({
        url: getBasePath() + '/api/grouploans',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            const tbody = $('#applicationsListBody').empty();
            const data = (response && response.data) ? response.data : response;

            if (data && data.length > 0) {
                $.each(data, function(index, item) {
                    const tr = $('<tr>');
                    tr.append($('<td>').html('<strong>' + (item.applicationNo || '') + '</strong>'));
                    tr.append($('<td>').text(item.groupCode || ''));
                    tr.append($('<td>').text(item.communityName || '—'));
                    tr.append($('<td>').text(item.loanAmount ? '₹' + parseFloat(item.loanAmount).toFixed(2) : '₹0.00'));
                    tr.append($('<td>').text(item.openingDate || ''));

                    const st = (item.status || 'PENDING').toUpperCase();
                    let badgeClass = 'bg-warning text-dark';
                    if (st === 'APPROVED') badgeClass = 'bg-success text-white';
                    else if (st === 'REJECTED') badgeClass = 'bg-danger text-white';

                    tr.append($('<td>').html('<span class="badge ' + badgeClass + '">' + st + '</span>'));

                    const reviewBtn = $('<button>', {
                        type: 'button',
                        class: 'btn btn-sm btn-outline-primary fw-bold',
                        html: '<i class="bi bi-eye me-1"></i> Review',
                        click: function() {
                            $('#selectApplication').val(item.applicationNo);
                            loadApplicationDetails(item.applicationNo);
                            $('html, body').animate({ scrollTop: 0 }, 'fast');
                        }
                    });

                    tr.append($('<td>').append(reviewBtn));
                    tbody.append(tr);
                });
            } else {
                tbody.html('<tr><td colspan="7" class="text-center text-muted py-3">No applications found in directory.</td></tr>');
            }
        },
        error: function(xhr) {
            console.error('Error loading applications directory:', xhr.responseText);
            $('#applicationsListBody').html('<tr><td colspan="7" class="text-center text-danger py-3">Failed to load directory.</td></tr>');
        }
    });
}