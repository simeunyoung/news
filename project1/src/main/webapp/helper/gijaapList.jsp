<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.GijaDAO"%>
<%@ page import = "helper.GijaDTO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.List"%>

<%-- 계획대로라면 신청이 들어온게 여기에 게시판처럼 나와야함 --%>
<%!
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
	String id = (String)session.getAttribute("memId");

	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	List gijaList = null;
	GijaDAO gdao = GijaDAO.getInstance();
	count = gdao.getGijaCount();
	if(count > 0){
		gijaList = gdao.getGija(startRow, endRow);
	}
	
	number = count - (currentPage - 1) * pageSize;
%>

<%if(count == 0){%>
&nbsp;&nbsp;&nbsp;&nbsp;
	<table align = "center" width = "700" border = "1" cellspacing = "0" cellpadding = "0">
		<tr>
			<td align = "center">들어온 요청이 없습니다</td>
	</table>
<%}else{%>
&nbsp;&nbsp;&nbsp;&nbsp;
	<center><b>기자신청목록</b></center>
		<table align = "center" width = "800" border = "1" cellspacing = "0" cellpadding = "0">
			<tr height = "30">
				<td align = "center" width = "50">번 호</td>
				<td align = "center" width = "100">i d</td>
				<td align = "center" width = "100">작성일</td>
				
		<%
			for(int i = 0 ; i < gijaList.size(); i++){
				GijaDTO gdto = (GijaDTO)gijaList.get(i);	
		%>
		<tr height = "20">
			<td align = "center" width = "50"><%=number--%></td>
			<td align = "center" width = "200"><a href = "gijacon.jsp?num=<%=gdto.getNum()%>&pageNum=<%=currentPage%>"><%=gdto.getId()%></a></td>
			<td align = "center" width = "100"><%=sdf.format(gdto.getReg())%></td>
		</tr>
		<%}%>		
		</table>
	<%}%>
	
	<form align = "center">
		<%
			if(count > 0){
				int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
				
				int startPage = (int)(currentPage / 10) * 10 + 1;
				int pageBlock = 10;
				
				int endPage = startPage + pageBlock - 1;
				
			if(endPage > pageCount)endPage = pageCount;
			
			if(startPage > 10){%>
				<a href = "gijaapList.jsp?pageNum = <%=startPage - 10%>">[이전]</a>
		<%} 
			for(int i = startPage ; i <= endPage ; i++){%>
				<a href = "gijaapList.jsp?pageNum = <%=i%>">[<%=i%>]</a>
		<%}
			if(endPage < pageCount){%>
				<a href = "gijaapList.jsp?pageNum = <%=startPage + 10%>">[다음]</a>
		<%}%>
	<%}%>
</form>