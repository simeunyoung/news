<%@page import="news.NewsDTO"%>
<%@page import="news.NewsDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
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
String id = (String) session.getAttribute("memId");
String pageNum = request.getParameter("pageNum");
String pageType = request.getParameter("pageType");

int pageSize = 5; // 한 페이지에 보여줄 목록의 수
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

if(pageNum == null){
	pageNum = "1";
}

int crtPage = Integer.parseInt(pageNum); // 선택한 pageNum을 숫자로 crtPage에 저장
int startNum = (crtPage - 1) * pageSize + 1; // 목록의 시작 번호와 끝 번호 지정
int endNum = crtPage * pageSize;

List newsList = null;
NewsDAO news = NewsDAO.getInstance();

int count = news.getMyNewsCount(id); // 해당 아이디가 쓴 기사 수 저장

if(count > 0){
	newsList = news.getMyNewsList(id, startNum, endNum);
}
int number = count - (crtPage -1) * pageSize;
%>
<body>
<!-- include 마이페이지 중 내가 쓴 기사 목록 폼 -->
	<div class="card">
		<div class="card-body">
			<h6 class="d-flex align-items-center mb-3">
				<i class="material-icons text-info mr-2">내가 쓴 기사(<%=count%>)</i>
			</h6>
			<%
				if (count == 0) { // 리스트에 목록이 없으면 보여줌
			%>
				<div class="no-list">저장된 글이 없습니다.</div>
			<%
				} else { // 리스트에 목록이 있으면 보여줌
			%>
			<table>
				<colgroup>
					<col style="width:5%" />
					<col style="width:15%" />
					<col style="width:18%" />
					<col style="width:35%" />
					<col style="width:18%" />
					<col style="width:9%" />
				</colgroup>
				<tr>
					<th>NO</th>
					<th>NEWSTYPE</th>
					<th>TITLE</th>
					<th>CONTENTS</th>
					<th>DATE</th>
					<th>VIEWS</th>
				</tr>
				<%
					if (newsList != null) {
						for (int i = 0; i < newsList.size(); i++) {
							NewsDTO journalist = (NewsDTO) newsList.get(i);
				%>
				<tr>
					<td><%=number--%></td>
					<td><%=journalist.getNewstype()%></td>
					<td>
  					<a href="/project1/news/content.jsp?num=<%=journalist.getNum()%>&pageNum=<%=crtPage%>">
   							 <%=journalist.getTitle()%>
 					</a>
					</td>
					<td class="over"><%=journalist.getCon()%></td>
					<td><%=sdf.format(journalist.getReg())%></td>
					<td><%=journalist.getViews()%></td>
				</tr>
				<%
					} // end for
						} // end if
				%>
			</table>
			<%
				} // end else
			%>
			<div class="pagination">
				<%
				if (count > 0) {
					// 하단 페이지 목록 번호 갯수 정하기
					int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
	
					int startPage = (int) (crtPage / 10) * 10 + 1;
					int pageBlock = 10;
					int endPage = startPage + pageBlock - 1;
					if (endPage > pageCount) {
						endPage = pageCount;
					}
	
					if (startPage > 10) {
				%>
					<a href="user_mypage_form.jsp?id=<%=id %>&pageType=<%=pageType %>&pageNum=<%=startPage - 10%>">[이전]</a>
				<%
					} // end if
					for (int i = startPage; i <= endPage; i++) {
				%>
					<a href="user_mypage_form.jsp?id=<%=id %>&pageType=<%=pageType %>&pageNum=<%=i%>">[<%=i%>]</a>
				<%
					}// end for
					if (endPage < pageCount) {
				%>
					<a href="user_mypage_form.jsp?id=<%=id %>&pageType=<%=pageType %>&pageNum=<%=startPage + 10%>">[다음]</a>
				<%
					} // end if
					}// end if(count)
				%>
			</div>
		</div>
	</div>
	
</body>
</html>