<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%
    String title = request.getParameter("title");
    String content = request.getParameter("content");

    // 파일 이름 설정
    String fileName = java.net.URLEncoder.encode(title, "UTF-8") + ".txt";

    // 응답 헤더 설정
    response.setContentType("application/octet-stream");
    response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");

    // 파일 내용 작성
    try (ServletOutputStream sos = response.getOutputStream()) {
        sos.write(("Memo Title : " + title + "\n").getBytes("UTF-8"));
        sos.write(("\n").getBytes("UTF-8"));
        sos.write(content.getBytes("UTF-8"));
    } catch (IOException e) {
        e.printStackTrace();
    }
    
%>
