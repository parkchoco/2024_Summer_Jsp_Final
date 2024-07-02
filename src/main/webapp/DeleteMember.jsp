<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>

<%
String sessionId = (String) session.getAttribute("sessionId");
if (sessionId == null) {
	out.println("ID를 가져올 수 없습니다.");
} else {
	out.println("가져온 ID: " + sessionId);
}
%>

<sql:setDataSource var="dataSource"
	url="jdbc:mysql://localhost:3306/Final_projectDB"
	driver="com.mysql.cj.jdbc.Driver" user="root" password="1234" />

<sql:update dataSource="${dataSource}" var="resultSet">
    DELETE FROM member WHERE id = ?
    <sql:param value="<%=sessionId%>" />
</sql:update>

<c:choose>
	<c:when test="${resultSet >= 1}">
		<%
		session.invalidate();
		%>
		<c:redirect url="Login.jsp" />
	</c:when>
	<c:otherwise>
		<p>회원 탈퇴에 실패했습니다.</p>
	</c:otherwise>
</c:choose>