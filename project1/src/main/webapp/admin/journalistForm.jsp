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
	if(dto.getMemberType() == null || dto.getMemberType().equals("0")) {
	out.print(dto.getMemberType());%>
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

<div class="page-wrap js-request">
	<h2>기자신청</h2>

<form method="post" action="journalistPro.jsp">
	<div class="js-request">
	<select name="press">
		<option value="동아일보">동아일보</option>
		<option value="경향신문">경향신문</option>
		<option value="노컷뉴스">노컷뉴스</option>
		<option value="NewDaily">NewDaily</option>
		<option value="뉴스타파">뉴스타파</option>
		<option value="디지털타임스">디지털타임스</option>
		<option value="마이데일리">마이데일리</option>
		<option value="매일경제">매일경제</option>
		<option value="미디어오늘">미디어오늘</option>
	</select>
	
	<input type="hidden" name="id" value="<%=dto.getId()%>" />
	<input type="hidden" name="memberType" value="<%=dto.getMemberType()%>" />
	<input type="hidden" name="email" value="<%=dto.getEmail()%>" />
	<input type="hidden" name="tel" value="<%=dto.getTel()%>" /> 
	<input type="submit" value="전송">
	</div>
</form>
</div>
<jsp:include page="/member/footer.jsp"></jsp:include>