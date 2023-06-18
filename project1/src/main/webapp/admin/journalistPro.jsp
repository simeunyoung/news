<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.LoginDAO"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="admin.LoginDTO" />
<jsp:setProperty property="*" name="dto" />

<%
LoginDAO dao = LoginDAO.getInstance();
dao.insertPJ(dto);
%>

dto.getId() : <%=dto.getId()%><br />
dto.getType() : <%=dto.getType()%><br />
dto.getEmail() : <%=dto.getEmail()%><br />