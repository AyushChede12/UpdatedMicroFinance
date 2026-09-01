let allCustomers = [];
let companyDetails = null;

$(document).ready(function() {
	// 1. Fetch Company Details for Report Header
	$.ajax({
		url: "api/preference/fetchAllCompanyAdministration",
		type: "GET",
		success: function(response) {
			if (response && response.data && response.data.length > 0) {
				companyDetails = response.data[0];
			}
		},
		error: function() {
			console.error("Company API failed");
		}
	});

	// 2. Fetch Branches for Filter Dropdown
	$.ajax({
		url: "api/preference/getAllBranchModule",
		type: "GET",
		success: function(response) {
			let branchList = [];
			if (response && response.data && Array.isArray(response.data)) {
				branchList = response.data;
			} else if (Array.isArray(response)) {
				branchList = response;
			}

			$("#branchName").empty();
			$("#branchName").append("<option value=''>SELECT BRANCH</option>");
			$("#branchName").append("<option value='ALL'>ALL BRANCHES</option>");

			branchList.forEach(function(branch) {
				if (branch.branchName) {
					$("#branchName").append(`<option value="${branch.branchName}">${branch.branchName.toUpperCase()}</option>`);
				}
			});
		},
		error: function() {
			console.error("Failed to load branches for report filter");
		}
	});



	// 3. Fetch All Customers for Report Table
	$.ajax({
		url: "api/customermanagement/getAllCustomer",
		type: "GET",
		success: function(data) {
			allCustomers = Array.isArray(data) ? data : (data.data || []);
			populateTable(allCustomers);
		},
		error: function() {
			alert("Failed to fetch customer data.");
		}
	});

	// 4. Search Filter
	$("#searchBtn").on("click", function(e) {
		e.preventDefault();

		const selectedBranch = $("#branchName").val();
		const fromDate = $("#fromDate").val();
		const toDate = $("#toDate").val();

		let filtered = allCustomers;

		if (selectedBranch && selectedBranch !== "ALL") {
			filtered = filtered.filter(c => (c.branchName || "").toUpperCase() === selectedBranch.toUpperCase());
		}

		if (fromDate && toDate) {
			const from = new Date(fromDate);
			const to = new Date(toDate);
			// set to end of day
			to.setHours(23, 59, 59, 999);

			filtered = filtered.filter(c => {
				if (!c.signupDate) return false;
				const regDate = new Date(c.signupDate);
				return regDate >= from && regDate <= to;
			});
		} else if (fromDate) {
			const from = new Date(fromDate);
			filtered = filtered.filter(c => c.signupDate && new Date(c.signupDate) >= from);
		} else if (toDate) {
			const to = new Date(toDate);
			to.setHours(23, 59, 59, 999);
			filtered = filtered.filter(c => c.signupDate && new Date(c.signupDate) <= to);
		}

		populateTable(filtered);
	});

	// Direct Print Button inside Modal
	$("#directPrintBtn").on("click", function() {
		printCustomerReport();
	});

	// PDF Download
    $(document).on("click", "#downloadPDF", function(e) {

        e.preventDefault();

        const customerId = $(".bankReportBtn.active").data("id");

        if (!customerId) {
            alert("Customer not selected.");
            return;
        }

        window.location.href =
            "api/customermanagement/export/"
            + customerId
            + "/pdf";
    });

    // Word Download
    $(document).on("click", "#downloadWord", function(e) {

        e.preventDefault();

        const customerId = $(".bankReportBtn.active").data("id");

        if (!customerId) {
            alert("Customer not selected.");
            return;
        }

        window.location.href =
            "api/customermanagement/export/"
            + customerId
            + "/word";
    });
});

function getResolvedImageUrl(val) {
	if (!val || val.trim() === "" || val === "null" || val === "undefined") {
		return "Uploads/upload.png";
	}
	val = val.trim();
	if (val.startsWith("http://") || val.startsWith("https://") || val.startsWith("data:")) {
		return val;
	}
	return "Uploads/" + val.replace(/^(\/)?Uploads\//, '');
}

function getFullAbsoluteImageUrl(val) {
	const origin = window.location.origin;
	if (!val || val.trim() === "" || val === "null" || val === "undefined") {
		return `${origin}/Uploads/upload.png`;
	}
	val = val.trim();
	if (val.startsWith("http://") || val.startsWith("https://") || val.startsWith("data:")) {
		return val;
	}
	const cleanPath = val.replace(/^(\/)?Uploads\//, '');
	return `${origin}/Uploads/${cleanPath}`;
}

function populateTable(data) {
	const tbody = $(".datatable tbody");
	tbody.empty();

	if (!data || !data.length) {
		tbody.append("<tr><td colspan='14' class='text-center text-muted'>No matching records found.</td></tr>");
		return;
	}

	data.forEach((customer, i) => {
		const memberCode = (customer.memberCode || "").toUpperCase();
		const accountNo = (customer.depositAcNo || "N/A").toUpperCase();
		const branchName = (customer.branchName || "").toUpperCase();
		const dob = (customer.dob || "").toUpperCase();
		const nomineeName = (customer.nomineeName || "").toUpperCase();
		const customerAddress = (customer.customerAddress || "").toUpperCase();
		const contactNo = (customer.contactNo || "").toUpperCase();
		const aadharNo = (customer.aadharNo || "").toUpperCase();
		const panNo = (customer.panNo || "").toUpperCase();
		const signupDate = (customer.signupDate || "").toUpperCase();
		const approved = customer.approved || customer.isApproved ? "YES" : "NO";

		let fullName = [
			customer.firstName,
			customer.middleName,
			customer.lastName
		].filter(Boolean).join(" ");
		if (!fullName) {
			fullName = customer.customerName || "";
		}

		tbody.append(`
	        <tr>
	            <td>${i + 1}</td>
	            <td>${memberCode}</td>
	            <td>${fullName.toUpperCase()}</td>
	            <td><strong>${accountNo}</strong></td>
	            <td>${branchName}</td>
	            <td>${dob}</td>
	            <td>${nomineeName}</td>
	            <td>${customerAddress}</td>
	            <td>${contactNo}</td>
	            <td>${aadharNo}</td>
	            <td>${panNo}</td>
	            <td>${signupDate}</td>
	            <td>${approved}</td>
	            <td>
	                <button class="btn btn-outline-success btn-sm bankReportBtn"
	                    data-id="${customer.id}"
	                    data-bs-toggle="modal"
	                    data-bs-target="#bankReportModal"
	                    title="View & Print Report">
	                    <i class="bi bi-printer"></i>
	                </button>
	            </td>
	        </tr>
	    `);
	});

	bindModalEvents();
}

function bindModalEvents() {
	$(".bankReportBtn").off("click").on("click", function() {
		$(".bankReportBtn").removeClass("active");
        $(this).addClass("active");
		const id = $(this).data("id");
		const customer = allCustomers.find(c => c.id == id);

		if (!customer) {
			alert("Customer not found!");
			return;
		}

		// Save currently selected customer for printing
		window.currentReportCustomer = customer;

		// Company Header
		if (companyDetails) {
			$("#bankName").text(companyDetails.companyName || "SAMITHA URBAN NIDHI LIMITED");
			$("#reportTitle").text(companyDetails.shortName || "CUSTOMER PROFILE");
		} else {
			$("#bankName").text("SAMITHA URBAN NIDHI LIMITED");
			$("#reportTitle").text("CUSTOMER PROFILE");
		}

		// Customer Header & Account Number
		const accountNo = (customer.depositAcNo || "N/A").toUpperCase();
		$("#customerCode").text((customer.memberCode || "N/A").toUpperCase());
		$("#signupDate").text(customer.signupDate || "N/A");

		$("#customerAccountNo").text(accountNo);
		$.ajax({
                url: "api/customersavings/getAccountNumbersByCode",
                type: "GET",
                data: {
                    selectByCustomer: customer.memberCode
                },
                success: function(response) {

                    if (response.status === "FOUND"
                            && response.data
                            && response.data.length > 0) {

                        let account = response.data.find(function(item) {
                            return item.customerAccountNo;
                        });

                        $("#customerAccountNo").text(
                            account ? account.customerAccountNo : "N/A"
                        );

                    } else {
                        $("#customerAccountNo").text("N/A");
                    }
                },
                error: function() {
                    $("#customerAccountNo").text("N/A");
                }
            });


		// Full Name
		let fullName = [
			customer.firstName,
			customer.middleName,
			customer.lastName
		].filter(Boolean).join(" ");
		if (!fullName) {
			fullName = customer.customerName || "N/A";
		}

		// Customer Info
		$("#customerName").text(fullName.toUpperCase());
		$("#accountNoDetail").text(accountNo);
		$("#gender").text((customer.customerGender || "N/A").toUpperCase());
		$("#dob").text(customer.dob || "N/A");
		$("#age").text(customer.customerAge || "N/A");
		$("#maritalStatus").text((customer.relationshipStatus || "N/A").toUpperCase());

		// Contact Info
		$("#contactNo").text(customer.contactNo || "N/A");
		$("#email").text((customer.emailId || "N/A").toUpperCase());
		$("#address").text((customer.customerAddress || "N/A").toUpperCase());
		$("#state").text((customer.state || "N/A").toUpperCase());
		$("#district").text((customer.district || "N/A").toUpperCase());
		$("#pincode").text(customer.pinCode || "N/A");

		// KYC Details
		$("#aadhar").text(customer.aadharNo || "N/A");
		$("#pan").text((customer.panNo || "N/A").toUpperCase());
		$("#voter").text((customer.voterNo || "N/A").toUpperCase());
		$("#driving").text((customer.drivingLicenceNo || "N/A").toUpperCase());

		// Photo & Signature Display
		const photoUrl = getResolvedImageUrl(customer.customerPhoto);
		const signatureUrl = getResolvedImageUrl(customer.customerSignature);

		$("#photoPreview").attr("src", photoUrl);
		$("#photoPreview").on("error", function() {
			$(this).attr("src", "Uploads/upload.png");
		});

		$("#signaturePreview").attr("src", signatureUrl);
		$("#signaturePreview").on("error", function() {
			$(this).attr("src", "Uploads/upload.png");
		});

		$('#bankReportModal').modal('show');
	});
}

function printCustomerReport() {
	const customer = window.currentReportCustomer;
	if (!customer) {
		alert("No customer selected to print.");
		return;
	}

	const c = companyDetails || {
		companyName: "SAMITHA URBAN NIDHI LIMITED",
		shortName: "SUNL",
		address: "Head Office",
		city: "City",
		state: "State",
		pinCode: "000000",
		cinNo: "N/A",
		emailId: "info@samithaurban.com",
		helplineNo: "1800-000-0000"
	};

	let fullName = [
		customer.firstName,
		customer.middleName,
		customer.lastName
	].filter(Boolean).join(" ");
	if (!fullName) {
		fullName = customer.customerName || "N/A";
	}

	const accountNo =
        $("#customerAccountNo").text().trim() ||
        (customer.depositAcNo || "N/A").toUpperCase();
	const photoSrc = getFullAbsoluteImageUrl(customer.customerPhoto);
	const signSrc = getFullAbsoluteImageUrl(customer.customerSignature);
	const origin = window.location.origin;

	const printHtml = `
		<!DOCTYPE html>
		<html>
		<head>
			<meta charset="UTF-8">
			<title>Customer Report - ${(customer.memberCode || '').toUpperCase()}</title>
			<base href="${origin}/">
			<style>
				@page { 
					size: A4; 
					margin: 12mm 15mm 12mm 15mm; 
				}
				* {
					-webkit-print-color-adjust: exact !important;
					print-color-adjust: exact !important;
					color-adjust: exact !important;
					box-sizing: border-box;
				}
				body { 
					font-family: 'Segoe UI', Arial, sans-serif; 
					color: #222; 
					line-height: 1.35; 
					margin: 0; 
					padding: 10px; 
					background: #fff;
				}
				.header-box { 
					text-align: center; 
					border-bottom: 2.5px solid #0d6efd; 
					padding-bottom: 8px; 
					margin-bottom: 12px; 
				}
				.header-box h2 { 
					margin: 0; 
					color: #0d6efd; 
					text-transform: uppercase; 
					font-size: 20px; 
					letter-spacing: 0.5px;
				}
				.header-box h4 { 
					margin: 3px 0; 
					color: #444; 
					font-size: 13px; 
					font-weight: 600; 
					text-transform: uppercase;
				}
				.header-box p { 
					margin: 2px 0; 
					font-size: 11px; 
					color: #555; 
				}
				
				.report-title-bar { 
					background: #0d6efd !important; 
					color: #ffffff !important; 
					padding: 5px 10px; 
					font-weight: bold; 
					font-size: 12px; 
					text-transform: uppercase; 
					margin-bottom: 10px; 
					display: flex; 
					justify-content: space-between; 
					border-radius: 3px;
				}
				
				.meta-table { 
					width: 100%; 
					border-collapse: collapse; 
					margin-bottom: 10px; 
				}
				.meta-table td { 
					padding: 4px 8px; 
					font-size: 11.5px; 
					border: 1px solid #ced4da; 
				}
				.meta-table th { 
					background: #f1f4f9 !important; 
					text-align: left; 
					padding: 4px 8px; 
					font-size: 11.5px; 
					width: 22%; 
					border: 1px solid #ced4da; 
					color: #222; 
					font-weight: 600;
				}
				
				.highlight-account { 
					background-color: #e8f4fd !important; 
					font-weight: bold; 
					color: #0d6efd; 
					font-size: 12px; 
				}
				
				.section-heading { 
					background: #e9ecef !important; 
					color: #0d6efd; 
					font-size: 11.5px; 
					font-weight: bold; 
					padding: 3px 8px; 
					border-left: 4px solid #0d6efd; 
					margin-top: 8px; 
					margin-bottom: 5px; 
					text-transform: uppercase; 
				}
				
				.media-container { 
					display: flex; 
					justify-content: space-between; 
					margin-top: 12px; 
					gap: 20px;
				}
				.media-card { 
					flex: 1;
					border: 1px solid #ced4da; 
					padding: 8px; 
					border-radius: 4px; 
					text-align: center; 
					background: #fafafa;
				}
				.media-card img { 
					height: 120px; 
					max-width: 100%; 
					object-fit: contain; 
					border: 1px solid #ddd;
					background: #fff;
					padding: 2px;
					border-radius: 3px;
				}
				.media-card .signature-img {
					height: 65px;
					margin-top: 25px;
				}
				.media-card p { 
					margin: 6px 0 0 0; 
					font-size: 11px; 
					font-weight: bold; 
					color: #333;
					text-transform: uppercase;
				}
				
				.footer-note { 
					text-align: center; 
					margin-top: 15px; 
					font-size: 9.5px; 
					color: #777; 
					border-top: 1px dashed #bbb; 
					padding-top: 6px; 
				}
			</style>
		</head>
		<body>
			<div class="header-box">
				<h2>${c.companyName || 'SAMITHA URBAN NIDHI LIMITED'}</h2>
				<h4>CUSTOMER COMPREHENSIVE PROFILE REPORT</h4>
				<p>${c.address || ''}, ${c.city || ''}, ${c.state || ''} - ${c.pinCode || ''} | CIN: ${c.cinNo || 'N/A'}</p>
				<p>Email: ${c.emailId || ''} | Helpline: ${c.helplineNo || ''}</p>
			</div>

			<div class="report-title-bar">
				<span>CUSTOMER PROFILE REPORT</span>
				<span>PRINT DATE: ${new Date().toLocaleDateString('en-GB')}</span>
			</div>

			<div class="section-heading">Primary Account & Membership Details</div>
			<table class="meta-table">
				<tr>
					<th>CUSTOMER CODE</th>
					<td><strong>${(customer.memberCode || 'N/A').toUpperCase()}</strong></td>
					<th>ACCOUNT NUMBER</th>
					<td class="highlight-account">${accountNo}</td>
				</tr>
				<tr>
					<th>BRANCH NAME</th>
					<td>${(customer.branchName || 'N/A').toUpperCase()}</td>
					<th>SIGN-UP DATE</th>
					<td>${customer.signupDate || 'N/A'}</td>
				</tr>
				<tr>
					<th>APPROVAL STATUS</th>
					<td>${customer.approved || customer.isApproved ? "APPROVED" : "PENDING"}</td>
					<th>MEMBER TYPE</th>
					<td>${(customer.memberType || 'GENERAL').toUpperCase()}</td>
				</tr>
			</table>

			<div class="section-heading">Personal Information</div>
			<table class="meta-table">
				<tr>
					<th>CUSTOMER NAME</th>
					<td colspan="3"><strong>${fullName.toUpperCase()}</strong></td>
				</tr>
				<tr>
					<th>RELATIVE / GUARDIAN</th>
					<td>${(customer.guardianName || 'N/A').toUpperCase()}</td>
					<th>GENDER</th>
					<td>${(customer.customerGender || 'N/A').toUpperCase()}</td>
				</tr>
				<tr>
					<th>DATE OF BIRTH</th>
					<td>${customer.dob || 'N/A'}</td>
					<th>AGE</th>
					<td>${customer.customerAge || 'N/A'}</td>
				</tr>
				<tr>
					<th>MARITAL STATUS</th>
					<td>${(customer.relationshipStatus || 'N/A').toUpperCase()}</td>
					<th>NOMINEE NAME</th>
					<td>${(customer.nomineeName || 'N/A').toUpperCase()}</td>
				</tr>
			</table>

			<div class="section-heading">Contact & Address Details</div>
			<table class="meta-table">
				<tr>
					<th>MOBILE NUMBER</th>
					<td>${customer.contactNo || 'N/A'}</td>
					<th>EMAIL ID</th>
					<td>${(customer.emailId || 'N/A').toLowerCase()}</td>
				</tr>
				<tr>
					<th>ADDRESS</th>
					<td colspan="3">${(customer.customerAddress || 'N/A').toUpperCase()}</td>
				</tr>
				<tr>
					<th>STATE</th>
					<td>${(customer.state || 'N/A').toUpperCase()}</td>
					<th>DISTRICT</th>
					<td>${(customer.district || 'N/A').toUpperCase()}</td>
				</tr>
				<tr>
					<th>PINCODE</th>
					<td colspan="3">${customer.pinCode || 'N/A'}</td>
				</tr>
			</table>

			<div class="section-heading">KYC & Identification Details</div>
			<table class="meta-table">
				<tr>
					<th>AADHAR NUMBER</th>
					<td>${customer.aadharNo || 'N/A'}</td>
					<th>PAN NUMBER</th>
					<td>${(customer.panNo || 'N/A').toUpperCase()}</td>
				</tr>
				<tr>
					<th>VOTER ID</th>
					<td>${(customer.voterNo || 'N/A').toUpperCase()}</td>
					<th>DRIVING LICENSE</th>
					<td>${(customer.drivingLicenceNo || 'N/A').toUpperCase()}</td>
				</tr>
			</table>

			<div class="media-container">
				<div class="media-card">
					<img src="${photoSrc}" alt="Customer Photo" onerror="this.src='${origin}/Uploads/upload.png'">
					<p>CUSTOMER PHOTO</p>
				</div>
				<div class="media-card">
					<img src="${signSrc}" class="signature-img" alt="Customer Signature" onerror="this.src='${origin}/Uploads/upload.png'">
					<p>CUSTOMER SIGNATURE</p>
				</div>
			</div>

			<div class="footer-note">
				This is a system-generated report from Samitha Urban Microfinance Banking System. Generated on ${new Date().toLocaleString()}.
			</div>
		</body>
		</html>
	`;

	const printWindow = window.open("", "_blank");
	if (printWindow) {
		printWindow.document.open();
		printWindow.document.write(printHtml);
		printWindow.document.close();

		// Ensure images are fully loaded before opening system print dialog
		const images = printWindow.document.images;
		let loadedCount = 0;
		const totalImages = images.length;

		function startPrint() {
			printWindow.focus();
			printWindow.print();
		}

		if (totalImages === 0) {
			setTimeout(startPrint, 250);
		} else {
			let isPrinted = false;
			const onImgLoad = function() {
				loadedCount++;
				if (loadedCount >= totalImages && !isPrinted) {
					isPrinted = true;
					setTimeout(startPrint, 250);
				}
			};

			for (let i = 0; i < totalImages; i++) {
				if (images[i].complete) {
					loadedCount++;
				} else {
					images[i].onload = onImgLoad;
					images[i].onerror = onImgLoad;
				}
			}

			if (loadedCount >= totalImages && !isPrinted) {
				isPrinted = true;
				setTimeout(startPrint, 250);
			} else {
				// Fallback safety timer
				setTimeout(function() {
					if (!isPrinted) {
						isPrinted = true;
						startPrint();
					}
				}, 1000);
			}
		}
	} else {
		alert("Pop-up blocked. Please allow pop-ups for this site to print.");
	}
}

// Upper-case non-image modal content
$("#bankReportModal").off("shown.bs.modal").on("shown.bs.modal", function() {
	$(this).find("th, td:not([id^='photo'], [id^='signature']), h6, .text-primary, .text-secondary, p").each(function() {
		if (this.tagName !== "IMG" && $(this).text().trim()) {
			let text = $(this).text();
			$(this).text(text.toUpperCase());
		}
	});
});
