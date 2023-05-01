<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="member.MemberDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	AdminDAO dao = AdminDAO.getInstance();
	int result = dao.deleteJas(dto);
	response.sendRedirect("journalistList.jsp");
%>
