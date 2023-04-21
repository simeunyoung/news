<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<body>
	<form action="deletePro.jsp" method="post">
		<div>
			<p>회원 탈퇴</p>
			<label>비밀번호</label><input type="password" name="pw">
			<div>
				<input value="탈퇴" type="submit" class="btn btn-outline-primary">
				<input value="취소" type="button" onclick="location='user_mypage_form.jsp'">
			</div>
		</div>
		
	</form>
</body>
</html>