<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="member.MemberDTO"%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	MemberDTO dto = dao.setMember(memId);
	// 일반회원이 아니면 들어올 수 없게함
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
	
<jsp:include page="/member/header.jsp" />

<title>기자신청</title>
<center><h2>기자신청</h2></center>

<hr />
<br />

<form method="post" action="journalistPro.jsp">
	<input type="text" name="press" placeholder="언론사" />
	<input type="hidden" name="id" value="<%=dto.getId()%>" />
	<input type="hidden" name="memberType" value="<%=dto.getMemberType()%>" />
	<input type="hidden" name="email" value="<%=dto.getEmail()%>" />
	<input type="hidden" name="tel" value="<%=dto.getTel()%>" /> 
	<input type="submit" value="전송">
</form>
<jsp:include page="/member/footer.jsp"></jsp:include>