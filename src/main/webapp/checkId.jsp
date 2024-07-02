<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.*"%>

<%
    String id = request.getParameter("id");
    boolean exists = false;
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

        if (rs.next()) {
            exists = true;
        }
    } catch (SQLException | ClassNotFoundException e) {
        out.println("An error occurred.");
        e.printStackTrace();
    } finally {
        if (rs != null) {
            try { rs.close(); } catch(SQLException e) { e.printStackTrace(); }
        }
        if (pstmt != null) {
            try { pstmt.close(); } catch(SQLException e) { e.printStackTrace(); }
        }
        if (conn != null) {
            try { conn.close(); } catch(SQLException e) { e.printStackTrace(); }
        }
    }

    out.println(exists ? "exists" : "notExists");
%>
