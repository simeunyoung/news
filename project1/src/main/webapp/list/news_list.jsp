<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "project.newsDTO" %>
<%@ page import = "project.newsDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>

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
	newsDAO newsPro = newsDAO.getInstance();
	newscount = newsPro.getNewsCount();
	
	if(newscount > 0){
		newsList = newsPro.getNews(startRow, endRow);
	}
	
	number = newscount - (currentPage - 1) * pageSize;
%>

<%=newscount%>

<html>
	<head>
		<title> 모든 뉴스 </title>
	</head>
	
	<body>
	<%
	if(newscount == 0){
	%>
	<table>
		<tr>
			<td> 뉴스 목록에 기사가 없습니다.</td>
		</tr>
	</table>
	<%
	}else{
	%>
	<table>
		<tr>
			<td> 번호 </td>
			<td> 제목 </td>
			<td> 작성자 </td>
			<td> 언론사 </td>
			<td> 작성일 </td>
			<td> 조회 </td>
		</tr>
		<%
		for(int i = 0; i < newsList.size(); i++){
			newsDTO article = (newsDTO)newsList.get(i);
		%>
		<tr>
			<td><%=number--%></td>
			<td><a href = "newsView.jsp?num=<%=article.getNum()%>"><%=article.getTitle() %></a></td>
			<td><%=article.getId() %></td>
			<td><%=article.getPress() %></td>
			<td><%=sdf.format(article.getReg()) %></td>
			<td><%=article.getViews() %></td>
		</tr>
		<%} %>
	</table>
	<%} %>
<%
	if(newscount > 0){
		int pageCount = newscount / pageSize + (newscount % pageSize == 0 ? 0 : 1);
		int startPage = (int)(currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount){
			endPage = pageCount;
		}
		if(startPage > 10){
%>
		<a href = "newslist.jsp?pageNum=<%=startPage - 10%>"> [이 전]</a>
<%
		}
			for(int i = startPage; i <= endPage; i++){
%>
			<a href = "newslist.jsp?pageNum=<%=i%>"> [<%=i %>]</a>
<%
			}
		if(endPage < pageCount){
%>
		<a href = "newslist.jsp?pageNum=<%=startPage + 10%>"> [다 음]</a>
<%
		}
	}
%>
	</body>
</html>