<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
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

<%
String id = (String) session.getAttribute("memId");
String id2 = request.getParameter("id");
String pageType = request.getParameter("pageType");
MemberDAO dao = MemberDAO.getInstance();
int check = dao.typeCheck(id);

%>

<body>
	<!-- 유저 프로필 폼 -->
	<div class="card">
		<div class="card-body">
			<div>
				<img src="/project1/resource/img/profile01.jpg" class="rounded-circle" width="150">
				<div>
					<h4 class="name"><%=id2 %> 님</h4>
					<div>
						<%
							if (id.equals(id2)) { // 본인이면
						%>
						<div class="row button-wrap">
						<button type="button" class="white-btn"	onclick="location='deleteForm.jsp?pageType=1'">탈퇴하기</button>
							<%if(check == -1){ // 기자면%> 
								<button type="button" class="submit-btn" onclick="location='user_mypage_form.jsp?id=<%=id%>&pageType=2'">기자프로필</button>
							<%} %>
						</div>
							<button type="button" class="bookmark-btn" onclick="location='/project1/company/pressForm.jsp'">구독현황 <i class="fa-solid fa-right-long"></i> </button>
						<%
						
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>

</body>
</html>