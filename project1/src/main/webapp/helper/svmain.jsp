<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "helper.Svcenter1DAO"%>
<%@ page import = "helper.Svcenter1DTO"%>
<%@ page import = "member.MemberDTO"%>
<%@ page import = "member.MemberDAO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.List"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%-- 고객센터 메인페이지 --%>
<%String id = (String)session.getAttribute("memId");
	if(id == null || id != null){%>				<%-- 로그인을 안한 유저도 들어올 수 있게 설정 --%>
<%!

	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm:ss"); // 날짜형식 설정
%>

<%
	MemberDAO mbDAO = MemberDAO.getInstance();
	MemberDTO mbdto = mbDAO.getMember(id);
	
	String pageNum = request.getParameter("pageNum");

%>
<jsp:include page="/member/header.jsp"></jsp:include>
<title>CODENEWS</title>
<div class = "page-wrap svmain">
	<div class="svmain-wrap">
	<h3 class="svmain-tit">도움이 필요한 서비스를 선택하세요.</h3>
		<ul>
			<li><a href = "/project1/admin/faqList.jsp">FAQ</a></li>
		<%-- 	<%if(id != null){ --%>
		<%-- 		if(!mbdto.getMemberType().equals("2")){%>		 --%>
					<li><a href = "/project1/admin/qnaWrite.jsp">1:1 문의하기</a></li>
		<%-- 		<%}%> --%>
		<%-- 	<%}%> --%>
			<li><a href = "myquestion.jsp">1:1 문의목록</a></li>
			<li><a href = "/project1/admin/qnaList.jsp">Q&A</a></li>
		<%-- 	<%if(id != null){	 --%>
		<%-- 		if(mbdto.getMemberType().equals("1")){%>	 --%>
					<li><a href = "/project1/admin/journalistForm.jsp">기자신청</a></li>
		<%-- 		<%}%>	 --%>
		<%-- 	<%}%> --%>
			<li><a href = "/project1/admin/qnaWrite2.jsp">제보하기</a></li>
		</ul>
	</div>
	<%}%>

</div>
<jsp:include page="/member/footer.jsp"></jsp:include>