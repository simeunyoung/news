<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 1대1 문의글 작성 페이지 --%>
<%if(session.getAttribute("memId") == null){%>
	<script>
		alert("로그인을 해주십시오");
		location = "/project1/member/loginForm.jsp";
	</script>
<%}%>

<center><b>글쓰기</b></center>
<br>
<form method = "post" name = "questionForm" action = "questionPro.jsp">

	<%-- 게시판 창 크기 조절하는 곳 --%>
<table width = "1000" height = "800" border = "1" cellspacing = "0" cellpadding = "0" align = "center">
	<tr height = "30">
		<td width = "80" align = "center">이 름</td>
		<td width = "330"><input type = "text" size = "10" maxlength = "30" name = "id"></td>
	</tr>
	
	<tr height = "30">
		<td width = "80" align = "center">제 목</td>
		<td width = "330"><input type = "text" size = "100" maxlength = "50" name = "title"></td>
	</tr>
	
	<tr height = "30">
		<td width = "80" align = "center">Email</td>
		<td width = "330"><input type = "text" size = "50" maxlength = "50" name = "email"></td>
	</tr>
	
	<tr>
		<td width = "70" align = "center">질문내용</td>
		<td width = "330"><textarea name = "con" rows = "44" cols = "127"></textarea></td>
	</tr>
		
	<tr height = "30">
		<td width = "70" align = "center">비밀번호</td>
		<td width = "330"><input type = "password" size = "8" maxlength = "12" name = "pw"></td>
	</tr>
	
	<tr>
		<td colspan = "2" align = "center">
			<input type = "submit" value = "전 송">
			<input type = "reset" value = "다시작성">
			<input type = button value = "취 소" onclick = "location = 'svmain.jsp'">
		</td>
	</tr>
</table>

</form>