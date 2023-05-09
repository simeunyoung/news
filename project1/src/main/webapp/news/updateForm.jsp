<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<jsp:include page="/member/header.jsp"></jsp:include>
<title>CODENEWS</title>
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num")); 
// 작성된 게시글을 수정하기 위해 게시글을 작성할 때 시퀀스로 전달 받은 num의 데이터를 이용하여 
// num과 일치하는 레코드들을 불러낸다. 이 때 데이터를 보여주는 것이 아니라 입력가능한 텍스트박스안에서 보여준다.

NewsDAO method = NewsDAO.getInstance();
NewsDTO text = method.getdata(num); // 데이터를 불러내는 메소드에 num의 값을 입력해서 num에 맞는 레코드를 불러낸다.
%>

<form action="updatePro.jsp" name="write" onsubmit="return submitPost()">
	<div class="form_box">
	<%-- form문에서 텍스트 박스에 불러낸 레코드 값들을 다시 입력할 수 있게 텍스트 박스에 넣어 수정하고 form문애소 submit하면,
	변경한 데이터를 Pro 페이지에 전달해준다. --%>
		<h3>게시글 수정</h3>
		작성자 :
		<%=text.getId()%><br /> <input type="hidden" name="id"
			value="<%=text.getId()%>">
		<%--<%=id%> --%>
		<br /> <input type="hidden" name="num" value="<%=text.getNum()%>">
		<input type="hidden" name="nick" value="<%=text.getNick()%>">
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
<jsp:include page="/member/footer.jsp"></jsp:include>



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
