<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<title>기사 작성</title>
<%request.setCharacterEncoding("UTF-8"); %>
<form action="writePro.jsp" name="write">
	<input type="hidden" name="id" value="Tester">
	<h3>게시글 작성</h3>
	작성자 : Tester
	<br /> <br />
	TOPIC : <select name="newstype">
				<option value="x">종류를 정해주세요.</option>
				<option value="Python">Python</option>
				<option value="java">Java</option>
				<option value="JavaScript">JavaScript</option>
			</select> <br />
			
	제목 : <input name="title" type="text" placeholder="제목을 입력해주세요." />
		  <br />
		  내용
		  <br />
 		     <textarea name="con" placeholder="내용을 입력해주세요."></textarea><br />
	비밀번호 : <input name="pw" type="text" placeholder="게시글 비밀번호를 입력해주세요."> &nbsp;&nbsp;&nbsp;
			 <input type="submit" class="submit_button" value="작성완료" />
</form>