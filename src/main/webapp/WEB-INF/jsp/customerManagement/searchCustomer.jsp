
<div class="pagetitle">
	<h1>CUSTOMER MANAGEMENT</h1>
	<nav>
		<ol class="breadcrumb">
			<li class="breadcrumb-item"><a href="openDashboard"> <i
					class="bi bi-people-fill"></i>
			</a></li>
			<li class="breadcrumb-item action">SEARCH CUSTOMER</li>
		</ol>
	</nav>
</div>

<div>
	<form id="formid">
		<div>
			<nav>
				<ol class="breadcrumb breadcrumb-title">
					<li class="breadcrumb-item action">Search Box</li>
				</ol>
			</nav>
			<div class="row">
				<div class="col-lg-3">
					<div class="d-flex flex-column formFields">
						<label for="">Branch</label> <select id="branchName"
							name="branchName" required="required"
							class="form-control selectField" style="height: 30px;">
							<option value="">Select Branch</option>

						</select>
					</div>
				</div>



				<div class="col-lg-3">
					<div class="d-flex flex-column formFields mb-4">
						<label for="">Customer Name</label> <input type="text"
							name="customerName" id="customerName" required="required"
							placeholder="Enter Customer Name" />
					</div>
				</div>




			</div>
		</div>
	</form>
</div>

<div class="row mt-5">
	<div class="col-12">
		<div class="card recent-sales">

			<div class="card-body table-responsive">
				<table class="table table-borderless datatable"
					style="white-space: nowrap;">
					<thead class="table-light">
						<tr
							style="font-family: 'Poppins', sans-serif; white-space: nowrap;">
							<th scope="col">Sl No.</th>
							<th scope="col">Customer Name</th>
							<th scope="col">Gender</th>
							<th scope="col">Date Of Birth</th>
							<th scope="col">Aadhar No</th>
							<th scope="col">PAN</th>
							<th scope="col">Contact No.</th>
							<th scope="col">Address</th>
							<th scope="col">Nominee Name</th>
						</tr>
					</thead>
					<tbody>
					</tbody>
				</table>
			</div>
		</div>
	</div>
</div>

</div>

<script>
	$(document).ready(
			function() {
				$.ajax({
					url : "api/customermanagement/getAllCustomer",
					type : "GET",
					success : function(data) {
						var tbody = $("table tbody");
						tbody.empty(); // Clear existing rows

						for (var i = 0; i < data.length; i++) {
							var customer = data[i];
							var status = customer.approved ? "Approved"
									: "Pending";

							var row = "<tr>" + "<td>" + (i + 1) + "</td>"
									+ "<td>" + (customer.customerName || '')
									+ "</td>" + "<td>"
									+ (customer.customerGender || '') + "</td>"
									+ "<td>" + (customer.dob || '') + "</td>"
									+ "<td>" + (customer.aadharNo || '')
									+ "</td>" + "<td>" + (customer.panNo || '')
									+ "</td>" + "<td>"
									+ (customer.contactNo || '') + "</td>"
									+ "</td>" + "<td>"
									+ (customer.customerAddress || '')
									+ "</td>" + "<td>"
									+ (customer.nomineeName || '') + "</td>"
									+ "</tr>";

							tbody.append(row);
						}
					},
					error : function() {
						alert("Failed to fetch customer data.");
					}
				});
			});
</script>

<script
	src="${pageContext.request.contextPath}/js/customerManagement/addCustomer.js"></script>
