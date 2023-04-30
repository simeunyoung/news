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
<title>핫토픽</title>
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
			<a href="list.jsp" class="more">더보기</a>
		</div>
		<div class="card topic-card">
			<%
			for (int i = 0; i < topicList.size(); i++) {
				NewsDTO topic = (NewsDTO) topicList.get(i);
				if (i == 0) {
			%>
			
				<div class="cont-box topic-only">
					<p><%=topic.getNewstype()%> 뉴스 / 조회수 : <%=topic.getViews()%></p>
					<div>
						<h3 class="cont-title" onclick="location='content.jsp?num=<%=topic.getNum()%>'"><%=topic.getTitle()%></h3>
						<span><%=topic.getId()%> 기자</span>
						<div><%=topic.getCon()%></div>
					</div>				
					<p class="cont-date">작성일자 : <%=sdf.format(topic.getReg())%></p>
				</div>
		</div>
			<%
			} else {
			%>
			<div class="card topic-card">
				<div class="topic-box">
					<p><%=topic.getNewstype()%> 뉴스 / 조회수 : <%=topic.getViews()%></p>
					<div>
						<h3 class="cont-title" onclick="location='content.jsp?num=<%=topic.getNum()%>'"><%=topic.getTitle()%></h3>
						<span><%=topic.getId()%> 기자</span>
						<div><%=topic.getCon()%></div>
					</div>				
					<p>작성일자 : <%=sdf.format(topic.getReg())%></p>
				</div>
			</div>
			<%
				}
			}
			%>
	</div>
</body>
</html>