<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<title>Q&A</title>

<jsp:useBean id="dto" class="admin.AdminDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	AdminDAO dao = AdminDAO.getInstance();
	dao.qnaInsert(dto);
	response.sendRedirect("qnaWrite.jsp");
%>