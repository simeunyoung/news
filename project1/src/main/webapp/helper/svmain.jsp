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
	count = svDAO.getSvcenterCount();
	if(count > 0){
		svcenterList = svDAO.getSvcenter(startRow, endRow);
	}
	number = count - (currentPage - 1) * pageSize;
%>

<title>고객센터</title>
<center><b>고객센터</b></center>
<table align = "center" width = "500" height = "60" border = "1" cellspacing = "0" cellpadding = "0">
	<tr>
		<td align = "center" colspan = "2">
			<a href = "questionForm.jsp">1대1문의하기</a>
		</td>
	
		<td align = "center" colspan = "2">
			<a href = "">신고하기</a>
		</td>

		<td align = "center" colspan = "2">
			<a href = "">기자신청하기</a>
		</td>
		
		<td align = "center" colspan = "2">
			<a href = "">내문의목록</a>
		</td>
		
		<td align = "center" colspan = "2">
			<a href = "frequentlyMain.jsp">자주묻는질문</a>
	</tr>			
</table>

<%
	if(count == 0){
%>
&nbsp;&nbsp;&nbsp;&nbsp;
<table align = "center" width = "700" border = "1" cellpadding = "0" cellspacing = "0">
	<tr>
		<td align = "center">
		문의글이 없습니다.
		</td>
</table>

<% }else{ %>
&nbsp;&nbsp;&nbsp;&nbsp;
<center><b>문의목록</b></center>
<table align = "center" width = "800" border = "1" cellspacing = "0" cellpadding = "0">
	<tr height = "30">
		<td align = "center" width = "50">번 호</td>
		<td align = "center" width = "500">제 목</td>
		<td align = "center" width = "100">작성자</td>
		<td align = "center" width = "100">작성날짜</td>
		
	<%
		for(int i = 0; i < svcenterList.size() ; i++){
			SvcenterDTO svdto = (SvcenterDTO)svcenterList.get(i);
	%>
	
	<tr height = "20">
		<td align = "center" width = "50"><%=number--%></td>
		<td align = "center" width = "200"><a href = "qtcon.jsp?num=<%=svdto.getNum1()%>&pageNum=<%=currentPage%>"><%=svdto.getTitle()%></a></td>			
		<td align = "center" width = "100"><%=svdto.getId()%></td>
		<td align = "center" width = "100"><%=sdf.format(svdto.getReg())%></td>
	</tr>
	<%}%>	
</table>
<%}%>
<form align="center">
<%
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		
		int startPage = (int)(currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock -1 ;
		
		if(endPage > pageCount) endPage = pageCount;
		
		if(startPage > 10){%>
	<a href = "svmain.jsp ? pageNum = <%=startPage - 10%>">[이전]</a>
<%}	
	for(int i = startPage ; i <= endPage ; i++){%>
	<a href = "svmain.jsp ? pageNum = <%=i%>">[<%=i%>]</a>
<%}
	if(endPage < pageCount){%>
	<a href = "svmain.jsp ? pageNum = <%=startPage + 10%>">[다음]</a>
<%
	}
}
%>
</form>