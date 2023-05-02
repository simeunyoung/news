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
		<h2>원하시는 페이지를 찾을 수 없습니다.</h2>
		<p>찾으려는 페이지의 주소가 잘못 입력되었거나,</p>
		<p>주소의 변경 혹은 삭제로 인해 사용하실 수 없습니다.</p>
		<p>입력하신 페이지의 주소가 정확한지 다시 한번 확인해 주세요.</p>
		<button type="button" onclick="location='/project1/news/main.jsp'">홈으로</button>
	</div>
</body>