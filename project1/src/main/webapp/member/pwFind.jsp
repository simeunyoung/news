<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:useBean id="member" class="member.MemberDTO" />
<jsp:setProperty property="*" name="member" />
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<%
	MemberDAO manager = MemberDAO.getInstance();
	String result = manager.pwFind(member);
	if(result == null){
%>
	<script>
		alert("아이디 또는 이메일이 일치하지 않습니다.");
		history.go(-1);
	</script>
<%}else{%>
	<h2>비밀번호는 [<%=result %>] 입니다.</h2>
	<a href="loginForm.jsp">로그인 하기</a>
<%}%>