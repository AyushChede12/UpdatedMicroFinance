<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Samitha Urban Nidhi Ltd.</title>
<script src="https://kit.fontawesome.com/ae73087723.js"
	crossorigin="anonymous"></script>
<!-- Only one jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
<style>
* {
	margin: 0;
	padding: 0;
	box-sizing: border-box;
}

body {
	font-family: 'Poppins', sans-serif;
	background: linear-gradient(135deg, rgba(15, 23, 42, 0.92) 0%, rgba(30, 41, 59, 0.92) 100%),
		url('Uploads/bgimageLogin.png') no-repeat center center;
	background-size: cover;
	min-height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	padding: 20px;
}

.container {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
}

.form-box {
	width: 100%;
	max-width: 440px;
	background: #ffffff;
	padding: 48px 40px;
	text-align: center;
	border-radius: 16px;
	box-shadow: 0 20px 40px -15px rgba(0, 0, 0, 0.3), 0 0 0 1px rgba(255, 255, 255, 0.1);
}

.form-box h1 {
	font-size: 28px;
	font-weight: 700;
	margin-bottom: 36px;
	color: #0f172a;
	position: relative;
	letter-spacing: -0.5px;
}

.form-box h1::after {
	content: "";
	width: 40px;
	height: 4px;
	border-radius: 4px;
	background: #2563eb;
	position: absolute;
	bottom: -10px;
	left: 50%;
	transform: translate(-50%);
}

.input-group-wrapper {
	display: flex;
	justify-content: space-between;
	align-items: center;
	margin-bottom: 24px;
	position: relative;
}

.textfield {
	position: relative;
	border-bottom: 2px solid #e2e8f0;
	width: 100%;
}

.inputfield {
	width: 100%;
	padding: 8px 36px 8px 4px;
	height: 44px;
	font-size: 14.5px;
	font-family: 'Poppins', sans-serif;
	border: none;
	background: none;
	outline: none;
	color: #0f172a;
}

.inputlabels {
	position: absolute;
	top: 50%;
	left: 4px;
	color: #94a3b8;
	transform: translateY(-50%);
	font-size: 13px;
	font-weight: 500;
	pointer-events: none;
	transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
	letter-spacing: 0.5px;
}

.inputfield:focus ~ .inputlabels, 
.inputfield:valid ~ .inputlabels {
	top: -6px;
	font-size: 11px;
	font-weight: 600;
	color: #2563eb;
}

.textfield span::before {
	content: '';
	position: absolute;
	bottom: -2px;
	left: 0;
	width: 0%;
	height: 2px;
	background: #2563eb;
	transition: 0.3s cubic-bezier(0.4, 0, 0.2, 1);
}

.inputfield:focus ~ span::before, 
.inputfield:valid ~ span::before {
	width: 100%;
}

.iconstyles {
	position: absolute;
	right: 8px;
	top: 50%;
	transform: translateY(-50%);
	font-size: 16px;
	color: #94a3b8;
	cursor: pointer;
	transition: color 0.2s ease;
}

.iconstyles:hover {
	color: #2563eb;
}

.enquirybtn {
	width: 100%;
	height: 44px;
	background-color: #2563eb;
	color: white;
	cursor: pointer;
	border: none;
	font-size: 14px;
	font-weight: 600;
	font-family: 'Poppins', sans-serif;
	border-radius: 10px;
	margin-top: 12px;
	letter-spacing: 0.5px;
	transition: all 0.2s ease;
	box-shadow: 0 4px 12px rgba(37, 99, 235, 0.25);
}

.enquirybtn:hover {
	background-color: #1d4ed8;
	box-shadow: 0 6px 16px rgba(37, 99, 235, 0.35);
	transform: translateY(-1px);
}

#errorMsg {
	color: #ef4444;
	font-size: 13px;
	margin-bottom: 16px;
	font-weight: 500;
}
</style>
</head>

<body>
	<div class="container">
		<div class="form-box">
			<h1>Login</h1>
			<div id="errorMsg"></div>
			<form id="form1">
				<div class="input-group-wrapper">
					<div class="textfield">
						<input class="inputfield" type="text" id="username"
							name="username" required> <span></span> <label
							class="inputlabels">USERNAME</label>
					</div>
					<i class="fa-solid fa-user iconstyles"></i>
				</div>

				<div class="input-group-wrapper">
					<div class="textfield">
						<input class="inputfield" type="password" required id="password"
							name="password"> <span></span> <label class="inputlabels">PASSWORD</label>
					</div>
					<i class="fa-solid fa-eye-slash iconstyles" id="eyeicon"></i>
				</div>

				<div style="margin-top: 24px;">
					<button type="submit" class="enquirybtn">SUBMIT</button>
				</div>
			</form>
		</div>
	</div>

	<script>
		$(document).ready(function() {
			// Password toggle
			$("#eyeicon").click(function() {
				let password = $("#password");
				let icon = $(this);
				if (password.attr("type") === "password") {
					password.attr("type", "text");
					icon.removeClass("fa-eye-slash").addClass("fa-eye");
				} else {
					password.attr("type", "password");
					icon.removeClass("fa-eye").addClass("fa-eye-slash");
				}
			});
		});
	</script>
	<script src="./js/login.js"></script>
</body>
</html>