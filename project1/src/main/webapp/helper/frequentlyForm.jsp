<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import = "member.MemberDTO"%>
<%@page import = "member.MemberDAO"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%
	String id = (String)session.getAttribute("memId"); //세션값으로 admin 아이디를 id에 대입

	MemberDAO mbDAO = MemberDAO.getInstance();
	MemberDTO mbdto = mbDAO.getMember(id);				//관리자 아이디를 메소드에 대입하여 관리자의 정보를 멤버 테이블에서 검색하여 꺼내옴
	
	try{
%>
<%-- 자주묻는질문 작성페이지 --%>
<title>CODENEWS</title>
<jsp:include page="/member/header.jsp" />
<br>
<form method = "post" name = "frequentlyForm" action = "frequentlyPro.jsp">

	<%-- 게시판 창 크기 조절하는 곳 --%>
<table width = "1000" height = "800" border = "1" cellspacing = "0" cellpadding = "0" align = "center">
	<tr height = "30">
		<td width = "80" align = "center">아이디</td>
		<td width = "330"><%=mbdto.getId()%></td>
	</tr>
	
	<tr height = "30">
		<td width = "80" align = "center">제 목</td>
		<td width = "330"><input type = "text" size = "100" maxlength = "50" name = "title"></td>
	</tr>
	
	<tr>
		<td width = "70" align = "center">질문내용</td>
		<td width = "330"><textarea name = "con" rows = "44" cols = "127"></textarea></td>
	</tr>
	
	<tr>
		<td colspan = "2" align = "center">
			<input type = "submit" value = "작 성">
			<input type = "reset" value = "다시작성">
			<input type = button value = "취 소" onclick = "location = 'svmain.jsp'">
		</td>
	</tr>
</table>
</form>
<%}catch(Exception e){}%>
<jsp:include page="/member/footer.jsp"></jsp:include>