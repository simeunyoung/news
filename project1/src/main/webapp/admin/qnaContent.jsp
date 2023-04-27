<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	AdminDTO dto = dao.getQna(num);
	if(memId == null) {dto.setMemberType("0");}
%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>Q&A 게시판</title>
이전글 다음글 기능 추가요망
<center><h3>Q&A</h3></center>

<hr />
<br />

<form>
	<table align="center" width="800" border="1" cellspacing="0">
		<tr height="30">
			<td align="center">
		</tr>
		<tr height="30">
			<td align="center"><%=dto.getTitle()%></td>
		</tr>
		<tr height="300">
			<td align="center"><%=dto.getCon()%></td>
		</tr>
	</table>
</form>