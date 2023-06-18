<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/dbaea98925.js" crossorigin="anonymous"></script>
<script src="/project1/resource/js/script.js"></script>
<jsp:useBean id="member" class="member.MemberDTO" />
<jsp:setProperty property="*" name="member" />

<%
	MemberDAO manager = MemberDAO.getInstance();
	String result = manager.idFind(member); // 아이디 찾기
	if(result == null){
%>
	<script>
		alert("이름 또는 생년월일이 일치하지 않습니다.");
		history.go(-1);
	</script>
<%} else {%>
	<div class="page-wrap idFind">
		<h2>아이디는 [<%=result %>] 입니다.</h2>
		<a href="/project1/member/loginForm.jsp" class="bookmark-btn">로그인 하기 <i class="fa-solid fa-right-long"></i> </a>
	</div>
<% } %>