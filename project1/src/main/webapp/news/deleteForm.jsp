<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<jsp:include page="/member/header.jsp" />

<title>게시글 삭제 확인</title>

<%
String loginuser = (String) session.getAttribute("memId");

int num = Integer.parseInt(request.getParameter("num")); // num 파라미터를 int 타입으로 변경해서 가져오기
%>

<div align="center">
<%if(loginuser != null){ 
MemberDAO memdao = MemberDAO.getInstance();
MemberDTO userinfo = memdao.getmember(loginuser);
String usertype = userinfo.getMemberType(); 

String admin = "2";
if(usertype.equals(admin)){
response.sendRedirect("deleteAdminPro.jsp?num="+num);	
}else{ %>	
<center>
<h2>해당 기사를 삭제하기 위해서는 기사에 저장된 비밀번호가 필요합니다.</h2>
<%-- 작성자가 해당 기사를 삭제하기 전에 게시물의 비밀번호를 확인하며, 삭제 의사를 다시 한번 확인한다. --%>
<form method="post" align="center" action="deletePro.jsp?num=<%=num%>">
<input type="text" name="pw">
<input type="hidden" name="num" value="<%=num%>"><br /><br />
<input class="button" type="submit" value="해당 기사 삭제" >&nbsp;&nbsp;
<input class="button" type="button" value="목록으로 돌아가기" onclick="location='list.jsp'">
</form>
</center>
<%} } %>
</div>

<jsp:include page="/member/footer.jsp"></jsp:include>

<style>
.button {
	background-color: #475d9f;
	color: #ffffff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 4px;
	margin: 3px 0;
	font-size: 16px;
	width: 200px;
	height: 30px;
}
</style>