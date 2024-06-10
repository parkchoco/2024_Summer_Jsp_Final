<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    String sessionId = (String) session.getAttribute("sessionId");
%>

<header class="pb-3 mb-4 border-bottom">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-center justify-content-lg-start">
            <a href="./LoginPage.jsp" class="d-flex align-items-center text-dark text-decoration-none">
                <svg width="40" height="40" fill="currentColor" viewBox="0 0 16 16">
                    <circle cx="8" cy="8" r="8" fill="currentColor" />
                    <text x="8" y="8.5" text-anchor="middle" dy=".3em" fill="white" font-size="3.5" font-family="Arial">
                        <%= (sessionId != null) ? sessionId : "Home" %>
                    </text>
                </svg>
                
            </a>

            <ul class="nav nav-pills">
                <c:choose>
                    <c:when test="${empty sessionId}">
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/member/Login.jsp'/>">로그인</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/member/SignUp.jsp'/>">회원 가입</a></li>
                    </c:when>
                    <c:otherwise>
                        
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/member/Logout.jsp'/>">로그아웃</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='/member/Update.jsp'/>">회원 수정</a></li>
                        <li class="nav-item"><a class="nav-link" href="<c:url value='../WriteMemo.jsp'/>">MEMO</a></li>
                        
                    </c:otherwise>
                </c:choose>
            </ul>
            
        </div>
    </div>
</header>
