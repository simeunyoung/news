<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a>

<title>회원가입</title>

<center><h2>회원가입</h2></center>

<hr>
<br>

<form action="signupPro.jsp">
	<table>
		<tr>
			<td><input type="text" name="id" placeholder="아이디"/></td>
		</tr>
		<tr>
			<td><input type="password" name="pw" placeholder="비밀번호" /></td>
		</tr>
		<tr>
			<td><input type="text" name="email" placeholder="이메일" /></td>
		</tr>
		<tr>
			<td><input type="submit" value="가입" />
		</tr>
	</table>
</form>