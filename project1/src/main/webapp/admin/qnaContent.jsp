<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.QnaDAO"%>
<%@ page import="admin.QnaDTO"%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>Q&A 게시판</title>
이전글 다음글 기능 추가요망
<%
	int num = Integer.parseInt(request.getParameter("num"));
	
	QnaDAO dao = QnaDAO.getInstance();
	QnaDTO dto = dao.getQna(num);
%>
<center><h3>Q&A</h3></center>

<hr />
<br />

<form>
	<table align="center" width="800" border="1" cellspacing="0">
		<tr height="30">
			<td align="center"><%=dto.getSubject()%></td>
		</tr>
		<tr height="300">
			<td align="center"><%=dto.getContent()%></td>
		</tr>
	</table>
</form>