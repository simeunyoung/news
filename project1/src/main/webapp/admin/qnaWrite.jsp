<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="admin.AdminDAO"%>

<%
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	MemberDTO dto = dao.setMember(memId);
	if(memId == null) {dto.setMemberType("0");}
	if(!(dto.getMemberType().equals("2"))) {response.sendRedirect("qnaList.jsp");}
%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>Q&A 작성하기</title>

<center><h2>Q&A 작성하기</h2></center>

<hr />
<br />

<form method="post" action="qnaPro.jsp">
	<table align="center" width="400" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td align="center" width="100">작성자</td>
			<td align="center">
				<input type="hidden" name="id" value="<%=dto.getId()%>" /><%=dto.getId()%>(<%=dto.getName()%>님)
				<input type="hidden" name="name" value="<%=dto.getName()%>" />
				<input type="hidden" name="questionType" value="5" />
				<input type="hidden" name="memberType" value="<%=dto.getMemberType()%>" />
			</td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">제목</td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="title" size="55" placeholder="제목" /></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">내용</td>
		</tr>
		<tr>
			<td colspan="2"><textarea cols="55" rows="10" name="con" placeholder="내용"></textarea>
		</tr>
		<tr height="30">
			<td align="center">첨부</td>
			<td align="center"><input type="button" value="첨부파일 추가" onclick="imgUpload.jsp">
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="작성" /><input type="button" value="취소" onclick="location='qnaList.jsp'" />
			</td>
		</tr>
	</table>
</form>