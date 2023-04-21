<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("utf-8"); %>
<jsp:useBean id="member" class="member.MemberDTO" />
<jsp:setProperty property="*" name="member" />

<%
	member.setReg(new Timestamp(System.currentTimeMillis()));
	MemberDAO manager = MemberDAO.getInstance();
	manager.insertMember(member);
	
	response.sendRedirect("loginForm.jsp");
%>