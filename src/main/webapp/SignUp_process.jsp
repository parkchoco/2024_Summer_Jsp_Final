<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql"%>
<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String password_confirm = request.getParameter("password_confirm");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");

    System.out.println("ID: " + id);
    System.out.println("Password: " + password);
    System.out.println("Password Confirm: " + password_confirm);
    System.out.println("Name: " + name);
    System.out.println("Phone: " + phone);
    System.out.println("Address: " + address);

    boolean hasError = false;
    String errorMessage = "";

    if (id == null || id.trim().isEmpty()) {
        hasError = true;
        errorMessage = "ID is required.";
    } else if (password == null || password.trim().isEmpty()) {
        hasError = true;
        errorMessage = "Password is required.";
    } else if (!password.equals(password_confirm)) {
        hasError = true;
        errorMessage = "Passwords do not match.";
    } else if (name == null || name.trim().isEmpty()) {
        hasError = true;
        errorMessage = "Name is required.";
    }
%>

<c:if test="${hasError}">
	<div style="color: red;">
		<p>
			Error:
			<%= errorMessage %></p>
	</div>
</c:if>

<c:if test="${!hasError}">
	<sql:setDataSource var="dataSource"
		url="jdbc:mysql://localhost:3306/Final_projectDB"
		driver="com.mysql.cj.jdbc.Driver" user="root" password="1234" />

	<sql:update dataSource="${dataSource}" var="result">
        INSERT INTO member (id, password, name, phone, address) VALUES (?, ?, ?, ?, ?)
        <sql:param value="<%= id %>" />
		<sql:param value="<%= password %>" />
		<sql:param value="<%= name %>" />
		<sql:param value="<%= phone %>" />
		<sql:param value="<%= address %>" />
	</sql:update>

	<c:if test="${result >= 1}">
		<div style="color: green;">
			<%
            session.invalidate();
        %>
			<jsp:include page="/SignUp_Success.jsp" />
		</div>
	</c:if>
	<c:if test="${result == 0}">
		<div style="color: red;">
			<jsp:include page="/SignUp_Failed.jsp" />
		</div>
	</c:if>
</c:if>