<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CODENEWS</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<body>


<%
	// 페이지에 보여줄 뉴스 개수 지정
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String newsType = request.getParameter("newstype");
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
	
	List<NewsDTO> newsList = null; // 뉴스 타입에 해당하는 뉴스 목록 저장
	NewsDAO newsPro = NewsDAO.getInstance();
	newscount = newsPro.getNewstypeCount(newsType); // 메소드
	
	if(newscount > 0){
		newsList = newsPro.getNewsType(startRow, endRow, newsType); // 메소드
	}
	
	// 뉴스 목록에서 역순으로 출력될 작성번호를 계산하면 가장 최신의 기사가 뜸
	number = newscount - (currentPage - 1) * pageSize;
%>

<jsp:include page="/member/header.jsp"></jsp:include>
<div class="page-wrap">
	<h2><%= newsType %>
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
	<div class="pagination">
		<%-- null이 아니고, 0보다 크면 페이징 --%>
		<% if (newsList != null && newsList.size() > 0) {
				// 전체 페이지 수 계산
                int pageCount = (newscount / pageSize) + (newscount % pageSize == 0 ? 0 : 1);
                int startPage = ((currentPage - 1) / 10) * 10 + 1;
                int endPage = startPage + 9;

                if (endPage > pageCount) {
                    endPage = pageCount;
                }

                if (startPage > 1) { %>
		<a
			href="newstypelist.jsp?pageNum=<%=startPage - 1 %>&newstype=<%=newsType %>">[이전]</a>
		<% }
			// 해당 페이지 번호를 누르면 페이지로 이동하게 링크를 걸음
                for (int i = startPage; i <= endPage; i++) { %>
		<% if (i == currentPage) { %>
		<a>[<%=i %>]</a>
		<% } else { %>
		<a href="newstypelist.jsp?pageNum=<%=i %>&newstype=<%= newsType %>">[<%=i %>]</a>
		<% } %>
		<% }

                if (endPage < pageCount) { %>
		<a
			href="newstypelist.jsp?pageNum=<%=endPage + 1 %>&newstype=<%=newsType %>">[다음]</a>
		<% }
            } %>
	</div>
</div>

</body>
<jsp:include page="/member/footer.jsp"></jsp:include>
</html>