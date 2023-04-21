<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "svcenter1.Svcenter1DAO"%>
<%@ page import = "java.sql.Timestamp"%>
<%request.setCharacterEncoding("UTF-8");%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	Svcenter1DAO svdao1 = Svcenter1DAO.getInstance();
	svdao1.deleteSvcenter1(num); 
	
	response.sendRedirect("frequentlyMain.jsp");
%>