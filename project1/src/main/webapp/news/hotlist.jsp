<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "news.NewsDTO" %>
<%@ page import = "news.NewsDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<jsp:include page="/member/header.jsp" />

<%
	//페이지에 보여줄 뉴스 개수 지정
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String pageNum = request.getParameter("pageNum");
	
	// 현재 페이지 번호를 pageNum변수에 저장
	// 값이 null일때 1로 지정
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호를 저장
	int startRow = (currentPage - 1) * pageSize + 1; // 페이지 시작 번호
	int endRow = currentPage * pageSize; // 페이지 끝 번호
	int newscount = 0; // 전체 게시글 수를 저장 할 변수
	int number = 0; // 게시글의 번호를 저장 할 변수
	
	List newsList = null;
	NewsDAO newsPro = NewsDAO.getInstance();
	newscount = newsPro.getNewsCount();
	
	// 조회수가 높은 게시물 저장
	if(newscount > 0){
		newsList = newsPro.gethotNews(startRow, endRow);
	}
	
	number = newscount - (currentPage - 1) * pageSize;
%>

<html>
	<head>
		<title> 핫 토픽 뉴스 </title>
	</head>
	
	<body>
	<%
	if(newscount == 0){
	%>
	<table width = "700" border = "1" cellpadding = "0" cellspacing = "0">
		<tr>
			<td> 핫한 뉴스가 없습니다. </td>
		</tr>
	</table>
	<%
	}else{
	%>
	<table border = "1" width = "700" cellpadding = "0" cellspacing = "0" align = "center">
		<tr height = "30">
			<td align = "center" width = "50"> 번호 </td>
			<td align = "center" width = "250"> 제목 </td>
			<td align = "center" width = "100"> 작성자 </td>
			<td align = "center" width = "150"> 언론사 </td>
			<td align = "center" width = "150"> 작성일 </td>
			<td align = "center" width = "50"> 조회 </td>
		</tr>
		<%
		for(int i = 0; i < newsList.size(); i++){
			NewsDTO article = (NewsDTO)newsList.get(i);
		%>
		<tr height = "30">
			<td align = "center" width = "50"><%=number--%></td>
			<td align = "center" width = "150"><a href = "content.jsp?num=<%=article.getNum()%>"><%=article.getTitle() %></a></td>
			<td align = "center" width = "150"><%=article.getId() %></td>
			<td align = "center" width = "150"><%=article.getPress() %></td>
			<td align = "center" width = "150"><%=sdf.format(article.getReg()) %></td>
			<td align = "center" width = "50"><%=article.getViews() %></td>
		</tr>
		<%} %>
	</table>
	<%} %>
	<div align = "center">
	<%
		if(newscount > 0){
			int pageCount = newscount / pageSize + (newscount % pageSize == 0 ? 0 : 1);
			int startPage = (int)(currentPage / 10) * 10 + 1;
			int pageBlock = 10;
			int endPage = startPage + pageBlock - 1;
			if(endPage > pageCount){
				endPage = pageCount;
			}
			if(startPage > 5){
	%>
		<a href = "hotlist.jsp?pageNum=<%=startPage - 10%>"></a>
	<%
			}
		for(int i = startPage; i <= endPage; i++){
	%>
		<a href = "hotlist.jsp?pageNum=<%=i%>"></a>
	<%
		}
		if(endPage < pageCount){
	%>
		<a href = "hotlist.jsp?pageNum=<%=startPage + 10%>"></a>
	<%
			}
		}
	%>
	</div>
<jsp:include page="/member/footer.jsp"></jsp:include>
	</body>
</html>