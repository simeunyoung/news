<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CODENEWS</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<jsp:include page="/member/header.jsp"></jsp:include>
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
<jsp:include page="/member/footer.jsp"></jsp:include>
</html>