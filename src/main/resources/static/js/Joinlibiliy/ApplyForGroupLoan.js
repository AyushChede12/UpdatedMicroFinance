/**
 * ApplyForGroupLoan.js
 * Reworked: Manual terms & deductions, real-time EMI, Interest, Total Repayment,
 * and automatic calculation of individual member loan amount, individual net disbursement (in hand), and individual EMI.
 */

// Single constant: defines whether GST applies to total fees or processing fee only
const GST_APPLIES_TO_TOTAL_FEES = true;

const getBasePath = function() {
    return (typeof globalContextPath !== 'undefined' && globalContextPath) ? globalContextPath : '';
};

let userHasManuallyEditedMembers = false;

$(document).ready(function() {
    initForm();
    loadGroupDropdown();
    loadApplicationsTable();
    bindEvents();
});

function initForm() {
    const today = new Date().toISOString().split('T')[0];
    $('#openingDate').val(today);
    calculateLoanTerms();
    calculateDeductions();
}

function loadGroupDropdown() {
    $.ajax({
        url: getBasePath() + '/api/groups',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            const dropdown = $('#groupCode');
            dropdown.empty();
            dropdown.append('<option value="">SELECT GROUP</option>');

            if (response && response.status === 'OK' && response.data && response.data.length > 0) {
                $.each(response.data, function(index, item) {
                    dropdown.append(
                        $('<option>', {
                            value: item.groupCode,
                            text: item.displayName
                        })
                    );
                });
            } else {
                dropdown.append('<option value="">No groups available</option>');
            }
        },
        error: function(xhr) {
            console.error('Failed to fetch groups:', xhr.responseText);
        }
    });
}

function bindEvents() {
    // Group Code Change: fetch profile via GET /api/groups/{groupCode}
    $('#groupCode').on('change', function() {
        const groupCode = $(this).val();
        if (groupCode) {
            fetchGroupProfile(groupCode);
        } else {
            clearGroupProfile();
        }
    });

    // Opening Date change updates First EMI Date
    $('#openingDate').on('change', function() {
        updateFirstEmiDate();
    });

    // Loan Amount input: recalculate terms, deductions, and auto-distribute to members
    $('#loanAmount').on('input change keyup', function() {
        calculateLoanTerms();
        calculateDeductions();
        if (!userHasManuallyEditedMembers) {
            autoDistributeToMembers(false);
        } else {
            updateMemberCalculations();
        }
    });

    // Other Loan Terms inputs triggering EMI, Interest, and Member EMI recalculation
    $('#term, #rateOfInterest, #interestType, #emiFrequency').on('input change keyup', function() {
        calculateLoanTerms();
        updateMemberCalculations();
    });

    // Financial Deductions inputs triggering Deductions & individual net disbursements recalculation
    $('.deduction-calc').on('input change keyup', function() {
        calculateDeductions();
        updateMemberCalculations();
    });

    // Member table input changes
    $('#memberAllocationBody').on('input change keyup', '.member-amount', function() {
        userHasManuallyEditedMembers = true;
        updateMemberCalculations();
    });

    // Auto-split button: forces equal distribution across all members
    $('#autoSplitBtn').on('click', function() {
        userHasManuallyEditedMembers = false;
        autoDistributeToMembers(true);
    });

    // Reset button
    $('#resetBtn').on('click', function() {
        $('#groupLoanForm')[0].reset();
        userHasManuallyEditedMembers = false;
        initForm();
        clearGroupProfile();
    });

    // Form Submit
    $('#groupLoanForm').on('submit', function(e) {
        e.preventDefault();
        handleSubmit();
    });

    // Delete All Group Loans button
    $('#deleteAllBtn').on('click', function() {
        if (confirm('Are you sure you want to delete ALL group loan data? This action will permanently remove all group loan applications, member allocations, and records.')) {
            deleteAllGroupLoans();
        }
    });
}

function fetchGroupProfile(groupCode) {
    $.ajax({
        url: getBasePath() + '/api/groups/' + encodeURIComponent(groupCode),
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            console.log('Group profile received:', response);
            if (response && response.status === 'OK' && response.data) {
                const profile = response.data;
                $('#communityName').val(profile.communityName || '');
                $('#communityAddress').val(profile.communityAddress || '');
                $('#allocatedStaff').val(profile.allocatedStaff || '');
                $('#scheduledCollectionDay').val(profile.scheduledCollectionDay || '');
                $('#communityLeader').val(profile.communityLeader || '');
                $('#leaderContactNumber').val(profile.leaderContactNumber || '');
                $('#leaderAddress').val(profile.leaderAddress || '');

                updateFirstEmiDate();
                renderMemberAllocationTable(profile.members || []);
            } else {
                alert('No profile details found for group: ' + groupCode);
                clearGroupProfile();
            }
        },
        error: function(xhr) {
            console.error('Error fetching group profile:', xhr.responseText);
            alert('Failed to fetch details for group: ' + groupCode);
            clearGroupProfile();
        }
    });
}

function clearGroupProfile() {
    $('#communityName, #communityAddress, #allocatedStaff, #scheduledCollectionDay, #communityLeader, #leaderContactNumber, #leaderAddress, #firstEmiDate').val('');
    $('#memberAllocationBody').html('<tr><td colspan="6" class="text-center text-muted py-3">Please select a Group Code to load member allocation list.</td></tr>');
    $('#memberTotalAllocated').text('0.00');
    $('#requiredLoanAmount').text('0.00');
    $('#memberTotalNetDisb').text('0.00');
    $('#memberTotalEmi').text('0.00');
    $('#memberMismatchAlert').hide();
    userHasManuallyEditedMembers = false;
}

// Render Member Allocation Table
function renderMemberAllocationTable(members) {
    const tbody = $('#memberAllocationBody');
    tbody.empty();

    if (!members || members.length === 0) {
        tbody.html('<tr><td colspan="6" class="text-center text-warning py-3">No members found registered in this group.</td></tr>');
        return;
    }

    $.each(members, function(index, m) {
        const row = $('<tr>');
        row.append($('<td>').text(index + 1));
        row.append($('<td>').html('<span class="badge bg-secondary">' + (m.memberCode || '') + '</span>'));
        row.append($('<td>').text(m.memberName || ''));
        row.append(
            $('<td>').html(
                '<input type="number" step="0.01" min="0.01" class="form-control member-amount font-weight-bold" ' +
                'data-code="' + (m.memberCode || '') + '" ' +
                'data-name="' + (m.memberName || '') + '" ' +
                'placeholder="0.00" required>'
            )
        );
        row.append($('<td>').html('₹ <span class="member-net-disb fw-bold text-success">0.00</span>'));
        row.append($('<td>').html('₹ <span class="member-emi fw-bold text-primary">0.00</span>'));
        tbody.append(row);
    });

    // Automatically calculate & split individual loan amount and net disbursement immediately
    autoDistributeToMembers(true);
}

// Auto-distribute total loan amount equally among members
function autoDistributeToMembers(force) {
    const loanAmount = parseFloat($('#loanAmount').val()) || 0;
    const memberInputs = $('.member-amount');
    const count = memberInputs.length;

    if (count === 0) return;

    if (loanAmount <= 0) {
        memberInputs.val('');
        $('.member-net-disb').text('0.00');
        $('.member-emi').text('0.00');
        updateMemberCalculations();
        return;
    }

    const baseShare = Math.floor((loanAmount / count) * 100) / 100;
    let distributedSum = 0;

    memberInputs.each(function(index) {
        if (index === count - 1) {
            const lastShare = parseFloat((loanAmount - distributedSum).toFixed(2));
            $(this).val(lastShare.toFixed(2));
        } else {
            $(this).val(baseShare.toFixed(2));
            distributedSum += baseShare;
        }
    });

    updateMemberCalculations();
}

// Calculate individual member Net Disbursement (Amount Customer Gets) and Individual EMI
function updateMemberCalculations() {
    const totalLoan = parseFloat($('#loanAmount').val()) || 0;
    const totalNetDisb = parseFloat($('#netDisbursement').val()) || 0;
    const totalEmi = parseFloat($('#emiAmount').val()) || 0;
    const rows = $('#memberAllocationBody tr');
    const count = rows.length;

    let sumAllocated = 0;
    let sumMemberNet = 0;
    let sumMemberEmi = 0;

    rows.each(function(index) {
        const input = $(this).find('.member-amount');
        if (input.length === 0) return;

        const mAmt = parseFloat(input.val()) || 0;
        sumAllocated += mAmt;

        let mNet = 0;
        let mEmi = 0;

        if (totalLoan > 0 && mAmt > 0) {
            if (index === count - 1 && Math.abs(sumAllocated - totalLoan) < 0.01) {
                mNet = parseFloat((totalNetDisb - sumMemberNet).toFixed(2));
            } else {
                mNet = parseFloat(((mAmt / totalLoan) * totalNetDisb).toFixed(2));
                sumMemberNet += mNet;
            }

            mEmi = (mAmt / totalLoan) * totalEmi;
        }

        $(this).find('.member-net-disb').text(mNet.toFixed(2));
        $(this).find('.member-emi').text(mEmi.toFixed(2));
        sumMemberEmi += mEmi;
    });

    $('#memberTotalAllocated').text(sumAllocated.toFixed(2));
    $('#requiredLoanAmount').text(totalLoan.toFixed(2));
    $('#memberTotalNetDisb').text(totalNetDisb.toFixed(2));
    $('#memberTotalEmi').text(sumMemberEmi.toFixed(2));

    const diff = Math.abs(sumAllocated - totalLoan);
    if (totalLoan > 0 && diff > 0.01) {
        $('#alertAllocatedSum').text(sumAllocated.toFixed(2));
        $('#alertRequiredAmount').text(totalLoan.toFixed(2));
        $('#alertDifference').text(diff.toFixed(2));
        $('#memberMismatchAlert').slideDown(150);
        $('#memberAllocationTable').addClass('border-danger');
        return false;
    } else {
        $('#memberMismatchAlert').slideUp(150);
        $('#memberAllocationTable').removeClass('border-danger');
        return true;
    }
}

function updateFirstEmiDate() {
    const collectionDayStr = ($('#scheduledCollectionDay').val() || '').trim().toUpperCase();
    const openingDateStr = $('#openingDate').val();

    if (!openingDateStr) {
        $('#firstEmiDate').val('');
        return;
    }

    const baseDate = new Date(openingDateStr);
    if (isNaN(baseDate.getTime())) return;

    const daysMap = {
        'SUNDAY': 0, 'MONDAY': 1, 'TUESDAY': 2, 'WEDNESDAY': 3, 'THURSDAY': 4, 'FRIDAY': 5, 'SATURDAY': 6
    };

    const targetDay = daysMap[collectionDayStr];
    const emiFrequency = $('#emiFrequency').val() || 'MONTHLY';

    if (targetDay !== undefined) {
        let daysToAdd = (targetDay - baseDate.getDay() + 7) % 7;
        if (daysToAdd === 0) daysToAdd = 7;
        const nextDate = new Date(baseDate);
        nextDate.setDate(baseDate.getDate() + daysToAdd);
        formatAndSetDate('#firstEmiDate', nextDate);
    } else {
        const nextDate = new Date(baseDate);
        if (emiFrequency === 'WEEKLY') {
            nextDate.setDate(baseDate.getDate() + 7);
        } else {
            nextDate.setMonth(baseDate.getMonth() + 1);
        }
        formatAndSetDate('#firstEmiDate', nextDate);
    }
}

function formatAndSetDate(selector, dateObj) {
    const yyyy = dateObj.getFullYear();
    const mm = String(dateObj.getMonth() + 1).padStart(2, '0');
    const dd = String(dateObj.getDate()).padStart(2, '0');
    $(selector).val(yyyy + '-' + mm + '-' + dd);
}

function calculateLoanTerms() {
    const loanAmount = parseFloat($('#loanAmount').val()) || 0;
    const term = parseInt($('#term').val()) || 0;
    const roiAnnual = parseFloat($('#rateOfInterest').val()) || 0;
    const interestType = $('#interestType').val() || 'FLAT';
    const emiFrequency = $('#emiFrequency').val() || 'MONTHLY';

    if (loanAmount <= 0 || term <= 0) {
        $('#interestOnLoan').val('0.00');
        $('#totalAmountToPay').val('0.00');
        $('#emiAmount').val('0.00');
        return;
    }

    const periodsPerYear = (emiFrequency === 'WEEKLY') ? 52 : 12;
    let totalInterest = 0;
    let totalAmountToPay = 0;
    let emi = 0;

    if (interestType === 'FLAT') {
        totalInterest = loanAmount * (roiAnnual / 100.0) * (term / periodsPerYear);
        totalAmountToPay = loanAmount + totalInterest;
        emi = totalAmountToPay / term;
    } else {
        if (roiAnnual === 0) {
            emi = loanAmount / term;
            totalAmountToPay = loanAmount;
            totalInterest = 0;
        } else {
            const r = (roiAnnual / 100.0) / periodsPerYear;
            const factor = Math.pow(1 + r, term);
            emi = (loanAmount * r * factor) / (factor - 1);
            totalAmountToPay = emi * term;
            totalInterest = totalAmountToPay - loanAmount;
        }
    }

    $('#interestOnLoan').val(totalInterest.toFixed(2));
    $('#totalAmountToPay').val(totalAmountToPay.toFixed(2));
    $('#emiAmount').val(emi.toFixed(2));
}

function calculateDeductions() {
    const loanAmount = parseFloat($('#loanAmount').val()) || 0;
    const procFeePercent = parseFloat($('#processingFeePercent').val()) || 0;
    const legalChargesPercent = parseFloat($('#legalChargesPercent').val()) || 0;
    const insuranceFeePercent = parseFloat($('#insuranceFeePercent').val()) || 0;
    const valuationFeePercent = parseFloat($('#valuationFeePercent').val()) || 0;
    const gstPercent = parseFloat($('#gstPercent').val()) || 0;

    if (loanAmount <= 0) {
        $('#totalDeduction').val('0.00');
        $('#netDisbursement').val('0.00');
        return;
    }

    const procFeeAmt = loanAmount * (procFeePercent / 100);
    const legalChargesAmt = loanAmount * (legalChargesPercent / 100);
    const insuranceFeeAmt = loanAmount * (insuranceFeePercent / 100);
    const valuationFeeAmt = loanAmount * (valuationFeePercent / 100);

    const baseForGst = GST_APPLIES_TO_TOTAL_FEES 
        ? (procFeeAmt + legalChargesAmt + insuranceFeeAmt + valuationFeeAmt)
        : procFeeAmt;

    const gstAmt = baseForGst * (gstPercent / 100);
    const totalDeduction = procFeeAmt + legalChargesAmt + insuranceFeeAmt + valuationFeeAmt + gstAmt;
    const netDisbursement = loanAmount - totalDeduction;

    $('#totalDeduction').val(totalDeduction.toFixed(2));
    $('#netDisbursement').val(netDisbursement.toFixed(2));
}

function handleSubmit() {
    const groupCode = $('#groupCode').val();
    const openingDate = $('#openingDate').val();
    const purposeOfLoan = $('#purposeOfLoan').val().trim();
    const loanAmount = parseFloat($('#loanAmount').val()) || 0;
    const term = parseInt($('#term').val()) || 0;
    const rateOfInterest = parseFloat($('#rateOfInterest').val());
    const interestType = $('#interestType').val();
    const emiFrequency = $('#emiFrequency').val();
    const emiMode = $('#emiMode').val();

    if (!groupCode) { alert('Please select a Group Code.'); $('#groupCode').focus(); return; }
    if (!openingDate) { alert('Please enter Opening Date.'); $('#openingDate').focus(); return; }
    if (!purposeOfLoan) { alert('Please enter Purpose of Loan.'); $('#purposeOfLoan').focus(); return; }
    if (loanAmount <= 0) { alert('Loan Amount must be greater than 0.'); $('#loanAmount').focus(); return; }
    if (term < 1) { alert('Term must be at least 1 installment.'); $('#term').focus(); return; }
    if (isNaN(rateOfInterest) || rateOfInterest < 0 || rateOfInterest > 100) { alert('Rate of Interest must be between 0% and 100%.'); $('#rateOfInterest').focus(); return; }
    if (!interestType) { alert('Please select Interest Type.'); $('#interestType').focus(); return; }
    if (!emiFrequency) { alert('Please select EMI Frequency.'); $('#emiFrequency').focus(); return; }
    if (!emiMode) { alert('Please select EMI Mode.'); $('#emiMode').focus(); return; }

    const members = [];
    let memberSum = 0;
    let hasInvalidMemberAmount = false;

    $('.member-amount').each(function() {
        const mRow = $(this).closest('tr');
        const mCode = $(this).data('code');
        const mName = $(this).data('name');
        const amt = parseFloat($(this).val()) || 0;
        const netDisb = parseFloat(mRow.find('.member-net-disb').text()) || 0;

        if (amt <= 0) hasInvalidMemberAmount = true;
        memberSum += amt;
        members.push({ 
            memberCode: mCode, 
            memberName: mName, 
            individualLoanAmount: amt,
            netDisbursementAmount: netDisb
        });
    });

    if (members.length === 0) { alert('No member allocations available for this group.'); return; }
    if (hasInvalidMemberAmount) { alert('Each member must have an Individual Loan Amount greater than 0.'); return; }

    if (Math.abs(memberSum - loanAmount) > 0.01) {
        alert('Validation Error: Member amounts sum to ₹' + memberSum.toFixed(2) + 
              ', but Loan Amount is ₹' + loanAmount.toFixed(2) + '. The sum must equal the Loan Amount.');
        $('#memberMismatchAlert').slideDown(150);
        return;
    }

    const payload = {
        groupCode: groupCode,
        openingDate: openingDate,
        purposeOfLoan: purposeOfLoan,
        loanAmount: loanAmount,
        term: term,
        rateOfInterest: rateOfInterest,
        interestType: interestType,
        emiFrequency: emiFrequency,
        emiMode: emiMode,
        emiAmount: parseFloat($('#emiAmount').val()) || 0,
        interestOnLoan: parseFloat($('#interestOnLoan').val()) || 0,
        totalAmountToPay: parseFloat($('#totalAmountToPay').val()) || 0,
        firstEmiDate: $('#firstEmiDate').val() || null,
        processingFeePercent: parseFloat($('#processingFeePercent').val()) || 0,
        legalChargesPercent: parseFloat($('#legalChargesPercent').val()) || 0,
        insuranceFeePercent: parseFloat($('#insuranceFeePercent').val()) || 0,
        valuationFeePercent: parseFloat($('#valuationFeePercent').val()) || 0,
        gstPercent: parseFloat($('#gstPercent').val()) || 0,
        totalDeduction: parseFloat($('#totalDeduction').val()) || 0,
        netDisbursement: parseFloat($('#netDisbursement').val()) || 0,
        penaltyMode: $('#penaltyMode').val(),
        monthlyPenalty: parseFloat($('#monthlyPenalty').val()) || 0,
        members: members
    };

    $('#saveBtn').prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-2"></span>Saving...');

    $.ajax({
        url: getBasePath() + '/api/grouploans',
        type: 'POST',
        contentType: 'application/json',
        data: JSON.stringify(payload),
        success: function(response) {
            $('#saveBtn').prop('disabled', false).html('<i class="bi bi-check-circle me-1"></i> SAVE APPLICATION');
            if (response && (response.status === 'CREATED' || response.status === 'OK')) {
                alert('SUCCESS: ' + (response.message || 'Group Loan Application saved successfully!'));
                $('#groupLoanForm')[0].reset();
                userHasManuallyEditedMembers = false;
                initForm();
                clearGroupProfile();
                loadApplicationsTable();
            } else {
                alert('Response: ' + (response.message || 'Operation finished.'));
            }
        },
        error: function(xhr) {
            $('#saveBtn').prop('disabled', false).html('<i class="bi bi-check-circle me-1"></i> SAVE APPLICATION');
            let errMsg = 'Failed to save Group Loan application.';
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

function loadApplicationsTable() {
    $.ajax({
        url: getBasePath() + '/api/grouploans',
        type: 'GET',
        dataType: 'json',
        success: function(response) {
            const tbody = $('#groupLoanBody').empty();
            const data = (response && response.data) ? response.data : response;

            if (data && data.length > 0) {
                $.each(data, function(index, item) {
                    const row = $('<tr>');
                    row.append($('<td>').html('<strong>' + (item.applicationNo || '') + '</strong>'));
                    row.append($('<td>').text(item.groupCode || ''));
                    row.append($('<td>').text(item.openingDate || ''));
                    row.append($('<td>').text(item.loanAmount ? parseFloat(item.loanAmount).toFixed(2) : '0.00'));
                    row.append($('<td>').text(item.term || ''));
                    row.append($('<td>').text(item.rateOfInterest ? parseFloat(item.rateOfInterest).toFixed(2) + '%' : ''));
                    row.append($('<td>').text(item.interestOnLoan ? parseFloat(item.interestOnLoan).toFixed(2) : '0.00'));
                    row.append($('<td>').text(item.totalAmountToPay ? parseFloat(item.totalAmountToPay).toFixed(2) : '0.00'));
                    row.append($('<td>').text(item.emiAmount ? parseFloat(item.emiAmount).toFixed(2) : '0.00'));
                    row.append($('<td>').text(item.firstEmiDate || ''));
                    row.append($('<td>').text(item.netDisbursement ? parseFloat(item.netDisbursement).toFixed(2) : '0.00'));
                    row.append($('<td>').html('<span class="badge bg-warning text-dark">' + (item.status || 'PENDING') + '</span>'));
                    tbody.append(row);
                });
            } else {
                tbody.html('<tr><td colspan="12" class="text-center text-muted py-3">No applications found.</td></tr>');
            }
        },
        error: function(xhr) {
            console.error('Error loading applications:', xhr.responseText);
            $('#groupLoanBody').html('<tr><td colspan="12" class="text-center text-danger py-3">Failed to load applications.</td></tr>');
        }
    });
}

function deleteAllGroupLoans() {
    $('#deleteAllBtn').prop('disabled', true).html('<span class="spinner-border spinner-border-sm me-1"></span> Deleting...');
    $.ajax({
        url: getBasePath() + '/api/grouploans',
        type: 'DELETE',
        success: function(response) {
            $('#deleteAllBtn').prop('disabled', false).html('<i class="bi bi-trash3 me-1"></i> DELETE ALL GROUP LOANS');
            alert('SUCCESS: All group loan data has been deleted.');
            loadApplicationsTable();
        },
        error: function(xhr) {
            $('#deleteAllBtn').prop('disabled', false).html('<i class="bi bi-trash3 me-1"></i> DELETE ALL GROUP LOANS');
            let errMsg = 'Failed to delete group loan data.';
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

