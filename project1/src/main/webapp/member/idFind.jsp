<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="member" class="member.MemberDTO" />
<jsp:setProperty property="*" name="member" />

<%
	MemberDAO manager = MemberDAO.getInstance();
	String result = manager.idFind(member);
	if(result == null){
%>
	<script>
		alert("아이디를 찾을 수 없습니다.");
		history.go(-1);
	</script>
<%} else {%>
	<p>아이디는 [<%=result %>] 입니다.</p>
	<a href="loginForm.jsp">로그인하기</a>
<% } %>