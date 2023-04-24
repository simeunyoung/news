<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<jsp:include page="header2.jsp"></jsp:include>
<title>기사 수정</title>
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
NewsDAO method = NewsDAO.getInstance();
NewsDTO text = method.getdata(num);
%>

<form action="updatePro.jsp" name="write">
	<div class="form_box">
		<h3>게시글 수정</h3>
		작성자 :
		<%=text.getId()%><br /> <input type="hidden" name="id"
			value="<%=text.getId()%>">
		<%--<%=id%> --%>
		<br /> <input type="hidden" name="num" value="<%=text.getNum()%>">
		</td> TOPIC : <select class="select_box" name="newstype">
			<option value="<%=text.getNewstype()%>">선택된 종류 :<%=text.getNewstype()%></option>
			<option value="Python">Python</option>
			<option value="java">Java</option>
			<option value="JavaScript">JavaScript</option>
		</select><br /> 제목 : <input class="input_box" name="title" type="text"
			value="<%=text.getTitle()%>"><br /> 내용<br />
		<textarea class="textarea_box" name="con"><%=text.getCon()%></textarea>
		<br /> 비밀번호 : <input class="short_box" name="pw" type="text"
			value="<%=text.getPw()%>">&nbsp;&nbsp;&nbsp; <input
			type="submit" class="submit_button" value="변경완료" /> &nbsp; <input
			type="reset" class="submit_button" value="초기화"> &nbsp; <input
			type="button" class="submit_button" value="목록보기"
			onclick="location='list.jsp'">
	</div>
</form>

<style>
.form_box {
	background-color: #ffffff;
	margin: 10px;
	border-radius: 4px;
	border: 1px solid #ddd;
	padding: 10px;
}

.select_box {
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 4px;
	margin: 3px 0;
	font-size: 14px;
	width: 12%;
}

.short_box {
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 4px;
	margin: 3px 0;
	font-size: 14px;
	width: 12%;
}

.input_box {
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 4px;
	margin: 3px 0;
	font-size: 14px;
	width: 96%;
}

.textarea_box {
	border: 1px solid #ddd;
	border-radius: 4px;
	padding: 4px;
	margin: 3px 0;
	font-size: 14px;
	width: 100%;
	height: 160px;
}

.submit_button {
	background-color: #475d9f;
	border: 1px solid #323f6b;
	color: #ffffff;
	border-radius: 4px;
	padding: 2px 8px;
	font-size: 14px;
}
</style>
