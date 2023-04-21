<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.QnaDAO"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<title>Q&A</title>

<jsp:useBean id="dto" class="admin.QnaDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	QnaDAO dao = QnaDAO.getInstance();
	dao.insertQna(dto);
	response.sendRedirect("qnaWrite.jsp");
%>