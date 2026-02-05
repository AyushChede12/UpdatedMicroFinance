$(document).ready(function () {

    // 🔒 PREVENT MULTIPLE EXECUTION (PAGE / JSP RELOAD SAFE)
    if (window.investmentTxnReportLoaded) {
        console.warn("JS already initialized, skipping...");
        return;
    }
    window.investmentTxnReportLoaded = true;

    let allPolicies = [];

    // ================= LOAD APPROVED POLICIES =================
    fetchApprovedPolicies();

    function fetchApprovedPolicies() {
        $.ajax({
            url: "api/Policymangment/getApprovedPolicies",
            type: "GET",
            success: function (response) {

                console.log("API RESPONSE =", response);

                if (response && Array.isArray(response.data)) {
                    allPolicies = response.data;
                    buildBranchDropdown(allPolicies);
                } else {
                    console.error("Invalid API response");
                }
            },
            error: function (err) {
                console.error("API ERROR", err);
            }
        });
    }

    // ================= STRING NORMALIZER =================
    function normalize(value) {
        return value
            .toString()
            .replace(/[\n\r\t]/g, "")
            .replace(/\s+/g, " ")
            .trim()
            .toUpperCase();
    }

    // ================= BRANCH DROPDOWN (ABSOLUTE UNIQUE) =================
    function buildBranchDropdown(data) {

        let $branch = $("#branchName2");

        // 💣 FORCE CLEAR (DOM + MEMORY)
        $branch.empty();
        $branch.html('<option value="">-- SELECT BRANCH --</option>');

        // Map<normalizedValue, displayValue>
        let branchMap = new Map();

        data.forEach(p => {

            let rawBranch =
                p.branchName ||
                (p.branch && p.branch.branchName) ||
                "";

            if (!rawBranch) return;

            let normalized = normalize(rawBranch);

            if (!branchMap.has(normalized)) {
                branchMap.set(normalized, rawBranch.trim());
            }
        });

        // 🔠 Alphabetical order
        [...branchMap.entries()]
            .sort((a, b) => a[1].localeCompare(b[1]))
            .forEach(([key, label]) => {
                $branch.append(
                    `<option value="${key}">${label.toUpperCase()}</option>`
                );
            });

        console.log("FINAL UNIQUE BRANCHES =", [...branchMap.values()]);
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
    $("#findBtn").off("click").on("click", function (e) {
        e.preventDefault();

        let selectedBranch = $("#branchName2").val();
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

        let result = allPolicies.filter(p => {

            let rawBranch =
                p.branchName ||
                (p.branch && p.branch.branchName) ||
                "";

            let branch = normalize(rawBranch);

            let rawDate =
                p.policyStartDate ||
                p.policyDate ||
                p.createdDate ||
                p.investmentDate;

            let policyDate = parseDate(rawDate);
            if (!policyDate) return false;

            return (
                branch === selectedBranch &&
                policyDate >= from &&
                policyDate <= to
            );
        });

        fillTable(result);
    });

    // ================= TABLE RENDER =================
    function fillTable(data) {

        let $tbody = $("table tbody");
        $tbody.empty();

        if (!data || data.length === 0) {
            $tbody.append(`
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

            $tbody.append(`
                <tr>
                    <td>${i + 1}</td>
                    <td>${p.policyCode || "-"}</td>
                    <td>${(p.customerName || "-").toUpperCase()}</td>
                    <td>${p.policyName || "-"}</td>
                    <td>${policyDate}</td>
                    <td>${p.policyAmount || "-"}</td>
                    <td>${p.contactNumber || "-"}</td>
                    <td>${(branch).toUpperCase()}</td>
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
