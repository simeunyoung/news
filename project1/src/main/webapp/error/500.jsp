<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	response.setStatus(HttpServletResponse.SC_OK);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 댓글 리스트</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<body>
	<div class="error-wrap">
		<h3>500</h3>
		<h2>페이지가 작동하지 않습니다.</h2>
		<button type="button" onclick="location='/project1/news/main.jsp'">홈으로</button>
	</div>
</body>
