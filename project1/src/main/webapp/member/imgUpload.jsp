<!DOCTYPE >
<%@page import="member.MemberDAO"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="java.util.*" %>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%
	String id = (String)session.getAttribute("memId");
	String dir = request.getRealPath("resource/img");
	out.println(dir);
	int max = 1024*1024*100;
	MultipartRequest mr = new MultipartRequest(request, dir, max, "UTF-8");
	
	String name = mr.getParameter("name");
	String sysName = mr.getFilesystemName("save");
    MemberDAO member = MemberDAO.getInstance();
    member.updateImg(sysName, id);
    
    response.sendRedirect("user_mypage_form.jsp?id="+id);
%>

<title>Insert title here</title>
</head>
<body>

</body>
</html>