<!DOCTYPE >
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import="java.util.*" %>
<html>
<head>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%@ page import="java.sql.*" %>

<%
	String dir = request.getRealPath("resource/img");
	out.println(dir);
	int max = 1024*1024*100;
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();
	MultipartRequest mr = new MultipartRequest(request, dir, max, "UTF-8", dp);
	
	String name = mr.getParameter("name");
	String sysName = mr.getFilesystemName("save");
	String orgName = mr.getOriginalFileName("save");
%>

<title>Insert title here</title>
</head>
<body>

</body>
</html>