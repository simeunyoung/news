<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "helper.SvcenterDAO"%>
<%@ page import = "java.sql.Timestamp"%>
<%request.setCharacterEncoding("UTF-8");%>
<%-- 1대1 문의 --%>

<jsp:useBean id = "svDTO" class = "helper.SvcenterDTO" />
<jsp:setProperty name = "svDTO" property = "*"/>

<%
	String id = (String)session.getAttribute("memId");
	
	SvcenterDAO svDAO = SvcenterDAO.getInstance();
	svDAO.insertSvcenter(svDTO, id);
	
	response.sendRedirect("svmain.jsp");
%>