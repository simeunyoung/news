
<%@page import="news.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="revalue.RevalueDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="revalue.RevalueDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>

<html>
<head>
<%-- css파일 경로 지정 --%>
<!-- <link href="/project1/resource/css/mypage.css" rel="stylesheet"> -->
<link href="/project1/resource/css/style.css" rel="stylesheet">

<%
String id = (String) session.getAttribute("memId");
String pageNum = request.getParameter("pageNum");
String pageType = request.getParameter("pageType");
String num = request.getParameter("num");

MemberDAO manager = MemberDAO.getInstance();
MemberDTO member = manager.getMember(id);

int check = manager.typeCheck(id);

if (id == null) {
%>
<script>
	location = '/project1/member/loginForm.jsp';
</script>
<%
} else {
%>

</head>
<body>
	<%-- col-mb-4 = mb는 중간 크기 화면 4는 가로크기, mb-3 = 하단 여백 --%>
	<%-- card 본문을 감쌈 --%>
	<jsp:include page="header.jsp" />
	<div class="container">
	
		<%
		if (pageType.equals("1")) {
		%>

		<div class="main-body">
			<nav aria-label="breadcrumb" class="main-breadcrumb">
				<ol class="breadcrumb">
					<%-- 사용자가 이전 페이지 or 홈으로 돌아갈 수 있음 --%>
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">user
						Profile</li>
				</ol>
			</nav>
			<div class="row gutters-sm">
				<div class="userform-wrap">
					<jsp:include page="userProForm.jsp" />
				</div>
				<div class="infoform-wrap">
					<jsp:include page="infoForm.jsp" />
					<div class="card userlist-wrap">
						<jsp:include page="userlist.jsp" />
					</div>
				</div>
			</div>
		</div>
	</div>
	<%
	} else if (pageType.equals("2")) {
	%>
	<div class="main-body">
		<nav aria-label="breadcrumb" class="main-breadcrumb">
			<ol class="breadcrumb">
				<%-- 사용자가 이전 페이지 or 홈으로 돌아갈 수 있음 --%>
				<li class="breadcrumb-item"><a href="index.html">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">
					기자Profile</li>
			</ol>
		</nav>
		<div class="row gutters-sm">
			<div class="jouralform-wrap">
				<jsp:include page="jouralProForm.jsp" />
			</div>
			<div class="infoform-wrap">
				<jsp:include page="infoForm.jsp" />
				<div class="journalist-wrap">
					<jsp:include page="journalist.jsp" />
				</div>
			</div>
		</div>

	</div>
	<%
	}
	%>
</body>

</html>
<%}%>

