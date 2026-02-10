$(document).ready(function () {
    loadChequeData();

    $("#findBtn").on("click", function () {
        applyFilters();
    });
});

// ---------------- GLOBAL ----------------
let allChequeData = [];
let rowIndex = 0;

// ---------------- LOAD DATA ----------------
function loadChequeData() {
    allChequeData = [];
    rowIndex = 0;
    $(".datatable tbody").empty();

    loadLoanPayment();
}

function loadLoanPayment() {
    $.get("api/reports/getCheckDataFromLoanPayment", function (res) {
        if (res.status === "OK") {
            allChequeData.push(...res.data.map(item => ({
                id: item.id,
                name: item.memberName,
                date: item.paymentDate,
                chequeNo: item.chequeNo,
                type: "RECEIVED",
                branch: item.branchName || "",
                source: "Loan Payment"
            })));
            loadSavingActivity();
        }
    });
}

function loadSavingActivity() {
    $.get("api/reports/getPayByFromSavingAccountActivity", function (res) {
        if (res.status === "OK") {
            allChequeData.push(...res.data.map(item => ({
                id: item.id,
                name: item.customerName,
                date: item.transactionDate,
                chequeNo: item.chequeNo,
                type: "ISSUED",
                branch: item.branchName || "",
                source: "Saving Activity"
            })));
            loadCreateSaving();
        }
    });
}

function loadCreateSaving() {
    $.get("api/reports/getCheckDataFromCreateSavings", function (res) {
        if (res.status === "OK") {
            allChequeData.push(...res.data.map(item => ({
                id: item.id,
                name: item.enterCustomerName,
                date: item.openingDate,
                chequeNo: item.chequeNo,
                type: "ISSUED",
                branch: item.branchName || "",
                source: "Create Savings"
            })));
            loadFinancialConsultant();
        }
    });
}

function loadFinancialConsultant() {
    $.get("api/reports/getCheckDataFromFinancialConsultant", function (res) {
        if (res.status === "OK") {
            allChequeData.push(...res.data.map(item => ({
                id: item.id,
                name: item.financialName,
                date: item.joiningDate,
                chequeNo: item.chequeNo,
                type: "ISSUED",
                branch: item.branchName || "",
                source: "Financial Consultant"
            })));
            loadTeamMember();
        }
    });
}

function loadTeamMember() {
    $.get("api/reports/getCheckDataFromTeamMember", function (res) {
        if (res.status === "OK") {
            allChequeData.push(...res.data.map(item => ({
                id: item.id,
                name: item.teamMemberName,
                date: item.signUpDate,
                chequeNo: item.chequeNo,
                type: "ISSUED",
                branch: item.branchName || "",
                source: "Team Member"
            })));
            renderTable(allChequeData);
        }
    });
}

// ---------------- FILTER ----------------
function applyFilters() {

    let fDate = $("#fDate").val();
    let tDate = $("#tDate").val();
    let chequeNo = $("#chequeNo").val().trim();
    let type = $("#type").val();
    let branch = $("#branchName").val();

    let fromDate = fDate ? new Date(fDate) : null;
    let toDate = tDate ? new Date(tDate) : null;

    let filtered = allChequeData.filter(item => {

        let itemDate = parseDate(item.date);

        if (fromDate && itemDate < fromDate) return false;
        if (toDate && itemDate > toDate) return false;

        if (chequeNo && !item.chequeNo?.toString().includes(chequeNo)) {
            return false;
        }

        if (type && item.type !== type) return false;
        if (branch && item.branch !== branch) return false;

        return true;
    });

    renderTable(filtered);
}

// ---------------- TABLE ----------------
function renderTable(data) {

    let tbody = $(".datatable tbody");
    tbody.empty();
    rowIndex = 0;

    if (data.length === 0) {
        tbody.append(`
            <tr>
                <td colspan="6" class="text-center text-muted">
                    No records found
                </td>
            </tr>
        `);
        return;
    }

    data.forEach(item => {
        rowIndex++;
        tbody.append(`
            <tr>
                <td>${rowIndex}</td>
                <td>${item.name}</td>
                <td>${formatDate(item.date)}</td>
                <td>${item.chequeNo || "-"}</td>
                <td>${item.type}</td>
                <td>
                    <button onclick="viewData(${item.id})">
                        <i class="bi bi-printer" style="color:green;"></i>
                    </button>
                </td>
            </tr>
        `);
    });
}

// ---------------- HELPERS ----------------
function parseDate(d) {
    return d ? new Date(d.split(" ")[0]) : null;
}

function formatDate(d) {
    if (!d) return "-";
    return new Date(d.split(" ")[0]).toLocaleDateString("en-GB");
}
