
<style>
body {
	font-family: Arial, sans-serif;
	background: #f2f2f2;
	margin: 0;
	padding: 0;
}

.container {
	max-width: 1000px;
	margin: 40px auto;
	padding: 60px;
	background: white;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
}

h2 {
	color: #444;
	margin-bottom: 20px;
	border-bottom: 2px solid #ddd;
	padding-bottom: 10px;
}

.user-id-section {
	background-color: #f9f9f9;
	border: 1px solid #ccc;
	padding: 20px;
	margin-bottom: 30px;
	border-radius: 8px;
	box-shadow: 2px 2px 8px rgba(0, 0, 0, 0.05);
}

.user-id-box {
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.user-id-box label {
	font-weight: bold;
}

select {
	padding: 6px 10px;
	border-radius: 4px;
	border: 1px solid #ccc;
	font-size: 14px;
}

.box-group {
	display: flex;
	flex-wrap: wrap;
	gap: 20px;
	justify-content: space-between;
}

.user-box {
	flex: 0 1 calc(50% - 10px);
	background: #fff;
	padding: 15px;
	border: 1px solid #ddd;
	border-radius: 6px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
	box-sizing: border-box;
	display: flex;
	flex-direction: column;
	gap: 10px;
}

.user-box label {
	font-weight: bold;
	margin-bottom: 8px;
}

.member-row {
	display: flex;
	align-items: center;
	justify-content: space-between;
	background-color: #fafafa;
	padding: 6px 10px;
	border-radius: 4px;
	border: 1px solid #eee;
	gap: 10px;
}

.checkbox-col {
	flex: 0 0 20px;
}

.bold-text {
	flex: 1;
	font-weight: bold;
	text-align: center;
}

.normal-text {
	flex: 1;
	font-weight: normal;
	text-align: right;
}

@media ( max-width : 768px) {
	.user-box {
		flex: 1 1 100%;
	}
}
</style>

<div class="pagetitle">
	<h1>User Menu Access</h1>

</div>

<div>
	<div class="user-id-section">
		<div class="user-id-box">
			<label for="customerId" id="customerSelection">Customer
				Selection </label> <select id="customerId" name="customerId"
				class="form-control selectField" style="width: 100%;">
				<option value="">-- Search Customer ID --</option>
			</select>
		</div>
	</div>

	<!-- Box Group -->
	<div class="box-group">

		<!-- Member Section -->
		<div class="user-box">
			<label>Customer Management</label>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Management =></div>
				<div class="normal-text">Add Customer</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Management =></div>
				<div class="normal-text">Add Customer KYC</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Management =></div>
				<div class="normal-text">Customer Summaryr</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Management =></div>
				<div class="normal-text">Customer Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Management =></div>
				<div class="normal-text">Search Customer</div>
			</div>


		</div>

		<div class="user-box">
			<label>Customer Shareholding</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Shareholding =></div>
				<div class="normal-text">Transfer Shares</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Shareholding =></div>
				<div class="normal-text">Unallotted Shares</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Shareholding =></div>
				<div class="normal-text">Generate Share Certificate</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Shareholding =></div>
				<div class="normal-text">Regenerate DNO</div>
			</div>

		</div>

		<!-- Data Entry -->
		<div class="user-box">
			<label>Account Management</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Ledger Account Master</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Outgoing Payment Entry</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Incoming Receipt Entry</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Bank / Cash Transfer</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Manual Journal Entry</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Incentive Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Incentive Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">MIS Interest Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Cheque Clearing Processing</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Mandate Deposit To Bank</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Bank Statement</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Cash Book</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Funds Transfer Register</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Daily Transaction Book</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Ledger Summary Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Journal Entry Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Trial Balance Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">P/L Statement</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Balance Sheet</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Account Management =></div>
				<div class="normal-text">Inter Branch Cash Transfer</div>
			</div>


		</div>

		<!-- Report Access -->
		<div class="user-box">
			<label>Customer Savings</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Savings Scheme Catalog</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Create Savings Account</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Saving Account Activity</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Savings Account Funds Transfer</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Savings Account Interest Transfer</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Savings Record Book</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Customer Savings Statement</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Saving Account Closer</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Savings Account Inquiry</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">SMS Service Fee</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Customer Savings =></div>
				<div class="normal-text">Account Maintenance Charges</div>
			</div>
		</div>

		<!-- Extra Role -->
		<div class="user-box">
			<label>Policy Management</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Plan Management</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Add New Investment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Policy Renewal Fee</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Daily Premium Renewal</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Flexible Premium Renewal</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Installment Record Book</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Investment Transaction Slip</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Recurring Payment Receipt</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Issue Certificate</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">ReIssue Certificate</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Interest Details</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Interest Payable</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Policy Management =></div>
				<div class="normal-text">Investment Data Search</div>
			</div>
		</div>

		<div class="user-box">
			<label>Loan Management</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Loan Scheme Catalog</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">EMI & Loan Calculator</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">New Loan Application</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Loan Approval</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Loan Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Regular Installment Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Irregular Installment Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Regular Loan Statement</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Irregular Loan Statement</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Generate Loan Documents</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Early Loan Closure</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Settled Loan Records</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Generate NOC Certificate</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Loan Management =></div>
				<div class="normal-text">Search Loan Accounts</div>
			</div>
		</div>

		<div class="user-box">
			<label>Joint Liability Loan</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">Loan Scheme Catalog</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">EMI & Loan Calculator</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">New Loan Application</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">Loan Approval</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">Loan Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">Regular Installment Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">Irregular Installment Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">Regular Loan Statement</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">Irregular Loan Statement</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Joint Liability Loan =></div>
				<div class="normal-text">Generate Loan Documents</div>
			</div>

		</div>

		<div class="user-box">
			<label>Request Approvals</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve New Client Request</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Share Transactions</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Finance Onboarding</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Policy</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve RD</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Recurring Deposits</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Saving Transactions</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Savings Account Transfers</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Regular EMI Payments</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Irregular EMI Payments</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Manual Payment Entries</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Maturity Applications</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Delete Maturity Applications Request</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Request Approvals =></div>
				<div class="normal-text">Approve Inter-Branch Cash Transfer</div>
			</div>

		</div>

		<div class="user-box">
			<label>Data Correction</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Customer Data Update</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Shareholding Adjustment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Financial Entry Correction</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Policy Details Update</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Renewal Data Correction</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Daily Renewal Update</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Flexible Transaction Removal</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Savings Account Correction</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Savings Transaction Removal</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Loan Account Correction</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Data Correction =></div>
				<div class="normal-text">Joint Liability Update</div>
			</div>

		</div>

		<div class="user-box">
			<label>Maturity Management</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Maturity Management =></div>
				<div class="normal-text">Maturity Scheme Master</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Maturity Management =></div>
				<div class="normal-text">Apply For Maturity</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Maturity Management =></div>
				<div class="normal-text">Full Maturity Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Maturity Management =></div>
				<div class="normal-text">Partial Maturity Payment</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Maturity Management =></div>
				<div class="normal-text">Maturity Application Status</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Maturity Management =></div>
				<div class="normal-text">Approved Status</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Maturity Management =></div>
				<div class="normal-text">Full Payment Status</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Maturity Management =></div>
				<div class="normal-text">Partial Payment Status</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Maturity Management =></div>
				<div class="normal-text">Print Maturity Receipt</div>
			</div>

		</div>

		<div class="user-box">
			<label>Incentive Management</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Incentive Management =></div>
				<div class="normal-text">Incentive Scheme Master</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Incentive Management =></div>
				<div class="normal-text">Generate Incentive Payments</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Incentive Management =></div>
				<div class="normal-text">Incentive Payment Details</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Incentive Management =></div>
				<div class="normal-text">Incentive Summary Report</div>
			</div>

		</div>

		<div class="user-box">
			<label>Financial Consultant</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Financial Consultant =></div>
				<div class="normal-text">Add Financial Consultant</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Financial Consultant =></div>
				<div class="normal-text">Financial Consultant Hierarchy</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Financial Consultant =></div>
				<div class="normal-text">Consultant Downline View</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Financial Consultant =></div>
				<div class="normal-text">Consultant Promotion Management</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Financial Consultant =></div>
				<div class="normal-text">Consultant ID Card Generator</div>
			</div>

		</div>

		<div class="user-box">
			<label>Team Management</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Team Management =></div>
				<div class="normal-text">Manage Designations</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Team Management =></div>
				<div class="normal-text">Manage Departments</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Team Management =></div>
				<div class="normal-text">Add Team Member</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Team Management =></div>
				<div class="normal-text">Generate Team Member ID Card</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Team Management =></div>
				<div class="normal-text">Search Team Member</div>
			</div>

		</div>

		<div class="user-box">
			<label>Reports & Analytics</label>
			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Investment Transaction Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Investment Summary Statement</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Financial Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Financial Consultant Team Collection
					Summary</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Cheque Transaction Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Incentive Payment Summary</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Recurring Installment Due Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Unapproved Loan Applications</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Approved Loan Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Loan Repayment Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Upcoming EMI Due Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Overdue Repayment Analysis</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Loan Installment Pending Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">EMI Collection Summary</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">EMI Irregularity Statement</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Loan Confirmation Document</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Maturity Status Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Investment Projection Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Maturity Obligation Report</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Tax Deducted at Source Summary</div>
			</div>

			<div class="member-row">
				<div class="checkbox-col">
					<input type="checkbox">
				</div>
				<div class="bold-text">Reports & Analytics =></div>
				<div class="normal-text">Policy Performance Report</div>
			</div>

		</div>
		<div class="row">
			<div class="col-12 text-center mt-4" style="margin-left: 300px;">
				<button type="button" id="saveAccessBtn" class="btnStyle bg-warning">Save</button>

			</div>
		</div>

	</div>

</div>

<script
	src="${pageContext.request.contextPath}/js/preferences/customerMenuAccess.js"></script>