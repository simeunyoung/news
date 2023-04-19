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
<title>유저 댓글 리스트</title>
</head>
<%
String id = (String)session.getAttribute("memId");
String pageNum = request.getParameter("pageNum");

int pageSize = 10; // 한 페이지에 보여줄 목록의 수
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
if(pageNum == null){
	pageNum = "1";
}
List userList = null;
int crtPage = Integer.parseInt(pageNum);
int startNum = (crtPage - 1) * pageSize + 1;
int endNum = crtPage * pageSize;

RevalueDAO rv = RevalueDAO.getInstance();

int count = rv.getMyReconCount(id);

if(count > 0){
	userList = rv.getMyReconList(id, startNum, endNum);
}
int number = count - (crtPage - 1) * pageSize;
%>
<body>
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
			<tr>
				<th>NO</th>
				<th>ID</th>
				<th>TITLE</th>
				<th>CONTENTS</th>
				<th>RECONTENTS</th>
				<th>IP</th>
				<th>DATE</th>
			</tr>
			<%
			if (userList != null) {
				for (int i = 0; i < userList.size(); i++) {
					RevalueDTO recon = (RevalueDTO) userList.get(i);
			%>
			<tr>
				<td><%=number--%></td>
				<td><%=recon.getId()%></td>
				<td><a
					href="news.jsp?num<%=recon.getNum()%>&pageNum=<%=crtPage%>">
						<%=recon.getTitle()%>
				</a></td>
				<td><%=recon.getCon()%></td>
				<td><%=recon.getReCon()%></td>
				<td><%=recon.getIp()%></td>
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
			<a href="userlist.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
		<%
			}
			for (int i = startPage; i <= endPage; i++) {
		%>
			<a href="userlist.jsp?pageNum=<%=i%>">[<%=i%>]</a>
		<%
			}
			if (endPage < pageCount) {
		%>
			<a href="userlist.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
		<%
				}
			}
		%>

	</div>
</body>
</html>