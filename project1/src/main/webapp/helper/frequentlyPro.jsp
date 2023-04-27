<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.Svcenter1DAO"%>
<%@ page import = "java.sql.Timestamp"%>
<% request.setCharacterEncoding("UTF-8");%>
<%-- 자주묻는질문 작성 --%>

<jsp:useBean id = "svDTO1" class = "helper.Svcenter1DTO">
	<jsp:setProperty name = "svDTO1" property = "*"/>
</jsp:useBean>

<%
	String id = (String)session.getAttribute("memId");
	svDTO1.setId(id);	

	Svcenter1DAO svDAO1 = Svcenter1DAO.getInstance();
	svDAO1.insertSvcenter1(svDTO1);
	
	response.sendRedirect("svmain.jsp");
%>