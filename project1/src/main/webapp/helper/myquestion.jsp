<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.SvcenterDAO"%>
<%@ page import = "helper.SvcenterDTO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.List"%>

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
	count = svDAO.getMySvcenterCount(id);
	if(count > 0){
		svcenterList = svDAO.getMySvcenter(id,startRow,endRow); 
	}
	number = count - (currentPage - 1) * pageSize;
%>

<%-- 
<center><b>내문의목록(전체 글 : <%=count%>)</b>
<table width = "700">
	<tr>
		<td align = "right">
		<%if(session.getAttribute("memId") == null){%>
			<a href = "">로그인</a>
		<%}else{%>
			<a href = "questionForm.jsp">글쓰기</a>
		<%}%>
		</td>
	</tr>
</table>
--%>

<%if(count == 0){%>
&nbsp;&nbsp;&nbsp;&nbsp;
<table align = "center" width = "700" border = "1" cellpadding = "0" cellspacing = "0">
	<tr>
		<td align = "center">작성하신 글이 없습니다.</td>
</table>

<%}else{%>
&nbsp;&nbsp;&nbsp;&nbsp;
<center><b>내문의목록</b>
<table ailgn = "center" width = "800" border = "1" cellspacing = "0" cellpadding = "0">
	<tr height = "30">
		<td align = "center" width = "50">글번호</td>
		<td align = "center" width = "500">제 목</td>
		<td align = "center" width = "100">작성자</td>
		<td align = "center" width = "100">문의날짜</td>
		
	<%
		for(int i = 0 ; i < svcenterList.size() ; i++){
			SvcenterDTO svdto = (SvcenterDTO)svcenterList.get(i);
	%>
	
	<tr height = "20">
		<td align = "center" width = "50"><%=number--%></td>
		<td align = "center" width = "200"><a href = "qtcon.jsp?num<%=svdto.getNum1()%>&pageNum=<%=currentPage%>"><%=svdto.getTitle()%></a></td>
		<td align = "center" width = "100"><%=svdto.getId()%></td>
		<td align = "center" width = "100"><%=sdf.format(svdto.getReg())%></td>
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
			
			if(endPage > pageCount) endPage = pageCount;
			
		if(startPage > 10){%>
		<a href = "myquestion.jsp ? pageNum = <%=startPage - 10%>">[이전]</a>
	<%}
		for(int i = startPage ; i <= endPage ; i++){%>
		<a href = "myquestion.jsp ? pageNum = <%=i%>">[<%=i%>]</a>
	<%}
		if(endPage < pageCount){%>
		<a href = "myquestion.jsp ? pageNum = <%=startPage + 10%>">[다음]</a>
	<%
		}
	}
%> 
</form>