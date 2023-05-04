<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="/project1/resource/css/style.css" rel="stylesheet"/>
<script src="/project1/resource/js/script.js"></script>
</head>

<%
	String loNum = request.getParameter("loNum");
	String cooId = null;
	Cookie [] cookies = request.getCookies();
	for(Cookie c : cookies){
		if(c.getName().equals("cooId")){
			cooId = c.getValue();
		}
	}
%>
<body onload="start()">
	<form action="loginPro.jsp" method="get" name="myform" onsubmit="return loginCheck();">
		<h2>로그인</h2>
		<div>
		<table>
			<tr>
				<td>
					<input type="hidden"  name="loNum" value="<%=loNum%>">
				<% if(cooId == null){ %>
					<input type="text" id="id" name="id" placeholder="아이디" >
				<%} else { %>
					<input type="text" id="id" name="id" value="<%=cooId %>" >
				<%} %>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" id="pw" name="pw" placeholder="비밀번호">
				</td>
			</tr>
			<tr>
				<td>
					<input type="checkbox" id="auto" name="auto" value="1">
					<label for="auto">로그인 상태 유지</label>
				</td>
			</tr>
		</table>
		</div>
		<input type="submit" value="로그인" />
	</form>
	<ul class="loginList">
		<li><a href="pwFindForm.jsp">비밀번호 찾기</a></li>
		<li><a href="idFindForm.jsp">아이디 찾기</a></li>
		<li><a href="inputForm.jsp">회원가입</a></li>
	</ul>
</body>
</html>