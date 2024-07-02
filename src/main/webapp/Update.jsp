<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<html>
<head>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootswatch@4.0.0/dist/minty/bootstrap.min.css">
<title>회원 수정</title>
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
		<%!String greeting = "회원 수정";%>

		<div class="p-5 mb-4 custom-header rounded-3 text-center">
			<div class="container-fluid py-5">
				<h1 class="display-5 fw-bold"><%=greeting%></h1>
			</div>
		</div>
		<div class="container">
			<sql:setDataSource var="dataSource"
				url="jdbc:mysql://localhost:3306/Final_projectDB"
				driver="com.mysql.cj.jdbc.Driver" user="root" password="1234" />

			<sql:query dataSource="${dataSource}" var="resultSet">
           SELECT * FROM MEMBER WHERE ID=?
           <sql:param value="${sessionScope.sessionId}" />
			</sql:query>

			<c:forEach var="row" items="${resultSet.rows}">
				<form name="newMember" class="form-horizontal"
					action="UpdateMember.jsp" method="post"
					onsubmit="return checkForm()">
					<div class="form-group row">
						<label class="col-sm-2">ID</label>
						<div class="col-sm-5">
							<input name="id" id="id" type="text" class="form-control"
								placeholder="ID" value="<c:out value='${row.id}'/>"
								onfocus="enableIdField()">
							<button type="button" class="btn btn-secondary"
								onclick="checkId()">중복 확인</button>
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">비밀번호</label>
						<div class="col-sm-5">
							<input name="password" type="text" class="form-control"
								placeholder="PASSWORD" value="<c:out value='${row.password}'/>">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">비밀번호확인</label>
						<div class="col-sm-5">
							<input name="password_confirm" type="text" class="form-control"
								placeholder="PASSWORD 확인">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">성명</label>
						<div class="col-sm-5">
							<input name="name" type="text" class="form-control"
								placeholder="NAME" value="<c:out value='${row.name}'/>">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">전화번호</label>
						<div class="col-sm-5">
							<input name="phone" type="text" class="form-control"
								placeholder="PHONE NUMBER" value="<c:out value='${row.phone}'/>">
						</div>
					</div>
					<div class="form-group row">
						<label class="col-sm-2">주소</label>
						<div class="col-sm-5">
							<input name="address" type="text" class="form-control"
								placeholder="ADDRESS" value="<c:out value='${row.address}'/>">
						</div>
					</div>
					<div class="form-group row text-center mt-4">
						<div class="col-12">
							<input type="submit" class="btn btn-primary me-2" value="회원수정">
							<a href="DeleteMember.jsp" class="btn btn-primary ms-2">회원탈퇴</a>
						</div>
					</div>
				</form>
			</c:forEach>
		</div>
		<%@ include file="/Brand.jsp"%>
	</div>

	<script type="text/javascript">
function checkForm() {
    if (!document.newMember.id.value) {
        alert("아이디를 입력하세요.");
        return false;
    }
    if ($("#id").prop("readonly") === false) {
        alert("아이디 중복 확인을 해주세요.");
        return false;
    }
    if (!document.newMember.password.value) {
        alert("비밀번호를 입력하세요.");
        return false;
    }
    if (document.newMember.password.value != document.newMember.password_confirm.value) {
        alert("비밀번호를 동일하게 입력하세요.");
        return false;
    }
    if (!document.newMember.phone.value) {
        alert("전화번호를 입력하세요.");
        return false;
    }
    if (!document.newMember.address.value) {
        alert("주소를 입력하세요.");
        return false;
    }
}
</script>
</body>
</html>
