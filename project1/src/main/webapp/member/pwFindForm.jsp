<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<body>
	<div class="login-wrap pw-wrap">
		<h2 class="login-logo" onclick="location='/project1/news/main.jsp'">비밀번호 찾기</h2>
		<form action="pwFind.jsp" method="post">
			<div class="login-table">
				<table>
					<tr>
						<td><input type="text" name="id" placeholder="아이디" /></td>
					</tr>
					<tr>
						<td><input type="text" name="email" placeholder="이메일" /></td>
					</tr>

				</table>
				<input type="submit" class="login-btn" value="비밀번호 찾기" />
			</div>
		</form>
		<p>아이디가 기억나지 않는다면? <span><a href="/project1/member/idFindForm.jsp">아이디 찾기</a></span></p>
	</div>
</body>
</html>