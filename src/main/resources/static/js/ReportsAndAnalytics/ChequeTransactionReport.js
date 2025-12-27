$(document).ready(function() {
	loadChequeData();

	// --- Find button pe filter apply karna hai ---
	$("#findBtn").click(function() {
		applyFilters();
	});
});

// --- Global Data Store ---
let allChequeData = [];
let rowIndex = 0;

function loadChequeData() {
	let tableBody = $(".datatable tbody");
	tableBody.empty();
	rowIndex = 0;
	allChequeData = [];

	// 1st API Call (Loan Payment)
	$.ajax({
		type: "GET",
		url: "api/reports/getCheckDataFromLoanPayment",
		contentType: "application/json",
		success: function(response) {
			if (response.status === "OK") {
				allChequeData = allChequeData.concat(
					response.data.map(item => ({
						id: item.id,
						name: item.memberName,
						date: item.paymentDate,
						chequeNo: item.chequeNo,
						source: "Loan Payment"
					}))
				);
				savingActivityChequeData();
			}
		}
	});
}

function savingActivityChequeData() {
	$.ajax({
		type: "GET",
		url: "api/reports/getPayByFromSavingAccountActivity",
		contentType: "application/json",
		success: function(response) {
			if (response.status === "OK") {
				allChequeData = allChequeData.concat(
					response.data.map(item => ({
						id: item.id,
						name: item.customerName,
						date: item.transactionDate,
						chequeNo: item.chequeNo,
						source: "Saving Activity"
					}))
				);
				createsavingAccountChequeData();
			}
		}
	});
}

function createsavingAccountChequeData() {
	$.ajax({
		type: "GET",
		url: "api/reports/getCheckDataFromCreateSavings",
		contentType: "application/json",
		success: function(response) {
			if (response.status === "OK") {
				allChequeData = allChequeData.concat(
					response.data.map(item => ({
						id: item.id,
						name: item.enterCustomerName,
						date: item.openingDate,
						chequeNo: item.chequeNo,
						source: "Create Savings"
					}))
				);
				FinancialConsultantChequeData();
			}
		}
	});
}

function FinancialConsultantChequeData() {
	$.ajax({
		type: "GET",
		url: "api/reports/getCheckDataFromFinancialConsultant",
		contentType: "application/json",
		success: function(response) {
			if (response.status === "OK") {
				allChequeData = allChequeData.concat(
					response.data.map(item => ({
						id: item.id,
						name: item.financialName,
						date: item.joiningDate,
						chequeNo: item.chequeNo,
						source: "Financial Consultant"
					}))
				);
				TeamMemberChequeData();
			}
		}
	});
}

function TeamMemberChequeData() {
	$.ajax({
		type: "GET",
		url: "api/reports/getCheckDataFromTeamMember",
		contentType: "application/json",
		success: function(response) {
			if (response.status === "OK") {
				allChequeData = allChequeData.concat(
					response.data.map(item => ({
						id: item.id,
						name: item.teamMemberName,
						date: item.signUpDate,
						chequeNo: item.chequeNo,
						source: "Team Member"
					}))
				);
				renderTable(allChequeData); // final render
			}
		}
	});
}

// -------------------- FILTERS --------------------
function applyFilters() {
	let fDate = $("#fDate").val();
	let tDate = $("#tDate").val();
	let chequeNo = $("#chequeNo").val().trim();

	let filteredData = allChequeData.filter(item => {
		let itemDate = new Date(item.date);
		let fromDate = fDate ? new Date(fDate) : null;
		let toDate = tDate ? new Date(tDate) : null;

		let dateCondition = true;
		if (fromDate && itemDate < fromDate) dateCondition = false;
		if (toDate && itemDate > toDate) dateCondition = false;

		let chequeCondition = true;
		if (chequeNo && !item.chequeNo?.toLowerCase().includes(chequeNo.toLowerCase())) {
			chequeCondition = false;
		}

		return dateCondition && chequeCondition;
	});

	renderTable(filteredData);
}

// -------------------- RENDER TABLE --------------------
function renderTable(data) {
	let tableBody = $(".datatable tbody");
	tableBody.empty();
	rowIndex = 0;

	if (data.length === 0) {
		// Agar filtered data empty hai to ek hi row dikhayenge
		let noDataRow = `<tr>
			<td colspan="6" class="text-center text-muted">No records found</td>
		</tr>`;
		tableBody.append(noDataRow);
		return;
	}

	data.forEach(item => {
		rowIndex++;
		let row = `<tr>
            <td>${rowIndex}</td>
            <td>${item.name}</td>
            <td>${item.date}</td>
            <td>${item.chequeNo || "-"}</td>
            <td>Paid</td>
            <td>
                <button class="iconbutton" onclick="viewData(${item.id})" title="View">
                    <i class="bi bi-printer" style="color: green;"></i>
                </button>
            </td>
        </tr>`;
		tableBody.append(row);
	});
}

