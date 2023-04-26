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
<%String url = dao.savePress(exist, press, id);
	if(url != null){ %>
		<script>
			location.replace("/project1/company/pressPage.jsp?press=<%=press%>"); 
		</script>	
<%}
%>



<%//response.sendRedirect("/project1/company/pressPage.jsp?press=" + press); %>
</body>
</html>