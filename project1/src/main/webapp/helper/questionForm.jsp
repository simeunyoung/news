<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDTO"%>
<%@ page import = "member.MemberDAO"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<%-- 1대1 문의 글작성 페이지 --%>
<%if(session.getAttribute("memId") == null){%>
	<script>
		alert("로그인을 해주십시오");
		location = "/project1/member/loginForm.jsp";
	</script>
<%}%>

<%
	String id = (String)session.getAttribute("memId");

	MemberDAO mbDAO = MemberDAO.getInstance();
	MemberDTO mbdto = mbDAO.getMember(id);

try{
%>
<title>CODENEWS</title>
<jsp:include page="/member/header.jsp" />
<center><b>글쓰기</b></center>
<br>
<form method = "post" name = "questionForm" action = "questionPro.jsp">

	<%-- 게시판 창 크기 조절하는 곳 --%>
<table width = "1000" height = "800" border = "1" cellspacing = "0" cellpadding = "0">
	<tr height = "30">
		<td width = "80">아이디</td>
		<td width = "330"><%=mbdto.getId()%></td>
	</tr>
	
	<tr height = "30">
		<td width = "80">제 목</td>
		<td width = "330"><input type = "text" size = "100" maxlength = "50" name = "title"></td>
	</tr>
	
	<tr height = "30">
		<td width = "80">Email</td>
		<td width = "330"><input type = "text" size = "50" maxlength = "50" name = "email"></td>
	</tr>
	
	<tr>
		<td width = "70">질문내용</td>
		<td width = "330"><textarea name = "con" rows = "44" cols = "127"></textarea></td>
	</tr>
		
	<tr height = "30">
		<td width = "70">비밀번호</td>
		<td width = "330"><input type = "password" size = "8" maxlength = "12" name = "pw"></td>
	</tr>
	
	<tr>
		<td colspan = "2">
			<input type = "submit" value = "전 송">
			<input type = "reset" value = "다시작성">
			<input type = button value = "취 소" onclick = "location = 'svmain.jsp'">
		</td>
	</tr>
</table>
</form>
<%}catch(Exception e){}%>
<jsp:include page="/member/footer.jsp"></jsp:include>