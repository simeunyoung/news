<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="admin.AdminDAO"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	AdminDAO dao = AdminDAO.getInstance();
	AdminDTO dto = dao.qnaUpdateGet(num);
%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>Q&A 삭제</title>
<center><h3>Q&A 삭제</h3></center>

<hr />
<br />

<form method="post" action="qnaDeletePro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
	<table align="center">
		<tr>
			<td>
				<input type="hidden" name="num" value="<%=dto.getNum()%>" />
				비밀번호 : <input type="password" name="pw"/><input type="submit" value="삭제" />
			</td>
		</tr>
	</table>
</form>