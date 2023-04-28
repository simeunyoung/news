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
          <td align="center"  width="250" >날짜</td> 
      <td align="center"  width="250" >아이디</td> 
      <td align="center"  width="100" >타입</td>
      <td align="center"  width="150" >제목</td> 
        
    </tr>
<% 
        for (int i = 0 ; i < searchList.size() ; i++) {
          NewsDTO dto = (NewsDTO)searchList.get(i);
%>
   <tr height="30">
 <td align="center"  width="50"><%=dto.getReg()%></td>
    <td align="center"  width="50"><%=dto.getId()%></td>
    <td align="center"  width="50"><%=dto.getNewstype()%></td>
    <td align="center" width="100" >
 <%if(search != null){ %>
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
<%} else if(startDate != null && endDate != null){%>
   <td align="center"  width="50"><%=dto.getTitle()%></td>
<%} %>
    </td>

  </tr>
     <%}%>
</table>
<%}}catch(Exception e){%>0개<% }%>




</body>
</html>
