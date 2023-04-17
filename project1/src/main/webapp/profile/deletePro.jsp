<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
</head>
<%
	String id = (String)session.getAttribute("memId");
	String pw = request.getParameter("pw");
	
	MemberDAO manager = MemberDAO.getInstance();
	int check = manager.deleteMember(id, pw);
	
	if(check == 1){
		session.invalidate();
	%>
	<script>
		alert("탈퇴되었습니다.");
		location="main.jsp";
	</script>
	<%}else { %>
		<script>
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
	<%} %>
<body>

</body>
</html>