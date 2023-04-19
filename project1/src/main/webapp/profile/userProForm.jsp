<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 프로필 폼</title>
</head>

<body>

	<div class="card">
		<div class="card-body">
			<%-- 자식요소들을 정렬 --%>
			<div class="d-flex flex-column align-items-center text-center">
				<%-- 이미지 가져오고 크기 조정 --%>
				<img src="https://bootdey.com/img/Content/avatar/avatar7.png"
					alt="Admin" class="rounded-circle" width="150">
				<%-- 이름, 나머지 글자들 크기 및 글자색 조정 --%>
				<div class="mt-3">
					<h4>user</h4>
					<p class="text-secondary mb-1">Full Stack Developer</p>
					<p class="text-muted font-size-sm">Bay Area, San Francisco, CA</p>
						
					<button class="btn btn-outline-primary"
						onclick="location='deleteForm.jsp'">탈퇴하기</button>
						
				</div>
			</div>
		</div>
	</div>
	
</body>
</html>