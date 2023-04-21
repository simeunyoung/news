<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.Svcenter1DAO"%>
<%@ page import = "helper.Svcenter1DTO"%>
<%@ page import = "java.text.SimpleDateFormat"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	try{
		Svcenter1DAO svdao1 = Svcenter1DAO.getInstance();
		Svcenter1DTO svdto1 = svdao1.getSvdto1(num);	
%>

<center><b>내 용</b></center>
<form>
	<table width = "600" height = "500" border = "1" cellspacing = "0" cellpadding = "0" align = "center">
		<tr width = "8" height = "8">
			<td align = "center" width = "10">글번호</td>
			<td align = "center" width = "10" align = "center" colspan = "3"><%=svdto1.getNum()%></td>
		</tr>
		
		<tr width = "10" height = "10">
			<td align = "center" width = "10">작성자</td>
			<td align = "center" width = "10" align = "center"><%=svdto1.getId()%></td>
			
			<td align = "center" width = "10">작성일</td>
			<td align = "center" width = "10" align = "center"><%=sdf.format(svdto1.getReg())%></td>
		</tr>
		
		<tr heigth = "6" height = "10">
			<td align = "center" width = "10">제 목</td>
			<td align = "center" width = "10" align = "center" colspan = "3"><%=svdto1.getTitle()%></td>
		</tr>
		
		<tr height = "400">
			<td align = "center" width = "20">내 용</td>
			<td align = "left" width = "20" align = "center" colspan = "3"><%=svdto1.getCon()%></td>
		</tr>
		
		<tr>
			<td colspan = "4" align = "right">
			
			<input type = "button" value = "글수정" onclick = "location.href='fqupForm.jsp?num=<%=svdto1.getNum()%>&pageNum<%=pageNum%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			<input type = "button" value = "글삭제" onclick = "location.href='fqdeleForm.jsp?num=<%=svdto1.getNum()%>&pageNum<%=pageNum%>'">
			&nbsp;&nbsp;&nbsp;&nbsp;
			
			<input type = "button" value = "글목록" onclick = "location.href='frequentlyMain.jsp?pageNum=<%=pageNum%>'">
			</td>
		</tr>
	</table>
<%}catch(Exception e){} %>
</form>