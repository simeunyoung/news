<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO" %>

<%	
	int pageSize = 20; // 한 페이지에서 보여줄 게시물 수
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm:ss"); // 작성일자 양식
	
	String pageNum = request.getParameter("pageNum"); // 현재 페이지를 받아옴 request는 리턴값이 String
	// 페이지를 받아올 때 null인경우 1을 대입
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum); // String을 int로 변환
	int startRow = (currentPage - 1) * pageSize + 1; // (1페이지 - 1) * 20 + 1 = 1
	int endRow = currentPage * pageSize; // 1페이지 x 20개
	List oneononeList = null; // 게시물 목록을 보여줄 리스트 선언
	
	AdminDAO dao = AdminDAO.getInstance(); // dao 객체 불러옴
	int count = dao.oneononeCount(); // db에 있는 게시물 수
	// 게시물이 있으면 목록 가져옴 1, 20 / 21, 40
	if(count > 0) {
		oneononeList = dao.oneononeList(startRow, endRow);
	}
	
	int number = count - (currentPage-1) * pageSize;
%>
<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>1:1 문의내역(관리자)</title>

<center><h2>1:1 문의내역(관리자)</h2></center>

<hr />

<center><h3>글목록(<%=count%>)</h3></center>

<%	if(count == 0){%>
	<table align="center" width="700" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td align="center">게시판에 저장된 글이 없습니다.</td>
		</tr>
	</table>
<%	} else {%>
<form>
	<table align="center" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td align="center" width="50">순번</td>
			<td align="center" width="80">고유번호</td>
			<td align="center" width="250">제목</td>
			<td align="center" width="100">작성자</td>
			<td align="center" width="200">작성일</td>
			<td align="center" width="80">조회</td>
			<td align="center" width="150">IP</td>
		</tr>
<%	for(int i = 0; i < oneononeList.size(); i++) {
		AdminDTO dto = (AdminDTO)oneononeList.get(i);%>
		<tr height="30">
			<td align="center"><%=number--%></td>
			<td align="center"><%=dto.getNum()%></td>
			<td align="center"><a href="1-1Content.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>"><%=dto.getTitle()%></a></td>
			<td align="center"><%=dto.getName()%></td>
			<td align="center"><%=sdf.format(dto.getReg())%></td>
			<td align="center"><%=dto.getIp()%></td>
		</tr>
<%	}%>		
	</table>
</form>

<form align="center">
<%}%>
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count % pageSize == 0? 0:1);
		
		int startPage = (int)(currentPage / 20) * 20 + 1;
		int pageBlock = 20;
		int endPage = startPage + pageBlock -1;
		
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > 20) {%>
			<a href="1-1List.jsp?pageNum=<%=startPage - 20%>">[이전]</a>
<%		}
		for(int i = startPage; i <= endPage; i++) {%>
			<a href="1-1List.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%		}
		if(endPage < pageCount) { %>
			<a href="1-1List.jsp?pageNum=<%=startPage + 20%>">[다음]</a>
<%		}
	}%>
</form>