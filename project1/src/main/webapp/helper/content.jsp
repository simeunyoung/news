<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="model.HelperDAO" %>
<%@ page import="model.HelperDTO" %>


<title>Q&A게시판</title>

<%
	// request.getParameter는 리턴타입이 String이라서 Integer를 이용해서 숫자로 변환
	int num = Integer.parseInt(request.getParameter("num"));
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	HelperDAO dao = HelperDAO.getInstance();
	HelperDTO dto = dao.getQna(num);
%>

<center><h3>문의내용</h3></center>

<hr />
<br />

<form>
	<table align="center" width="800" border="1" solid>
		<tr height="30">
			<td align="center" colspan="4"><%=dto.getSubject()%></td>
		</tr>
		<tr height="20">
			<td align="left">조회수 : <%=dto.getReadcount()%></td>
			<td align="left">작성자 : <%=dto.getName()%></td>
			<td align="left"><%=sdf.format(dto.getReg())%></td>
		</tr>
	</table>
</form>