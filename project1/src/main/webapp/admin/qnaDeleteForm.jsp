<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="admin.AdminDAO"%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	AdminDAO dao = AdminDAO.getInstance();
	AdminDTO dto = dao.qnaUpdateGet(num); // num으로 qna 정보를 불러옴
%>
<jsp:include page="/member/header.jsp" />

<title>Q&A 삭제</title>
<center><h3>Q&A 삭제</h3></center>

<hr />
<br />

<form method="post" action="qnaDeletePro.jsp?num=<%=dto.getNum()%>&pageNum=<%=pageNum%>">
	<table align="center">
		<tr>
			<td>
				<input type="hidden" name="num" value="<%=dto.getNum()%>" />
				비밀번호 : <input type="password" name="pw"/><input type="submit" value="삭제" />
			</td>
		</tr>
	</table>
</form>
<jsp:include page="/member/footer.jsp"></jsp:include>