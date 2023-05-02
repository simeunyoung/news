<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="admin.AdminDTO"/>
<jsp:setProperty property="*" name="dto" />

<%
	String pageNum = request.getParameter("pageNum");
	AdminDAO dao = AdminDAO.getInstance();
	int result = dao.qnaUpdate(dto);
	
	response.sendRedirect("qnaList.jsp");
%>
