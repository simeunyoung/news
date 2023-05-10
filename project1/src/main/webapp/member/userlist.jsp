<%@page import="revalue.RevalueDTO"%>
<%@page import="java.util.List"%>
<%@page import="revalue.RevalueDAO"%>
<%@page import="java.text.SimpleDateFormat"%>
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
String id = (String)session.getAttribute("memId");
String pageNum = request.getParameter("pageNum");
String nick = (String)session.getAttribute("nick");
String pageType = request.getParameter("pageType");
int pageSize = 3; // 한 페이지에 보여줄 목록의 수
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
if(pageNum == null){
	pageNum = "1";
}
List userList = null;
int crtPage = Integer.parseInt(pageNum);
int startNum = (crtPage - 1) * pageSize + 1;
int endNum = crtPage * pageSize;

RevalueDAO rv = RevalueDAO.getInstance();

int count = rv.getMyReconCount(id); // 댓글 개수

if(count > 0){
	userList = rv.getMyReconList(id, startNum, endNum);
}
int number = count - (crtPage - 1) * pageSize;


%>
<body>
	<!-- 유저의 댓글 리스트 -->
	<div class="card-body">
		<h6 class="d-flex align-items-center mb-3">
			<i class="material-icons text-info mr-2">내가 쓴 댓글(<%=count%>)
			</i>
		</h6>
		<%
			if (count == 0) {
		%>
		<div>저장된 댓글이 없습니다.</div>
		<%
			} else {
		%>
		<table>
				<colgroup>
					<col style="width:5%" />
					<col style="width:15%" />
					<col style="width:18%" />
					<col style="width:32%" />
					<col style="width:15%" />
					<col style="width:15%" />
				</colgroup>
			<tr>
				<th>NO</th>
				<th>ID</th>
				<th>TITLE</th>
				<th>CONTENTS</th>
				<th>RECONTENTS</th>
				<th>DATE</th>
			</tr>
			<%
			if (userList != null) {
				for (int i = 0; i < userList.size(); i++) {
					RevalueDTO recon = (RevalueDTO) userList.get(i);
					int result = rv.getReconNum(recon.getTitle(),recon.getCon());
			%>
			<tr>
				<td><%=number--%></td>
				<td>
					<%if(recon.getId().equals("@@")) {%>
						탈퇴한 회원
					<%}else{ %>
						<%=recon.getId()%>
					<%} %>
				</td>
				<td class="over"><a href="/project1/news/content.jsp?num=<%=result%>">
						<%=recon.getTitle()%>
				</a></td>
				<td class="over"><%=recon.getCon()%></td>
				<td class="over"><%=recon.getReCon()%></td>
				<td><%=sdf.format(recon.getReg())%></td>
			</tr>
			<%
			}
			%>
		</table>
		<%
		}
		}
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
				<a href="user_mypage_form.jsp?pageNum=<%=startPage - 10%>&pageType=<%=pageType%>&id=<%=id%>">[이전]</a>
			<%
				}
				for (int i = startPage; i <= endPage; i++) {
			%>
				<a href="user_mypage_form.jsp?pageNum=<%=i%>&pageType=<%=pageType%>&id=<%=id%>">[<%=i%>]</a>
			<%
				}
				if (endPage < pageCount) {
			%>
				<a href="user_mypage_form.jsp?pageNum=<%=startPage + 10%>&pageType=<%=pageType%>&id=<%=id%>">[다음]</a>
			<%
					}
				}
			%>
		</div>
	</div>
</body>
</html>