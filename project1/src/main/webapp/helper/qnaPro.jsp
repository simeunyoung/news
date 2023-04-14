<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.HelperDAO" %>
<%request.setCharacterEncoding("UTF-8");%>

<title>1:1 문의하기</title>

<jsp:useBean id="dto" class="model.HelperDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	dto.setIp(request.getRemoteAddr());
	
	HelperDAO dao = HelperDAO.getInstance();
	dao.insertQna(dto);
	response.sendRedirect("helperMain.jsp");
%>