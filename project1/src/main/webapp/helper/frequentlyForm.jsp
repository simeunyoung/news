<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 자주묻는질문 작성하는 곳 --%>
<center><b>글쓰기</b></center>
<br>
<form method = "post" name = "frequentlyForm" action = "frequentlyPro.jsp">

	<%-- 게시판 창 크기 조절하는 곳 --%>
<table width = "1000" height = "800" border = "1" cellspacing = "0" cellpadding = "0" align = "center">
	<tr height = "30">
		<td width = "80" align = "center">아이디</td>
		<td width = "330"><input type = "text" size = "" maxlength = "30" name = "id"></td>
	</tr>
	
	<tr height = "30">
		<td width = "80" align = "center">제 목</td>
		<td width = "330"><input type = "text" size = "100" maxlength = "50" name = "title"></td>
	</tr>
	
	<tr>
		<td width = "70" align = "center">질문내용</td>
		<td width = "330"><textarea name = "con" rows = "47" cols = "127"></textarea></td>
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