<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:useBean id="member" class="member.MemberDTO" />
<jsp:setProperty property="*" name="member" />

<%
	String id = (String)session.getAttribute("memId");
	member.setId(id);
	
	MemberDAO manager = MemberDAO.getInstance();
	manager.updateMember(member);
	
	response.sendRedirect("user_mypage_form.jsp?id="+id);
%>
<script>
	alert("수정이 완료 되었습니다.");
</script>

