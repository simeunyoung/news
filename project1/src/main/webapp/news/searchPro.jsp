<%@page import="news.NewsDAO"%>
<%@page import="news.NewsDTO"%>
<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>


<%!
    int pageSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%   String search = request.getParameter("search");


    List searchList = null;

    NewsDAO dao = NewsDAO.getInstance();

    searchList = dao.getSearchList(search);
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
   <% try{%>
<b>검색결과: <%=searchList.size()%>개</b>
   
<% 
   if (searchList.size() == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>

<%  } else {    %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30"> 
      <td align="center"  width="250" >아이디</td> 
      <td align="center"  width="100" >타입</td>
      <td align="center"  width="150" >제목</td> 
        
    </tr>
<% 
        for (int i = 0 ; i < searchList.size() ; i++) {
          NewsDTO dto = (NewsDTO)searchList.get(i);
%>
   <tr height="30">

    <td align="center"  width="50"><%=dto.getId()%></td>
    <td align="center"  width="50"><%=dto.getNewstype()%></td>
    <td align="center" width="100" >
    <% String search2 = dto.getTitle().replace(search,"@"+search+"@");%>
           <% String[] spl = search2.split("@"); %>
           <a><%for(int z = 0 ; z < spl.length; z++)
           {if(!search.equals(spl[z])){   
              out.print(spl[z].trim());
           }else{%>
                <strong><%out.print(spl[z].trim());%></strong>
          <%}}%></a>
    </td>

  </tr>
     <%}%>
</table>
<%}}catch(Exception e){%>0개<% }%>




</body>
</html>
