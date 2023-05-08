
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
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>


<%
String id = (String) session.getAttribute("memId");
String pageNum = request.getParameter("pageNum");
String pageType = request.getParameter("pageType");
String num = request.getParameter("num");

MemberDAO manager = MemberDAO.getInstance();
MemberDTO member = manager.getMember(id);


int check = manager.typeCheck(id);

if (id == null && pageType.equals("1")) {
%>

<script>
	location = '/project1/member/loginForm.jsp';
</script>
<%
} else {
%>

</head>
<!-- 마이페이지 pageType이 1이면 회원프로필, 2면 기자프로필-->
<body>
	<jsp:include page="header.jsp" />
	<div class="container">
		<%
			if (pageType.equals("1")) { 
		%>

		<div class="main-body">
			<nav aria-label="breadcrumb" class="main-breadcrumb">
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">user
						Profile</li>
				</ol>
			</nav>
			<div class="row gutters-sm">
				<div class="userform-wrap">
					<!-- 유저의 프로필 부분 -->
					<jsp:include page="userProForm.jsp" />
					<button type="button" onclick="location='/project1/company/pressForm.jsp'">구독현황 보러가기</button>
				</div>
				<div class="infoform-wrap">
					<!-- 유저의 정보 부분  -->
					<jsp:include page="infoForm.jsp" />
					<div class="card userlist-wrap">
					<!-- 유저가 쓴 댓글 리스트 -->
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
				<li class="breadcrumb-item"><a href="index.html">Home</a></li>
				<li class="breadcrumb-item active" aria-current="page">
					기자Profile</li>
			</ol>
		</nav>
		<div class="row gutters-sm">
			<div class="jouralform-wrap">
				<!-- 기자의 프로필 부분 -->
				<jsp:include page="jouralProForm.jsp" />
				<button type="button" onclick="location='/project1/company/pressForm.jsp'">구독현황 보러가기</button>
			</div>
			<div class="infoform-wrap">
				<!-- 기자의 정보 부분 -->
				<jsp:include page="infoForm.jsp" />
				<div class="journalist-wrap">
					<!-- 기자가 쓴 뉴스 리스트 -->
					<jsp:include page="journalist.jsp" />
				</div>
			</div>
		</div>

	</div>
	<%
	}
	%>
	<%}%>
	
</body>
<jsp:include page="/member/footer.jsp"></jsp:include>
</html>


