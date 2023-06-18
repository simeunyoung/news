<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="admin.AdminDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	dto.setIp(request.getRemoteAddr());

	AdminDAO dao = AdminDAO.getInstance();
	int result = dao.insertJas(dto);
	if(result == 0) {%>
	<script>
		alert("중복신청되었거나 이미 반려되었습니다.");
		window.location.href = "/project1/news/main.jsp";
	</script>
	<%} else {%>
	<script>
		alert("정상적으로 신청되었습니다.");
		window.location.href = "/project1/news/main.jsp";
	</script>
	<%}%>
