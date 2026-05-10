$(document).ready(function() {

	loadLedger();

	// 🔍 Search button click
	$("#serachBtn").click(function(e) {
		e.preventDefault();
		loadTransactions();
	});

});

// ================= LOAD LEDGER =================
function loadLedger() {

	$.ajax({
		url: "accountManagement/getUniqueLedgerDropdown",
		type: "GET",
		success: function(response) {

			let options = '<option value="">--SELECT LEDGER--</option>';

			if (response && response.data) {

				response.data.forEach(function(item) {

					options += `
	                    <option value="${item.accountCode}">
	                        ${item.accountCode} - ${item.accountTitle}
	                    </option>
	                `;
				});
			}

			$("#chooseLedger").html(options);
		},
		error: function() {
			alert("❌ Error loading ledger dropdown");
		}
	});
}


// ================= LOAD TRANSACTIONS =================
function loadTransactions() {

	let branchName = $("#branchName").val();
	let accountNumber = $("#chooseLedger").val();
	let startDate = $("#startDate").val();
	let endDate = $("#endDate").val();

	// ✅ Validation
	if (!branchName || !accountNumber || !startDate || !endDate) {
		alert("⚠ Please fill all fields");
		return;
	}

	// 🔄 Loader (optional)
	$(".datatable tbody").html(`<tr><td colspan="8" class="text-center">Loading...</td></tr>`);

	$.ajax({
		url: "accountManagement/daily-transaction",
		type: "GET",
		data: {
			branchName: branchName,
			accountNumber: accountNumber,
			startDate: startDate,
			endDate: endDate
		},

		success: function(response) {

			let tableBody = "";
			let count = 1;

			if (response && response.status === "OK" && response.data.length > 0) {

				let runningBalance = 0;

				response.data.forEach(function(txn) {

					let debit = txn.debit ? parseFloat(txn.debit) : 0;
					let credit = txn.credit ? parseFloat(txn.credit) : 0;

					// ✅ Running Balance Calculate
					runningBalance += (credit - debit);

					tableBody += `
                        <tr>
                            <td>${count++}</td>
                            <td>${txn.transactionDate || '-'}</td>
                            <td>${txn.referenceNo || '-'}</td>
                            <td>${txn.accountCode || txn.accountNumber || '-'}</td>
                            <td>${txn.narration || '-'}</td>
                            <td>${debit.toFixed(2)}</td>
                            <td>${credit.toFixed(2)}</td>
                            <td>${runningBalance.toFixed(2)}</td>
                        </tr>
                    `;
				});

			} else {
				tableBody = `
                    <tr>
                        <td colspan="8" class="text-center text-danger">
                            No Data Found
                        </td>
                    </tr>
                `;
			}

			$(".datatable tbody").html(tableBody);
		},

		error: function(xhr) {
			console.error(xhr);
			$(".datatable tbody").html(`
                <tr>
                    <td colspan="8" class="text-center text-danger">
                        Error fetching data
                    </td>
                </tr>
            `);
		}
	});
}

function exportToExcel() {

	let table = document.querySelector(".datatable");

	// ❌ Check if no data
	let rows = table.querySelectorAll("tbody tr");
	if (rows.length === 1 && rows[0].innerText.includes("No Data")) {
		alert("⚠ No data to export");
		return;
	}

	// ✅ Convert table to worksheet
	let wb = XLSX.utils.book_new();
	let ws = XLSX.utils.table_to_sheet(table);

	// ✅ Add sheet
	XLSX.utils.book_append_sheet(wb, ws, "Transactions");

	// ✅ File name with date
	let today = new Date().toISOString().slice(0, 10);

	XLSX.writeFile(wb, "Daily_Transaction_" + today + ".xlsx");
}

function printReport() {

	let table = document.querySelector(".datatable").outerHTML;

	let branch = $("#branchName option:selected").text();
	let ledger = $("#chooseLedger option:selected").text();
	let startDate = $("#startDate").val();
	let endDate = $("#endDate").val();

	let printWindow = window.open('', '', 'width=900,height=700');

	printWindow.document.write(`
        <html>
        <head>
            <title>Print Report</title>
            <style>
                body {
                    font-family: Arial, sans-serif;
                    padding: 20px;
                }
                h2 {
                    text-align: center;
                    margin-bottom: 10px;
                }
                .info {
                    margin-bottom: 15px;
                }
                table {
                    width: 100%;
                    border-collapse: collapse;
                }
                table, th, td {
                    border: 1px solid #000;
                }
                th, td {
                    padding: 8px;
                    text-align: center;
                }
                .text-end {
                    text-align: right;
                }
            </style>
        </head>
        <body>

            <h2>DAILY TRANSACTION REPORT</h2>

            <div class="info">
                <b>Branch:</b> ${branch} <br>
                <b>Ledger:</b> ${ledger} <br>
                <b>From:</b> ${startDate} &nbsp;&nbsp;
                <b>To:</b> ${endDate}
            </div>

            ${table}

        </body>
        </html>
    `);

	printWindow.document.close();
	printWindow.focus();

	// ⏱ Thoda delay for rendering
	setTimeout(function() {
		printWindow.print();
		printWindow.close();
	}, 500);
}