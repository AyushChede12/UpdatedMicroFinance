$(document).ready(function () {

    let allPolicies = [];

    // ================= LOAD DATA =================
    loadApprovedPolicies();

    function loadApprovedPolicies() {
        $.ajax({
            url: "api/Policymangment/getApprovedPolicies",
            type: "GET",
            success: function (response) {

                console.log("API RESPONSE =", response);

                if (response && Array.isArray(response.data)) {
                    allPolicies = response.data;
                    loadBranchDropdown(allPolicies);
                } else {
                    console.error("Invalid API response");
                }
            },
            error: function (e) {
                console.error("API ERROR", e);
            }
        });
    }

    // ================= BRANCH DROPDOWN =================
    function loadBranchDropdown(data) {

        let branchDropdown = $("#branchName1");
        branchDropdown.empty();
        branchDropdown.append('<option value="">SELECT</option>');

        let branches = new Set();

        data.forEach(p => {

            let branchName =
                p.branchName ||
                p.branch ||
                p.branch_name ||
                p.branch?.branchName;

            if (branchName) {
                branchName = branchName.toString().trim();
                if (!branches.has(branchName)) {
                    branches.add(branchName);
                    branchDropdown.append(
                        `<option value="${branchName}">${branchName}</option>`
                    );
                }
            }
        });
    }

    // ================= DATE PARSER (SAFE) =================
    function parseDate(dateStr) {

        if (!dateStr) return null;

        // yyyy-MM-dd or yyyy-MM-ddTHH:mm:ss
        let iso = new Date(dateStr);
        if (!isNaN(iso)) return iso;

        // dd-MM-yyyy
        if (dateStr.includes("-")) {
            let p = dateStr.split("-");
            if (p.length === 3) {
                return new Date(p[2], p[1] - 1, p[0]);
            }
        }

        return null;
    }

    // ================= FIND BUTTON =================
    $("#findBtn").click(function (e) {
        e.preventDefault();

        let branch = $("#branchName1").val();
        let fromDate = $("#fromDate").val();
        let toDate = $("#toDate").val();

        if (!branch || !fromDate || !toDate) {
            alert("All fields required");
            return;
        }

        let from = new Date(fromDate).setHours(0, 0, 0, 0);
        let to = new Date(toDate).setHours(0, 0, 0, 0);

        if (from > to) {
            alert("From Date cannot be greater than To Date");
            return;
        }

        let filtered = allPolicies.filter(p => {

            // branch
            let policyBranch =
                p.branchName ||
                p.branch ||
                p.branch_name ||
                p.branch?.branchName ||
                "";

            policyBranch = policyBranch.toString().trim().toLowerCase();

            // date
            let rawDate =
                p.policyDate ||
                p.policy_date ||
                p.createdDate ||
                p.investmentDate;

            let policyDateObj = parseDate(rawDate);
            if (!policyDateObj) return false;

            let policyDate = policyDateObj.setHours(0, 0, 0, 0);

            return (
                policyBranch === branch.trim().toLowerCase() &&
                policyDate >= from &&
                policyDate <= to
            );
        });

        console.log("FILTERED RECORDS =", filtered.length);
        fillTable(filtered);
    });

    // ================= TABLE FILL =================
    function fillTable(data) {

        let tbody = $("table tbody");
        tbody.empty();

        if (!data || data.length === 0) {
            tbody.append(`
                <tr>
                    <td colspan="10" class="text-center text-danger">
                        No data found
                    </td>
                </tr>
            `);
            return;
        }

        $.each(data, function (i, p) {

            let branch =
                p.branchName ||
                p.branch ||
                p.branch_name ||
                p.branch?.branchName ||
                "-";

            let date =
                p.policyDate ||
                p.policy_date ||
                p.createdDate ||
                p.investmentDate ||
                "-";

            tbody.append(`
                <tr>
                    <td>${i + 1}</td>
                    <td>${p.policyCode || "-"}</td>
                    <td>${p.customerName || "-"}</td>
                    <td>${p.policyName || "-"}</td>
                    <td>${date}</td>
                    <td>${p.policyAmount || "-"}</td>
                    <td>${p.contactNumber || "-"}</td>
                    <td>${branch}</td>
                    <td><span class="badge bg-success">APPROVED</span></td>
                    <td>
                        <button class="btn btn-sm btn-primary"
                            onclick="openPrintModal(${p.id})">
                            <i class="bi bi-printer"></i>
                        </button>
                    </td>
                </tr>
            `);
        });
    }

    // ================= PRINT MODAL =================
    window.openPrintModal = function (id) {

        let p = allPolicies.find(x => x.id === id);
        if (!p) return;

        $("#bankName").text("MICROFINANCE BANK");
        $("#reportTitle").text("Investment Transaction Report");

        $("#customerName").text(p.customerName || "-");
        $("#accountNumber").text(p.policyCode || "-");
        $("#periodCovered").text(
            p.policyDate || p.policy_date || "-"
        );

        $("#transactionTableBody").html(`
            <tr>
                <td>${p.policyCode || "-"}</td>
                <td>${p.policyDate || "-"}</td>
                <td>${p.policyAmount || "-"}</td>
                <td>${p.policyType || "-"}</td>
                <td>${p.policyMode || "-"}</td>
            </tr>
        `);

        $("#bankReportModal").modal("show");
    };

    // ================= PRINT =================
    $("#printBankReportBtn").click(function () {
        let data = $("#bankReportContent").html();
        let old = $("body").html();
        $("body").html(data);
        window.print();
        $("body").html(old);
        location.reload();
    });

});
