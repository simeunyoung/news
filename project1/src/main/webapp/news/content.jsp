<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO" %>
<%@ page import="news.NewsDAO" %>
<%@ page import="java.util.*" %>
<jsp:include page="header2.jsp"></jsp:include>

<title>글 확인</title>
<%
request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num")); //list에서 파라미터 값으로 게시글 보게 설정하기
String currentPage = request.getParameter("currentPage");

NewsDAO method = NewsDAO.getInstance();
NewsDTO text = method.getCon(num);

String title = text.getTitle();
String con = text.getCon();
%>

<div class="content_box">
<div class="con1"><div class="conl"><b>뉴스 종류 : </b><%=text.getNewstype()%></div><div class="conr"><b>조회수 : </b><%=text.getViews()%></div></div>
<div class="con1"><b>Title : </b><%=text.getTitle()%></div>
<div class="con1"><div class="conl"><b>작성자 : </b><%=text.getId()%>&nbsp;&nbsp;&nbsp;<b>언론사 : </b><%=text.getPress()%></div><div class="conr"><b>작성일 : </b><%=text.getReg()%></div></div>
<div class="con1"><b> 글자 크기 </b></div><br />
<div align="left">
<button type="button" class="button" onclick="changeFontSize('small')">작게</button>
<button type="button" class="button" onclick="changeFontSize('normal')">보통</button>
<button type="button" class="button" onclick="changeFontSize('large')">크게</button>
<div class="con1"><b>내용 : </b></div><br />
<div id="content"><%=text.getCon()%></div>
<div align="right">
<button id="copyButton">URL 복사</button>
<input type="button" class="button" value="수정하기" onclick="location='updateForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="삭제하기" onclick="location='deleteForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">
</div>
<br />

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

<%-- ========================= 경계선 ========================= --%>

<div class="recon_box">
<b>댓글</b><br /><br />
<div align="right"><button  onClick="window.location.reload()">새로고침</button></div>
<% 
List recons = method.getRecon(title,con);
if(recons != null){
for(int rnum=0 ; rnum< recons.size() ; rnum++) {	
NewsDTO recontext = (NewsDTO) recons.get(rnum); //Object(list)형 --> DTO형으로 꺼내주고 있다. 	 
%>
<div align="right">
<%=recontext.getReg()%>&nbsp;&nbsp;
<a href="reconUpdateForm.jsp?num=<%=recontext.getNum()%>" ><font color="#808080">수정</font></a>&nbsp;
/&nbsp;<a href="reconDeletePro.jsp?num=<%=recontext.getNum()%>"><font color="#808080">삭제</font></a>
</div>
<b><%= recontext.getId()%></b><font color="#808080">#<%=recontext.getNum() %></font> [ IP : <%= recontext.getIp() %> ]
<br />&nbsp;&nbsp;&nbsp;&nbsp;<%=recontext.getRecon()%>
			
<hr />		
<%} }else{%>
<center><br /><br /> 현재 존재하는 댓글이 없습니다. <br /><br /><br /><br /></center>
<%}%>



<br /><form action="reconwritePro.jsp" method="post" class="flexthing">
<input type="hidden" name="id" >
<input type="hidden" name="title" value="<%=text.getTitle()%>" >
<input type="hidden" name="con" value="<%=text.getCon()%>" >
<b>댓글 작성</b>&nbsp;&nbsp;<textarea class="textarea_box" name="recon" placeholder="댓글 내용을 입력해주세요."></textarea>
&nbsp;&nbsp;<input type="submit" value="입력" class="submit_button"></form></div></div>
 

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
















    
    