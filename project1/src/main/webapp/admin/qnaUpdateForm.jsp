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
<div class="page-wrap content">
	<div class="content-box cont mf">
		<h3>Q&A 수정</h3>
		<div class="cont-top">
			<div class="cont-top-left"># <%=dto.getNum()%><input type="hidden" name="num" value="<%=dto.getNum()%>" /></div>
			<div class="cont-top-right"><i class="fa-solid fa-eye" style="color: #bfbfbf;"></i> <%=dto.getReadCount()%></div>
		</div>
<form method="post" action="qnaUpdatePro.jsp?pageNum=<%=pageNum%>">
	<table>
		<colgroup>
			<col style="width:20%">
			<col style="width:80%">
		</colgroup>
		<tr height="30">
		<td>문의유형</td>
			<td>
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
			<td>제목</td>
			<td><input type="text" name="title" value="<%=dto.getTitle()%>" size="70" /></td>
		</tr>
		<tr height="30">
			<td>비밀번호</td>
			<td><input type="password" name="pw" value="<%=dto.getPw()%>" size="70" /></td>
		</tr>
		<tr height="30">
			<td>작성자</td>
			<td><%=dto.getId()%>(<%=dto.getName()%>님)</td>
		</tr>
		<tr height="300">
			<td>내용</td>
			<td><textarea cols="100" rows="20" name="con"><%=dto.getCon()%></textarea></td>
		</tr>
		<tr height="30">
			<td>작성일자</td>
			<td> <%=sdf.format(dto.getReg())%></td>
		</tr>

	</table>
		<div class="buttom-wrap">
			<input type="button" class="white-btn" value="목록" onclick="location='qnaList.jsp'" />
			<input type="submit" class="white-btn" value="수정" />
	</div>
</form>
</div>
</div>
<jsp:include page="/member/footer.jsp"></jsp:include>