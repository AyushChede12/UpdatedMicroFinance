/* =====================================================
   CHEQUE TRANSACTION REPORT – FINAL WORKING JS
   ===================================================== */

$(document).ready(function () {

    console.log("JS FILE LOADED");
    console.log("Context Path =", contextPath);

    loadChequeData();

    $("#findBtn").on("click", function () {
        applyFilters();
    });
});


/* ================= GLOBAL ================= */

let allChequeData = [];
let rowIndex = 0;


/* ================= LOAD START ================= */

function loadChequeData() {

    allChequeData = [];
    rowIndex = 0;
    $(".datatable tbody").empty();

    loadLoanPayment();
}


/* ================= API 1 : LOAN PAYMENT ================= */

function loadLoanPayment() {

    $.ajax({
        url: contextPath + "/api/reports/getCheckDataFromLoanPayment",
        type: "GET",
        success: function (res) {

            console.log("Loan Payment API:", res);

            let data = extractData(res);

            data.forEach(item => {
                allChequeData.push({
                    id: item.id,
                    name: item.memberName || "-",
                    date: item.paymentDate,
                    chequeNo: item.chequeNo,
                    type: "RECEIVED",
                    branch: item.branchName || "",
                    source: "Loan Payment"
                });
            });

            loadSavingActivity();
        },
        error: function () {
            loadSavingActivity();
        }
    });
}


/* ================= API 2 : SAVING ACTIVITY ================= */

function loadSavingActivity() {

    $.ajax({
        url: contextPath + "/api/reports/getPayByFromSavingAccountActivity",
        type: "GET",
        success: function (res) {

            console.log("Saving Activity API:", res);

            let data = extractData(res);

            data.forEach(item => {
                allChequeData.push({
                    id: item.id,
                    name: item.customerName || "-",
                    date: item.transactionDate,
                    chequeNo: item.chequeNo,
                    type: "ISSUED",
                    branch: item.branchName || "",
                    source: "Saving Activity"
                });
            });

            loadCreateSaving();
        },
        error: function () {
            loadCreateSaving();
        }
    });
}


/* ================= API 3 : CREATE SAVINGS ================= */

function loadCreateSaving() {

    $.ajax({
        url: contextPath + "/api/reports/getCheckDataFromCreateSavings",
        type: "GET",
        success: function (res) {

            console.log("Create Savings API:", res);

            let data = extractData(res);

            data.forEach(item => {
                allChequeData.push({
                    id: item.id,
                    name: item.enterCustomerName || "-",
                    date: item.openingDate,
                    chequeNo: item.chequeNo,
                    type: "ISSUED",
                    branch: item.branchName || "",
                    source: "Create Savings"
                });
            });

            loadFinancialConsultant();
        },
        error: function () {
            loadFinancialConsultant();
        }
    });
}


/* ================= API 4 : FINANCIAL CONSULTANT ================= */

function loadFinancialConsultant() {

    $.ajax({
        url: contextPath + "/api/reports/getCheckDataFromFinancialConsultant",
        type: "GET",
        success: function (res) {

            console.log("Financial Consultant API:", res);

            let data = extractData(res);

            data.forEach(item => {
                allChequeData.push({
                    id: item.id,
                    name: item.financialName || "-",
                    date: item.joiningDate,
                    chequeNo: item.chequeNo,
                    type: "ISSUED",
                    branch: item.branchName || "",
                    source: "Financial Consultant"
                });
            });

            loadTeamMember();
        },
        error: function () {
            loadTeamMember();
        }
    });
}


/* ================= API 5 : TEAM MEMBER ================= */

function loadTeamMember() {

    $.ajax({
        url: contextPath + "/api/reports/getCheckDataFromTeamMember",
        type: "GET",
        success: function (res) {

            console.log("Team Member API:", res);

            let data = extractData(res);

            data.forEach(item => {
                allChequeData.push({
                    id: item.id,
                    name: item.teamMemberName || "-",
                    date: item.signUpDate,
                    chequeNo: item.chequeNo,
                    type: "ISSUED",
                    branch: item.branchName || "",
                    source: "Team Member"
                });
            });

            console.log("FINAL DATA SIZE =", allChequeData.length);
            renderTable(allChequeData);
        },
        error: function () {
            renderTable(allChequeData);
        }
    });
}


/* ================= FILTER ================= */

function applyFilters() {

    let fDate = $("#fDate").val();
    let tDate = $("#tDate").val();
    let chequeNo = $("#chequeNo").val().trim();
    let type = $("#type").val();
    let branch = $("#branchName").val();

    let fromDate = parseInputDate(fDate);
    let toDate = parseInputDate(tDate);

    let filtered = allChequeData.filter(item => {

        let itemDate = parseDate(item.date);

        if (fromDate && itemDate && itemDate < fromDate) return false;
        if (toDate && itemDate && itemDate > toDate) return false;

        if (chequeNo && !String(item.chequeNo || "").includes(chequeNo)) return false;

        // enable only if dropdown values match ISSUED / RECEIVED
        // if (type && item.type !== type) return false;

        if (branch && item.branch &&
            item.branch.toLowerCase() !== branch.toLowerCase()) return false;

        return true;
    });

    renderTable(filtered);
}


/* ================= TABLE ================= */

function renderTable(data) {

    let tbody = $(".datatable tbody");
    tbody.empty();
    rowIndex = 0;

    if (!data || data.length === 0) {
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


/* ================= HELPERS ================= */

function extractData(res) {
    if (!res) return [];
    if (Array.isArray(res.data)) return res.data;
    if (Array.isArray(res.response)) return res.response;
    if (Array.isArray(res.result)) return res.result;
    return [];
}


function parseDate(d) {
    if (!d) return null;
    return new Date(d.split(" ")[0]);
}


/* 🔥 FIXED INPUT DATE FORMAT (DD-MM-YYYY) */
function parseInputDate(d) {

    if (!d) return null;

    let parts = d.split("-");
    if (parts.length === 3) {
        return new Date(parts[2] + "-" + parts[1] + "-" + parts[0]);
    }
    return new Date(d);
}


function formatDate(d) {
    if (!d) return "-";
    return new Date(d.split(" ")[0]).toLocaleDateString("en-GB");
}
