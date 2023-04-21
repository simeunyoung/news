<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:include page="header2.jsp"></jsp:include>
<%-- 액션태그 include를 사용하여 writeForm페이지에 header페이지를 상단으로 불러온다. --%>
<title>기사 작성</title>
<%request.setCharacterEncoding("UTF-8"); %>
<%

//String id = request.getParameter("id");
%>
<body>
	<Script>
		function option_check() {
			var newstype = document.write.newstype.value;
			if (newstype == "x") {
				alert("뉴스의 종류가 선택되지 않았습니다.");
				return false
			}
		} // 폼 태그에 newstype 값을 선택하지 않을 때 알림창으로 알려준다.
	</Script>

	<form action="writePro.jsp" name="write"
		onsubmit="return option_check()">
			
		<input type="hidden" name="id" value="Tester"><%--<%=id%> --%>
		<%-- 작성자 --%>
		<%-- 글을 작성할 때 직접 입력하면 안되는 부분을 히든 값으로 넘겨서 기록하기 --%>
		<div class="form_box">
			<h3>게시글 작성</h3>
			작성자 : Tester
			<%--<%=id%>--%><br />
			<br /> TOPIC : <select class="select_box" name="newstype">
				<option value="x">종류를 정해주세요.</option>
				<option value="Python">Python</option>
				<option value="java">Java</option>
				<option value="JavaScript">JavaScript</option>
			</select><br /> 제목 : <input class="input_box" name="title" type="text"
				placeholder="제목을 입력해주세요."><br /> 내용<br />
			<textarea class="textarea_box" name="con" placeholder="내용을 입력해주세요."></textarea>
			<br /> 비밀번호 : <input class="short_box" name="pw" type="text"
				placeholder="게시글 비밀번호를 입력해주세요.">&nbsp;&nbsp;&nbsp; <input
				type="submit" class="submit_button" value="작성완료" />
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
	width: 8%;
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
	width: 97%;
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
	font-soze: 18px;
}
</style>

</body>
