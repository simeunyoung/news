<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="member.MemberDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	AdminDAO dao = AdminDAO.getInstance();
	dao.addJournalist(dto.getId());
%>

dto.getId() : <%=dto.getId()%><br />
dto.getType() : <%=dto.getMemberType()%><br />
dto.getEmail() : <%=dto.getEmail()%><br />