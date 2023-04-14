<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "project.newsDAO" %>
<%@ page import = "project.newsDTO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file = "/view2/color.jsp" %>

<%
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
	String id = (String)session.getAttribute("memID");

	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	List articleList = null;
	newsDAO daoPro = newsDAO.getInstance();
	count = daoPro.getMyArticleCount(id);
	if(count > 0){
		articleList = daoPro.getMyArticles(id, startRow, endRow);
	}
	number = count - (currentPage - 1) * pageSize;
%>

<html>
	<head>
	<title>나의 활동</title>
	<link>
	</head>
	
	<body>
		<b> 글 목록 (전체 글 : <%=count %>)</b>
		<table>
			<tr>
				<td align = "rignt">
				<%if(session.getAttribute("memId") == null){%>
					<a href = ""> 회원 가입 </a>
				<%}else{ %>
					<a href = ""> 수정 / 삭제</a>
					<a href = ""> 글 쓰기</a>
				<%} %>
				</td>
			</tr>
		</table>
		
		<%if(count == 0){ %>
		
		<table>
			<tr>
				<td align = "center"> 활동한 흔적이 없습니다.</td>
			</tr>
		</table>
		
		<%}else{ %>
		
		<table>
			<tr>
				<td align = "center"> 번 호 </td>
				<td align = "center"> 제 목 </td>
				<td align = "center"> 작성자 </td>
				<td align = "center"> 닉네임 </td>
				<td align = "center"> 작성일 </td>
				<td align = "center"> 조 회 </td>
			</tr>
			
			<%
			for(int i = 0; i < articleList.size(); i++){
				newsDTO article = (newsDTO)articleList.get(i);
			%>
			
			<tr>
				<td align = "center"> <%=number-- %> </td>
				
			</tr>
			<%} %>
		</table>
		<%} %>
	</body>
</html>