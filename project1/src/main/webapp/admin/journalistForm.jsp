<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO" %>
<%@ page import="member.MemberDTO" %>

<%
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	MemberDTO dto = null;
	dto = dao.memberTypeCheck(memId);
%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>기자신청</title>

<center><h2>기자신청</h2></center>

<hr />
<br />

<form method="post" action="journalistPro.jsp">
	<input type="hidden" name="id" value="<%=dto.getId()%>" />
	<input type="hidden" name="memberType" value="<%=dto.getMemberType()%>" />
	<input type="hidden" name="email" value="<%=dto.getEmail()%>" />
	<input type="submit" value="전송">
</form> 