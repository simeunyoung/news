<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO" %>
<%@ page import="news.NewsDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>
<%@ page import="news.RatingDAO" %>
<%@ page import="news.RatingDTO" %>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<jsp:include page="/member/header.jsp"></jsp:include>
<jsp:useBean id="dto" class="member.MemberDTO" />

<title>글 확인</title>
<%
String loginuser = (String) session.getAttribute("memId");

request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num")); //list에서 파라미터 값으로 게시글 보게 설정하기
String currentPage = request.getParameter("currentPage");

NewsDAO method = NewsDAO.getInstance();
NewsDTO text = method.getCon(num);

String title = text.getTitle();
String con = text.getCon();
String news_scrap = method.newsscrap(loginuser);

int Count = 0;
RatingDAO rDAO = RatingDAO.getInstance();
Count = rDAO.ratingcount(num); 
RatingDTO rDTO = rDAO.getRatingDTO(num); 
%>
<%
if(news_scrap == null){
	news_scrap = "";
}
String[] parts = news_scrap.split("@");
boolean include = false;
for(String part : parts){
	if(part.equals(Integer.toString(num))){
		include = true;
		break;
	}
}
%>
접속자 정보 : <%= loginuser%><br /><br /><hr />

<div class="content_box">
<div class="con1"><div class="conl"><b>뉴스 종류 : </b><%=text.getNewstype()%></div><div class="conr"><b>조회수 : </b><%=text.getViews()%></div></div>
<div class="con1"><b>Title : </b><%=text.getTitle()%></div>
<div class="con1"><div class="conl"><b>작성자 : </b><a href = "/project1/member/user_mypage_form.jsp?id=<%=text.getId()%>&pageType=2"><%=text.getNick()%></a>&nbsp;&nbsp;&nbsp;<b>언론사 : </b><%=text.getPress()%></div><div class="conr"><b>작성일 : </b><%=text.getReg()%></div></div>
<div class="con1"><b> 글자 크기 </b></div><br />	
<div align="left">
<button type="button" class="button" onclick="changeFontSize('small')">작게</button>
<button type="button" class="button" onclick="changeFontSize('normal')">보통</button>
<button type="button" class="button" onclick="changeFontSize('large')">크게</button>
<div class="con1"><b>내용 : </b></div><br />
<div id = "content"><%=text.getCon()%></div>
<div align="right">
<%if(loginuser != null){%>
<%if(!loginuser.equals(text.getId())){%>
<form>
<table align = "right" width = "500" height = "60" border = "1" cellspacing =  "0" cellpadding = "0">
	<tr>
		<td align = "right" colspan = "0">
			<input type = "button" name = "good" value = "좋아요" onclick = "location.href='gisagood.jsp?num=<%=text.getNum()%>'">		
			<input type = "button" name = "bad" value = "싫어요" onclick = "location.href='gisabad.jsp?num=<%=text.getNum()%>'">
		</td>
	</tr>
	</table>
</form>
	<%}%>
<%}%>
<table align = "right" width = "100" height = "60" border = "1" cellspacing = "0" cellpadding = "0">
	<tr>
		<td align = "right" colspan = "0" width = "2" height = "10">
			<td align = "center" width = "10" height = "10">좋아요</td>
			<td align = "center" width = "10" height = "10">싫어요</td>
			<td align = "center" width = "10" height = "10">총 점</td>
	</tr>
	<tr>
		<td align = "right">
			<td align = "center"><%=rDTO.getGood()%>
			<td align = "center"><%=rDTO.getBad()%>
			<td align = "center"><%=rDTO.getTotal()%>
		</td>
	</tr>
</table>
<% if(!include){%>
<button onclick= "location='news_scrap.jsp?num=<%=num%>&news_scrap=<%=news_scrap%>&loginuser=<%=loginuser%>'">스크랩 하기</button>
<%}else if(include){%>
<button onclick= "location='news_scrap_delete.jsp?num=<%=num%>&news_scrap=<%=news_scrap%>&loginuser=<%=loginuser%>'">스크랩 취소</button>
<%}%>
<button id="copyButton">URL 복사</button>

<%if(session.getAttribute("memId") == null) {%>
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">
<%}else if(loginuser.equals("admin")){%>
<input type="button" class="button" value="삭제하기" onclick="location='deleteForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">
<%}else if(loginuser.equals(text.getId())){ %>
<input type="button" class="button" value="수정하기" onclick="location='updateForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="삭제하기" onclick="location='deleteForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">	
<%}%>

</div>
<br />

<%-- ========================= 경계선 ========================= --%>

<div class="recon_box">
<jsp:include page="recon.jsp">
<jsp:param value="<%=text.getTitle()%>" name="title"/>
<jsp:param value="<%=text.getCon()%>" name="con"/>
<jsp:param value="<%=num%>" name="num"/>
</jsp:include>
</div></div>
<jsp:include page="/member/footer.jsp"></jsp:include>

<script>
function changeFontSize(size) {
  var content = document.getElementById('content');
  if (size === 'small') {
    content.style.fontSize = '16px';
  } else if (size === 'normal') {
    content.style.fontSize = '20px';
  } else if (size === 'large') {
    content.style.fontSize = '24px';
  }
}
</script>

<style>
#content {
  font-size: 20px;
}
</style>

<script>
var copyButton = document.getElementById('copyButton');

copyButton.addEventListener('click', function() {
    var url = window.location.href;  // 현재 URL 가져오기
    var tempInput = document.createElement("input");  // 임시 input 엘리먼트 생성
    tempInput.setAttribute("value", url);  // input 엘리먼트에 URL 값 추가
    document.body.appendChild(tempInput);  // input 엘리먼트를 body에 추가
    tempInput.select();  // input 엘리먼트 선택
    document.execCommand("copy");  // 복사 명령 실행
    document.body.removeChild(tempInput);  // input 엘리먼트 삭제
    alert("URL이 복사되었습니다.");
});
</script>

<style>
.button {
	background-color: #475d9f;
	border: 1px solid #323f6b;
	color: #ffffff;
	border-radius: 4px;
	padding: 2px 8px;
	font-size: 14px;
}	
.content_box{
background-color: #ffffff;
border-radius: 4px;
border: 1px solid #ddd;
padding: 10px;
}
.con_box{
background-color: #f5f4ee;
border-radius: 4px;
border: 1px solid #ddd;
padding: 10px;
}
.con1{
display: flex;
width: 100%;
}
.conl{
width: 80%;
}
.conr{
width: 20%;
}
.flexthing{
display: flex;
}
.recon_box{
background-color: #eff5ee;
border-radius: 4px;
border: 1px solid #ddd;
padding: 10px;
}
.textarea_box {
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 4px;
	margin: 3px 0;
	font-size: 14px;
	width: 90%;
	height: 80px;
}
.submit_button {
	background-color: #475d9f;
	color: #ffffff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 4px;
	margin: 3px 0;
	font-size: 20px;
	width: 80px;
	height: 80px;
}
</style>