<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "helper.Svcenter1DAO"%>
<%@ page import = "helper.Svcenter1DTO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.List"%>

<%-- 고객센터 메인페이지 --%>
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
	
	List svcenterList1 = null;
	Svcenter1DAO svDAO1 = Svcenter1DAO.getInstance();
	count = svDAO1.getSvcenterCount1();
	if(count > 0){
		svcenterList1 = svDAO1.getSvcenter1(startRow, endRow);
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
			<a href = "qalist.jsp">문의목록</a>
		</td>
		
	<%if(id != null){%>
		<td align = "center" colspan = "2">
			<a href = "">기자신청하기</a>
		</td>
	<%}%>	
		<td align = "center" colspan = "2">
			<a href = "myquestion.jsp">내문의목록</a>
		</td>
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
<center><b>자주묻는질문</b></center>
<table align = "center" width = "800" border = "1" cellspacing = "0" cellpadding = "0">
	<tr height = "30">
		<td align = "center" width = "50">번 호</td>
		<td align = "center" width = "500">제 목</td>
		<td align = "center" width = "100">작성자</td>
		<td align = "center" width = "100">작성날짜</td>
		
	<%
		for(int i = 0; i < svcenterList1.size() ; i++){
			Svcenter1DTO svdto1 = (Svcenter1DTO)svcenterList1.get(i);
	%>
	
	<tr height = "20">
		<td align = "center" width = "50"><%=number--%></td>
		<td align = "center" width = "200"><a href = "fqcon.jsp?num=<%=svdto1.getNum()%>&pageNum=<%=currentPage%>"><%=svdto1.getTitle()%></a></td>			
		<td align = "center" width = "100"><%=svdto1.getId()%></td>
		<td align = "center" width = "100"><%=sdf.format(svdto1.getReg())%></td>
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

<%if(id != null){
	if(id.equals("admin")){%>
	<form method = "post" action = "frequentlyForm.jsp" name = "svmain" align = "right">
		<table width = "600" border = "0" cellspacing = "0" cellpadding = "0" align = "right">
			<tr>
				<td align = "right">
					<input type = "submit" value = "글쓰기">
				</td>
			</tr>
		<%}%>
	<%}%>
		</table>
	</form>