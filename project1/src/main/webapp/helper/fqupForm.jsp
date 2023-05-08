<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.Svcenter1DAO"%>
<%@ page import = "helper.Svcenter1DTO"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<title>CODENEWS</title>
<jsp:include page="/member/header.jsp"></jsp:include>
<%--자주묻는질문 수정페이지 --%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	try{
		Svcenter1DAO svdao1 = Svcenter1DAO.getInstance();
		Svcenter1DTO svdto1 = svdao1.updateGetSvcenter1(num); 		//해당 글번호를 받아와서 대입하고 해당 글의 데이터를 꺼내오는중
%>

<center><b>글수정</b>
<br>
	<form method = "post" name = "frequentlyForm" action = "fqupPro.jsp?pageNum=<%=pageNum%>">
		<table width = "1000" height = "800" border = "1" cellspacing = "0" cellpadding = "0" align = "center">
			<tr heigth = "30">
				<td width = "80" align = "center">작성자</td>
				<td align = "left" width = "330"><%=svdto1.getId()%>			<%-- 아이디는 로그인을 한 상태이고 해당 페이지는 관리자만 작성 수정이 가능하기에 admin 고정이기에 DB에서 꺼내와 대입 --%>
					<input type = "hidden" name = "num" value = "<%=svdto1.getNum()%>"></td>
			</tr>
			<tr height = "30">
				<td width = "80" align = "center">제 목</td>
				<td align = "left" width = "330">
					<input type = "text" size = "10" maxlength = "50" name = "title" value = "<%=svdto1.getTitle()%>"></td>
			</tr>
			<tr heigth = "30">
				<td width = "80" align = "center">내 용</td>
				<td align = "left width = "330">
				<textarea name = "con" rows = "44" cols = "127"><%=svdto1.getCon()%></textarea></td>
			</tr>
			<tr>
				<td colspan = "2" align = "center">
					<input type = "submit" value = "수정하기">
					<input type = "reset" value = "다시작성">
					<input type = "button" value = "돌아가기" onclick = "location.href='svmain.jsp?pageNum=<%=pageNum%>'"></td>
			</tr>
			</table>
	</form>
<%}catch(Exception e){}%>
<jsp:include page="/member/footer.jsp"></jsp:include>
