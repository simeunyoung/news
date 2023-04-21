<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.NewsDAO" %>
<title>댓글 삭제</title>

<% int num = Integer.parseInt(request.getParameter("num"));
NewsDAO method = NewsDAO.getInstance();
method.deleteRecon(num);
%>
<script>
alert("댓글이 삭제되었습니다.")
history.go(-1);
</script>