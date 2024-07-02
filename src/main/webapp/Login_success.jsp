<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<title>회원 정보</title>
</head>
<body>
	<div class="container py-4">
		<%@ include file="/home.jsp"%>
		<div class="p-5 mb-4 bg-body-tertiary rounded-3">
			<div class="container-fluid py-5">
				<%
			String msg = request.getParameter("msg");
      		if (msg.equals("0")||msg.equals("2")){
      %>
				<h1 class="display-5 fw-bold">회원 정보</h1>
				<p class="col-md-8 fs-4">Membership Info</p>
				<% }
      		else if (msg.equals("1")){
        %>
				<h1 class="display-5 fw-bold">회원 가입</h1>
				<p class="col-md-8 fs-4">Membership Joining</p>
				<% }%>
			</div>
		</div>
		<div class="row align-items-md-stretch   text-center"></div>
	</div>
</body>
</html>