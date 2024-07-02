<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    String fileName = java.net.URLEncoder.encode(title, "UTF-8") + ".txt";

    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

    try (ServletOutputStream sos = response.getOutputStream()) {
        sos.write(("Memo Title : " + title + "\n").getBytes("UTF-8"));
        sos.write(("\n").getBytes("UTF-8"));
        sos.write(content.getBytes("UTF-8"));
    } catch (IOException e) {
        e.printStackTrace();
    }
    
%>