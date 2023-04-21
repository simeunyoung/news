<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="member" class="member.MemberDTO" />
<jsp:setProperty property="*" name="member" />

<%
	MemberDAO manager = MemberDAO.getInstance();
	String result = manager.pwFind(member);
	if(result == null){
%>
	<script>
		alert("비밀번호를 찾을 수 없습니다.");
		history.go(-1);
	</script>
<%}else{%>
	<h2>비밀번호는 [<%=result %>] 입니다.</h2>
	<a href="loginForm.jsp">로그인 하기</a>
<%}%>