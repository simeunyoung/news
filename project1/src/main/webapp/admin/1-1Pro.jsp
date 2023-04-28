<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="admin.AdminDTO"/>
<jsp:setProperty property="*" name="dto" />

<title>1:1 문의하기</title>

<%
	dto.setIp(request.getRemoteAddr());

	AdminDAO dao = AdminDAO.getInstance();
	dao.oneononeInsert(dto);
	response.sendRedirect("1-1List.jsp");
%>