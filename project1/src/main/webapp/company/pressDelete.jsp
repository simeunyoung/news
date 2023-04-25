<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<% MemberDAO dao = MemberDAO.getInstance();%>
<% String press = request.getParameter("press");%>
<% String exist = request.getParameter("exist");%>
<% String id = request.getParameter("id");%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%dao.unSavePress(exist, press, id);%>
<%response.sendRedirect("/project1/company/pressPage.jsp?press=" + press); %>
</body>
</html>