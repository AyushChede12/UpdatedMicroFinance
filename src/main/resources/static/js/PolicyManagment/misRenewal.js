/**
 * misRenewal.js — Frontend logic for the MIS Renewal module
 * API base: /api/mis (resolved with context path from <meta name="baseUrl">)
 */

'use strict';

// Read the application context path injected by main.jsp via <meta name="baseUrl" content="${baseUrl}">
// e.g. /MicrofinanceDemo  — ensures fetch reaches /MicrofinanceDemo/api/mis/... not /api/mis/...
const _ctxPath = (document.querySelector('meta[name="baseUrl"]') || {}).content || '';
const MIS_API = _ctxPath + '/api/mis';
let selectedPolicyId = null;
let selectedPolicyData = null;

// Maps customer code → first policy number (only codes with MIS policies appear)
const _misCustomerPolicyMap = {};


// ══════════════════════════════════════════════════════════════════════
//  INIT
// ══════════════════════════════════════════════════════════════════════
document.addEventListener('DOMContentLoaded', function () {
    initCustomerCodeDropdown();
    loadAllPolicies();
    document.getElementById('misSearchBtn').addEventListener('click', handleSearch);
    document.getElementById('misLoadAllBtn').addEventListener('click', loadAllPolicies);
    document.getElementById('misViewSelectedBtn') && document.getElementById('misViewSelectedBtn').addEventListener('click', handleViewSelected);
    document.getElementById('misAddNextPayoutBtn') && document.getElementById('misAddNextPayoutBtn').addEventListener('click', handleAddNextPayout);
    document.getElementById('misPrematureCloseBtn') && document.getElementById('misPrematureCloseBtn').addEventListener('click', handlePrematureClose);
    document.getElementById('misRenewBtn') && document.getElementById('misRenewBtn').addEventListener('click', handleRenew);
});

// ══════════════════════════════════════════════════════════════════════
//  CUSTOMER CODE DROPDOWN INIT
// ══════════════════════════════════════════════════════════════════════
function initCustomerCodeDropdown() {
    fetch(MIS_API + '/policies')
        .then(r => r.json())
        .then(res => {
            if (!res.data || res.data.length === 0) return;

            const select = document.getElementById('misSearchCustomer');
            const policySelect = document.getElementById('misSearchPolicy');
            if (!select) return;

            select.innerHTML = '<option value="">SELECT CUSTOMER CODE</option>';
            if (policySelect) {
                policySelect.innerHTML = '<option value="">SELECT POLICY NUMBER</option>';
            }
            const seen = new Set();
            const seenPolicies = new Set();
            const policyToCustomerMap = {};

            res.data.forEach(p => {
                const code = p.customerId;
                if (!code) return;

                // Populate map: store all policy numbers per customer
                if (!_misCustomerPolicyMap[code]) {
                    _misCustomerPolicyMap[code] = [];
                }
                if (p.policyNumber && !_misCustomerPolicyMap[code].includes(p.policyNumber)) {
                    _misCustomerPolicyMap[code].push(p.policyNumber);
                    policyToCustomerMap[p.policyNumber] = code;
                }

                // Add option only once per unique customer code
                if (!seen.has(code)) {
                    seen.add(code);
                    const opt = document.createElement('option');
                    opt.value = code;
                    opt.textContent = p.customerName ? `${code} - ${p.customerName}` : code;
                    select.appendChild(opt);
                }

                // Populate all unique policies initially in policySelect
                if (policySelect && p.policyNumber && !seenPolicies.has(p.policyNumber)) {
                    seenPolicies.add(p.policyNumber);
                    const pOpt = document.createElement('option');
                    pOpt.value = p.policyNumber;
                    pOpt.textContent = p.policyNumber;
                    policySelect.appendChild(pOpt);
                }
            });

            // Wire change & input event: populate policy dropdown when customer is selected
            const handleCustomerChange = function () {
                const selectedCode = this.value.trim();
                if (!policySelect) return;

                policySelect.innerHTML = '<option value="">SELECT POLICY NUMBER</option>';
                const policies = selectedCode ? (_misCustomerPolicyMap[selectedCode] || []) : Array.from(seenPolicies);

                policies.forEach(pNo => {
                    const opt = document.createElement('option');
                    opt.value = pNo;
                    opt.textContent = pNo;
                    policySelect.appendChild(opt);
                });

                // Auto-select first policy if available and a customer was picked
                if (selectedCode && policies.length > 0) {
                    policySelect.value = policies[0];
                }
            };

            select.addEventListener('change', handleCustomerChange);
            select.addEventListener('input', handleCustomerChange);

            // Wire change event on policy select dropdown
            if (policySelect) {
                policySelect.addEventListener('change', function () {
                    const chosenPolicy = this.value.trim();
                    if (chosenPolicy && policyToCustomerMap[chosenPolicy] && !select.value) {
                        select.value = policyToCustomerMap[chosenPolicy];
                    }
                    handleSearch();
                });
            }
        })
        .catch(err => console.warn('MIS dropdown init error:', err));
}


// ══════════════════════════════════════════════════════════════════════
//  SEARCH & LOAD
// ══════════════════════════════════════════════════════════════════════
function handleSearch() {
    const customerCode = document.getElementById('misSearchCustomer').value.trim();
    const policyNo = document.getElementById('misSearchPolicy').value.trim();

    if (customerCode) {
        loadPoliciesByCustomer(customerCode).then(() => {
            if (policyNo) {
                const rows = document.querySelectorAll('#misPolicyTableBody tr[data-policy-id]');
                rows.forEach(row => {
                    const cell = row.querySelector('td:nth-child(2)');
                    if (cell && !cell.textContent.trim().includes(policyNo)) {
                        row.style.display = 'none';
                    } else {
                        row.style.display = '';
                    }
                });
            }
        });
    } else if (policyNo) {
        loadAllPolicies().then(() => {
            // Filter table by policy number
            const rows = document.querySelectorAll('#misPolicyTableBody tr[data-policy-id]');
            rows.forEach(row => {
                const cell = row.querySelector('td:nth-child(2)');
                if (cell && !cell.textContent.trim().includes(policyNo)) {
                    row.style.display = 'none';
                } else {
                    row.style.display = '';
                }
            });
        });
    } else {
        loadAllPolicies();
    }
}

function loadAllPolicies() {
    return fetch(MIS_API + '/policies')
        .then(r => r.json())
        .then(res => {
            if (res.data) renderPolicyTable(res.data);
            else showEmptyTable();
        })
        .catch(err => {
            console.error('MIS load error:', err);
            showEmptyTable();
        });
}

function loadPoliciesByCustomer(customerId) {
    return fetch(MIS_API + '/policies/customer/' + encodeURIComponent(customerId))
        .then(r => r.json())
        .then(res => {
            if (res.data && res.data.length > 0) renderPolicyTable(res.data);
            else showEmptyTable('No MIS policies found for customer: ' + customerId);
        })
        .catch(err => {
            console.error('MIS customer search error:', err);
            showEmptyTable();
        });
}

// ══════════════════════════════════════════════════════════════════════
// ══════════════════════════════════════════════════════════════════════
//  RENDER POLICY TABLE & ROW SELECTION
// ══════════════════════════════════════════════════════════════════════
function renderPolicyTable(policies) {
    const tbody = document.getElementById('misPolicyTableBody');
    if (!policies || policies.length === 0) {
        showEmptyTable();
        return;
    }
    tbody.innerHTML = '';
    policies.forEach((p, i) => {
        const row = document.createElement('tr');
        row.setAttribute('data-policy-id', p.id);
        row.style.cursor = 'pointer';
        row.innerHTML = `
            <td>${i + 1}</td>
            <td><strong>${p.policyNumber || '—'}</strong></td>
            <td>${p.customerName || p.customerId || '—'}</td>
            <td>${p.planName || '—'}</td>
            <td>₹${formatNum(p.principalAmount)}</td>
            <td>${p.interestRate || '—'}%</td>
            <td>₹${formatNum(p.monthlyPayoutAmount)}</td>
            <td>${p.startDate || '—'}</td>
            <td>${p.maturityDate || '—'}</td>
            <td>${p.nextPayoutDate || '—'}</td>
            <td>${statusBadge(p.status)}</td>
        `;
        row.addEventListener('click', () => highlightAndSelectRow(row, p));
        row.addEventListener('dblclick', () => {
            highlightAndSelectRow(row, p);
            selectPolicy(p.id);
        });
        tbody.appendChild(row);
    });

    if (selectedPolicyId) {
        const selRow = tbody.querySelector(`tr[data-policy-id="${selectedPolicyId}"]`);
        if (selRow) {
            selRow.classList.add('table-active');
            enableActionButtons(true);
        } else {
            enableActionButtons(false);
        }
    } else {
        enableActionButtons(false);
    }
}

function highlightAndSelectRow(row, p) {
    const tbody = document.getElementById('misPolicyTableBody');
    tbody.querySelectorAll('tr').forEach(r => r.classList.remove('table-active'));
    row.classList.add('table-active');
    selectedPolicyId = p.id;
    selectedPolicyData = p;
    enableActionButtons(true);
    setText('selectedPolicyNotice', `Selected: ${p.policyNumber} (${p.customerName || p.customerId || ''})`);
}

function enableActionButtons(enabled) {
    const viewBtn = document.getElementById('misViewSelectedBtn');
    const addBtn = document.getElementById('misAddNextPayoutBtn');
    if (viewBtn) viewBtn.disabled = !enabled;
    if (addBtn) addBtn.disabled = !enabled;
    if (!enabled) setText('selectedPolicyNotice', 'Select a policy from table to perform actions.');
}

function showEmptyTable(msg = 'No policies found.') {
    document.getElementById('misPolicyTableBody').innerHTML =
        `<tr><td colspan="11" class="text-center text-muted">${msg}</td></tr>`;
    enableActionButtons(false);
    hidePolicyDetail();
}

function handleViewSelected() {
    if (selectedPolicyId) {
        selectPolicy(selectedPolicyId);
    } else {
        alert("Please select a policy from the table first.");
    }
}

// ══════════════════════════════════════════════════════════════════════
//  ADD NEXT PAYOUT (ADMIN / TESTING)
// ══════════════════════════════════════════════════════════════════════
function handleAddNextPayout() {
    if (!selectedPolicyId) {
        alert("Please select a policy from the table first.");
        return;
    }

    const btn = document.getElementById('misAddNextPayoutBtn');
    const originalText = btn.innerHTML;
    btn.disabled = true;
    btn.innerHTML = '<span class="spinner-border spinner-border-sm" role="status" aria-hidden="true"></span> Adding...';

    fetch(MIS_API + '/policies/' + selectedPolicyId + '/add-next-payout', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    })
        .then(r => r.json())
        .then(res => {
            btn.disabled = false;
            btn.innerHTML = originalText;

            if (res.status === 'OK') {
                alert(res.message || 'Next payout added successfully!');
                selectPolicy(selectedPolicyId);
                loadAllPolicies();
            } else {
                alert('Cannot add payout: ' + (res.message || 'Unknown error'));
            }
        })
        .catch(err => {
            btn.disabled = false;
            btn.innerHTML = originalText;
            console.error('Add next payout error:', err);
            alert('Failed to add next payout: ' + err.message);
        });
}

// ══════════════════════════════════════════════════════════════════════
//  SELECT / VIEW POLICY
// ══════════════════════════════════════════════════════════════════════
function selectPolicy(policyId) {
    selectedPolicyId = policyId;

    // Fetch policy detail
    fetch(MIS_API + '/policies/' + policyId)
        .then(r => r.json())
        .then(res => {
            if (res.data) {
                selectedPolicyData = res.data;
                renderPolicyDetail(res.data);
                loadSummary(policyId);
                loadLedger(policyId);
                renderActionPanels(res.data);
                document.getElementById('misPolicyDetailSection').style.display = 'block';
                document.getElementById('misPolicyDetailSection').scrollIntoView({ behavior: 'smooth' });
            }
        })
        .catch(err => console.error('Policy detail error:', err));
}

function renderPolicyDetail(p) {
    setText('dpPolicyNumber', p.policyNumber);
    document.getElementById('dpStatus').innerHTML = statusBadge(p.status);
    setText('dpCustomerId', p.customerId);
    setText('dpCustomerName', p.customerName);
    setText('dpPlanName', p.planName);
    setText('dpTenure', p.tenureMonths + ' months');
    setText('dpRoi', p.interestRate + '%');
    setText('dpPayoutDay', p.payoutDay ? 'Day ' + p.payoutDay + ' of each month' : '—');
    setText('dpLockIn', p.lockInMonths + ' months');
    setText('dpNominee', (p.nomineeName || '—') + (p.nomineeRelation ? ' (' + p.nomineeRelation + ')' : ''));
    setText('dpStartDate', p.startDate);
    setText('dpMaturityDate', p.maturityDate);
    setText('dpPrincipal', '₹' + formatNum(p.principalAmount));
    setText('dpMonthlyPayout', '₹' + formatNum(p.monthlyPayoutAmount));
}

function loadSummary(policyId) {
    fetch(MIS_API + '/policies/' + policyId + '/summary')
        .then(r => r.json())
        .then(res => {
            if (res.data) {
                const s = res.data;
                setText('smTotalInvested', '₹' + formatNum(s.totalInvested));
                setText('smTotalInterest', '₹' + formatNum(s.totalInterestEarned));
                setText('smTotalTds', '₹' + formatNum(s.totalTdsDeducted));
                setText('smNextPayout', s.nextPayoutDate || '—');
                setText('smDaysMaturity', s.daysUntilMaturity + ' days');
                setText('smLockInStatus', s.lockInActive ? '🔒 LOCK-IN ACTIVE' : '✅ LOCK-IN CLEARED');
                setText('smLockInEnd', s.lockInActive ? 'Lock-in ends on: ' + s.lockInEndsOn : '');

                // Update premature close panel with live data
                if (selectedPolicyData) {
                    const principal = selectedPolicyData.principalAmount || 0;
                    const penalty = (principal * 0.01).toFixed(2);
                    const refund = (principal - parseFloat(penalty)).toFixed(2);
                    setText('pcPrincipal', '₹' + formatNum(principal));
                    setText('pcPenaltyAmount', '₹' + formatNum(penalty));
                    setText('pcRefundAmount', '₹' + formatNum(refund));

                    if (s.lockInActive) {
                        document.getElementById('pcLockInWarning').style.display = 'block';
                        setText('pcLockInEndDate', s.lockInEndsOn);
                        document.getElementById('pcCloseForm').style.display = 'none';
                    } else {
                        document.getElementById('pcLockInWarning').style.display = 'none';
                        document.getElementById('pcCloseForm').style.display = 'block';
                    }
                }
            }
        })
        .catch(err => console.error('Summary error:', err));
}

function loadLedger(policyId) {
    fetch(MIS_API + '/policies/' + policyId + '/ledger')
        .then(r => r.json())
        .then(res => {
            const tbody = document.getElementById('misLedgerTableBody');
            if (res.data && res.data.length > 0) {
                tbody.innerHTML = '';
                res.data.forEach((l, i) => {
                    tbody.innerHTML += `
                        <tr>
                            <td>${i + 1}</td>
                            <td>${l.payoutDate || '—'}</td>
                            <td>₹${formatNum(l.interestAmount)}</td>
                            <td>₹${formatNum(l.tdsDeducted)}</td>
                            <td><strong>₹${formatNum(l.netPaid)}</strong></td>
                            <td><span class="badge bg-success">${l.status || 'PAID'}</span></td>
                        </tr>`;
                });
            } else {
                tbody.innerHTML = '<tr><td colspan="6" class="text-center text-muted">No payout records yet.</td></tr>';
            }
        })
        .catch(err => console.error('Ledger error:', err));
}

function renderActionPanels(p) {
    const prematurePanel = document.getElementById('misPrematureClosePanel');
    const renewPanel = document.getElementById('misRenewPanel');

    prematurePanel.style.display = p.status === 'ACTIVE' ? 'block' : 'none';
    renewPanel.style.display = p.status === 'MATURED' ? 'block' : 'none';
}

// ══════════════════════════════════════════════════════════════════════
//  PREMATURE CLOSE
// ══════════════════════════════════════════════════════════════════════
function handlePrematureClose() {
    if (!selectedPolicyId) return;
    const reason = document.getElementById('pcReason').value.trim();
    if (!reason) { alert('Please enter a closure reason.'); return; }

    if (!confirm('Are you sure you want to PREMATURELY CLOSE this MIS policy?\nThis action cannot be undone.')) return;

    fetch(MIS_API + '/policies/' + selectedPolicyId + '/premature-close', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ reason: reason })
    })
        .then(r => r.json())
        .then(res => {
            if (res.status === 'OK') {
                alert('Policy prematurely closed successfully.\nRefund Amount: ₹' + formatNum(res.data.refundAmount));
                loadAllPolicies();
                hidePolicyDetail();
            } else {
                alert('Error: ' + res.message);
            }
        })
        .catch(err => alert('Premature close failed: ' + err.message));
}

// ══════════════════════════════════════════════════════════════════════
//  RENEW
// ══════════════════════════════════════════════════════════════════════
function handleRenew() {
    if (!selectedPolicyId) return;
    if (!confirm('Renew this MATURED MIS policy?\nA new MIS policy will be created with the same terms.')) return;

    fetch(MIS_API + '/policies/' + selectedPolicyId + '/renew', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' }
    })
        .then(r => r.json())
        .then(res => {
            if (res.status === 'CREATED') {
                alert('Policy renewed successfully!\nNew Policy Number: ' + (res.data ? res.data.policyNumber : ''));
                loadAllPolicies();
                hidePolicyDetail();
            } else {
                alert('Error: ' + res.message);
            }
        })
        .catch(err => alert('Renewal failed: ' + err.message));
}

// ══════════════════════════════════════════════════════════════════════
//  HELPERS
// ══════════════════════════════════════════════════════════════════════
function hidePolicyDetail() {
    selectedPolicyId = null;
    selectedPolicyData = null;
    document.getElementById('misPolicyDetailSection').style.display = 'none';
}

function statusBadge(status) {
    const map = {
        'ACTIVE': 'mis-status-active',
        'MATURED': 'mis-status-matured',
        'CLOSED': 'mis-status-closed',
        'PREMATURELY_CLOSED': 'mis-status-prematurely_closed',
        'RENEWED': 'mis-status-renewed'
    };
    const cls = map[status] || '';
    return `<span class="mis-status-badge ${cls}">${status || '—'}</span>`;
}

function formatNum(val) {
    if (val === null || val === undefined) return '0.00';
    return parseFloat(val).toLocaleString('en-IN', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}

function setText(id, val) {
    const el = document.getElementById(id);
    if (el) el.textContent = val !== null && val !== undefined ? val : '—';
}
