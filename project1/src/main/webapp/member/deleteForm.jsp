<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CODENEWS</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>

<body>
<%
	String id = (String)session.getAttribute("memId");
	String pageType = request.getParameter("pageType");
%>
<div class="login-wrap">
	<form action="deletePro.jsp" method="post">
		<div>
			<p class="login-logo">회원 탈퇴</p>
			<div class="login-table">
				<table>
					<tr>
						<td>
							<div class="label">비밀번호 확인</div>
							<input type="password" name="pw">
						</td>
					</tr>
				</table>
				<div class="flex-center">
					<input value="탈퇴" type="submit" class="submit-btn">
					<input value="취소" type="button" class="white-btn" onclick="location='user_mypage_form.jsp?id=<%=id%>&pageType=<%=pageType%>'">
				</div>
			</div>
		</div>
		
	</form>
</div>
</body>

</html>