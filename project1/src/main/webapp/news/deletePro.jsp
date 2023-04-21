<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="news.NewsDAO" %>
<title>기사 삭제 진행</title>

<%
int num = Integer.parseInt(request.getParameter("num"));
String pw = request.getParameter("pw");

NewsDAO method = NewsDAO.getInstance();
int formcheck = method.deleteNews(num,pw);

if(formcheck == 1) {
response.sendRedirect("testlist.jsp");
} else {%>
<script>       
alert("비밀번호가 맞지 않습니다");
history.go(-1);
</script>
<%}%>