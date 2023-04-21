<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
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

<html>
<head>
<title>모든 뉴스</title>
</head>

<body>
	<%
	if(newscount == 0){
	%>
	<table width="700" border="1" cellpadding="0" cellspacing="0">
		<tr>
			<td>뉴스 목록에 기사가 없습니다.</td>
		</tr>
	</table>
	<%
	}else{
	%>
	<table border="1" width="700" cellpadding="0" cellspacing="0"
		align="center">
		<tr height="30">
			<td align="center" width="50">번호</td>
			<td align="center" width="250">제목</td>
			<td align="center" width="100">작성자</td>
			<td align="center" width="150">언론사</td>
			<td align="center" width="150">작성일</td>
			<td align="center" width="50">조회</td>
		</tr>
		<%
		for(int i = 0; i < newsList.size(); i++){
			NewsDTO article = (NewsDTO)newsList.get(i);
		%>
		<tr height="30">
			<td align="center" width="50"><%=number--%></td>
			<td align="center" width="150"><a
				href="content.jsp?num=<%=article.getNum()%>"><%=article.getTitle() %></a></td>
			<td align="center" width="150"><%=article.getId() %></td>
			<td align="center" width="150"><%=article.getPress() %></td>
			<td align="center" width="150"><%=sdf.format(article.getReg()) %></td>
			<td align="center" width="50"><%=article.getViews() %></td>
		</tr>
		<%} %>
	</table>
	<%} %>
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
		<%}	for(int i = startPage; i <= endPage; i++){%>
		<a href="list.jsp?pageNum=<%=i%>"> [<%=i %>]
		</a>
		<%}if(endPage < pageCount){	%>
		<a href="list.jsp?pageNum=<%=startPage + 10%>"> [다 음]</a>
		<%	}	}	%>
	</div>
</body>
</html>