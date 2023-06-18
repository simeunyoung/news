<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%String sid = (String)session.getAttribute("sid");%>
<%String stype = (String)session.getAttribute("stype");%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>로그인</title>
<%=sid%>
<%=stype%>
<center><h2>로그인</h2></center>

<hr>
<br>

<form action="signinPro.jsp">
	<table>
		<tr>
			<td><input type="text" name="id" placeholder="아이디"></td>
		</tr>	
		<tr>
			<td><input type="password" name="pw" placeholder="비밀번호"></td>
		</tr>	
		<tr>
			<td><input type="submit" value="로그인"></td>
		</tr>	
	</table>
</form>
