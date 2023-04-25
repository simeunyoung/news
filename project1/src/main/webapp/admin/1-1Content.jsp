<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="admin.AdminDAO" %>
<%@ page import="admin.AdminDTO" %>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>1:1 문의 게시판</title>

<%
	// request.getParameter는 리턴타입이 String이라서 Integer를 이용해서 숫자로 변환
	int num = Integer.parseInt(request.getParameter("num"));
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	AdminDAO dao = AdminDAO.getInstance();
	AdminDTO dto = dao.oneononeGet(num);
%>

<center><h3>1:1 문의내용</h3></center>

<hr />
<br />

<form>
	<table align="center" width="800" border="1" cellspacing="0">
		<tr height="30">
			<td align="center" colspan="4"><%=dto.getTitle()%></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">작성자 : <%=dto.getId()%>(<%=dto.getName()%>)</td>
		</tr>
		<tr height="30">
			<td align="center" width="400">이메일 : <%=dto.getEmail()%></td>
			<td align="center">연락처 : <%=dto.getTel()%></td>
		<tr height="200">
			<td align="center" colspan="2"><%=dto.getCon()%></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">작성일자 : <%=sdf.format(dto.getReg())%></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="3">
				<input type="button" value="목록" onclick="location='1-1List.jsp'" />
				<input type="button" value="수정" onclick="location='1-1List.jsp'" />
				<input type="button" value="삭제" onclick="location='1-1List.jsp'" />
			</td>
		</tr>
	</table>
</form>