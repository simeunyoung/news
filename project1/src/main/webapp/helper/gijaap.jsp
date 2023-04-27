<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO"%>
<%@ page import = "member.MemberDTO" %>
<%-- 기자신청 페이지 --%>

<%
	String id = (String)session.getAttribute("memId");

	MemberDAO mbDAO = MemberDAO.getInstance();
	MemberDTO mbdto = mbDAO.getMember(id);
	
	try{
%>
<center><b>기자신청</b></center>
<form method = "post" action = "gijaapPro.jsp" name = "userinput">
	<table width = "600" border = "1" cellspacing = "3" align = "center">
		
		<tr>
			<td width = "200">ID</td>
			<td width = "400"><%=mbdto.getId()%></td>
		</tr>
		
		<tr>
			<td width = "200">이 름</td>
			<td width = "400"><%=mbdto.getName()%></td>
		</tr>
		
		<tr>
			<td width = "200">이메일</td>
			<td width = "400"><%=mbdto.getEmail()%></td>
		</tr>
		
		<tr>
			<td width = "200">전화전호</td>
			<td width = "400"><%=mbdto.getTel()%></td>
		</tr>
		
		<tr>
			<td width = "200">언론사</td>
			<td width = "400">
				<input type = "text" name = "press" size = "40" maxlength = "30"></td>
		</tr>
		
		<tr>
			<td colspan = "2" align = "center">
				<input type = "submit" value = "신 청">
				<input type = "button" value = "취 소" onclick = "location='svmain.jsp'">
			</td>
		</tr>	
	</table>
</form>
<%}catch(Exception e){}%>