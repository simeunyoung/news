<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="member" class="member.MemberDTO" />
<jsp:setProperty property="*" name="member" />

<%
	member.setReg(new Timestamp(System.currentTimeMillis()));
	MemberDAO manager = MemberDAO.getInstance();
	int result = manager.insertMember(member); // 회원가입
	if(result == 0){ // insert 안됐을때
		%>
		<script>
		alert("이미 가입되어 있는 아이디입니다.");
		history.go(-1);
		</script>
		<%
	}
		
	response.sendRedirect("loginForm.jsp");
%>
<%=result%>