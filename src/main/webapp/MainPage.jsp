<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>My Memory</title>
<style>
body {
	background-color: #fefefe;
}

.custom-header {
	background-color: #f4f4f4;
	color: black;
}

.custom-header h1 {
	font-size: 4rem;
}

.custom-tagline {
	color: black;
}
</style>
</head>
<body>
	<div class="container py-4">
		<%!
        String greeting = "MY MEMORY";
        String tagline = "Welcome to MY MEMORY!";
        %>
		<div class="p-5 mb-4 custom-header rounded-3 text-center">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=greeting%></h1>
			</div>
		</div>
		<div class="row align-items-md-stretch text-center">
			<div class="col-md-12">
				<div class="h-50 p-5">
					<h3 class="custom-tagline"><%=tagline%></h3>
				</div>
				<div class="row justify-content-center align-items-center">
					<%
                    String error = request.getParameter("error");
                    if (error != null) {
                        out.println("<div class='alert alert-danger'>아이디와 비밀번호를 확인해 주세요</div>");
                    }
                    %>
					<form class="form-signin d-flex flex-column align-items-center"
						action="j_security_check" method="post">
						<div class="form-floating mb-3 col-sm-5">
							<input type="text" class="form-control" name='j_username'
								required autofocus> <label for="floatingInput">ID</label>
						</div>
						<div class="form-floating mb-3 col-sm-5">
							<input type="password" class="form-control" name='j_password'>
							<label for="floatingInput">Password</label>
						</div>
						<div class="d-flex justify-content-center">
							<a href="./SignUp.jsp" class="btn btn-secondary me-2"
								style="width: 100px;">SIGN UP</a>
							<button class="btn btn-secondary" type="submit"
								style="width: 100px;">LOGIN</button>
						</div>
					</form>

				</div>
			</div>
		</div>
		<%@ include file="Brand.jsp"%>
	</div>
</body>
</html>
