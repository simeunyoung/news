<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO"%>
<% MemberDAO dao = MemberDAO.getInstance();%>
<% String id = request.getParameter("id");%>
<% int size = request.getParameterMap().size()-1;%>
<% StringBuilder sb = new StringBuilder(); %>
<%for (int i = 0; i <= size; i++) {
  if (request.getParameter(Integer.toString(i)) != null) {
    sb.append("@" + request.getParameter(Integer.toString(i)));
  }
}
String result = sb.toString();%>
<% dao.PSubscribe(id, result);%>
		<script>
			location.replace("/project1/company/pressForm.jsp?id=<%=id%>");
		</script>



<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
</head>
<body>

</body>
</html>