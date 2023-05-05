<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="/project1/resource/css/style.css" rel="stylesheet"/>
<script src="/project1/resource/js/script.js"></script>
</head>
<style>
#en-wrap{
display:none;
}
</style>

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
<body>
	<div class="login-wrap">
	<select id="lang-select" onchange="changeSelection()">
		<option value="ko">한국어</option>
		<option value="en">English</option>
	</select>
	<div id="ko-wrap">
	<form action="loginPro.jsp" method="get" name="myform" onsubmit="return loginCheck();">
		<h2 class="login-logo" onclick="location='/project1/news/main.jsp'">CODENEWS</h2>
		<div class="login-table">
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
					<div class="row">
						<input type="checkbox" id="auto" name="auto" value="1">
						<label for="auto">로그인 상태 유지</label>
					</div>				
				</td>
			</tr>
		</table>
		<input type="submit" value="로그인" class="login-btn" />
		</div>
		
	</form>
	<ul class="login-list">
		<li><a href="pwFindForm.jsp">비밀번호 찾기</a></li>
		<li><a href="idFindForm.jsp">아이디 찾기</a></li>
		<li><a href="inputForm.jsp">회원가입</a></li>
	</ul>
	</div>
	
	<div id="en-wrap">
	<form action="loginPro.jsp" method="get" name="myform" onsubmit="return loginCheck();">
		<h2 class="login-logo" onclick="location='/project1/news/main.jsp'">CODENEWS</h2>
		<div class="login-table">
		<table>
			<tr>
				<td>
					<input type="hidden"  name="loNum" value="<%=loNum%>">
				<% if(cooId == null){ %>
					<input type="text" id="id" name="id" placeholder="Username" >
				<%} else { %>
					<input type="text" id="id" name="id" value="<%=cooId %>" >
				<%} %>
				</td>
			</tr>
			<tr>
				<td>
					<input type="password" id="pw" name="pw" placeholder="Password">
				</td>
			</tr>
			<tr>
				<td>
					<div class="row">
						<input type="checkbox" id="auto" name="auto" value="1">
						<label for="auto">Stay Signed in</label>
					</div>				
				</td>
			</tr>
		</table>
		<input type="submit" value="Sign in" class="login-btn" />
		</div>
		
	</form>
	<ul class="login-list">
		<li><a href="pwFindForm.jsp">Forgot your Password?</a></li>
		<li><a href="idFindForm.jsp">Forgot your Username?</a></li>
		<li><a href="inputForm.jsp">Sign up</a></li>
	</ul>
	</div>
	</div>
	<script>

	function changeSelection() {
		var selectedElement = document.getElementById("lang-select");

		// 선택한 option의 value, 텍스트
		var optionVal = selectedElement.options[selectedElement.selectedIndex].value;
		if (optionVal == "ko") {
			document.getElementById("ko-wrap").style.display = "block";
			document.getElementById("en-wrap").style.display = "none";

		} else if (optionVal == "en") {
			document.getElementById("en-wrap").style.display = "block";
			document.getElementById("ko-wrap").style.display = "none";

		}
	}
	</script>
</body>
</html>