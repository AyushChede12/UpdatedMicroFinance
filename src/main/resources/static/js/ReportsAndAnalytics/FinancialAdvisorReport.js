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
                $("#fetchFinancialConsultants")
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

    // ================= BRANCH DROPDOWN =================
    function populateBranchDropdown(data) {

        var select = $("#branchName2");

        select.empty().append('<option value="">SELECT</option>');

        let branchSet = new Set();

        data.forEach(f => {
            if (f.branchName) {
                branchSet.add(normalize(f.branchName));
            }
        });

        branchSet.forEach(branch => {
            select.append(`<option value="${branch}">${branch}</option>`);
        });
    }

    // ================= TABLE RENDER =================
    function renderTable(data) {

        var tbody = $("#fetchFinancialConsultants");
        tbody.empty();

        if (!data || data.length === 0) {
            tbody.append("<tr><td colspan='10'>No matching consultants found.</td></tr>");
            return;
        }

        $.each(data, function (i, f) {

            let approvedStatus = '-';
            if (f.approved === true) {
                approvedStatus = '<span style="color: green; font-weight: 600;">APPROVED</span>';
            } else if (f.approved === false) {
                approvedStatus = '<span style="color: red; font-weight: 600;">NOT APPROVED</span>';
            }

            tbody.append(`
                <tr>
                    <td>${i + 1}</td>
                    <td>${f.financialCode || '-'}</td>
                    <td>${(f.financialName || '-').toUpperCase()}</td>
                    <td>${f.joiningDate || '-'}</td>
                    <td>${(f.branchName || '-').toUpperCase()}</td>
                    <td>${f.dob || '-'}</td>
                    <td>${f.contactNo || '-'}</td>
                    <td>${(f.address || '-').toUpperCase()}</td>
                    <td>${approvedStatus}</td>
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
            $("#financialName").text(f.financialName || "N/A");
            $("#dob").text(f.dob || "N/A");
            $("#age").text(f.age || "N/A");
            $("#contactNo").text(f.contactNo || "N/A");
            $("#branchName").text(f.branchName || "N/A");
            $("#address").text(f.address || "N/A");
        });
    }

    // ================= FILTER =================
    $("#findFinancialAdvisorBtn").on("click", function (e) {
        e.preventDefault();

        var branch = $("#branchName2").val();
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
