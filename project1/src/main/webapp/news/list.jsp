<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>  
<title>기존 리스트 파일 div태그 활용하여 리메이크</title>
<jsp:include page="/member/header.jsp"></jsp:include>
<%
request.setCharacterEncoding("UTF-8");

String loginuser= null;
loginuser = (String)session.getAttribute("memId");
String memtype = null;

if(loginuser == null){
	memtype = "0";
}else{
	MemberDAO memdao = MemberDAO.getInstance();
	MemberDTO usertype = memdao.getmember(loginuser);

	memtype = usertype.getMemberType();	
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = request.getParameter("pageNum");
if(pageNum == null){ pageNum = "1"; }

int pageSize = 10;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
int newscount = 0;
int number = 0;

List newsList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newscount = newsPro.getNewsCount(); // 추가 DAO

if(newscount > 0){
newsList = newsPro.getNews(startRow, endRow); // 추가 DAO
}

number = newscount - (currentPage - 1) * pageSize;
%>

접속자 정보 : <%= loginuser%>

<div class="form_box">
<div class="boxname_link">
<div class="boxname"><h3>모든 뉴스(둘러보기)</h3></div>
<div align="right" class="boxname">
<%

if(memtype.equals("2")){ %>
<button class="button" onclick="location='writeForm.jsp'" ><b>글쓰기</b></button>
<%} else if(memtype.equals("-1")){ %>
<button class="button" onclick="location='writeForm.jsp'" ><b>글쓰기</b></button>
<%}else if(memtype.equals("0")){ %>
현재 비로그인 중입니다.
<%} %>
</div></div>


<%  if(newscount == 0){ // 게시글이 없을 때 %>
<br /><br /><br /><br /><br /> <center> <h3>죄송합니다.. 현재 뉴스 목록에 기사가 없습니다.</h3>
<h4> 뉴스를 준비 중입니다.<br /> 나중에 다시 이용하여 주시기 바랍니다. </h4>
</center> <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<% }else{ %>

<div class="table_box">
<div class="one_box" align="center"><b>작성 번호</b></div>
<div class="two_box" align="center"><b>뉴스(내용)</b></div>
<div class="three_box" align="center"><b>작성자</b></div>
<div class="four_box" align="center"><b>언론사</b></div>
<div class="five_box" align="center"><b>작성일</b></div>
<div class="six_box" align="center"><b>조회수</b></div>
</div><hr />
<% for(int i = 0; i < newsList.size(); i++){
NewsDTO article = (NewsDTO)newsList.get(i); %>
<div>
<a href="content.jsp?num=<%=article.getNum()%>"><font color="#000000">
<div class="text_box">
<div class="one_box" align="center"><%=number--%></div>
<div class="two_see" >
<b><font size="4px" color="#000000"><%=article.getTitle() %></font></b><br /><br />&nbsp;&nbsp;<%=article.getCon() %></div>
<div class="three_box" align="center"><%=article.getId() %></div>
<div class="four_box" align="center"><%=article.getPress() %> </div>
<div class="five_box" align="center"><%=sdf.format(article.getReg()) %> </div>
<div class="six_box" align="center"><%=article.getViews() %> </div>
</div></font></a></div>
<% if(i != newsList.size()){ %>

<%} } } %>
<div align="center">
<%
if(newscount > 0){
int pageCount = newscount / pageSize + (newscount % pageSize == 0 ? 0 : 1);
int startPage = (int)(currentPage / 10) * 10 + 1;
int pageBlock = 10;
int endPage = startPage + pageBlock - 1;
if(endPage > pageCount){
endPage = pageCount;
}
if(startPage > 10){%>
<a href="list.jsp?pageNum=<%=startPage - 10 %>"> [이 전]</a>
<%} for(int i = startPage; i <= endPage; i++){%>
<a href="list.jsp?pageNum=<%=i%>"> [<%=i %>]
</a>
<%}if(endPage < pageCount){ %>
<a href="list.jsp?pageNum=<%=startPage + 10%>"> [다 음]</a>
<% } } %>
</div>



<style>
*{
margin:0;
padding:0;
box-sizing:border-box;
}
.boxname_link{
display: flex;
}
.boxname{
width: 50%;
}
.form_box {
background-color: #ffffff;
margin: 10px;
border-radius: 4px;
border: 1px solid #ddd;
padding: 10px;
}
.text_box {
display: flex;
background-color: #ffffff;
margin: 3px;
border-radius: 4px;
border: 1px solid #ddd;
padding: 2px;
width: 100%;
}
.table_box {
display: flex;
height: 5%;
width: 100%;
margin:0;
padding:0;
box-sizing:border-box;
}

.one_box {
margin: 10px;
padding: 10px;
width: 7%;
}
.two_box {
margin: 10px;
padding: 10px;
width: 60%;
}
.two_see {
margin: 10px;
padding: 10px;
width: 60%;
text-overflow: ellipsis;  
overflow : hidden;
display: -webkit-box;
-webkit-line-clamp: 4;
-webkit-box-orient: vertical;
}
.three_box {
margin: 10px;
padding: 10px;
width: 10%;
}
.four_box {
margin: 10px;
padding: 10px;
width: 8%;
}
.five_box {
margin: 10px;
padding: 10px;
width: 10%;
}
.six_box {
margin: 10px;
padding: 10px;
width: 5%;
}
.button {
	background-color: #475d9f;
	color: #ffffff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 4px;
	margin: 3px 0;
	font-size: 15px;
	width: 70px;
	height: 30px;
}
</style>