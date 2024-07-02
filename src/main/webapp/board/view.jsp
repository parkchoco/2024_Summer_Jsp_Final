<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="mvc.model.BoardDTO"%>
<%
	String sessionId = (String) session.getAttribute("sessionId");
	List boardList = (List) request.getAttribute("boardlist");	
	
	
    Integer num = (Integer) request.getAttribute("num");
    Integer nowpage = (Integer) request.getAttribute("page");
    String subject = (String) request.getAttribute("subject");
   
%>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>Board</title>
</head>
<body>
<div class="container py-4">
    <jsp:include page="/home.jsp" />
    
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">SUBJECT</h1>
            <p class="col-md-8 fs-4">My StudyRoom</p>      
        </div>
    </div>
    <div class="row align-items-md-stretch text-center">
        <form name="newWrite" action="./BoardWriteAction2.do" method="post" onsubmit="return checkForm()">
        
        <div class="mb-3 row">
    <label class="col-sm-2 control-label">제목</label>
    <div class="col-sm-7 d-flex align-items-center">
        <input name="subject" class="form-control" value="<%= subject %>">
        
        
    </div>
</div>

<div class="mb-3 row">
    <label class="col-sm-2 control-label">내용</label>
    <div class="col-sm-7">
        <textarea name="content" cols="50" rows="5" class="form-control" placeholder="content"></textarea>
    </div>
</div>



            <div class="mb-3 row">
                <div class="col-sm-offset-2 col-sm-10">
                    <input type="submit" class="btn btn-primary" value="등록">
                    
                    <a href="./BoardListAction.do?pageNum=<%=nowpage%>"	class="btn btn-primary"> 취소</a>
                </div>
            </div>
            
       
            
            
        </form>
    </div>
    <jsp:include page="/Brand.jsp" />
</div>
</body>
</html>
