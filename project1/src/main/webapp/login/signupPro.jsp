<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.LoginDAO" %>
<%
request.setCharacterEncoding("UTF-8");
%>

<jsp:useBean id="dto" class="admin.LoginDTO"/>
<jsp:setProperty property="*" name="dto" />

<%
	LoginDAO dao = LoginDAO.getInstance();

	dto.setIp(request.getRemoteAddr());
	dao.signUp(dto);
%>