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

<title>CODENEWS</title>
<%
String loginuser = (String) session.getAttribute("memId"); //loginPro에서 생성된 세션을 가져오기

request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num")); //list에서 파라미터 값으로 게시글 보게 설정하기
String currentPage = request.getParameter("currentPage"); // 현재 페이지 정보를 저장하기 위해 변수 선언


NewsDAO method = NewsDAO.getInstance(); 
NewsDTO text = method.getCon(num); // num이라는 파라미터를 가지고 있는 레코드를 가져오는 메소드

String title = text.getTitle(); // 변수 선언
String con = text.getCon(); // 변수 선언
String news_scrap = method.newsscrap(loginuser); // 현재 로그인한 사용자의 스크랩한 뉴스목록을 가져와 변수에 저장

RatingDAO rDAO = RatingDAO.getInstance();
RatingDTO rDTO = rDAO.getRatingDTO(num); //기사평점 테이블의 good과 bad 그리고 total의 값을 각각 합쳐서 값을 꺼내옴

// 사용자가 현재 뉴스를 스크랩한것인지 확인하는 코드
// 스크랩이 null인경우 ""로 초기화
// 초기화 시킨 이유는 split()을 사용할때 null인 경우에 NullPointerException이 발생함 때문에 초기화 시켜줌
if(news_scrap == null){
	news_scrap = "";
}
// @기준으로 스크랩한 뉴스 목록에서 하나의 뉴스를 구분하기 위해 @ 기준으로 분할하여 저장
String[] parts = news_scrap.split("@");
// parts배열의 요소인 part를 현재 뉴스 num과 비교 만약 num이 news_scrap에 포함 되어있으면 true를 반환
boolean include = false;
for(String part : parts){
	if(part.equals(Integer.toString(num))){
		include = true;
		break;
	}
}



String usertype = null;
MemberDTO userinfo = null;

String admin = "2";
String normaluser = "1";
String writer = "-1";

if(loginuser == null) {
userinfo.setMemberType("0");
}
if(loginuser != null){ //로그인을 했을 때
MemberDAO memdao = MemberDAO.getInstance();
userinfo = memdao.getmember(loginuser); // 세션을 통해서 member 테이블의 데이터를 가져온다.
usertype = userinfo.getMemberType();  // 가져온 데이터 중에 맴버의 종류를 변수로 선언
}
// 싫어요가 30개 이상일 때
if(rDTO.getBad() >= 30 && session.getAttribute("memId") == null ){
%>
<script type="text/javascript">
alert("해당 게시글은 많은 이용자에 의해 블라인드 처리된 게시글 입니다.");
history.go(-1);
</script>
<%}else if(rDTO.getBad() >= 30 && (usertype.equals(normaluser) || usertype.equals(writer))){ %>
<script type="text/javascript">
alert("해당 게시글은 많은 이용자에 의해 블라인드 처리된 게시글 입니다.");
history.go(-1);
</script>
<%}else{ %>
<div class="content_box">
<div class="con1"><div class="conl"><b>뉴스 종류 : </b><%=text.getNewstype()%></div><div class="conr"><b>조회수 : </b><%=text.getViews()%></div></div>
<div class="con1"><b>Title : </b><%=text.getTitle()%></div>
<div class="con1"><div class="conl"><b>작성자 : </b><a href = "/project1/member/user_mypage_form.jsp?id=<%=text.getId()%>&pageType=2"><%=text.getNick()%></a>&nbsp;&nbsp;&nbsp;<b>언론사 : </b><%=text.getPress()%></div><div class="conr"><b>작성일 : </b><%=text.getReg()%></div></div>
<div class="con1"><b> 글자 크기 </b></div><br />	
<div align="left">
<%-- 각 버튼을 누를때 글자크기 변경 --%>
<button type="button" class="button" onclick="changeFontSize('small')">작게</button>
<button type="button" class="button" onclick="changeFontSize('normal')">보통</button>
<button type="button" class="button" onclick="changeFontSize('large')">크게</button>
<div class="con1"><b>내용 : </b></div><br />
<div id = "content"><%=text.getCon()%></div>
<div align="right">
<%if(loginuser != null){ 					// 로그인을 했을 때 					
	if(!loginuser.equals(text.getId())){%>	<%-- 세션에서 받아온 id값이 있어야 되고 기사를 작성한 본인은 평점을 달지 못하게 설정 --%>
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
	</tr>
	<tr>
		<td align = "right">
			<td align = "center"><%=rDTO.getGood()%>
			<td align = "center"><%=rDTO.getBad()%>
		</td>
	</tr>
</table>
<%
// include가 flase인 경우 스크랩되지 않은 뉴스이기때문에 스크랩하기 버튼 활성화
if(!include){
	// 세션이 없다면 버튼을 클릭했을때 메세지 창을 띄움
	if(session.getAttribute("memId") == null) {
%>
<button onclick="alert('로그인 후 사용 가능합니다.');">스크랩 하기</button>
<%
	// 로그인이 되었을때 스크랩 가능
	}else{
%>
<%-- 버튼을 누르면 메시지 출력 및 news_scrap.jsp로 이동, 각 3개의 파라미터를 함께 전달 --%>
<button onclick="alert('스크립트 되었습니다.'); location='news_scrap.jsp?num=<%=num%>&news_scrap=<%=news_scrap%>&loginuser=<%=loginuser%>';">스크랩 하기</button>
<%
	}
// 스크랩되었던 뉴스라면 버튼을 눌렀을때 스크랩 취소 가능
}else if(include){
%>
<%-- 버튼을 누르면 메시지 출력 및 news_scrap_delete.jsp로 이동, 각 3개의 파라미터를 함께 전달 --%>
<button onclick="alert('스크립트 취소 되었습니다.'); location='news_scrap_delete.jsp?num=<%=num%>&news_scrap=<%=news_scrap%>&loginuser=<%=loginuser%>';">스크랩 취소</button>
<%
}
%>
<%-- 버튼을 누르면 url복사 가능 --%>
<button id="copyButton">URL 복사</button>

<%
if(loginuser != null){ //로그인을 했을 때

if(loginuser.equals(text.getId())){%> <%-- 세션과 작성자가 일치할 때 --%>
<input type="button" class="button" value="삭제하기" onclick="location='deleteForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="수정하기" onclick="location='updateForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">
<%}else if(usertype.equals(admin)){ %> <%-- 세션과 운영자의 종류가 일치할 때 --%>
<input type="button" class="button" value="삭제하기" onclick="location='deleteForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">	
<%}else if(usertype.equals(normaluser)){%> <%-- 세션이 일반 유저일 때 --%>
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">
<%} 
}
//끝난 곳
if(session.getAttribute("memId") == null) {%> <%-- 비로그인 일 때 --%>
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">
<%} %>
</div>
<br />

<%-- ========================= 경계선 ========================= --%>
<%-- include 액션태그를 사용해서 JSP파일을 content와 합친다. --%><%-- 해당 include 액션 태그에서 사용할 파라미터를 전달하는 역활을 한다. --%>
<div class="recon_box">
<jsp:include page="recon.jsp"> 
<jsp:param value="<%=text.getTitle()%>" name="title"/> 
<jsp:param value="<%=text.getCon()%>" name="con"/>
<jsp:param value="<%=num%>" name="num"/>
</jsp:include>
</div></div></div>
<jsp:include page="/member/footer.jsp"></jsp:include>


<script>
// 기사 내용 글자의 크기를 변경하는 기능
function changeFontSize(size) {
	// document.getElementById를 사용하여 content요소를 가지고 옴
	// document.getElementById는 특정 ID를 가진 HTML요소를 가져오는 메서드
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

<%-- 기본적인 기사의 글자 크기를 20px로 지정 --%>
<style>
#content {
  font-size: 20px;
}
</style>

<script>
var copyButton = document.getElementById('copyButton');
// 버튼 클릭시 실행될 함수 지정
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


<%} %>
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