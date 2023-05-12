<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO"%>
<%@ page import = "member.MemberDTO"%>
<%@page import="revalue.RevalueDTO"%>
<%@page import="revalue.RevalueDAO"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<title>CODENEWS</title>
<jsp:include page="/member/header.jsp"></jsp:include>
<head></head>
<%String id = (String)session.getAttribute("memId");
String pageType = request.getParameter("pageType");
String num = request.getParameter("num");

MemberDAO mbDAO = MemberDAO.getInstance();
MemberDTO mbdto = mbDAO.getMember(id);

	if(id == null || id != null){%>			<%-- 로그인이 안된 유저나 로그인이 된 유저들 들어올 수 있게 설정 --%>
<body>

<div class="page-wrap sitemap">

<div class="site-wrap">
<h2 class="site-tit">전체서비스</h2>
<div class="sitemap-wrap">
		<ul>
			<li><h3>회사소개</h3></li>
			<li><a href="/project1/company/introduce.jsp">사이트 소개</a></li>
			<li><a href="/project1/company/introduce.jsp?pageNum=1">팀원 소개</a></li>
		</ul>
		<ul>
			<li><h3>유저정보</h3></li>
			<%if(id == null){%>
				<li><a href="/project1/member/loginForm.jsp">로그인</a></li>
			<%}else{%>
				<li><a href="/project1/member/deleteForm.jsp">회원탈퇴</a></li>
			<%} %>
			<%if(id == null){%>
				<li><a href="/project1/member/inputForm.jsp">회원가입</a></li>
			<%}else{%>
				<li><a href="/project1/member/user_mypage_form.jsp?num=1&id=<%=id%>&pageType=1">정보수정</a></li>
			<%} %>
			<%if(id == null){%>
				<li><a href="/project1/member/idFindForm.jsp">아이디찾기</a></li>
			<%}else{%>
				<li><a href="/project1/member/user_mypage_form.jsp?id=<%=id%>&pageType=1">내프로필</a></li>
			<%} %>
			<%if(id == null){%>
				<li><a href="/project1/member/pwFindForm.jsp">비밀번호찾기</a></li>
			<%}else{%>
				<li><a href="/project1/member/logout.jsp">로그아웃</a></li>
			<%} %>
		</ul>
		<ul>
			<li><h3>뉴스</h3></li>
			<li><a href="/project1/news/main.jsp">전체뉴스</a></li>
			<li><a href="/project1/news/newstypelist.jsp?newstype=Python">파이썬</a></li>
			<li><a href="/project1/news/newstypelist.jsp?newstype=java">자바</a></li>
			<li><a href="/project1/news/newstypelist.jsp?newstype=JavaScript">자바스크립트</a></li>
			<li><a href="/project1/news/hotlist.jsp">핫토픽</a></li>
		</ul>
		<ul>
			<li><h3>파트너십</h3></li>
			<li><a href="/project1/company/introduce.jsp?pageNum=2">언론사리스트</a></li>
			<li><a href="/project1/company/introduce.jsp?pageNum=2">기자리스트</a></li>

		</ul>
		<ul>
			<li><h3>고객센터</h3></li>
			<li><a href="/project1/admin/qnaList.jsp">Q&A</a></li>
			<li><a href="/project1/helper/svmain.jsp">FAQ</a></li>
			<li><a href="/project1/admin/qnaWrite.jsp">1:1문의하기</a></li>
			<li><a href="/project1/helper/myquestion.jsp">1:1문의목록</a></li>
		</ul>
		<%if(id != null){%>
			<%if(mbdto.getMemberType().equals("2")){%>
				<ul>
					<li><h3>관리자</h3></li>
					<li><a href="/project1/admin/qnaList.jsp">Q&A</a></li>
					<li><a href="/project1/admin/faqList.jsp">FAQ</a></li>
					<li><a href="/project1/admin/journalistList.jsp">기자신청목록</a></li>
					<li><a href="/project1/helper/jebolist.jsp">제보목록</a></li>
				</ul>
			<%}%>
		<%}%>
	</div>
</div>
</div>
<%}%>
</body>
<jsp:include page="/member/footer.jsp"></jsp:include>