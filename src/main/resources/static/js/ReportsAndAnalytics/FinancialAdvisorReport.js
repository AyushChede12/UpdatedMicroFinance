$(document).ready(function () {

    // 🔒 PREVENT MULTIPLE EXECUTION
    if (window.financialConsultantInitialized) {
        console.warn("Financial Consultant JS already initialized");
        return;
    }
    window.financialConsultantInitialized = true;

    var allFinancialConsultants = [];

    // ================= FETCH APPROVED CONSULTANTS =================
    $.ajax({
        url: "api/reports/getApprovedFinancialConsultant",
        method: "GET",
        contentType: "application/json; charset=ISO-8859-1",
        success: function (response) {

            if (response && Array.isArray(response.data)) {
                allFinancialConsultants = response.data;
                populateBranchDropdown(allFinancialConsultants);
                renderTable(allFinancialConsultants);
            } else {
                $(".datatable tbody")
                    .html("<tr><td colspan='10'>No approved consultants found.</td></tr>");
            }
        },
        error: function () {
            alert("Error while fetching Financial Consultant data.");
        }
    });

    // ================= NORMALIZE =================
    function normalize(text) {
        return text
            ?.toString()
            .replace(/\s+/g, " ")
            .trim()
            .toUpperCase();
    }

    // ================= BRANCH DROPDOWN (NO DUPLICATE EVER) =================
    function populateBranchDropdown(data) {

        var select = $("#branchName");

        // 💣 HARD RESET
        select.empty().append('<option value="">Select</option>');

        let branchSet = new Set();

        data.forEach(f => {
            if (!f.branchName) return;
            branchSet.add(normalize(f.branchName));
        });

        branchSet.forEach(branch => {
            select.append(`<option value="${branch}">${branch}</option>`);
        });

        console.log("UNIQUE BRANCHES =", [...branchSet]);
    }

    // ================= TABLE RENDER =================
    function renderTable(data) {

        var tbody = $(".datatable tbody");
        tbody.empty();

        if (!data.length) {
            tbody.append("<tr><td colspan='10'>No matching consultants found.</td></tr>");
            return;
        }

        $.each(data, function (i, f) {
            tbody.append(`
                <tr>
                    <td>${i + 1}</td>
                    <td>${f.branchName || '-'}</td>
                    <td>${f.financialCode || '-'}</td>
                    <td>${f.joiningDate || '-'}</td>
                    <td>${f.financialName || '-'}</td>
                    <td>${f.dob || '-'}</td>
                    <td>${f.contactNo || '-'}</td>
                    <td>
                        <button class="btn btn-outline-success btn-sm viewReportBtn"
                            data-id="${f.id}"
                            data-bs-toggle="modal"
                            data-bs-target="#bankReportModal">
                            <i class="bi bi-printer"></i>
                        </button>
                    </td>
                </tr>
            `);
        });

        bindModalEvents();
    }

    // ================= MODAL BIND =================
    function bindModalEvents() {

        $(".viewReportBtn").off("click").on("click", function () {

            var id = $(this).data("id");
            var f = allFinancialConsultants.find(x => x.id === id);
            if (!f) return;

            $("#financialCode").text(f.financialCode || "N/A");
            $("#joiningDate").text(f.joiningDate || "N/A");
            $("#financialName").text(f.financialName || "");
            $("#dob").text(f.dob || "");
            $("#age").text(f.age || "");
            $("#contactNo").text(f.contactNo || "");
            $("#branchName").text(f.branchName || "");
        });
    }

    // ================= FILTER =================
    $("#findFinancialAdvisorBtn").on("click", function (e) {
        e.preventDefault();

        var branch = $("#branchName").val();
        var fromDate = $("#fromDate").val();
        var toDate = $("#toDate").val();

        let filtered = allFinancialConsultants;

        if (branch) {
            filtered = filtered.filter(f =>
                normalize(f.branchName) === normalize(branch)
            );
        }

        if (fromDate && toDate) {
            filtered = filtered.filter(f => {
                if (!f.joiningDate) return false;
                let d = new Date(f.joiningDate);
                return d >= new Date(fromDate) && d <= new Date(toDate);
            });
        }

        renderTable(filtered);
    });

});
