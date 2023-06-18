<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");

	AdminDTO dto = dao.qnaUpdateGet(num);
%>
<jsp:include page="/member/header.jsp" />

<title>Q&A 수정</title>
memId = <%=memId%>
<center><h3>Q&A 수정</h3></center>

<hr />
<br />

<form method="post" action="qnaUpdatePro.jsp?pageNum=<%=pageNum%>">
	<table align="center" width="800" border="1" cellspacing="0">
		<tr height="30">
			<td align="center" width="400">
				글 고유번호 : <%=dto.getNum()%>
				<input type="hidden" name="num" value="<%=dto.getNum()%>" />
			</td>
			<td align="center">조회수 : <%=dto.getReadCount()%></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">문의유형 :
				<select name="questionType">
					<option value='0'>선택</option>
					<option value='1'>자바(Java)</option>
					<option value='2'>파이썬(Python)</option>
					<option value='3'>자바스크립트(JavaScript)</option>
					<option value='4'>뉴스 제보하기</option>
					<option value='5'>제휴 및 문의하기</option>
					<option value='6'>신고하기</option>
				</select>
			</td>
		</tr>
		<tr height="30">
			<td align="center" colspan="4">제목 : <input type="text" name="title" value="<%=dto.getTitle()%>" size="70" /></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">비밀번호 : <input type="password" name="pw" value="<%=dto.getPw()%>" size="70" /></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">작성자 : <%=dto.getId()%>(<%=dto.getName()%>님)</td>
		</tr>
		<tr height="300">
			<td align="center" colspan="2"><textarea cols="100" rows="20" name="con"><%=dto.getCon()%></textarea></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">작성일자 : <%=sdf.format(dto.getReg())%></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="3">
				<input type="button" value="목록" onclick="location='qnaList.jsp'" />
				<input type="submit" value="수정" />
			</td>
		</tr>
	</table>
</form>
<jsp:include page="/member/footer.jsp"></jsp:include>