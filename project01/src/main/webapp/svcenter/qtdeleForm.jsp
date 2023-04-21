<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
%>

<title>문의글삭제</title>

<script language = "JavaScript">

function deleteSave(){
		if(document.qtdelForm.pw.value == ''){
			alert("비밀번호를 입력해주시기 바랍니다.");
			document.qtdelFrom.pw.focus();
			return false;
		}
}
</script>

<center><b>문의글삭제</b>
<br>
	<form method = "post" name = "qtdelForm" action = "qtdelePro.jsp?pageNum=<%=pageNum%>"
	onsubmit = "return deleteSave()">
		<table border = "1" align = "center" cellspacing = "0" cellpadding = "0" width = "360">
			<tr heigth = "30">
				<td ailgn = "center"><b>비밀번호를 입력해주십시오.</b></td>
			</tr>
			<tr height = "30">
				<td align = "center">비밀번호 : <input type = "password" name = "pw" size = "8" maxlength = "12">
					<input type = "hidden" name = "num" value = "<%=num%>"></td>
			</tr>
			<tr heigth = "30">
				<td align = "center">
					<input type = "submit" value = "글삭제">
					<input type = "button" value = "문의목록" onclick = "location.href='svmain.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
		</table>
	</form>