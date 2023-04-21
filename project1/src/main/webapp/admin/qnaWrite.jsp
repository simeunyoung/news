<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>Q&A 작성하기</title>

<center><h2>Q&A 작성하기</h2></center>

<hr />
<br />

<form method="post" action="qnaPro.jsp">
	<table align="center" width="400" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td align="center" width="100">작성자</td>
			<td><input type="text" name="id" size="40" placeholder="아이디"/>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">제목</td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="subject" size="55" placeholder="제목" /></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">문의내용</td>
		</tr>
		<tr>
			<td colspan="2"><textarea cols="55" rows="10" name="content" placeholder="내용"></textarea>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="작성" /><input type="button" value="취소" onclick="location='siteMap.jsp'" />
			</td>
		</tr>
	</table>
</form>