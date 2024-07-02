<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String name = (String) request.getAttribute("name");
	
%>
<html>
<head>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<title>Board</title>
</head>
<script type="text/javascript">
	function checkForm() {
		
		if (!document.newWrite.subject.value) {
			alert("과목을 입력하세요.");
			return false;
		}
				
	}
</script>
<body>
<div class="container py-4">
	<jsp:include page="/home.jsp" />
	
	 <div class="p-5 mb-4 bg-body-tertiary rounded-3">
      <div class="container-fluid py-5">
        <h1 class="display-5 fw-bold">게시판</h1>
        <p class="col-md-8 fs-4">Board</p>      
      </div>
    </div>

	<div class="row align-items-md-stretch text-center">
    <form name="newWrite" action="./BoardWriteAction.do" method="post" onsubmit="return checkForm()">
        
        <div class="mb-3 row">
            <label class="col-sm-2 control-label">과목 이름</label>
            <div class="col-sm-5">
                <input name="subject" type="text" class="form-control" placeholder="subject">
            </div>
            <div class="col-sm-5 d-flex align-items-center">
                <input type="submit" class="btn btn-primary mx-2" value="등록">

            </div>
        </div>
    </form>
</div>

	<jsp:include page="/Brand.jsp" />
	</div>
</body>
</html>



