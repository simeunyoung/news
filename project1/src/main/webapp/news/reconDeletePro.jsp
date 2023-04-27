<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.NewsDAO" %>
<title>댓글 삭제</title>

<% int num = Integer.parseInt(request.getParameter("num"));
NewsDAO method = NewsDAO.getInstance();
method.deleteRecon(num);
int connum = Integer.parseInt(request.getParameter("connum"));

response.sendRedirect("content.jsp?num="+connum);
%>
<script>
alert("댓글이 삭제되었습니다.")
</script>