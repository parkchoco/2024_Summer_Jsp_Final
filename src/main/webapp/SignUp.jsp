<%@ page contentType="text/html; charset=utf-8"%>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootswatch@4.0.0/dist/minty/bootstrap.min.css">
<title>SIGN UP</title>
<style>
.form-horizontal {
	display: flex;
	flex-direction: column;
	align-items: center;
	justify-content: center;
}

.form-group.row {
	display: flex;
	flex-direction: row;
	align-items: center;
	justify-content: center;
	width: 100%;
}

.form-group.row .col-sm-offset-2.col-sm-10 {
	display: flex;
	justify-content: center;
	width: 100%;
}

.form-group.row label {
	width: 20%;
	text-align: center;
	padding-right: 1rem;
}

.form-group.row .form-control {
	width: 80%;
}

.custom-header h1 {
	font-weight: bold;
	font-size: 4rem;
}
</style>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
function checkId() {
    var id = $("#id").val();
    $.ajax({
        url: "checkId.jsp",
        type: "GET",
        data: { id: id },
        success: function(response) {
            if (response.trim() === "exists") {
                alert("이미 존재하는 아이디입니다.");
                $("#id").val("");
                $("#id").focus();
            } else {
                alert("사용 가능한 아이디입니다.");
                $("#id").prop("readonly", true);
            }
        }
    });
}

function enableIdField() {
    $("#id").prop("readonly", false);
}
</script>
</head>
<body>
	<div class="container py-4">
		<%@ include file="/home.jsp"%>
		<%!String greeting = "SIGN UP";%>

		<div class="p-5 mb-4 custom-header rounded-3 text-center">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=greeting%></h1>
			</div>
		</div>
		<div class="container">
			<form name="signup" class="form-horizontal"
				action="SignUp_process.jsp" method="post"
				onsubmit="return checkForm()">
				<div class="form-group row">
					<label class="col-sm-2">ID</label>
					<div class="col-sm-5">
						<input name="id" id="id" type="text" class="form-control"
							placeholder="ID" onfocus="enableIdField()">
						<button type="button" class="btn btn-secondary"
							onclick="checkId()">중복 확인</button>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">PASSWD</label>
					<div class="col-sm-5">
						<input name="password" type="password" class="form-control"
							placeholder="PASSWORD">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">CHECK PASSWD</label>
					<div class="col-sm-5">
						<input name="password_confirm" type="password"
							class="form-control" placeholder="CHECK PASSWORD">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">NAME</label>
					<div class="col-sm-5">
						<input name="name" type="text" class="form-control"
							placeholder="NAME">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">PHONE NUMBER</label>
					<div class="col-sm-5">
						<input name="phone" type="text" class="form-control"
							placeholder="PHONE NUMBER">
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">ADDRESS</label>
					<div class="col-sm-5">
						<input name="address" type="text" class="form-control"
							placeholder="ADDRESS">
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="submit" class="btn btn-primary" value="SIGN UP">
					</div>
				</div>
			</form>
		</div>
		<%@ include file="/Brand.jsp"%>
	</div>

	<script type="text/javascript">
function checkForm() {
    if (!document.signup.id.value) {
        alert("아이디를 입력하세요.");
        return false;
    }
    if ($("#id").prop("readonly") === false) {
        alert("아이디 중복 확인을 해주세요.");
        return false;
    }
    if (!document.signup.password.value) {
        alert("비밀번호를 입력하세요.");
        return false;
    }
    if (document.signup.password.value != document.signup.password_confirm.value) {
        alert("비밀번호를 동일하게 입력하세요.");
        return false;
    }
    if (!document.signup.name.value) {
        alert("이름을 입력하세요.");
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
</body>
</html>
