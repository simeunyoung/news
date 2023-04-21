<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "svcenter1.Svcenter1DAO"%>
<%@ page import = "java.sql.Timestamp"%>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id = "svDTO1" class = "svcenter1.Svcenter1DTO">
	<jsp:setProperty name = "svDTO1" property = "*"/>
</jsp:useBean>

<%
	//String id = (String)session.getAttribute("memId");
	//svDTO.setId(id);	

	Svcenter1DAO svDAO1 = Svcenter1DAO.getInstance();
	svDAO1.insertSvcenter1(svDTO1);
	
	response.sendRedirect("frequentlyMain.jsp");
%>