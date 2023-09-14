<%@ page import="java.util.ArrayList"%>
<%@ page import="model.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String username = (String) session.getAttribute("sessUsername");
String role = (String) session.getAttribute("sessRole");

if ("guest".equals(role)) {
	response.sendRedirect("../user/login.jsp");
}
%>

<!DOCTYPE html>
<html lang="en">
<head>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link
	href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;700;800&display=swap"
	rel="stylesheet" />
<script src="https://kit.fontawesome.com/e1c5337441.js"
	crossorigin="anonymous"></script>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-KK94CHFLLe+nY2dmCWGMq91rCGa5gtU4mk92HdvYe+M/SXH301p5ILy+dN9+nJOZ"
	crossorigin="anonymous" />
<link rel="stylesheet" type="text/css" href="../../css/styles.css" />
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Customer Inquiry</title>
</head>
<body>

	<nav class="navbar navbar-expand-lg navbar-dark fixed-top p-3">
		<div class="container-fluid">
			<a class="navbar-brand"
				href="<%=request.getContextPath()%>/jsp/user/home.jsp"><h1
					class="store-name">LUNAR LIBRARY</h1></a>
			<button class="navbar-toggler" type="button"
				data-bs-toggle="offcanvas" data-bs-target="#offcanvasNavbar"
				aria-controls="offcanvasNavbar" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="offcanvas offcanvas-end bg-dark" tabindex="-1"
				id="offcanvasNavbar" aria-labelledby="offcanvasNavbarLabel">
				<div class="offcanvas-header">
					<h5 class="offcanvas-title" id="offcanvasNavbarLabel"></h5>
					<button type="button" class="btn-close" data-bs-dismiss="offcanvas"
						aria-label="Close"></button>
				</div>
				<div class="offcanvas-body">
					<ul
						class="navbar-nav justify-content-start align-items-center flex-grow-1 pe-3">
						<li class="nav-item"><a class="nav-link " aria-current="page"
							href="<%=request.getContextPath()%>/jsp/user/home.jsp">Home</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/user/genres.jsp">Genres</a>
						</li>

						<%
						if (role != null) {
							if (role.equals("admin") || role.equals("owner")) {
						%>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/addBook.jsp">Add
								Book</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/manageBook.jsp">Manage
								Books</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/manageMember.jsp">Manage
								User</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/SalesInquiry">Sales
								Inquiry</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/jsp/admin/bookInquiry.jsp">Book
								Inquiry</a></li>
						<li class="nav-item"><a class="nav-link"
							href="<%=request.getContextPath()%>/ViewInquiriesServlet">Customer
								Inquiries</a></li>
						<%
						}
						}
						%>



					</ul>


					<%
					if (role != null) {
						if (role.equals("admin") || role.equals("owner") || role.equals("member")) {
					%>

					<a href="<%=request.getContextPath()%>/jsp/user/wishlist.jsp"
						class="text-white fw-light"><button class="btn me-2"
							type="submit">
							<img src="<%=request.getContextPath()%>/imgs/wishlist.png"
								style="width: 28px; height: auto;"> <i
								class="fa-solid fa-book-heart fa-lg text-dark"></i>
						</button></a> <a href="<%=request.getContextPath()%>/jsp/user/cart.jsp"
						class="text-white fw-light"><button class="btn me-4"
							type="submit">
							<i class="fa-solid fa-cart-shopping fa-lg text-white mt-3"></i>
						</button></a>


					<div class="dropdown me-2">
						<button class="btn btn-success dropdown-toggle text-white fw-bold"
							type="button" id="dropdownMenuButton" data-bs-toggle="dropdown"
							aria-expanded="false">
							<i class="fa-solid fa-user me-2"></i><%=username%>
						</button>
						<ul class="dropdown-menu" aria-labelledby="dropdownMenuLink">
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/jsp/user/profilePage.jsp">Profile</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/viewOrders">Orders</a></li>
							<li><a class="dropdown-item"
								href="<%=request.getContextPath()%>/jsp/user/inquiryForm.jsp">Inquiry
									Form</a></li>

						</ul>
					</div>



					<form action="<%=request.getContextPath()%>/jsp/user/logout.jsp">
						<button class="btn btn-danger" type="submit">Logout</button>
					</form>

					<%
					} else if (role.equals("guest")) {
					%>

					<a href="login.jsp" class="text-white fw-light">
						<button class="btn btn-success me-4" type="submit">Login</button>
					</a> <a href="signUp.jsp" class="text-white fw-light">
						<button class="btn btn-dark" type="submit">Sign Up</button>
					</a>

					<%
					}
					}
					%>




				</div>
			</div>
		</div>
	</nav>

	<div class="container my-5">
		<h1 class="text-center mb-4">Customer Inquiry Form</h1>
		<form action="<%=request.getContextPath()%>/CustomerInquiryServlet"
			method="post">
			<input type="hidden" name="user_id" value="${sessUserID}" />

			<div class="mb-3">
				<label for="inquiry_type" class="form-label">Inquiry Type:</label> <select
					name="inquiry_type" id="inquiry_type" class="form-select">
					<option value="Books">Inquiries regarding books,
						recommendations, or requests.</option>
					<option value="Orders">Inquiries regarding orders,
						delivery, and payment.</option>
					<option value="Other">Other general inquiries or reports.</option>
				</select>
			</div>

			<div class="mb-3">
				<label for="inquiry_text" class="form-label">Inquiry Text:</label>
				<textarea name="inquiry_text" id="inquiry_text" rows="4" cols="50"
					class="form-control"></textarea>
			</div>

			<div class="form-check mb-3">
				<input type="checkbox" name="require_response" id="require_response"
					class="form-check-input"> <label for="require_response"
					class="form-check-label">Require a response?</label>
			</div>

			<div id="email_section" style="display: none;">
				<label for="email" class="form-label">Email:</label> <input
					type="email" name="email" id="email" class="form-control" />
			</div>

			<input type="submit" value="Submit Inquiry"
				class="btn btn-primary mt-3" />
		</form>
	</div>

	<script>
		//Function to display alert and remove parameters from URL
		function displayAlertAndRemoveParams(message) {
			alert(message);
			// Remove the parameter from the URL after displaying the alert
			const urlWithoutParams = window.location.href.split('?')[0];
			window.history.replaceState({}, document.title, urlWithoutParams);
		}

		// Show/hide email section based on "Require a response?" checkbox
		const requireResponseCheckbox = document
				.getElementById("require_response");
		const emailSection = document.getElementById("email_section");

		requireResponseCheckbox.addEventListener("change", function() {
			if (this.checked) {
				emailSection.style.display = "block";
			} else {
				emailSection.style.display = "none";
			}
		});
	</script>
	
	<%
	String success = request.getParameter("success");
	if (success != null && success.equals("true")) {
	%>
	<script>
		displayAlertAndRemoveParams("Inquiry submitted successfully.");
	</script>
	<%
	}
	%>

	<%-- Display error message if there was an error submitting the inquiry --%>
	<%
	String error = request.getParameter("error");
	if (error != null && error.equals("true")) {
	%>
	<script>
		displayAlertAndRemoveParams("Failed to submit inquiry.");
	</script>
	<%
	}
	%>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-ENjdO4Dr2bkBIFxQpeoTz1HIcje39Wm4jDKdf19U8gI4ddQ3GYNS7NTKfAdVQSZe"
		crossorigin="anonymous"></script>
</body>
</html>
