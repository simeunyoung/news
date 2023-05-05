<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<script src="https://kit.fontawesome.com/dbaea98925.js" crossorigin="anonymous"></script>
<title>CODENEWS</title>
<%-- main에서 사용될 코드
1. main의 div에서 내부 div 태그를 이용해서 영역을 4가지로 분리
div 1 div 2
div 3 div 4
main div : display flex를 사용해서 배열을 맞춰 준다.
div 1 : topiclist.jsp <재가공 예정>
div 2 : company 언론사.jsp <재가공 예정>
div 3 : list.jsp <재가공 예정>
div 4 : company 기자.jsp <재가공 예정>

2.
 --%>
<%
request.setCharacterEncoding("UTF-8");

String loginuser = (String) session.getAttribute("memId");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = "1";
int pageSize = 5;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

List newsList = null;
List newsList2 = null;
NewsDAO newsPro = NewsDAO.getInstance();
newsList = newsPro.getNews(startRow, endRow); // 추가 DAO

newsList2 = newsPro.getNews7days(); // list 페이지 자료 수집
int listnumber = newsList2.size();
%>
<%-- 구독목록 --%>
<% 	MemberDAO dao = MemberDAO.getInstance();
	String exist = dao.selectExist(loginuser);
	String[] existArray = null;
	
if (exist == null) {
	existArray = new String[1];
	existArray[0] = "-";
} else {
	existArray = exist.split("@");
}
	String reporter = dao.subscribeR(loginuser);
	String[] reporterArray = null;
	if (reporter == null) {
		reporterArray = new String[1];
		reporterArray[0] = "-";
	} else {
		reporterArray = reporter.split("@");
	}
	String[] nameArray = new String[existArray.length];
	
	
%>
<!-- header -->
<jsp:include page="/member/header.jsp"></jsp:include>


<div class="main_box">
	<div class="left_box">
		<div class="main-card hot_topic">
			<jsp:include page="hotTopic.jsp" />
		</div>
		<div class="main-card main_list">
			<div class="title-box">
				<div class="row">
					<p class="title">오늘의 뉴스</p>
					<button type="button" class="white-btn" onClick="window.location.reload()"><i class="fa-solid fa-rotate-right"></i>새로보기</button>
				</div>
				<a href="/project1/news/main_list.jsp" class="more">전체 보기<i class="fa-solid fa-angle-right"></i></a>
			</div>	
			<div class="list-card">
				<%
				for (int i = 0; i < newsList.size(); i++) {
					int random = (int)(Math.random()*(listnumber-1));
					NewsDTO article = (NewsDTO) newsList2.get(random);
				%>
				<div class="card cont-box" onclick="location='content.jsp?num=<%=article.getNum()%>'">
					<h4 class="cont-title" ><%=article.getTitle()%></h4>
					<div class="cont-txt"><%=article.getCon()%></div>				
					<p class="cont-date"><%=article.getNewstype()%> | <%=article.getId()%> | <%=sdf.format(article.getReg())%> </p>
				</div>
				<%
				}
				%>
			</div>
		</div>
	</div>	
	<div class="right_box">
		<div class="main-card jn_bookmark">
			<div class="title-box">
				<p class="title">구독한 언론사</p>
				<% if(loginuser == null){ %>
				<a href="/project1/member/loginForm.jsp" class="more">전체 보기<i class="fa-solid fa-angle-right"></i></a>
				<% }else{ %>
				<a href="/project1/company/pressForm.jsp" class="more">전체 보기<i class="fa-solid fa-angle-right"></i></a>
				<% }%>
			</div>
			<div class="book-wrap">
				<div class="row">
					<% for(int i = 1 ; i < existArray.length ; i++){%>
					<div class="card"><a href ="/project1/company/pressPage.jsp?press=<%= existArray[i] %>"><%= existArray[i] %></a></div>
					<% }%>
				</div>
			</div>
		</div>
		<div class="main-card press_bookmark">
			<div class="title-box">
				<p class="title">구독한 기자</p>
				<% if(loginuser == null){ %>
				<a href="/project1/member/loginForm.jsp" class="more">전체 보기<i class="fa-solid fa-angle-right"></i></a>
				<% }else{ %>
				<a href="/project1/company/pressForm.jsp" class="more">전체 보기<i class="fa-solid fa-angle-right"></i></a>
				<% }%>
				
			</div> 	
			<div class="book-wrap">
			<div class="row">
				<% for(int i = 1 ; i < reporterArray.length ; i++){%>
				<% MemberDTO mem = dao.getMember(reporterArray[i]); %>
				<div class="card"><a href ="/project1/member/user_mypage_form.jsp?pageType=2&id=<%= reporterArray[i] %>"><%= mem.getNick() %></a></div>
				<% }%>
			</div>
			</div>
		</div>
	</div>	
</div>

<!-- footer -->
<jsp:include page="/member/footer.jsp"></jsp:include>
