
//janvi : today 
function AccNoDropdown() {
    $.ajax({
        url: "api/customersavings/getAllSavingAccountData",
        type: "GET",
        success: function(response) {
			console.log("API response:", response);
            var dropdown1 = $('#accountNumber');
            dropdown1.empty();
            dropdown1.append('<option value="">Select</option>');

            if (response.status === "FOUND" && response.data) {
                $.each(response.data, function(index, item) {
                   dropdown1.append('<option value="' + item.accountNumber+ '">' + item.accountNumber + '</option>');
                });
            } else {
                dropdown1.append('<option value="">No Account Number found</option>');
            }
        },
        error: function() {
            alert("Failed to fetch Policyname.");
        }
    });
}

//fetch Policy Name
function schemeNameDropdown() {
    $.ajax({
        url: "api/customersavings/fetchsavingchemecatalog",
        type: "GET",
        success: function(response) {
			console.log("API response:", response);
            var dropdown = $('#schemename');
            dropdown.empty();
            dropdown.append('<option value="">Select</option>');

            if (response.status === "FOUND" && response.data) {
                $.each(response.data, function(index, item) {
                   dropdown.append('<option value="' + item+ '">' + item + '</option>');
                });
            } else {
                dropdown.append('<option value="">No Policyname found</option>');
            }
        },
        error: function() {
            alert("Failed to fetch Policyname.");
        }
    });
}

//search team member
let allSavingAccData = []; 
 // Global array to store all team member data

function searchInTheSavingAcc() {
	$.ajax({
		type: "GET",
		contentType: "application/json",
		url: 'api/customersavings/getAllSavingAccountData',
		data: {},
		async: false,
		success: function(response) {
			if (!response.data || response.data.length === 0) {
				alert("No data found!");
				return;
			}

			allSavingAccData = response.data; // store for filtering
			renderTable(response.data);
		},
		error: function() {
			alert("Failed to fetch data. Please try again.");
		}
	});
}

function renderTable(data) {
	let j = 1;
	
	const tableData = data.map(function(value) {			
		return (
			`<tr>
                <td>${j++}</td>
                
               <td>${value.accountNumber}</td>
									<td>${value.typeofaccount}</td>
			                        <td>${value.selectByCustomer}</td>
			                        <td>${value.enterCustomerName}</td>
									<td>${value.contactNumber}</td>
									<td>${value.branchName}</td>
									<td>${value.address}</td>
									<td>${value.district}</td>
									<td>${value.state}</td>
									<td>${value.openingDate}</td>
									<td>${value.financialConsultantCode}</td>
									<td>${value.selectPlan}</td>
									<td>${value.approved}</td>
            </tr>`
		);
	}).join('');
	$('#tableSavingAcc').html(tableData);
}

//today : Janvi

//janvi sonkusare
// Branch Filter (Column 9)
const inputBranch = document.getElementById("branchName");
inputBranch.addEventListener("change", filterBranchAndDate);

// From Date Filter (Registration Date)
const inputFromDate = document.getElementById("fromDate");
inputFromDate.addEventListener("input", filterBranchAndDate);

// To Date Filter (Registration Date)
const inputToDate = document.getElementById("toDate");
inputToDate.addEventListener("input", filterBranchAndDate);

// Function to filter by both Branch and Date together
function filterBranchAndDate() {
    const branchKeyword = document.getElementById("branchName").value;
    const fromDate = document.getElementById("fromDate").value;
    const toDate = document.getElementById("toDate").value;

    const rows = document.querySelectorAll("#tableSavingAcc tr");

    rows.forEach(row => {
        const branch = row.cells[6] ? row.cells[6].textContent.trim() : ''; // Column 9: Branch
        const dateCell = row.cells[10] ? row.cells[10].textContent.trim() : ''; // Column 5: Registration Date
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
const inputaccHolderName = document.getElementById("customerName");
inputaccHolderName.addEventListener("input", function() {
    filterTableByColumn(4, inputaccHolderName.value);
});

// Account no. Filter (Column 1)
const inputaccountNo = document.getElementById("accountNumber");
inputaccountNo.addEventListener("change", function() {
    filterTableByColumn(1, inputaccountNo.value); // Column 2: Member Name
});

// Member code Filter (Column 6)
const inputmemberCode = document.getElementById("customerCode");
inputmemberCode.addEventListener("input", function() {
    filterTableByColumn(3, inputmemberCode.value); // Column 7: Mobile No.
});

// Advisor/collector code Filter (Column 9)
const inputadvisorCode = document.getElementById("financialConsultantCode");
inputadvisorCode.addEventListener("input", function() {
    filterTableByColumn(11, inputadvisorCode.value); // Column 5: Aadhar No.
});

// Scheme name Filter (Column 3)
const inputsBPlan = document.getElementById("schemename");
inputsBPlan.addEventListener("change", function() {
    filterTableByColumn(12, inputsBPlan.value); // Column 6: PAN No.
}); 


function filterTableByColumn(index, keyword) {
	const rows = document.querySelectorAll("#tableSavingAcc tr");
	keyword = keyword.toLowerCase();

	rows.forEach(row => {
		const cell = row.cells[index];
		if (cell) {
			const text = cell.textContent.toLowerCase();
			row.style.display = text.includes(keyword) ? "" : "none";			
		}
	});
}

