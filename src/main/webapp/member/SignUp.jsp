<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootswatch@4.0.0/dist/minty/bootstrap.min.css">
	<script type="text/javascript">
		function checkForm() {
			if (!document.signup.userid.value) {
				alert("아이디를 입력하세요.");
				return false;
			}

			if (!document.signup.password.value) {
				alert("비밀번호를 입력하세요.");
				return false;
			}

			if (document.signup.password.value !== document.signup.password_confirm.value) {
				alert("비밀번호를 동일하게 입력하세요.");
				return false;
			}

			if (!document.signup.username.value) {
				alert("성명을 입력하세요.");
				return false;
			}

			if (!document.signup.phone.value) {
				alert("전화번호를 입력하세요.");
				return false;
			}

			if (!document.signup.address.value) {
				alert("주소를 입력하세요.");
				return false;
			}
		}
	</script>
	<title>SIGN UP</title>
</head>
<body>

		
		<div class="container py-4">
		<%@ include file="../home.jsp" %>
        <%!String greeting = "SIGN UP";%>

        <div class="p-5 mb-4 custom-header rounded-3 text-center">
            <div class="container-fluid py-5">
                <h1 class="display-5 fw-bold"><%=greeting%></h1>
            </div>
        </div>
		
		<div class="container">
			<form name="signup" class="form-horizontal" action="SignUp_process.jsp" method="post" onsubmit="return checkForm()">
    <div class="form-group row">
        <label class="col-sm-2">ID</label>
        <div class="col-sm-5">
            <input name="id" type="text" class="form-control" placeholder="ID">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">PASSWD</label>
        <div class="col-sm-5">
            <input name="password" type="password" class="form-control" placeholder="PASSWORD">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">CHECK PASSWD</label>
        <div class="col-sm-5">
            <input name="password_confirm" type="password" class="form-control" placeholder="CHECK PASSWORD">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">NAME</label>
        <div class="col-sm-5">
            <input name="name" type="text" class="form-control" placeholder="NAME">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">PHONE NUMBER</label>
        <div class="col-sm-5">
            <input name="phone" type="text" class="form-control" placeholder="PHONE NUMBER">
        </div>
    </div>
    <div class="form-group row">
        <label class="col-sm-2">ADDRESS</label>
        <div class="col-sm-5">
            <input name="address" type="text" class="form-control" placeholder="ADDRESS">
        </div>
    </div>
    <div class="form-group row">
        <div class="col-sm-offset-2 col-sm-10">
            <input type="submit" class="btn btn-primary" value="SIGN UP">
        </div>
    </div>
</form>

		</div>
		<%@ include file="../Brand.jsp"%>
	</div>
</body>
</html>