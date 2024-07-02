<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="mvc.model.BoardDAO" %>
<%@ page import="java.util.List" %>

<%

    String idParam = request.getParameter("id");
    int id = 0;
    if (idParam != null) {
        id = Integer.parseInt(idParam);
    }


    BoardDAO dao = BoardDAO.getInstance();
    String content = "";
    if (id > 0) {
        List<String> storeContents = dao.getStoreContentForRange(id, id);
        if (!storeContents.isEmpty()) {
            content = storeContents.get(0);

            String sessionId = (String) session.getAttribute("sessionId");
            dao.deductUserPoints(sessionId, 500);
        }
    }
%>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>주문</title>
</head>
<body>
<div class="container py-4">
    <jsp:include page="/home.jsp" />

    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">결제 완료</h1>
            <p class="col-md-8 fs-4">payment complete</p>
        </div>
    </div>
    

    <div class="text-center mb-4">
        <img src="./images/coupon.png" alt="상품 이미지" class="img-fluid">
    </div>


    <div class="row justify-content-center">
        <div class="col-md-8 text-center">
            <p class="fs-4">문화상품권 코드입니다</p>
            <p class="fs-5"><strong><%= content %></strong></p>
        </div>
    </div>

    <%@ include file="/Brand.jsp" %>
</div>
</body>
</html>
