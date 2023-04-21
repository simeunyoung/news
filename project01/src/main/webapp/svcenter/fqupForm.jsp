<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "svcenter1.Svcenter1DAO"%>
<%@ page import = "svcenter1.Svcenter1DTO"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	try{
		Svcenter1DAO svdao1 = Svcenter1DAO.getInstance();
		Svcenter1DTO svdto1 = svdao1.updateGetSvcenter1(num); 
%>

<center><b>글수정</b>
<br>
	<form method = "post" name = "frequentlyForm" action = "fqupPro.jsp?pageNum=<%=pageNum%>">
		<table width = "1000" height = "800" border = "1" cellspacing = "0" cellpadding = "0" align = "center">
			<tr heigth = "30">
				<td width = "80" align = "center">작성자</td>
				<td align = "left" width = "330">
					<input type = "text" size = "10" maxlength = "10" name = "id" value = "<%=svdto1.getId()%>">
					<input type = "hidden" name = "num" value = "<%=svdto1.getNum()%>"></td>
			</tr>
			<tr height = "30">
				<td width = "80" align = "center">제 목</td>
				<td align = "left" width = "330">
					<input type = "text" size = "10" maxlength = "50" name = "title" value = "<%=svdto1.getTitle()%>"></td>
			</tr>
			<tr heigth = "30">
				<td width = "80" align = "center">내 용</td>
				<td align = "left width = "330">
				<textarea name = "con" rows = "44" cols = "127"><%=svdto1.getCon()%></textarea></td>
			</tr>
			<tr>
				<td colspan = "2" align = "center">
					<input type = "submit" value = "수 정">
					<input type = "reset" value = "다시작성">
					<input type = "button" value = "돌아가기" onclick = "location.href='frequentlyMain.jsp?pageNum=<%=pageNum%>'"></td>
			</tr>
			</table>
	</form>
<%}catch(Exception e){}%>