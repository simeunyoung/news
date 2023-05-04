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
<title>CodeNews에 오신걸 환영합니다.</title>
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
NewsDAO newsPro = NewsDAO.getInstance();
newsList = newsPro.getNews(startRow, endRow); // 추가 DAO
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

<!-- 테스트 !! -->
 <div>
	<input type="button" value="리스트로 이동" onClick="location='list.jsp'">
	<input type="button" value="sessionTest"
		onClick="location='sessiontest.jsp'">
	접속자 정보 :
	<%=loginuser%>
</div>

<div class="main_box">
	<div class="left_box">
		<div class="main-card hot_topic">
			<jsp:include page="hotTopic.jsp" />
		</div>
		<div class="main-card main_list">
			<div class="title-box">
				<p class="title">오늘의 뉴스</p>
				<a href="/project1/company/pressForm.jsp" class="more">더보기</a>
			</div>	
			<div class="list-card">
				<%
				for (int i = 0; i < newsList.size(); i++) {
					NewsDTO article = (NewsDTO) newsList.get(i);
				%>
				<div class="card cont-box" onclick="location='content.jsp?num=<%=article.getNum()%>'">
					<p><%=article.getNewstype()%> 뉴스 </p>
					<div>
						<h4 class="cont-title" ><%=article.getTitle()%></h4>
						<span><%=article.getId()%> 기자</span>
						<div><%=article.getCon()%></div>
					</div>				
					<p class="cont-date">작성일자 : <%=sdf.format(article.getReg())%></p>
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
				<a href="/project1/member/loginForm.jsp" class="more">더보기</a>
				<% }else{ %>
				<a href="/project1/company/pressForm.jsp" class="more">더보기</a>
				<% }%>
			</div>
			<div>
				<% for(int i = 1 ; i < existArray.length ; i++){%>
				<a href ="/project1/company/pressPage.jsp?press=<%= existArray[i] %>"><%= existArray[i] %></a><br>
				<% }%>
			</div>
		</div>
		<div class="main-card press_bookmark">
			<div class="title-box">
				<p class="title">구독한 기자</p>
				<% if(loginuser == null){ %>
				<a href="/project1/member/loginForm.jsp" class="more">더보기</a>
				<% }else{ %>
				<a href="/project1/company/pressForm.jsp" class="more">더보기</a>
				<% }%>
				
			</div> 	
			<div>
				<% for(int i = 1 ; i < reporterArray.length ; i++){%>
				<% MemberDTO mem = dao.getMember(reporterArray[i]); %>
				<a href ="/project1/member/user_mypage_form.jsp?pageType=2&id=<%= reporterArray[i] %>"><%= mem.getNick() %></a><br>
				<% }%>
			</div>
		</div>
	</div>	
</div>

<!-- footer -->
<jsp:include page="/member/footer.jsp"></jsp:include>
