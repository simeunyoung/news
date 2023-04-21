<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="project.NewsDTO"%>
<%@ page import="project.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>

<%
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String newstype = request.getParameter("newstype");
	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int newscount = 0;
	int number = 0;
	
	List<NewsDTO> newsList = null;
	NewsDAO newsPro = NewsDAO.getInstance();
	newscount = newsPro.getNewstypeCount(newstype); // 메소드
	
	if(newscount > 0){
		newsList = newsPro.getNewsType(startRow, endRow, newstype); // 메소드
	}
	
	number = newscount - (currentPage - 1) * pageSize;
%>

<html>
<body>
<center>
	<h2><%= newstype %>
		뉴스
	</h2>
	<table border="1">
		<thead>
			<tr>
				<th width="50">번호</th>
				<th width="200">제목</th>
				<th width="100">작성자</th>
				<th width="150">작성일</th>
				<th width="50">조회수</th>
			</tr>
		</thead>
		<tbody>
			<% if (newsList != null) {
                    for (NewsDTO article : newsList) { %>
			<tr>
				<td><%= number %></td>
				<td><a href="content.jsp?num=<%= article.getNum() %>"><%= article.getTitle() %></a></td>
				<td><%= article.getId() %></td>
				<td><%= sdf.format(article.getReg()) %></td>
				<td><%= article.getViews() %></td>
			</tr>
			<% number--;
                    }
                } %>
		</tbody>
	</table>
	<br>
	<div align="center">
		<% if (newsList != null && newsList.size() > 0) {
                int pageCount = (newscount / pageSize) + (newscount % pageSize == 0 ? 0 : 1);
                int startPage = ((currentPage) / 10) * 10 + 1;
                int endPage = startPage + 9;
                if (endPage > pageCount) {
                    endPage = pageCount;}

                if (startPage > 1) { %>
		<a href="newstypelist.jsp?pageNum=<%= startPage - 10 %>&newstype=<%= newstype %>">[이전]</a>
		<% } for (int i = startPage; i <= endPage; i++) { %>
		<a href="newstypelist.jsp?pageNum=<%= i %>&newstype=<%= newstype %>">[<%= i %>]</a>
		<% } if (endPage < pageCount) { %>
		<a	href="newstypelist.jsp?pageNum=<%= endPage + 10 %>&newstype=<%= newstype %>">[다음]</a>
		<% } } %>
	</div>


</center>
</body>
</html>