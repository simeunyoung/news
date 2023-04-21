<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="admin.LoginDAO"%>
<%@ page import="admin.LoginDTO" %>

<%
	List jList = null;

	LoginDAO dao = LoginDAO.getInstance();
	int count = dao.getJCount();
	
	jList = dao.getJList();
%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>기자신청 리스트</title>

<center><h2>기자신청 리스트</h2></center>

<hr />
<br />

<center><h3>기자신청 목록(<%=count%>)</h3></center>

<form>
	<table align="center" width="700" border="1" cellspacing="0">
		<tr height="30">
			<td align="center" width="200">아이디</td>
			<td align="center" width="100">타입</td>
			<td align="center" width="300">이메일</td>
			<td align="center" width="100">승인/거절</td> 
		</tr>
	</table>
	<table action="journalistPro.jsp" align="center" width="700" border="1" cellspacing="0">
<%	for(int i = 0; i < jList.size(); i++) {
		LoginDTO dto = (LoginDTO)jList.get(i);%>	
		<tr height="20">
			<td align="center" width="200"><%=dto.getId()%><input type="hidden" name="id" value="<%=dto.getId()%>" /></td>
			<td align="center" width="100"><%=dto.getType()%><input type="hidden" name="type" value="<%=dto.getType()%>" /></td>
			<td align="center" width="300"><%=dto.getEmail()%><input type="hidden" name="email" value="<%=dto.getEmail()%>" /></td>
			<td align="center" width="100"><input type="submit" value="승인"/></td>
		</tr>
<%	} %>
	</table>
</form>