<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<jsp:include page="/member/header.jsp" />

<title>게시글 삭제 확인</title>

<%


int num = Integer.parseInt(request.getParameter("num"));
%>

<div align="center">

<center>
<h2>해당 기사를 삭제하기 위해서는 기사에 저장된 비밀번호가 필요합니다.</h2>
<form method="post" align="center" action="deletePro.jsp?num=<%=num%>">
<input type="text" name="pw">
<input type="hidden" name="num" value="<%=num%>"><br /><br />
<input class="button" type="submit" value="해당 기사 삭제" >&nbsp;&nbsp;
<input class="button" type="button" value="목록으로 돌아가기" onclick="location='list.jsp'">
</form>
</center>
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