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
<title>기사리스트</title>
</head>
<%
String id = (String) session.getAttribute("memId");
String pageNum = request.getParameter("pageNum");

int pageSize = 5;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

if(pageNum == null){
	pageNum = "1";
}

int crtPage = Integer.parseInt(pageNum);
int startNum = (crtPage - 1) * pageSize + 1;
int endNum = crtPage * pageSize;

List newsList = null;
NewsDAO news = NewsDAO.getInstance();

int count = news.getMyNewsCount(id);

if(count > 0){
	newsList = news.getMyNewsList(id, startNum, endNum);
}
int number = count - (crtPage -1) * pageSize;
%>
<body>
	<div class="card">
		<div class="card-body">
			<h6 class="d-flex align-items-center mb-3">
				<i class="material-icons text-info mr-2">내가 쓴 기사(<%=count%>)</i>
			</h6>
			<%
				if (count == 0) { // 리스트에 목록이 없으면 보여줌
			%>
				<div>저장된 댓글이 없습니다.</div>
			<%
				} else { // 리스트에 목록이 있으면 보여줌
			%>
			<table>
				<tr>
					<th>NO</th>
					<th>ID</th>
					<th>NEWSTYPE</th>
					<th>TITLE</th>
					<th>CONTENTS</th>
					<th>IP</th>
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
					<td><%=journalist.getId()%></td>
					<td><%=journalist.getNewstype()%></td>
					<td><a
						href="news.jsp?num<%=journalist.getNum()%>&pageNum=<%=crtPage%>">
							<%=journalist.getTitle()%>
					</a></td>
					<td><%=journalist.getCon()%></td>
					<td><%=journalist.getIp()%></td>
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
				<a href="journalist.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
			<%
				} // end if
				for (int i = startPage; i <= endPage; i++) {
			%>
				<a href="journalist.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%
				}// end for
				if (endPage < pageCount) {
			%>
				<a href="journalist.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
			<%
				} // end if
				}// end if(count)
			%>

		</div>
	</div>
	
</body>
</html>