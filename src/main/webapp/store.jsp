<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.List, mvc.model.BoardDAO" %>

<%

    BoardDAO dao = BoardDAO.getInstance();
    List<String> storeContents = dao.getStoreContentForRange(1, 6);


    String sessionId = (String) session.getAttribute("sessionId");
    int userPoints = dao.getUserPoints(sessionId);
%>

<html>
<head>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <title>상점</title>
    <script type="text/javascript">
        var userPoints = <%= userPoints %>;

        function confirmPayment(id) {
            if (userPoints >= 500) {
                if (confirm("500 포인트 결제 하시겠습니까?")) {
                    // Redirect to the orderInfo.jsp page with the selected ID
                    window.location.href = "./orderInfo.jsp?id=" + id;
                }
            } else {
                alert("포인트가 부족합니다. 현재 포인트: " + userPoints);
            }
        }
    </script>
</head>
<body>
<div class="container py-4">
    <jsp:include page="/home.jsp" />
    <div class="p-5 mb-4 bg-body-tertiary rounded-3">
        <div class="container-fluid py-5">
            <h1 class="display-5 fw-bold">상점</h1>
            <p class="col-md-8 fs-4">store</p>
        </div>
    </div>

    <div class="row align-items-md-stretch text-center">
        <% for (int i = 0; i < storeContents.size(); i++) { %>
            <div class="col-md-4 mb-4">
                <div class="h-100 p-2">
                    <img src="./images/coupon.png" alt="상품 이미지" class="img-fluid mb-3">
                    <p>문화상품권</p>
                    <p>500 p</p>
                    <button class="btn btn-success" onclick="confirmPayment(<%= i + 1 %>)">결제하기 &raquo;</button>
                </div>
            </div>
        <% } %>
    </div>
</div>
<%@ include file="/Brand.jsp" %>
</body>
</html>
