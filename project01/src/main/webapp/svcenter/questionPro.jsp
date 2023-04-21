<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "svcenter.SvcenterDAO"%>
<%@ page import = "java.sql.Timestamp"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id = "svDTO" class = "svcenter.SvcenterDTO" />
<jsp:setProperty name = "svDTO" property = "*"/>

<%
	//String id = (String)session.getAttribute("memId");
	//svDTO.setId(id);
	
	SvcenterDAO svDAO = SvcenterDAO.getInstance();
	svDAO.insertSvcenter(svDTO);
	
	response.sendRedirect("svmain.jsp");
%>