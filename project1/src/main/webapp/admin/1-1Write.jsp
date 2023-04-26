<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<script src="helper.js"></script>
<title>1:1 문의하기</title>

<center><h2>1:1 문의하기</h2></center>

<hr />
<br />

<body onload="begin()">
<form method="post" name="qnaform" action="1-1Pro.jsp" onsubmit="return check()">
	<table align="center" width="500" border="1" cellspacing="0" cellpadding="0">
		<input type="hidden" name="memberType" value="0"/>
		<tr height="30">
			<td align="center">문의유형</td>
			<td align="center">
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
			<td align="center" width="150">아이디</td>
			<td><input type="text" name="id" size="50"/></td>
		</tr>
		<tr height="30">
			<td align="center">작성자</td>
			<td><input type="text" name="name" size="50" /></td>
		</tr>
		<tr height="30">
			<td align="center">이메일(선택사항)</td>
			<td><input type="text" name="email" size="50" /></td>
		</tr>
		<tr height="30">
			<td align="center">연락처(선택사항)</td>
			<td><input type="text" name="tel" size="50" /></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">제목</td>
		</tr>
		<tr>
			<td colspan="2"><input type="text" name="title" size="70" /></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">문의내용</td>
		</tr>
		<tr>
			<td colspan="2"><textarea cols="70" rows="10" name="con"></textarea></td>
		</tr>
		<tr height="20">
			<td colspan="2">
			문의내용 n/1000자 입력 확인기능 구현요망
			</td>
		</tr>
		<tr height="30">
			<td align="center">첨부</td>
			<td align="center"><input type="button" value="첨부파일 추가" onclick="imgUpload.jsp">
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="작성" /><input type="button" value="취소" onclick="location='1-1List.jsp'" />
			</td>
		</tr>
	</table>
</form>