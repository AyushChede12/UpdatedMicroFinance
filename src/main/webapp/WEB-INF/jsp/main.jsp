<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">

<title>Admin Dashboard</title>

<!-- ================= ICONS ================= -->
<script src="https://kit.fontawesome.com/ae73087723.js"
	crossorigin="anonymous"></script>

<link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css"
	rel="stylesheet" />

<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- ================= CSS ================= -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/css/bootstrap.min.css">

<link rel="stylesheet" href="./css/admin.css">

<!-- Select2 CSS and JS -->
<link
	href="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/css/select2.min.css"
	rel="stylesheet" />
<script
	src="https://cdn.jsdelivr.net/npm/select2@4.1.0-rc.0/dist/js/select2.min.js"></script>

</head>

<body>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	
	<!-- ================= HEADER ================= -->
	<jsp:include page="header.jsp" />

	<!-- ================= SIDEBAR ================= -->
	<jsp:include page="sidebar.jsp" />

	<!-- ================= MAIN CONTENT ================= -->
	<main id="main" class="main">
		<jsp:include page="${contentPage}" />
	</main>

	<!-- ================= JS (ORDER VERY IMPORTANT) ================= -->

	

	<!-- Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.12.9/dist/umd/popper.min.js"></script>

	<!-- Bootstrap -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@4.0.0/dist/js/bootstrap.min.js"></script>

	<!-- ApexCharts -->
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/apexcharts/3.46.0/apexcharts.min.js"></script>

	<!-- ================= CUSTOM JS ================= -->
	<script src="./js/adminscript.js"></script>

	<!-- ================= HEADER USERNAME LOGIC ================= -->
	<script>
		$(document).ready(function() {
			let username = sessionStorage.getItem("username");

			if (username) {
				$("#bindUserName").text(username);
			} else {
				window.location.href = "index";
			}
		});
	</script>

</body>
</html>
