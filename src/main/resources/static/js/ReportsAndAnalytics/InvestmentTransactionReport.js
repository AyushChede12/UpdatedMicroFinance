$(document).ready(function () {

    // 🔒 PREVENT MULTIPLE EXECUTION
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

                if (response && Array.isArray(response.data)) {
                    allPolicies = response.data;
                    buildBranchDropdown(allPolicies);
                    fillTable(allPolicies); // ✅ INITIAL LOAD (LIKE FIRST TABLE)
                } else {
                    $("table tbody").html(
                        "<tr><td colspan='10'>No approved policies found</td></tr>"
                    );
                }
            },
            error: function () {
                alert("Error while fetching policy data");
            }
        });
    }

    // ================= NORMALIZE =================
    function normalize(value) {
        return value
            ?.toString()
            .replace(/[\n\r\t]/g, "")
            .replace(/\s+/g, " ")
            .trim()
            .toUpperCase();
    }

    // ================= BRANCH DROPDOWN =================
    function buildBranchDropdown(data) {

        let $branch = $("#branchName2");
        $branch.empty().append('<option value="">SELECT</option>');

        let branchSet = new Set();

        data.forEach(p => {
            let branch =
                p.branchName ||
                (p.branch && p.branch.branchName) ||
                "";

            if (branch) {
                branchSet.add(normalize(branch));
            }
        });

        [...branchSet].sort().forEach(b => {
            $branch.append(`<option value="${b}">${b}</option>`);
        });
    }

    // ================= DATE PARSER =================
    function parseDate(dateStr) {
        if (!dateStr) return null;
        let d = new Date(dateStr);
        return isNaN(d) ? null : d;
    }

    // ================= FIND BUTTON =================
    $("#findBtn").on("click", function (e) {
        e.preventDefault();

        let branch = $("#branchName2").val();
        let fromDate = $("#fromDate").val();
        let toDate = $("#toDate").val();

        let filtered = allPolicies;

        if (branch) {
            filtered = filtered.filter(p => {
                let b =
                    p.branchName ||
                    (p.branch && p.branch.branchName) ||
                    "";
                return normalize(b) === normalize(branch);
            });
        }

        if (fromDate && toDate) {
            let from = new Date(fromDate);
            let to = new Date(toDate);
            to.setHours(23, 59, 59, 999);

            filtered = filtered.filter(p => {
                let d = parseDate(
                    p.policyStartDate ||
                    p.policyDate ||
                    p.createdDate ||
                    p.investmentDate
                );
                return d && d >= from && d <= to;
            });
        }

        fillTable(filtered);
    });

    // ================= TABLE RENDER =================
    function fillTable(data) {

        let $tbody = $("table tbody");
        $tbody.empty();

        if (!data || data.length === 0) {
            $tbody.append(`
                <tr>
                    <td colspan="10" class="text-center text-danger">
                        No matching data found
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

            let approvedStatus =
                p.approved === true
                    ? '<span class="badge bg-success">APPROVED</span>'
                    : '<span class="badge bg-danger">NOT APPROVED</span>';

            $tbody.append(`
                <tr>
                    <td>${i + 1}</td>
                    <td>${p.policyCode || "-"}</td>
                    <td>${(p.customerName || "-").toUpperCase()}</td>
                    <td>${p.schemeType || "-"}</td>
                    <td>${policyDate}</td>
                    <td>${p.policyAmount || "-"}</td>
                    <td>${p.contactNo || "-"}</td>
                    <td>${branch.toUpperCase()}</td>
                    <td>${approvedStatus}</td>
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
