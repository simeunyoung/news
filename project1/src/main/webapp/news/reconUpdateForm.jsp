<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<title>댓글 수정</title>
<%
request.setCharacterEncoding("UTF-8");
int num = Integer.parseInt(request.getParameter("num"));
NewsDAO method = NewsDAO.getInstance();
NewsDTO text = method.getRecon(num);
%>
<form action="reconUpdatePro.jsp" method="post">
	<h3>작성한 댓글 수정</h3>
<input type="hidden" name="num" value="<%=text.getNum()%>">
변경하실 댓글 내용<br /><input type="text" class="textarea_box" name="recon" value="<%=text.getRecon()%>"><br />
<div align="right">
<input type="submit" class="submit_button" value="변경하기">&nbsp;
<input type="button" class="submit_button" value="목록보기" onclick="location='testlist.jsp'">&nbsp;
</div></form>



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
