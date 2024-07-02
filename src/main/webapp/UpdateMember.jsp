<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
    request.setCharacterEncoding("UTF-8");

    String id = request.getParameter("id");
    String password = request.getParameter("password");
    String name = request.getParameter("name");
    String phone = request.getParameter("phone");
    String address = request.getParameter("address");
    String sessionId = (String) session.getAttribute("sessionId");

    boolean hasError = false;
    String errorMessage = "";

    Connection conn = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    try {
        String dbURL = "jdbc:mysql://localhost:3306/Final_projectDB";
        String dbUser = "root";
        String dbPassword = "1234";
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(dbURL, dbUser, dbPassword);

        String sql = "SELECT id FROM member WHERE id = ?";
        pstmt = conn.prepareStatement(sql);
        pstmt.setString(1, id);
        rs = pstmt.executeQuery();

        if (rs.next() && !rs.getString("id").equals(sessionId)) {
            hasError = true;
            errorMessage = "이미 존재하는 아이디입니다.";
        } else {
            sql = "UPDATE member SET id=?, password=?, name=?, phone=?, address=? WHERE id=?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, id);
            pstmt.setString(2, password);
            pstmt.setString(3, name);
            pstmt.setString(4, phone);
            pstmt.setString(5, address);
            pstmt.setString(6, sessionId);

            int resultSet = pstmt.executeUpdate();

            if (resultSet >= 1) {
                session.setAttribute("sessionId", id);
                response.sendRedirect("Login.jsp");
                return;
            } else {
                hasError = true;
                errorMessage = "회원정보 수정에 실패했습니다.";
            }
        }
    } catch (Exception e) {
        hasError = true;
        errorMessage = "예외가 발생하였습니다: " + e.getMessage();
        e.printStackTrace();
    } finally {
        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }

    if (hasError) {
%>
    <div class="alert alert-danger">
        <strong>오류:</strong> <%= errorMessage %>
    </div>
<%
    }
%>
