<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<title>CODENEWS</title>
<jsp:include page="/member/header.jsp"></jsp:include>
<%String id = (String)session.getAttribute("memId");
	if(id == null || id != null){%>
<center><b>사이트맵</b></center>
<table align = "center" width = "800" border = "1" cellspacing = "0" cellpadding = "0">
	<tr height = "30">
		<td align = "center" width = "100">회사소개</td>
		<td align = "center" width = "100">유저정보</td>
		<td align = "center" width = "100">뉴스테마</td>
		<td align = "center" width = "100">파트너쉽</td>
		<td align = "center" width = "100">고객센터</td>
	<%if(id != null){%>
		<%if(id.equals("admin")){%>
		<td align = "center" width = "100">관리자</td>
		<%}%>
	<%}%>
	</tr>
	<tr>
		<td align = "center"><a href="/project1/company/introduce.jsp">사이트 소개</a></td>
		<td align = "center"><a href="/project1/member/loginForm.jsp">로그인</a></td>
		<td align = "center"><a href="/project1/news/main.jsp">뉴스메인</a></td>
		<td align = "center"><a href="/project1/company/introduce.jsp?pageNum=2">언론사리스트</a></td>
		<td align = "center"><a href="/project1/helper/svmain.jsp">Q&A게시판</a></td>
	<%if(id != null){%>
		<%if(id.equals("admin")){%>
		<td align = "center"><a href="/project1/admin/qnaList.jsp">Q&A</a></td>
		<%}%>
	<%}%>
	</tr>
	<tr>
		<td align = "center"><a href="/project1/company/introduce.jsp?pageNum=1">팀원 소개</a></td>
		<td align = "center"><a href="/project1/member/inputForm.jsp">회원가입</a></td>
		<td align = "center"><a href="/project1/sitemap/sitemapmain.jsp">사이트맵</a></td>
		<td align = "center"><a href="/project1/company/introduce.jsp?pageNum=2">기자리스트</a></td>
		<td align = "center"><a href="/project1/helper/questionForm.jsp">1대1문의</a></td>
	<%if(id != null){%>
		<%if(id.equals("admin")){ %>
		<td align = "center"><a href="/project1/admin/journalistList.jsp">기자신청목록</a></td>
		<%}%>
	<%}%>
	</tr>
	<tr>
		<td rowspan = "17"></td>
		<td align = "center"><a href="/project1/member/idFindForm.jsp">아이디찾기</a></td>
		<td align = "center"><a href="/project1/news/newstypelist.jsp?newstype=Python">파이썬</a></td>
		<td align = "center"><a href="/project1/helper/qalist.jsp">문의목록</a></td>
		<td rowspan = "17"></td>
	<%if(id != null){%>
		<%if(id.equals("admin")){ %>
		<td align = "center"><a href="/project1/admin/faqList.jsp">FAQ목록</a>
		<%}%>
	<%}%>
	</tr>
	<tr>
		<td align = "center"><a href="/project1/member/pwFindForm.jsp">비밀번호찾기</a></td>
		<td align = "center"><a href="/project1/news/newstypelist.jsp?newstype=Java">자바</a></td>
		<td rowspan = "8"></td>
	<%if(id != null){%>
		<%if(id.equals("admin")){%>
		<td align = "center"><a href="">제보받은목록</a></td>
		<%}%>
	<%}%>
	</tr>
	<tr>
		<td align = "center"><a href="/project1/member/deleteForm.jsp">회원탈퇴</a></td>
		<td align = "center"><a href="/project1/news/newstypelist.jsp?newstype=JavaScript">자바스크립트</a></td>
	</tr>
	<tr>
		<td align = "center"><a href="/project1/member/user_mypage_form.jsp">정보수정</a></td>
		<td align = "center"><a href="/project1/news/list.jsp">모든뉴스리스트</a></td>
	</tr>
	<tr>
		<td align = "center"><a href="/project1/member/user_mypage_form.jsp">내프로필</a></td>
		<td align = "center"><a href="/project1/news/hotlist.jsp">핫토픽기사</a></td>
	</tr>
	<tr>
		<td align = "center"><a href="/project1/member/logout.jsp">로그아웃</a></td>
		<td rowspan = "4"></td>
	</tr>
</table>
<%}%>
<jsp:include page="/member/footer.jsp"></jsp:include>