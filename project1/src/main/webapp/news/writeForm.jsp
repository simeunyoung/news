<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>
<jsp:include page="/member/header.jsp"></jsp:include>
<%-- 액션태그 include를 사용하여 writeForm페이지에 header페이지를 상단으로 불러온다. --%>
<title>기사 작성</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script type="text/javascript" src="/project1/resource/static/smarteditor/js/HuskyEZCreator.js" charset="utf-8"></script>

<%
request.setCharacterEncoding("UTF-8");

String loginuser = (String) session.getAttribute("memId");
MemberDTO userinfo = null;
String usernick = null;
MemberDAO memdao = MemberDAO.getInstance();

if (session.getAttribute("memId") != null) {
	userinfo = memdao.getmember(loginuser);
	usernick = userinfo.getNick();
}
if (session.getAttribute("memId") == null) {
%>
<Script>
	alert("[에러 발생] 권한을 가지고 있지 않은 사용자 접근 시도를 하였습니다. 로그인을 하고 접근하여 주시기 바랍니다.");
</Script>
<%
response.sendRedirect("list.jsp");
}
%>
<body>
	
	접속자 정보 :
	<%=loginuser%>
	<form action="writePro.jsp" name="write"
		onsubmit="return submitPost()">

		<input type="hidden" name="id" value="<%=loginuser%>"> <input
			type="hidden" name="nick" value="<%=usernick%>">
		<%-- 작성자 --%>
		<%-- 글을 작성할 때 직접 입력하면 안되는 부분을 히든 값으로 넘겨서 기록하기 --%>
		<div class="form_box">
			<h3>게시글 작성</h3>
			<br /> 작성자 :
			<%=usernick%>
			<br /> TOPIC : <select class="select_box" name="newstype">
				<option value="x">종류를 정해주세요.</option>
				<option value="Python">Python</option>
				<option value="java">Java</option>
				<option value="JavaScript">JavaScript</option>
			</select><br /> 제목 : <input class="input_box" name="title" type="text"
				placeholder="제목을 입력해주세요."><br /> 내용<br />
			<div id="smartEditor"><textarea id="editorTxt" class="textarea_box" name="con" placeholder="내용을 입력해주세요."></textarea></div>
			<br /> 비밀번호 : <input class="short_box" name="pw" type="text"
				placeholder="게시글 비밀번호를 입력해주세요.">&nbsp;&nbsp;&nbsp; <input
				type="submit" class="submit_button" value="작성완료"  />
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
<script>
let oEditors = []

smartEditor = function() {
  console.log("Naver SmartEditor")
  nhn.husky.EZCreator.createInIFrame({
    oAppRef: oEditors,
    elPlaceHolder: "editorTxt",
    sSkinURI: "/project1/resource/static/smarteditor/SmartEditor2Skin.html",
    fCreator: "createSEditor2"
  })
}

$(document).ready(function() {
  smartEditor()
})

submitPost = function() {
  oEditors.getById["editorTxt"].exec("UPDATE_CONTENTS_FIELD", [])
  let content = document.getElementById("editorTxt").value;
  var newstype = document.write.newstype.value;
  var title = document.write.title.value;
  var pw = document.write.pw.value;

  if(newstype == "x"){ // 폼 태그에 newstype 값을 선택하지 않을 때 알림창으로 알려준다.
		alert("뉴스의 종류가 선택되지 않았습니다.");
		return false  
	  }else if(title == ''){
		  alert("제목을 입력하세요.");
			return false
	  }else if(pw == '') {
		alert("비밀번호를 입력하세요.");
		return false
	  }else if(content == '') {
    alert("내용을 입력해주세요.")
    oEditors.getById["editorTxt"].exec("FOCUS")
    return false;
  } else {
    console.log(content)
    return true;
  }
  

}

 

</script>
</body>
