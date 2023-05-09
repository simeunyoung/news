<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="admin.AdminDAO"%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String pageNum2 = request.getParameter("pageNum2");
	
	AdminDAO dao = AdminDAO.getInstance();
	AdminDTO dto = dao.getRecon(num);
	
	int result = dao.deleteRecon(dto);
	if(result == 1) {%>
	<script>
		alert("삭제되었습니다");
		window.location.href ="/project1/admin/qnaContent.jsp?num=<%=dto.getNum2()%>&pageNum=<%=pageNum%>&pageNum2=<%=pageNum2%>";
	</script>
	<%} else {%>
	<script>
	alert("비정상적인 접근입니다");
	window.location.href ="/project1/admin/qnaContent.jsp?num=<%=dto.getNum2()%>&pageNum=<%=pageNum%>&pageNum2=<%=pageNum2%>";
	</script>
	<%}%>