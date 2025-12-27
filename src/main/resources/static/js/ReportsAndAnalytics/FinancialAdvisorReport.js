$(document).ready(function () {
    var allFinancialConsultants = [];

    // ✅ Fetch Approved Consultants (once)
    $.ajax({
        url: "api/reports/getApprovedFinancialConsultant",
        method: "GET",
        contentType: "application/json; charset=ISO-8859-1",
        success: function (response) {
            if (response && response.data && Array.isArray(response.data)) {
                allFinancialConsultants = response.data;
                populateBranchDropdown(allFinancialConsultants);
                renderTable(allFinancialConsultants);
            } else {
                $(".datatable tbody").html("<tr><td colspan='10'>No approved consultants found.</td></tr>");
            }
        },
        error: function () {
            alert("Error while fetching Financial Consultant data.");
        }
    });

    // ✅ Populate Branch Dropdown dynamically
    function populateBranchDropdown(data) {
        var branches = [...new Set(data.map(f => f.branchName).filter(Boolean))];
        var select = $("#branchName");
        select.empty().append('<option value="">Select</option>');
        branches.forEach(branch => {
            select.append(`<option value="${branch}">${branch}</option>`);
        });
    }

    // ✅ Render Consultant Table
    function renderTable(data) {
        var tbody = $(".datatable tbody");
        tbody.empty();

        if (!data.length) {
            tbody.append("<tr><td colspan='10'>No matching consultants found.</td></tr>");
            return;
        }

        $.each(data, function (i, f) {
            tbody.append(
                "<tr>" +
                "<td>" + (i + 1) + "</td>" +
                "<td>" + (f.branchName || '-') + "</td>" +
                "<td>" + (f.financialCode || '-') + "</td>" +
                "<td>" + (f.joiningDate || '-') + "</td>" +
                "<td>" + (f.financialName || '-') + "</td>" +
				"<td>" + (f.dob || '-') + "</td>" +
                "<td>" + (f.contactNo || '-') + "</td>" +
				"<td><button class='btn btn-outline-success btn-sm viewReportBtn' data-id='" + f.id + "' data-bs-toggle='modal' data-bs-target='#bankReportModal' title='View Report'><i class='bi bi-printer'></i></button></td>" + 
                "</tr>"
            );
        });

        bindModalEvents();
    }

    // ✅ Bind Modal Data (same as before)
    function bindModalEvents() {
        $(".viewReportBtn").off("click").on("click", function () {
            var id = $(this).data("id");
            var f = allFinancialConsultants.find(x => x.id === id);
            if (!f) return;

            $("#bankLogo").attr("src", "https://i.ibb.co/zFSWbkC/banklogo.png");
            $("#bankName").text("Sterling Microfinance Bank");
            $("#reportTitle").text("Financial Consultant Registration Report");

            $("#financialCode").text(f.financialCode || "N/A");
            $("#joiningDate").text(f.joiningDate || "N/A");
            $("#financialName").text(f.financialName || "");
            $("#dob").text(f.dob || "");
            $("#age").text(f.age || "");
            $("#contactNo").text(f.contactNo || "");
            $("#branchName").text(f.branchName || "");
            $("#selectPosition").text(f.selectPosition || "");

            $("#address").text(f.address || "");
            $("#district").text(f.district || "");
            $("#state").text(f.state || "");
            $("#pinCode").text(f.pinCode || "");
            $("#profession").text(f.profession || "");
            $("#academicBackground").text(f.academicBackground || "");

            $("#fees").text(f.fees || "");
            $("#modeofPayment").text(f.modeofPayment || "");
            $("#chequeNo").text(f.chequeNo || "");
            $("#chequeDate").text(f.chequeDate || "");
            $("#depositAccount").text(f.depositAccount || "");
            $("#refNo").text(f.refNo || "");

            $("#referralCode").text(f.referralCode || "");
            $("#referralName").text(f.referralName || "");
            $("#comments").text(f.comments || "");
            $("#financialStatus").text(f.financialStatus || "");
            $("#smsSend").text(f.smsSend || "");
            $("#isApproved").text(f.isApproved ? "Yes" : "No");
        });
    }

    // ✅ Filter Form Submit Event (frontend filtering only)
    $("#findFinancialAdvisorBtn").on("click", function (e) {
        e.preventDefault();

        var branch = $("#branchName").val();
        var fromDate = $("#fromDate").val();
        var toDate = $("#toDate").val();

        var filtered = allFinancialConsultants;

        if (branch) {
            filtered = filtered.filter(f => f.branchName === branch);
        }

        if (fromDate && toDate) {
            filtered = filtered.filter(f => {
                if (!f.joiningDate) return false;
                var joinDate = new Date(f.joiningDate);
                return joinDate >= new Date(fromDate) && joinDate <= new Date(toDate);
            });
        }

        renderTable(filtered);
    });

    // ✅ Print Report
    $("#printBankReportBtn").click(function () {
        var content = document.getElementById("bankReportContent").innerHTML;
        var printWindow = window.open("", "", "width=900,height=700");
        printWindow.document.write(
            "<html><head><title>Financial Consultant Report</title>" +
            "<link href='https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css' rel='stylesheet'>" +
            "<style>body { font-family: Arial; padding: 20px; } h4,h5,h6{color:#0d6efd;} table{width:100%;border-collapse:collapse;} th,td{padding:8px;border:1px solid #ddd;} th{background-color:#f2f2f2;}</style>" +
            "</head><body>" + content + "</body></html>"
        );
        printWindow.document.close();
        printWindow.focus();
        printWindow.print();
    });
});
