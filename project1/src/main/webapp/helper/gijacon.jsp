<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.GijaDTO"%>
<%@ page import = "helper.GijaDAO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%-- 신청이 들어온 것을 보고 승락을 하면 바뀌는 구조로 할려고 했었음 --%>
<%
	String id = (String)session.getAttribute("memId");
	
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	try{
			GijaDAO gdao = GijaDAO.getInstance();
			GijaDTO gdto = gdao.getGjdto(num);
%>

<center><b>기자신청보기</b>
<br>
<form method = "post" action = "gijaPro.jsp" name = "gijacon">
	<table width = "600" height = "500" border = "1" cellspacing = "0" cellpadding = "0" align = "center">
		<tr width = "8" height = "8">
			<td align = "center" width = "10">글번호</td>
			<td align = "center" width = "10" align = "center" colspan = "3"><%=gdto.getNum()%></td>
		</tr>
		
		<tr width = "10" height = "10">
			<td align = "center" width = "35">신청인</td>
			<td align = "center" width = "35" align = "center"><%=gdto.getId()%></td>
		
			<td align = "center" width = "35">신청일</td>
			<td align = "center" width = "35" align = "center"><%=sdf.format(gdto.getReg())%>
		</tr>
		
		<tr height = "10">
			<td align = "center" width = "70">Email</td>
			<td align = "center" width = "70" align = "center" colspan = "3"><%=gdto.getEmail()%></td>
		</tr>
		
		<tr height = "10">
			<td align = "center" width = "70">전화번호</td>
			<td align = "center" width = "70" align = "center" colspan = "3"><%=gdto.getTel()%></td>
		</tr>
		
		<tr height = "10">
			<td align = "center" width = "35">언론사</td>
			<td align = "center" width = "35" align = "center" colsapn = "3"><%=gdto.getPress()%></td>
		</tr>
		
		<tr>
			<td colspan = "4" align = "right">
				<%if(id != null){
					if(id.equals("admin")){%>
			<input type = "submit" value = "승인">
			<input type = "button" value = "거절" onclick = "">
			<%}%>
		<%}%>
		</td>
	</tr>		
	</table>
<%}catch(Exception e){}%>
</form>