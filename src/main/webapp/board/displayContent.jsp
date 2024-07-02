<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .card-header {
            position: relative;
        }
        .delete-btn {
            position: absolute;
            right: 10px;
            top: 50%;
            transform: translateY(-50%);
        }
    </style>
    <title>Display Content</title>
</head>
<body>
<div class="container py-4">
     <%@ include file="../home.jsp" %>
    
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">게시판</h1>
            <p class="col-md-8 fs-4">저장된 내용</p>      
        </div>
    </div>
    
    <!-- Search Form -->
    <form action="<c:url value="./DisplayContent.do"/>" method="post" class="mb-4">
        <div class="input-group">
            <input name="subject" type="text" class="form-control" placeholder="제목을 입력하세요" aria-label="제목을 입력하세요" aria-describedby="button-search">
            <button class="btn btn-primary" type="submit" id="button-search">검색</button>
        </div>
    </form>
    
    <div class="row align-items-md-stretch text-center">
        <c:forEach var="display" items="${displayList}">
            <div class="col-md-12 mb-3">
                <div class="card">
                    <div class="card-header text-center">
                        <strong>${display.subject}</strong>
                        <form action="<c:url value="./DeleteContent.do"/>" method="post" class="delete-btn">
                            <input type="hidden" name="id" value="${display.id}" />
                            <button type="submit" class="btn btn-secondary btn-sm">삭제</button>
                        </form>
                    </div>
                    <div class="card-body">
                        <p>${display.content}</p>
                        <small class="text-muted">작성일: ${display.createdAt}</small>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <jsp:include page="/Brand.jsp" />
</div>
</body>
</html>
