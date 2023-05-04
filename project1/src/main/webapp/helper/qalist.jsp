<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.SvcenterDAO"%>
<%@ page import = "helper.SvcenterDTO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.List"%>
<%--1대1 문의를 했을 경우 1대1문의가 들어온 전체를 게시판으로 출력 --%>
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
	
	List svcenterList = null;
	SvcenterDAO svDAO = SvcenterDAO.getInstance();
	count = svDAO.getSvcenterCount();							//1대1 문의가 들어온게 있는지 확인 있으면 몇개인지 검색하고 count에 저장 글이 있다면 1 없다면 0
	if(count > 0){
		svcenterList = svDAO.getSvcenter(startRow, endRow);		//글이 있을 경우 검색하고 리스트에 저장
	}
	
	number = count - (currentPage - 1) * pageSize;
%>

<%if(count == 0){%>												<%-- 글이 없을때만 동작 --%>
&nbsp;&nbsp;&nbsp;&nbsp;
	<table align = "center" width = "700" border = "1" cellspacing = "0" cellpadding = "0">
		<tr>
			<td align = "center">문의글이 없습니다.</td>
	</table>
	
<%}else{%>
&nbsp;&nbsp;&nbsp;&nbsp;
<center><b>문의목록</b></center>
	<table align = "center" width = "800" border = "1" cellspacing = "0" cellpadding = "0">
		<tr height = "30">
			<td align = "center" width = "50">번 호</td>
			<td align = "center" width = "500">제 목</td>
			<td align = "center" width = "100">작성자</td>
			<td align = "center" width = "100">작성일</td>
			
		<%
			for(int i = 0 ; i < svcenterList.size() ; i++){				
				SvcenterDTO svdto = (SvcenterDTO)svcenterList.get(i);			//글이 있을 경우 테이블을 생성하고 위에서 검색한 내용이 리스트에 저장되어있기에 저장되어있는 값만큼 반복하여 값을 하나씩 꺼냄
		%>
		
		<tr heigth = "20">
			<td align = "center" width = "50"><%=number--%></td>
			<td align = "center" width = "200"><a href = "qtcon.jsp?num=<%=svdto.getNum1()%>&pageNum=<%=currentPage%>"><%=svdto.getTitle()%></a></td>
			<td align = "center" width = "100"><%=svdto.getId()%></td>
			<td align = "center" width = "100"><%=sdf.format(svdto.getReg())%></td>
		</tr>
	<%}%>
	
		<tr>
			<td colspan = "4" align = "right">
				<input type = "button" value = "고객센터로" onclick = "location.href='svmain.jsp?pageNum=<%=pageNum%>'">
			</td>
		</tr>
	</table>
<%}%>

<form align = "center">
	<%
		if(count > 0){
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			
			int startPage = (int)(currentPage / 10) * 10 + 1;
			int pageBlock = 10;
			
			int endPage = startPage + pageBlock -1;
			
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 10){%>
			<a href = "qalist.jsp?pageNum = <%=startPage - 10%>">[이전]</a>
	<%}
		for(int i = startPage ; i <= endPage ; i++){%>
			<a href = "qalist.jsp?pageNum = <%=i%>">[<%=i%>]</a>
	<%}
		if(endPage < pageCount){%>
			<a href = "qalist.jsp?pageNum = <%=startPage + 10%>">[다음]</a>
	<%}%>
<%}%>
</form>