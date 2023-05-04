<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="member.MemberDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	AdminDAO dao = AdminDAO.getInstance();
	int result = dao.denyJas(dto);
	if(result == 1) {%>
	<script>
		alert("해당신청을 반려하였습니다");
		window.location.href = "/project1/admin/journalistList.jsp";
	</script>
	<%} else {%>
	<script>
		alert("기자거절 실패");
		window.location.href = "/project1/admin/journalistList.jsp";
	</script>
	<%}%>
