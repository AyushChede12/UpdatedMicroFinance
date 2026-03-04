$(document).ready(function () {

    if (window.financialConsultantInitialized) {
        console.warn("Financial Consultant JS already initialized");
        return;
    }
    window.financialConsultantInitialized = true;

    var allFinancialConsultants = [];

    /* ================= COMPANY DETAILS ================= */

    const companyDetails = {
        name: "CO OPERATIVE SOCIETY LTD NAGPUR",
        address: "PLOT NO 497 NEW NANDANWAN",
        state: "MAHARASHTRA",
        pin: "440024",
        cin: "ASJ#567",
        email: "example@gmail.com",
        helpline: "9566200223",
        branchManager: "9558712001"
    };

    /* ================= FETCH DATA ================= */

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

    function normalize(text) {
        return text?.toString().replace(/\s+/g, " ").trim().toUpperCase();
    }

    /* ================= BRANCH DROPDOWN ================= */

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

    /* ================= TABLE ================= */

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
                approvedStatus = '<span style="color: green; font-weight:600;">APPROVED</span>';
            } else if (f.approved === false) {
                approvedStatus = '<span style="color:red; font-weight:600;">NOT APPROVED</span>';
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

    /* ================= MODAL DATA SET ================= */

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

            $("#selectPosition").text(f.selectPosition || "N/A");

            $("#address").text(f.address || "N/A");
            $("#district").text(f.district || "N/A");
            $("#state").text(f.state || "N/A");
            $("#pinCode").text(f.pinCode || "N/A");
            $("#profession").text(f.profession || "N/A");
            $("#academicBackground").text(f.academicBackground || "N/A");

            $("#fees").text(f.fees || "0");
            $("#modeofPayment").text(f.modeofPayment || "N/A");
            $("#chequeNo").text(f.chequeNo || "N/A");
            $("#chequeDate").text(f.chequeDate || "N/A");
            $("#depositAccount").text(f.depositAccount || "N/A");
            $("#refNo").text(f.refNo || "N/A");

            $("#referralCode").text(f.referralCode || "N/A");
            $("#referralName").text(f.referralName || "N/A");

            $("#comments").text(f.comments || "N/A");
            $("#financialStatus").text(f.financialStatus || "N/A");
            $("#smsSend").text(f.smsSend || "N/A");
            $("#isApproved").text(f.approved ? "APPROVED" : "NOT APPROVED");
        });
    }

    /* ================= FILTER ================= */

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
	/* ================= PRINT ================= */

	$(document).off("click", "#printBankReportBtn").on("click", "#printBankReportBtn", function () {

	    var content = document.getElementById("bankReportContent").innerHTML;

	    var newWindow = window.open('', '', 'width=900,height=700');

	    newWindow.document.write(`
	    <html>
	    <head>
	    <title>Consultant Report</title>

	    <style>

	    body{
	        font-family: Arial;
	        padding:30px;
	        background:#fff;
	    }

	    .center{
	        text-align:center;
	        margin-bottom:15px;
	    }

	    .company{
	        font-size:24px;
	        font-weight:bold;
	    }

	    .line{
	        margin-top:4px;
	        font-size:15px;
	    }

	    .info{
	        margin-top:6px;
	        font-size:14px;
	    }

	    hr{
	        margin:20px 0;
	    }

	    .box{
	        border:1px solid #ddd;
	        border-radius:8px;
	        padding:15px;
	        margin-bottom:15px;
	    }

	    .title{
	        font-weight:bold;
	        color:#0d6efd;
	        margin-bottom:10px;
	        font-size:16px;
	    }

	    .row{
	        display:flex;
	        gap:20px;
	        margin-bottom:10px;
	    }

	    .col{
	        flex:1;
	    }

	    p{
	        margin:4px 0;
	        font-size:14px;
	    }

	    </style>

	    </head>

	    <body>

	    <div class="center">

	        <div class="company">${companyDetails.name}</div>
	        <div class="line">${companyDetails.address}</div>
	        <div class="line">${companyDetails.state} - ${companyDetails.pin}</div>

	        <div class="info">
	        CIN : ${companyDetails.cin} |
	        Email : ${companyDetails.email} |
	        Helpline : ${companyDetails.helpline}, ${companyDetails.branchManager}
	        </div>

	    </div>

	    <hr>

	    ${content}

	    </body>
	    </html>
	    `);

	    newWindow.document.close();
	    newWindow.focus();
	    newWindow.print();
	});
	});