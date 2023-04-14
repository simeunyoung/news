<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="model.HelperDAO"%>
<%@ page import="model.HelperDTO" %>

<%
	HelperDAO dao = HelperDAO.getInstance(); // dao 객체 불러옴
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm"); // 작성일자 양식
	List qnaList = null; // 게시물 목록을 보여줄 리스트 선언
	int count = dao.getQnaCount(); // db에 있는 게시물 수
	
	if(count > 0) {
		qnaList = dao.getQnaList();
	}
	
	int number = count;
%>

<title>Q&A게시판</title>

<center><h2>Q&A게시판</h2></center>

<hr />

<center><h3>글목록(<%=count%>)</h3></center>
<%	if(count == 0){%>
	<table align="center" width="700" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td align="center">게시판에 저장된 글이 없습니다.</td>
		</tr>
	</table>
<%} else {%>
<form>
	<table align="center" width="700" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td align="center" width="50">번호</td>
			<td align="center" width="250">제목</td>
			<td align="center" width="100">작성자</td>
			<td align="center" width="120">작성일</td>
			<td align="center" width="80">조회</td>
			<td align="center" width="100">IP</td>
		</tr>
<%	for(int i = 0; i < qnaList.size(); i++) {
		HelperDTO dto = (HelperDTO)qnaList.get(i);%>
		<tr height="30">
			<td align="center"><%=number--%></td>
			<td align="center"><a href="content.jsp?num=<%=dto.getNum()%>"><%=dto.getSubject()%></a>
			<td align="center"><%=dto.getName()%></td>
			<td align="center"><%=sdf.format(dto.getReg())%></td>
			<td align="center"><%=dto.getReadcount()%></td>
			<td align="center"><%=dto.getIp()%></td>
		</tr>
<%}%>		
	</table>
</form>
<%}%>