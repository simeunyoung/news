<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>유저 프로필 폼</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>

<%
String id = (String) session.getAttribute("memId");
String id2 = request.getParameter("id");
MemberDAO dao = MemberDAO.getInstance();
int check = dao.typeCheck(id);

%>

<body>

	<div class="card">
		<div class="card-body">
			<%-- 자식요소들을 정렬 --%>
			<div class="d-flex flex-column align-items-center text-center">
				<%-- 이미지 가져오고 크기 조정 --%>
				<img src="/project1/resource/img/profile.png" class="rounded-circle" width="150">
				

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
						<%if(check == -1){ %>
						<button class="btn btn-outline-primary"
						onclick="location='user_mypage_form.jsp?id=<%=id%>&pageType=2'">기자프로필</button>
						<%} %>
					<%
					}
					%>
				</div>
			</div>
		</div>
	</div>

</body>
</html>