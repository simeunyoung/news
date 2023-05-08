<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<%
	String id = (String)session.getAttribute("memId");
%>
<body>
	<footer>
		<ul>
		<!-- 비회원일 경우 로그인 노출 -->
		<%if(id == null){ %>
				<li><a href="/project1/member/loginForm.jsp">로그인</a></li>
			<%}else{ %>
				<li><a href="/project1/member/logout.jsp">로그아웃</a></li>
			<%} %>
				<li><a href="/project1/sitemap/sitemapmain.jsp">전체서비스</a></li>
		</ul>
		<ul>
			<li>이용약관</li>
			<li>개인정보처리방침</li>
			<li>서비스안내</li>
		</ul>
	</footer>
</body>
</html>