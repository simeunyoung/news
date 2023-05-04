<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO" %>
<%@ page import="member.MemberDTO" %>

<%
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	MemberDTO dto = dao.setMember(memId);
	if(dto.getMemberType() == null) {%>
	<script>
		alert("로그인 후 진행해주세요");
		history.go(-1);
	</script>
	<%} else if(dto.getMemberType().equals("1")) {%>
	<%} else {%>
	<script>
		alert("일반회원이 아닙니다.");
		history.go(-1);
	</script>
	<%}%>
<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>기자신청</title>

<center><h2>기자신청</h2></center>

<hr />
<br />

<form method="post" action="journalistPro.jsp">
	<input type="hidden" name="num2" value="<%=session.getAttribute("num2")%>" />
	<input type="hidden" name="id" value="<%=dto.getId()%>" />
	<input type="hidden" name="memberType" value="<%=dto.getMemberType()%>" />
	<input type="hidden" name="email" value="<%=dto.getEmail()%>" />
	<input type="hidden" name="tel" value="<%=dto.getTel()%>" /> 
	<input type="submit" value="전송">
</form>