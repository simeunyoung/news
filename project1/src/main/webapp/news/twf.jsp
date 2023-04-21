<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8"); %>
<%
String num = request.getParameter("num");
String reg = request.getParameter("reg");
String ip = request.getParameter("ip");
// String press = request.getParameter("press");
//String id = request.getParameter("id");
%>
<form action="twp.jsp" name="write" onsubmit="return option_check()">
	<input type="hidden" name="num" value="<%=num%>">
	<%-- 글 작성 번호 --%>
	<input type="hidden" name="reg" value="<%=reg%>">
	<%-- 글 작성 일자 --%>
	<input type="hidden" name="ip" value="<%=ip%>">
	<%-- IP 주소 --%>
	<%-- <input type="hidden" name="press" value="<%=press%>">
		 언론사 --%>
	<input type="hidden" name="id" value="Tester<%--<%=id%> --%>>">
	<%-- 작성자 --%>
	<%-- 글을 작성할 때 직접 입력하면 안되는 부분을 히든 값으로 넘겨서 기록하기 --%>
	작성자 : Tester
	<%--<%=id%>--%>
	<br /> <br /> TOPIC : <select class="select_box" name="newstype">
		<option value="x">종류를 정해주세요.</option>
		<option value="Python">Python</option>
		<option value="java">Java</option>
		<option value="JavaScript">JavaScript</option>
	</select><br /> 제목 : <input class="input_box" name="title" type="text"
		placeholder="제목을 입력해주세요."><br /> 내용<br />
	<textarea class="textarea_box" name="con" placeholder="내용을 입력해주세요."></textarea>
	<br /> 비밀번호 : <input class="short_box" name="pw" type="text"
		placeholder="게시글 비밀번호를 입력해주세요.">&nbsp;&nbsp;&nbsp; <input
		type="submit" class="submit_button" value="작성완료" /> <
</form>