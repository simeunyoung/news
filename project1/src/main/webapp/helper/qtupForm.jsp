<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.SvcenterDAO"%>
<%@ page import = "helper.SvcenterDTO"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<%-- 1대1 문의글 수정 --%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	try{
		SvcenterDAO svdao = SvcenterDAO.getInstance();
		SvcenterDTO svdto = svdao.updateGetSvcenter(num); 
%>

<title>CODENEWS</title>
<jsp:include page="/member/header.jsp" />
<br>
	<form method = "post" name = "questionfrom" action = "qtupPro.jsp?pageNum=<%=pageNum%>">
		<table width = "1000" height = "800" border = "1" cellspacing = "0" cellpadding = "0" align = "center">
			<tr height = "30">
				<td width = "80" align = "center">작성자</td>
				<td align = "left" width = "330"><%=svdto.getId()%>
						<input type = "hidden" name = "num1" value = "<%=svdto.getNum1()%>"></td>
			</tr>
			<tr height = "30">
				<td width = "80" align = "center">제 목</td>
				<td align = "left" width = "330">
					<input type = "text" size = "100" maxlength = "50" name = "title" value = "<%=svdto.getTitle()%>"></td>
			</tr>
			<tr height = "30">
				<td width = "80" align = "center">Email</td>
				<td align = "left" width = "330">
					<input type = "text" size = "50" maxlength = "50" name = "email" value = "<%=svdto.getEmail()%>"></td>
			</tr>
			<tr height = "30">
				<td width = "70" align = "center">질문내용</td>
				<td align = "left" width = "330">
					<textarea name = "con" rows = "44" cols = "127"><%=svdto.getCon()%></textarea></td>
			</tr>
			<tr height = "30">
				<td width = "70" align = "center">비밀번호</td>
				<td align = "left" width = "330">
					<input type = "password" size = "8" maxlength = "12" name = "pw"></td>
			</tr>
			<tr>
				<td colspan = "2" align = "center">
					<input type = "submit" value = "글수정">
					<input type = "reset" value = "다시작성">
					<input type = "button" value = "글목록" onclick = "location.href='qalist.jsp?pageNum=<%=pageNum%>num=<%=num%>'"></td>
			</tr>
		</table>
	</form>
<%}catch(Exception e){}%>
<jsp:include page="/member/footer.jsp"></jsp:include>