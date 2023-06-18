<%@page import="news.NewsDAO"%>
<%@page import="news.NewsDTO"%>
<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>


<%!
	
    int pageSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%  
String search = request.getParameter("search");
String startDate = request.getParameter("startDate");
String endDate = request.getParameter("endDate");
String date = request.getParameter("date");

    List searchList = null;

    NewsDAO dao = NewsDAO.getInstance();

    if(search != null){
    	searchList = dao.getSearchList(search);
    }else if(startDate != null && endDate != null){
    	searchList = dao.getSearchDateList(startDate, endDate);	
    }else if(date.equals("today")){
    	searchList = dao.getSearchTodayList(date);
    }else if(date.equals("week")){
    	searchList = dao.getSearchTodayList(date);
    }else if(date.equals("month")){
    	searchList = dao.getSearchTodayList(date);
    }else if(date.equals("year")){
    	searchList = dao.getSearchTodayList(date);
    }
    
%>
<!DOCTYPE>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
<jsp:include page="/member/header.jsp" />
<br>
   <% try{%>
<b>검색결과: <%=searchList.size()%>개</b>
   
<% 
   if (searchList.size() == 0) {
%>
<table>
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>

<%  } else {    %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 
      <th align="center"  width="250" >NO</th> 
      <th align="center"  width="250" >제목</th> 
      <th align="center"  width="100" >작성자</th>
      <th align="center"  width="150" >언론사</th> 
      <th align="center"  width="150" >작성일</th> 
      <th align="center"  width="150" >조회수</th>         
    </tr>
<% int number = 1;
        for (int i = 0 ; i < searchList.size() ; i++) {
        	
          NewsDTO dto = (NewsDTO)searchList.get(i);
%>
   <tr height="30" onclick="location='content.jsp?num=<%=dto.getNum()%>'">
 	<td align="center"  width="50"><%=dto.getNum()%></td>
  
	 <%if(search != null){ %>
	   <td align="center" width="100" >
		<%String search2 = dto.getTitle().replace(search, "@"+search+"@");%>
		<%String[] spl = search2.split("@");%>
		<a>
		<%for(int z = 0 ; z < spl.length; z++){
			if(!search.equals(spl[z])){
				out.print(spl[z]);
			}else{
				%><span style="font-weight:bold"><%out.print(spl[z]);%></span><%
			}
			}%>
		</a>
	    </td>
	<%}else{ %>
	<td align="center"  width="50"><%=dto.getTitle()%></td>
	<%} %>

   
 	<td align="center"  width="50"><%=dto.getId()%></td>
    <td align="center"  width="50"><%=dto.getPress()%></td>
    <td align="center"  width="50"><%=sdf.format(dto.getReg())%></td>
    <td align="center"  width="50"><%=dto.getViews()%></td>
  </tr>
     <%}%>
</table>
<%}}catch(Exception e){%>0개<% }%>




</body>
</html>
