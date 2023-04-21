<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="admin.HelperDAO" %>
<%@ page import="admin.HelperDTO" %>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>1:1 문의 게시판</title>

<%
	// request.getParameter는 리턴타입이 String이라서 Integer를 이용해서 숫자로 변환
	int num = Integer.parseInt(request.getParameter("num"));
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	HelperDAO dao = HelperDAO.getInstance();
	HelperDTO dto = dao.getQna(num);
%>

<center><h3>1:1 문의내용</h3></center>

<hr />
<br />

<form>
	<table align="center" width="800" border="1" cellspacing="0">
		<tr height="30">
			<td align="center" colspan="4"><%=dto.getSubject()%></td>
		</tr>
		<tr height="20">
			<td align="center">작성자 : <%=dto.getName()%></td>
			<td align="center">작성일자 : <%=sdf.format(dto.getReg())%></td>
			<td align="center">조회수 : <%=dto.getReadcount()%></td>
		</tr>
		<tr>
			<td align="center" colspan="3" height="200"><%=dto.getContent()%></td>
		</tr>
		<tr>
			<td align="center"><input type="button" value="목록" onclick="location='qnaList.jsp'" /></td>
			<td align="center"><input type="button" value="수정" onclick="location='qnaList.jsp'" /></td>
			<td align="center"><input type="button" value="삭제" onclick="location='qnaList.jsp'" /></td>
		</tr>
	</table>
</form>