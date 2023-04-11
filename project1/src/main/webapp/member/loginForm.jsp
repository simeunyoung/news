<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<link href="/project1/resource/css/style.css" rel="stylesheet"/>
<script>
	function start(){
		document.myform.id.focus();
	}
	function loginCheck(){
		if(!document.myform.id.value){
			alert("아이디를 입력하지 않으셨습니다.");
			document.myform.id.focus();
			return false;
		}
		if(!document.myform.pw.value){
			alert("비밀번호를 입력하지 않으셨습니다.");
			document.myform.pw.focus();
			return false;
		}
	}
	
</script>
</head>
<%
	String cooId = null;
	Cookie [] cookies = request.getCookies();
	for(Cookie c : cookies){
		if(c.getName().equals("cooId")){
			cooId = c.getValue();
		}
	}
%>
<body>
	<form action="loginPro.jsp" method="post" name="myform" onsubmit="return loginCheck();">
		<h2>로그인</h2>
		<table>
			<tr>
				<td>
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
			<tr>
				<td colspan="2">
				</td>
			</tr>
		</table>
		<input type="submit" value="로그인" />
	</form>
</body>
</html>