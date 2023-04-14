<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="project.NewsDAO" %>
<jsp:useBean id="dto" class="project.NewsDTO" />
<jsp:setProperty property="*" name="dto" />
<%request.setCharacterEncoding("UTF-8"); %>
<%
    dto.setReg(new Timestamp(System.currentTimeMillis())); //날짜 가져오기
	dto.setIp(request.getRemoteAddr()); // ip 가져오기
	
	// String id = request.getParameter("id");
	dto.setId("Tester"); // 작성자 : 아이디로 가져오기

    NewsDAO news = NewsDAO.getInstance();
    news.insert(dto);
%>