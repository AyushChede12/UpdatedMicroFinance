$(document).ready(function () {

    // 🔒 PREVENT MULTIPLE EXECUTION (MOST IMPORTANT FIX)
    if (window.policyReportInitialized) {
        console.warn("JS already initialized, skipping...");
        return;
    }
    window.policyReportInitialized = true;

    let allPolicies = [];

    // ================= LOAD APPROVED POLICIES =================
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
            error: function (err) {
                console.error("API ERROR", err);
            }
        });
    }

    // ================= NORMALIZE STRING =================
    function normalize(text) {
        return text
            .toString()
            .replace(/\s+/g, " ")
            .replace(/[\n\r\t]/g, "")
            .trim()
            .toUpperCase();
    }

    // ================= BRANCH DROPDOWN (ABSOLUTE DISTINCT) =================
    function loadBranchDropdown(data) {

        let branchDropdown = $("#branchName");

        // 💣 HARD RESET
        branchDropdown.empty();
        branchDropdown.append('<option value="">SELECT</option>');

        let branchSet = new Set();

        data.forEach(p => {

            let rawBranch =
                p.branchName ||
                (p.branch && p.branch.branchName) ||
                "";

            if (!rawBranch) return;

            let cleanBranch = normalize(rawBranch);

            if (!branchSet.has(cleanBranch)) {
                branchSet.add(cleanBranch);
            }
        });

        // ✅ append ONLY unique
        branchSet.forEach(branch => {
            branchDropdown.append(
                `<option value="${branch}">${branch}</option>`
            );
        });

        console.log("FINAL UNIQUE BRANCHES =", [...branchSet]);
    }

    // ================= DATE PARSER =================
    function parseDate(dateStr) {
        if (!dateStr) return null;
        let d = new Date(dateStr);
        if (!isNaN(d)) {
            d.setHours(0, 0, 0, 0);
            return d;
        }
        return null;
    }

    // ================= FIND BUTTON =================
    $("#findBtn").on("click", function (e) {
        e.preventDefault();

        let selectedBranch = $("#branchName").val();
        let fromDate = $("#fromDate").val();
        let toDate = $("#toDate").val();

        if (!selectedBranch || !fromDate || !toDate) {
            alert("Please select branch and date range");
            return;
        }

        let from = new Date(fromDate);
        from.setHours(0, 0, 0, 0);

        let to = new Date(toDate);
        to.setHours(23, 59, 59, 999);

        let filteredData = allPolicies.filter(p => {

            let rawBranch =
                p.branchName ||
                (p.branch && p.branch.branchName) ||
                "";

            let policyBranch = normalize(rawBranch);

            let rawDate =
                p.policyStartDate ||
                p.policyDate ||
                p.createdDate ||
                p.investmentDate;

            let policyDate = parseDate(rawDate);
            if (!policyDate) return false;

            return (
                policyBranch === selectedBranch &&
                policyDate >= from &&
                policyDate <= to
            );
        });

        fillTable(filteredData);
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

        data.forEach((p, i) => {

            let branch =
                p.branchName ||
                (p.branch && p.branch.branchName) ||
                "-";

            let policyDate =
                p.policyStartDate ||
                p.policyDate ||
                "-";

            tbody.append(`
                <tr>
                    <td>${i + 1}</td>
                    <td>${p.policyCode || "-"}</td>
                    <td>${p.customerName || "-"}</td>
                    <td>${p.policyName || "-"}</td>
                    <td>${policyDate}</td>
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

});
