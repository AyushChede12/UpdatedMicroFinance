
//janvi sonkusare
// Branch Filter (Column 9)
const inputBranch = document.getElementById("branchName");
inputBranch.addEventListener("change", filterBranchAndDate);

// From Date Filter (Registration Date)
const inputFromDate = document.getElementById("dateFrom");
inputFromDate.addEventListener("input", filterBranchAndDate);

// To Date Filter (Registration Date)
const inputToDate = document.getElementById("dateTo");
inputToDate.addEventListener("input", filterBranchAndDate);

// Function to filter by both Branch and Date together
function filterBranchAndDate() {
    const branchKeyword = document.getElementById("branchName").value;
    const fromDate = document.getElementById("dateFrom").value;
    const toDate = document.getElementById("dateTo").value;

    const rows = document.querySelectorAll("#searchTeamMember tr");

    rows.forEach(row => {
        const branch = row.cells[6] ? row.cells[6].textContent.trim() : ''; // Column 9: Branch
        const dateCell = row.cells[4] ? row.cells[4].textContent.trim() : ''; // Column 5: Registration Date
        const rowDate = new Date(dateCell);

        // Filter by Branch and Date Range
        let showRow = true;
        
        if (branchKeyword && branch !== branchKeyword) {
            showRow = false;
        }

        // Filter by Date Range
        if (fromDate && new Date(fromDate) > rowDate) {
            showRow = false;
        }

        if (toDate && new Date(toDate) < rowDate) {
            showRow = false;
        }

        row.style.display = showRow ? "" : "none";
    });
}

// Applicant name Filter (Column 2)
const inputaccHolderName = document.getElementById("teamMemberName");
inputaccHolderName.addEventListener("input", function() {
    filterTableByColumn(1, inputaccHolderName.value);
});

// Account no. Filter (Column 1)
const inputaccountNo = document.getElementById("teamMamberCode");
inputaccountNo.addEventListener("input", function() {
    filterTableByColumn(7, inputaccountNo.value); // Column 2: Member Name
});

// Member code Filter (Column 6)
const inputmemberCode = document.getElementById("contactNo");
inputmemberCode.addEventListener("input", function() {
    filterTableByColumn(5, inputmemberCode.value); // Column 7: Mobile No.
});

// Advisor/collector code Filter (Column 9)
const inputadvisorCode = document.getElementById("designation");
inputadvisorCode.addEventListener("input", function() {
    filterTableByColumn(8, inputadvisorCode.value); // Column 5: Aadhar No.
});

// Scheme name Filter (Column 3)
const inputsBPlan = document.getElementById("department");
inputsBPlan.addEventListener("change", function() {
    filterTableByColumn(9, inputsBPlan.value); // Column 6: PAN No.
}); 


function filterTableByColumn(index, keyword) {
	const rows = document.querySelectorAll("#searchTeamMember tr");
	keyword = keyword.toLowerCase();

	rows.forEach(row => {
		const cell = row.cells[index];
		if (cell) {
			const text = cell.textContent.toLowerCase();
			row.style.display = text.includes(keyword) ? "" : "none";
			//const isMatch = text.includes(keyword);
			// Don't override if already hidden by another filter
			/*if (row.style.display !== "none") {
				row.style.display = isMatch ? "" : "none";
			}*/
		}
	});
}
