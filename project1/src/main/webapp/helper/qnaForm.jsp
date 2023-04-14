<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%int num = 0;%>
<script src="helper.js"></script>
<title>1:1 문의하기</title>

<center><h2>1:1 문의하기</h2></center>
<!--	
	보냄 : num, id, email, content
	만들어야 할 것 : js, 
 -->
<hr />

<br />

<body onload="begin()">
<form method="post" name="qnaform" action="qnaPro.jsp" onsubmit="return check()">
	<input type="hidden" name="num" value="<%=num%>">
	<table align="center" width="400" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td align="center" width="100">작성자</td>
			<td><input type="text" name="name" size="40"/>
		</tr>
		<tr height="30">
			<td align="center">이메일</td>
			<td><input type="email" name="email" size="40" /></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">제목</td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="subject" size="55" /></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">문의내용</td>
		</tr>
		<tr>
			<td colspan="2"><textarea cols="55" rows="10" name="content"></textarea>
		</tr>
		<tr height="20">
			<td colspan="2">
			문의내용 n/1000자 입력 확인기능 구현요망
			</td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="작성" />
			</td>
		</tr>
	</table>
</form>
