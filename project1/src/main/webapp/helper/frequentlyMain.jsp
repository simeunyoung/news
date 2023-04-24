<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.Svcenter1DAO"%>
<%@ page import = "helper.Svcenter1DTO"%>
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
	
	List svcenterList1 = null;
	Svcenter1DAO svDAO1 = Svcenter1DAO.getInstance();
	count = svDAO1.getSvcenterCount1(); 
	
	if(count > 0){
		svcenterList1 = svDAO1.getSvcenter1(startRow, endRow); 
	}
	
	number = count - (currentPage - 1) * pageSize;
%>

<title>고객센터</title>
<center><b>자주 묻는 질문 게시판</b></center>

<%
	if(count == 0){
%>
&nbsp;&nbsp;&nbsp;&nbsp;
<table align = "center" width = "700" border = "1" cellpadding = "0" cellspacing = "0">
	<tr>
		<td align = "center">
		게시된 글이 없습니다.
		</td>
</table>

<%}else{%>
&nbsp;&nbsp;&nbsp;&nbsp;
<center><b>자주 묻는 질문</b></center>
<table border = "1" width = "800" cellpadding = "0" cellspacing = "0" align = "center">
	<tr height = "30">
		<td align = "center" width = "50">번 호</td>
		<td align = "center" width = "500">제 목</td>
		<td align = "center" width = "100">작성자</td>
		<td align = "center" width = "200">작성일</td>
		
<%
	for(int i = 0 ; i < svcenterList1.size() ; i++){
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

<form align = "center">
	<%
		if(count > 0){
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			
			int startPage = (int)(currentPage / 10) * 10 + 1;
			int pageBlock = 10;
			
			int endPage = startPage + pageBlock - 1;
			
			if(endPage > pageCount) endPage = pageCount;
			
			if(startPage > 10){%>
			<a href = "frequentlyMain.jsp?pageNum=<%=startPage - 10%>">[이 전]</a>
	<%}
			for(int i = startPage ; i <= endPage ; i++){%>
			<a href = "frequentlyMain.jsp?pageNum=<%=i%>">[<%=i%>]</a>
	<%}
			if(endPage < pageCount){%>
			<a href = "frequentlyMain.jsp?pageNum=<%=startPage + 10%>">[다 음]</a>
	<%
			}
		}
	%>
</form>

		
<%-- 	
<%//if(id.equals("admin")){%>		
<form method = "post" action = "frequentlyForm.jsp" name = "frequentlyMain">
	<table width = "600" border = "1" cellspacing ="0" cellpadding = "0" align = "right">
		<input type = "submit" name = "config" value = "글쓰기" align = "right">
<%//}else{%>
		<input type = "button" value = "고객센터 페이지로" onclick = "location = 'svmain.jsp'">
<%//}%>
	</table>
</form>
--%>	
