function getCashBook() {

	let branchName = $("#branchName").val();
	let startDate = $("#startDate").val();
	let endDate = $("#endDate").val();

	if (!branchName || !startDate || !endDate) {
		alert("Please select all fields");
		return;
	}

	$("#showDetilsBtn").prop("disabled", true).text("Loading...");

	$.ajax({
		url: "accountManagement/getCashBookTransaction",
		type: "GET",
		data: {
			branchName: branchName,
			startDate: startDate,
			endDate: endDate
		},

		success: function(response) {

			if (response.status === "OK") {
				bindTable(response.data);
			} else {
				alert(response.message);
			}

			$("#showDetilsBtn").prop("disabled", false).text("SHOW DETAILS");
		},

		error: function() {
			alert("Error fetching data");
			$("#showDetilsBtn").prop("disabled", false).text("SHOW DETAILS");
		}
	});
}


// ================= TABLE =================
function bindTable(data) {

	let rows = "";
	let totalDebit = 0;
	let totalCredit = 0;
	let closingBalance = 0;

	if (!data || data.length === 0) {

		rows = `<tr><td colspan="8" class="text-center">No Records Found</td></tr>`;

	} else {

		let runningBalance = 0;

		data.forEach((item, index) => {

			let debit = parseFloat(item.debit || 0);
			let credit = parseFloat(item.credit || 0);

			totalDebit += debit;
			totalCredit += credit;

			// ✅ Running Balance
			runningBalance += (debit - credit);
			closingBalance = runningBalance;

			rows += `
				<tr>
					<td>${index + 1}</td>
					<td>${item.transactionDate || '-'}</td>
					<td>${item.referenceNo || '-'}</td>
					<td>${item.accountNumber || '-'}</td>
					<td>${item.narration || '-'}</td>
					<td class="text-end">${debit.toFixed(2)}</td>
					<td class="text-end">${credit.toFixed(2)}</td>
					<td class="text-end">${runningBalance.toFixed(2)}</td>
				</tr>
			`;
		});
	}

	$(".datatable tbody").html(rows);

	$("#totalDebit").text(totalDebit.toFixed(2));
	$("#totalCredit").text(totalCredit.toFixed(2));
	$("#closingBalance").text(closingBalance.toFixed(2));
}


// ================= EXPORT =================
function exportToExcel() {

	let table = document.querySelector(".datatable");

	if ($(".datatable tbody tr").length === 0) {
		alert("No data to export");
		return;
	}

	let wb = XLSX.utils.book_new();
	let ws = XLSX.utils.table_to_sheet(table);

	XLSX.utils.book_append_sheet(wb, ws, "Cash Book");

	XLSX.writeFile(wb, "Cash_Book_Report.xlsx");
}


// ================= PRINT =================
function printReport() {

	let table = document.querySelector(".datatable").outerHTML;

	let branch = $("#branchName option:selected").text();
	let startDate = $("#startDate").val();
	let endDate = $("#endDate").val();

	let printWindow = window.open('', '', 'width=900,height=700');

	printWindow.document.write(`
		<html>
		<head>
			<title>Cash Book</title>
			<style>
				body { font-family: Arial; padding:20px; }
				h2 { text-align:center; }
				table { width:100%; border-collapse:collapse; }
				table, th, td { border:1px solid black; }
				th, td { padding:8px; text-align:center; }
				.text-end { text-align:right; }
			</style>
		</head>
		<body>

		<h2>CASH BOOK REPORT</h2>

		<p>
			<b>Branch:</b> ${branch} <br>
			<b>From:</b> ${startDate} &nbsp;&nbsp;
			<b>To:</b> ${endDate}
		</p>

		${table}

		<br>
		<p style="text-align:right;">
			<b>Total Debit:</b> ${$("#totalDebit").text()} |
			<b>Total Credit:</b> ${$("#totalCredit").text()} |
			<b>Closing Balance:</b> ${$("#closingBalance").text()}
		</p>

		</body>
		</html>
	`);

	printWindow.document.close();

	setTimeout(() => {
		printWindow.print();
		printWindow.close();
	}, 500);
}