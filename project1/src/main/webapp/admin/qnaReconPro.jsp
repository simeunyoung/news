<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="admin.AdminDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	int num = (int)session.getAttribute("num");
	String title = (String)session.getAttribute("title");
	
	dto.setIp(request.getRemoteAddr());
	
	AdminDAO dao = AdminDAO.getInstance();
	dao.qnaReconInsert(dto);%>
	response.sendRedirect("qnaContent.jsp?num=<%%>");
%>