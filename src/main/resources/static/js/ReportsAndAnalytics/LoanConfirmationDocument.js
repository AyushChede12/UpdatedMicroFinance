$(document).ready(function () {

    let allLoans = [];

    // ==========================
    // Load Loan Plan Dropdown
    // ==========================
    $.ajax({
        url: "api/datacorrection/fetchAllApprovedLoanApplications",
        type: "GET",
        success: function (response) {

            if (response.status === "OK") {

                allLoans = response.data;

                const uniquePlans = new Set();

                allLoans.forEach(item => {
                    let planName = item.loanPlanName || item.typeOfLoan;
                    if (planName) {
                        uniquePlans.add(planName.trim());
                    }
                });

                $("#loanPlanName").empty();
                $("#loanPlanName").append("<option value=''>-- Select Loan Name --</option>");

                uniquePlans.forEach(plan => {
                    $("#loanPlanName").append(
                        `<option value="${plan}">${plan}</option>`
                    );
                });

                // First time table load
                bindTable(allLoans);

            } else {
                alert("Error : " + response.message);
            }

        },
        error: function (xhr) {
            if (xhr.status !== 404) {
                alert("API Error");
            }
        }
    });


    // ==========================
    // FIND BUTTON
    // ==========================
    $("#findBtn").click(function (e) {

        e.preventDefault();

        let plan = $("#loanPlanName").val();
        let financialCode = $("#financialCode").val().trim().toUpperCase();
        let toDate = $("#toDate").val();

        function parseDate(dateStr) {
            if (!dateStr) return null;
            if (typeof dateStr === 'string') {
                let parts = dateStr.split(/[-/]/);
                if (parts.length === 3) {
                    if (parts[0].length !== 4) {
                        dateStr = `${parts[2]}-${parts[1]}-${parts[0]}`;
                    }
                }
            }
            let d = new Date(dateStr);
            return isNaN(d) ? null : d;
        }

        let filtered = allLoans.filter(item => {

            let loanDate = parseDate(item.loanDate);
            let tDate = toDate ? new Date(toDate) : null;
            if (tDate) tDate.setHours(23, 59, 59, 999);
            
            let planName = item.loanPlanName || item.typeOfLoan || "";

            return (
                (!plan || planName === plan) &&
                (!financialCode || (item.financialConsultantId && item.financialConsultantId.toUpperCase().includes(financialCode))) &&
                (!tDate || (loanDate && loanDate <= tDate))
            );

        });

        bindTable(filtered);

    });

});


// ==========================
// TABLE BIND FUNCTION
// ==========================
function bindTable(data) {

    let tbody = $(".datatable tbody");
    tbody.empty();

    if (!data.length) {
        tbody.append("<tr><td colspan='13'>No Data Found</td></tr>");
        return;
    }

    data.forEach(function (loan, index) {

        let loanAmount = parseFloat(loan.loanAmount || 0);
        let disbursedAmount = parseFloat(loan.disbursedAmount || 0);
        let totalPaid = parseFloat(loan.totalPaidAmount || 0);

        let outstanding = (disbursedAmount - totalPaid).toFixed(2);

        let row = `
        <tr>
            <td>${index + 1}</td>
            <td>${loan.loanId || ""}</td>
            <td>${loan.memberName || ""}</td>
            <td>${loan.loanPlanName || ""}</td>
            <td>${loanAmount}</td>
            <td>${disbursedAmount}</td>
            <td>${loan.rateOfInterest || ""}</td>
            <td>${loan.loanTerm || ""}</td>
            <td>${loan.loanStartDate || ""}</td>
            <td>${loan.loanEndDate || ""}</td>
            <td>${totalPaid}</td>
            <td>${outstanding}</td>
            <td>${loan.confirmationStatus || "Pending"}</td>
        </tr>
        `;

        tbody.append(row);

    });

}