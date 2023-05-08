<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<<<<<<< Updated upstream
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
=======
>>>>>>> Stashed changes
<%@ page import = "member.MemberDAO"%>
<%@ page import = "member.MemberDTO"%>
<%-- 1대1 문의글 삭제 --%>
<%
	String id = (String)session.getAttribute("memId");
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	MemberDAO mbDAO = MemberDAO.getInstance();
	MemberDTO mbdto = mbDAO.getMember(id);
%>

<<<<<<< Updated upstream
<title>CODENEWS</title>
<jsp:include page="/member/header.jsp" />
=======
>>>>>>> Stashed changes
<%if(id != null){
	if(mbdto.getMemberType().equals("2")){%>
	<center><b>글삭제</b>
<br>
<form method = "post" name = "qtdelForm" action = "qtdelePro.jsp?pageNum=<%=pageNum%>">
	<table border = "1" align = "center" cellspacing = "0" cellpadding = "0" width = "360">
		<tr heigth = "30">
			<td align = "center"><b>현재글을 삭제하시겠습니까?</b></td>					<%-- 잘못눌러서 글이 바로 삭제되는것을 방지하기 위해서 재차 묻게 해놓음 --%>
		</tr>
		<tr heigth = "30">
			<td align = "center">
				<input type = "submit" value = "글삭제">
				<input type = "button" value = "목록으로" onclick = "location.href='qalist.jsp?pageNum=<%=pageNum%>'">
				<input type = "hidden" name = "num" value = "<%=num%>">
			</td>
		</tr>
	</table>
</form>
	<%}else{%>
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
					<input type = "button" value = "문의목록" onclick = "location.href='qalist.jsp?pageNum=<%=pageNum%>'">
				</td>
			</tr>
		</table>
	</form>
<<<<<<< Updated upstream
<jsp:include page="/member/footer.jsp"></jsp:include>
	<%}%>
<%}%>
=======
	<%}%>
<%}%>
>>>>>>> Stashed changes
