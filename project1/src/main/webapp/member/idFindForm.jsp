<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<body>
<div class="login-wrap pw-wrap">
		<h2 class="login-logo">아이디 찾기</h2>
		<form action="idFind.jsp" method="post">
			<div class="login-table">
				<table>
					<tr>
						<td><input type="text" name="name" placeholder="이름" /></td>
					</tr>
					<tr>
						<td><input type="text" name="birthdate" placeholder="생년월일" /></td>
					</tr>

				</table>
				
				<input type="submit" class="login-btn" value="아이디 찾기" />
			</div>
		</form>
		<p>아이디가 없으신가요? <span><a href="/project1/member/inputForm.jsp">회원가입</a></span></p>
	</div>
</body>
</html>