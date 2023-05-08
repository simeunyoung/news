<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<%-- 자주묻는질문 글 삭제 --%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pagaNum");
%>

<title>CODENEWS</title>
<jsp:include page="/member/header.jsp" />

<center><b>글삭제</b>
<br>
<form method = "post" name = "fqdeleForm" action = "fqdelePro.jsp?pageNum=<%=pageNum%>">
	<table border = "1" align = "center" cellspacing = "0" cellpadding = "0" width = "360">
		<tr heigth = "30">
			<td align = "center"><b>현재글을 삭제하시겠습니까?</b></td>					<%-- 잘못눌러서 글이 바로 삭제되는것을 방지하기 위해서 재차 묻게 해놓음 --%>
		</tr>
		<tr heigth = "30">
			<td align = "center">
				<input type = "submit" value = "글삭제">
				<input type = "button" value = "목록으로" onclick = "location.href='svmain.jsp?pageNum=<%=pageNum%>'">
				<input type = "hidden" name = "num" value = "<%=num%>">
			</td>
		</tr>
	</table>
</form>
<jsp:include page="/member/footer.jsp"></jsp:include>
