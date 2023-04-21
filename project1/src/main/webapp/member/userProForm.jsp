<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 프로필 폼</title>
</head>
<%
String id = (String) session.getAttribute("memId");
String id2 = request.getParameter("id");
String fileName = "";
%>
<body>

	<div class="card">
		<div class="card-body">
			<%-- 자식요소들을 정렬 --%>
			<div class="d-flex flex-column align-items-center text-center">
				<%-- 이미지 가져오고 크기 조정 --%>
				 <img src="/project1/resource/img/profile.png" class="rounded-circle" width="150">
				<form action="upload.jsp" method="post"
					enctype="multipart/form-data">
					<input type="file"	name="profile-pic" id="profile-pic"> 
					<input type="submit" value="업로드">
				</form>

				<%-- 이름, 나머지 글자들 크기 및 글자색 조정 --%>
				<div class="mt-3">
					<h4>user</h4>
					<p class="text-secondary mb-1">Full Stack Developer</p>
					<p class="text-muted font-size-sm">Bay Area, San Francisco, CA</p>

					<%
					if (id.equals(id2)) {
					%>
					<button class="btn btn-outline-primary"
						onclick="location='deleteForm.jsp'">탈퇴하기</button>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>

</body>
</html>