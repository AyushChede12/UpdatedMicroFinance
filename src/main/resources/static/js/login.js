/*$(document).ready(function() {
	$("#form1").submit(function(e) {
		e.preventDefault();

		let username = $("#username").val().trim();
		let password = $("#password").val().trim();

		if (!username || !password) {
			$("#errorMsg").text("UserName and password are required").show();
			return;
		}

		$.ajax({
			url: 'api/loginPage/loginValidate',  // Make sure endpoint matches Spring Boot
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify({ username: username, password: password }),
			success: function(response) {
				// Assuming ApiResponse has integer status and message
				if (response.status === 'OK') {
					sessionStorage.setItem("username", response.data.username);
					window.location.href = 'openDashboard'; // replace with your homepage

				} else {
					$("#errorMsg").text(response.message).show();
				}
			},
			error: function(xhr) {
				if (xhr.status === 401) {
					$("#errorMsg").text("Invalid username or password").show();
				} else {
					$("#errorMsg").text("Something went wrong. Try again!").show();
				}
			}
		});

	});
	
	
});
*/
$(document).ready(function() {
	$("#loginForm").submit(function(e) {
		e.preventDefault(); // Prevent normal form submission

		const userName = $("#userName").val();
		const password = $("#password").val();

		$.ajax({
			type: "POST",
			url: "loginValidate",
			contentType: "application/json",
			data: JSON.stringify({
				userId: userName, // match your backend UserCreation field
				password: password
			}),
			success: function(response) {
				if (response.status === "success") {
					alert("Login Successful!");

					// Redirect to dashboard
					window.location.href = response.redirectUrl;
				} else {
					alert(response.message);
				}
			},
			error: function() {
				alert("Server error during login!");
			}
		});
	});

		/*$.ajax({
			url: "api/preference/login",
			type: "POST",
			contentType: "application/json",
			data: JSON.stringify({
				customerId: $("#customerId").val(),
				password: $("#password").val()
			}),
			success: function(response) {
				if (response.status === "OK") {
					// Redirect to dashboard.jsp
					window.location.href = "openDashboard";
				} else {
					alert("Invalid credentials");
				}
			},
			error: function() {
				alert("Login failed!");
			}
		});*/
	});





$(document).ready(function() {
	loadSidebar();
});

function loadSidebar() {
	$.ajax({
		type: "GET",
		url: "getUserServices", // fetch services for logged-in user
		success: function(services) {
			if (!services || services.length === 0) return;

			// Hide all parent and child menus initially
			$(".sidebar-nav > li.nav-item").hide();
			$(".nav-content li").hide();

			// Store parent modules that have at least one child allowed
			const parentsToShow = new Set();

			services.forEach(item => {
				// Check if item contains parent info (assuming format: ModuleName:ChildName)
				// If your backend stores module separately, use that
				const childId = item.replace(/\s+/g, "_").trim();
				const li = $("#" + childId);

				if (li.length) {
					li.show(); // show child

					// Find parent UL and LI
					const parentUl = li.closest("ul.collapse");
					if (parentUl.length) {
						parentUl.addClass("show"); // expand parent UL
						parentUl.prev("a").removeClass("collapsed"); // expand arrow
						parentsToShow.add(parentUl.closest("li.nav-item").attr("id"));
					}
				}
			});

			// Show only parent modules that have visible children
			parentsToShow.forEach(parentId => {
				$("#" + parentId).show();
			});
		},
		error: function() {
			console.log("Failed to load user services");
		}
	});
}