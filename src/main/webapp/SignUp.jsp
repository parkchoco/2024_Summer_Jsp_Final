<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<html>
<head>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootswatch@4.0.0/dist/minty/bootstrap.min.css">
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

/* 새로운 스타일 */
.form-container {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.form-group {
    width: 100%;
    display: flex;
    justify-content: center;
}

.form-group .form-control {
    width: 50%; /* 입력 필드의 너비 조절 */
}
</style>
<script type="text/javascript">
    function checkForm() {
        // 폼 검증 로직 유지
    }
</script>
<title>SIGN UP</title>
</head>
<body>

<div class="container py-4">
    <%!String greeting = "SIGN UP";%>

    <div class="p-5 mb-4 custom-header rounded-3 text-center">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold"><%=greeting%></h1>
        </div>
    </div>

    <div class="container">
        <form name="signup" class="form-horizontal form-container"
            action="signup_process.jsp" method="post"
            onsubmit="return checkForm()">
            <div class="form-group">
                <input name="userid" type="text" class="form-control"
                    placeholder="ID">
            </div>
            <div class="form-group">
                <input name="password" type="password" class="form-control"
                    placeholder="PASSWORD">
            </div>
            <div class="form-group">
                <input name="password_confirm" type="password"
                    class="form-control" placeholder="CHECK PASSWORD">
            </div>
            <div class="form-group">
                <input name="second_password" type="password"
                    class="form-control" placeholder="SECOND PASSWORD">
            </div>
            <div class="form-group">
                <input name="username" type="text" class="form-control"
                    placeholder="NAME">
            </div>
            <div class="form-group">
                <input name="phone" type="text" class="form-control"
                    placeholder="PHONE NUMBER">
            </div>
            <div class="form-group">
                <input name="address" type="text" class="form-control"
                    placeholder="ADDRESS">
            </div>
            <div class="form-group d-flex justify-content-center">
                <input type="submit" class="btn btn-primary" value="SIGN UP">
            </div>
            <!-- SIGN UP 페이지 회원가입 칸 기존 왼쪽에 있는걸 중앙으로 설정 
            칸 마다 앞에 붙여져있던 label 삭제 - 필요 없다고 판단. -->
        </form>
    </div>
    <%@ include file="Brand.jsp"%>
</div>
</body>
</html>
