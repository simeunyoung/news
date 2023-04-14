<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
</head>
<body>
	<div>
		<h2>비밀번호 찾기</h2>
		<form action="pwFind.jsp" method="post">
			아이디 : <input type="text" name="id" /><br />
			이메일 : <input type="text" name="email" /><button>인증번호 받기</button><br />
					<input type="text" name="ccNum" disabled /><br>
					<input type="submit" value="비밀번호찾기" />
		</form>
	</div>
</body>
</html>