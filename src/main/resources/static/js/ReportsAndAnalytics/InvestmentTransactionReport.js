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
                (p.branchName || (p.branch && p.branch.branchName) || "")
                    .toString()
                    .trim();

            if (branchName && !branches.has(branchName.toLowerCase())) {
                branches.add(branchName.toLowerCase());
                branchDropdown.append(
                    `<option value="${branchName.toLowerCase()}">${branchName}</option>`
                );
            }
        });
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
    $("#findBtn").click(function (e) {
        e.preventDefault();

        let branch = $("#branchName1").val();
        let fromDate = $("#fromDate").val();
        let toDate = $("#toDate").val();

        if (!branch || !fromDate || !toDate) {
            alert("All fields required");
            return;
        }

        let from = new Date(fromDate);
        from.setHours(0, 0, 0, 0);

        let to = new Date(toDate);
        to.setHours(23, 59, 59, 999);

        let filtered = allPolicies.filter(p => {

            // ===== BRANCH =====
            let policyBranch =
                (p.branchName || (p.branch && p.branch.branchName) || "")
                    .toString()
                    .trim()
                    .toLowerCase();

            // ===== DATE (IMPORTANT FIX) =====
            let rawDate =
                p.policyStartDate ||   // ✅ MAIN FIELD
                p.policyDate ||
                p.createdDate ||
                p.investmentDate;

            let policyDateObj = parseDate(rawDate);
            if (!policyDateObj) return false;

            return (
                policyBranch.includes(branch.toLowerCase()) &&
                policyDateObj >= from &&
                policyDateObj <= to
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

        data.forEach((p, i) => {

            let branch = p.branchName || (p.branch && p.branch.branchName) || "-";
            let date = p.policyStartDate || "-";

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

});
