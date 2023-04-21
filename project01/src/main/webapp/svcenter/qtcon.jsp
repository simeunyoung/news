<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "svcenter.SvcenterDAO"%>
<%@ page import = "svcenter.SvcenterDTO"%>
<%@ page import = "java.text.SimpleDateFormat"%>

<title>문의내용</title>

<% 
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	try{
		SvcenterDAO svDAO = SvcenterDAO.getInstance();
		SvcenterDTO svDTO = svDAO.getSvDTO(num);
%>

<center><b>문의내용보기</b>
<br>
<form>
	<table width = "600" height = "500" border = "1" cellspacing = "0" cellpadding = "0" align = "center">
		<tr width = "8" height = "8">
			<td align = "center" width = "10">글번호</td>
			<td align = "center" width = "10" align = "center" colspan = "3"><%=svDTO.getNum1()%></td>
		</tr>
		
		<tr width = "10" height = "10">
			<td align = "center" width = "35">작성자</td>
			<td align = "center" width = "35" align = "center"><%=svDTO.getId()%></td>
			
			<td align = "center" width = "35">작성일</td>
			<td align = "center" width = "35" align = "center"><%=sdf.format(svDTO.getReg())%>
		</tr>
		
		<tr height = "10">
			<td align = "center" width = "70">email</td>
			<td align = "center" width = "70" align = "center" colspan = "3"><%=svDTO.getEmail()%></a></td>
		</tr>
		
		<tr height = "10">
			<td align = "center" width = "70">제 목</td>
			<td align = "center" width = "70" align = "center" colspan = "3"><%=svDTO.getTitle()%></td>
		</tr>
		
		<tr height = "30">
			<td align = "center" width = "125">문의내용</td>
			<td align = "left" width = "400" heigth = "300" align = "center" colspan = "3"><%=svDTO.getCon()%></td>
		</tr>
		
		<tr>
			<td colspan = "4" align = "right">
				<%
					//String id = (String)session.getAttribute("memId");
					//if(id != null){
						//if(id.equals(svDTO.getTitle())){
				%>
			<input type = "button" value = "글수정" onclick = "location.href='qtupForm.jsp?num=<%=svDTO.getNum1()%>&pageNum=<%=pageNum%>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
			<input type = "button" value = "글삭제" onclick = "location.href='qtdeleForm.jsp?num=<%=svDTO.getNum1()%>&pageNum=<%=pageNum%>'">
				&nbsp;&nbsp;&nbsp;&nbsp;
				<%//}%>
			<%//}%>
			<input type = "button" value = "글목록" onclick = "location.href='svmain.jsp?pageNum=<%=pageNum%>'">
		</td>
	</tr>		
</table>
<%}catch(Exception e){} %>
</form>