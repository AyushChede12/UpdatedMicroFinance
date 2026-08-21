<style>
.header-right-buttons {
	position: absolute;
	right: 20px;
	display: flex;
	align-items: center;
	gap: 10px;
}

.header-btn {
	display: inline-flex;
	align-items: center;
	gap: 6px;
	padding: 7px 16px;
	border-radius: 20px;
	text-decoration: none;
	font-size: 13px;
	font-weight: 600;
	transition: all 0.2s ease;
}

/* HELP BUTTON */
.help-btn {
	background: #eff6ff;
	color: #2563eb;
	border: 1px solid #bfdbfe;
}

.help-btn:hover {
	background: #2563eb;
	color: #ffffff;
	border-color: #2563eb;
	box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
	transform: translateY(-1px);
}

/* LOGOUT BUTTON */
.logout-btn {
	background: #fef2f2;
	color: #ef4444;
	border: 1px solid #fecaca;
}

.logout-btn:hover {
	background: #ef4444;
	color: #ffffff;
	border-color: #ef4444;
	box-shadow: 0 4px 12px rgba(239, 68, 68, 0.25);
	transform: translateY(-1px);
}
</style>
<header id="header" class="header fixed-top d-flex align-items-center">
	<div class="d-flex align-items-center justify-content-between w-100">

		<!-- LEFT -->
		<div class="d-flex align-items-center">
			<a href="/" class="logo d-flex align-items-center">
				<p id="bindUserName"
					style="color: #0f172a; margin: 0; font-size: 20px; font-weight: 700; margin-left: 10px; letter-spacing: -0.3px;">
				</p>
			</a> <i class="bi bi-list toggle-sidebar-btn ms-3"></i>
		</div>

		<!-- RIGHT -->
		<div class="header-right-buttons">
			<a href="helpmanual" class="header-btn help-btn">
				<i class="fa fa-question-circle"></i> Help
			</a>
			<a href="#" class="header-btn logout-btn" onclick="logoutUser()">
				<i class="fa fa-sign-out"></i> Logout
			</a>
		</div>

	</div>
	<script>
		function logoutUser() {
			var confirmLogout = confirm("Are you sure you want to logout?");
			if (confirmLogout) {
				sessionStorage.clear();
				alert("Logout Successful!");
				window.location.href = "/";
			}
		}
	</script>
</header>
