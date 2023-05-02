<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	
	AdminDTO dto = dao.faqGet(num);
%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>FAQ 수정</title>
memId = <%=memId%>
<center><h3>FAQ 수정</h3></center>

<hr />
<br />

<form method="post" action="faqUpdatePro.jsp?pageNum<%=pageNum%>">
	<table align="center" width="">
		<tr>
			
		</tr>
	</table>
</form>