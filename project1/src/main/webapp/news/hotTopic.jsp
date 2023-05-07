<%@page import="news.NewsDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="news.NewsDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CODENEWS</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<%
request.setCharacterEncoding("UTF-8");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = "1";
int pageSize = 5;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

List newsList = null;
List topicList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newsList = newsPro.getNews(startRow, endRow); // list 페이지 자료 수집
topicList = newsPro.gethotNews(startRow, endRow); // hotlist 페이지 자료 수집
%>
<body>
	<div class="hot-box">
		<div class="title-box">
			<p class="title">Hot TOPIC</p>
			<a href="hotlist.jsp" class="more">전체 보기<i class="fa-solid fa-angle-right"></i></a>
		</div>
		<div class="card topic-card">
			<%
			for (int i = 0; i < topicList.size(); i++) {
				NewsDTO topic = (NewsDTO) topicList.get(i);
				if (i == 0) {
			%>
			
				<div class="cont-box topic-only" onclick="location='content.jsp?num=<%=topic.getNum()%>'">
					<h3 class="cont-title"><%=topic.getTitle()%></h3>
					<div class="cont-txt"><%=topic.getCon()%></div>
					<span><%=topic.getNewstype()%> | <%=sdf.format(topic.getReg())%> | <%=topic.getViews()%></span>			
				</div>
		</div>
			<%
			} else {
			%>
			<div class="card topic-card">
				<div class="topic-box" onclick="location='content.jsp?num=<%=topic.getNum()%>'">
					<h3 class="cont-title" ><%=topic.getTitle()%></h3>
<%-- 						<span><%=topic.getId()%> 기자</span> --%>
					<div class="cont-txt"><%=topic.getCon()%></div>
					<span><%=topic.getNewstype()%> | <%=sdf.format(topic.getReg())%> | <%=topic.getViews()%></span>
				</div>
			</div>
						<%
				}
			}
			%>
			

	</div>
</body>
</html>