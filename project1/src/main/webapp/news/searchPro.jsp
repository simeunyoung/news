<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="/view/color.jsp"%>

<%!
    int pageSize = 10;
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%   String search = request.getParameter("search");


    List searchList = null;
    MemberDAO dao = MemberDAO.getInstance();

    searchList = dao.getSearchList(search);
%>
<html>
<head>
<title>게시판</title>
<link href="style.css" rel="stylesheet" type="text/css">
</head>

<body>
   <% try{%>
<b>검색결과: <%=articleList.size()%>개</b>
   
<% 
   if (articleList.size() == 0) {
%>
<table width="700" border="1" cellpadding="0" cellspacing="0">
<tr>
    <td align="center">
    게시판에 저장된 글이 없습니다.
    </td>
</table>

<%  } else {    %>
<table border="1" width="700" cellpadding="0" cellspacing="0" align="center"> 
    <tr height="30" bgcolor="<%=value_c%>"> 
      <td align="center"  width="250" >제   목</td> 
      <td align="center"  width="100" >작성자</td>
      <td align="center"  width="150" >작성일</td> 
      <td align="center"  width="50" >조 회</td> 
      <td align="center"  width="100" >IP</td>    
    </tr>
<% 
        for (int i = 0 ; i < articleList.size() ; i++) {
          BoardDataBean article = (BoardDataBean)articleList.get(i);
%>
   <tr height="30">
    <td  width="250" >
   <%
         int wid=0; 
         if(article.getRe_level()>0){
           wid=5*(article.getRe_level());
   %>
     <img src="images/level.gif" width="<%=wid%>" height="16">
     <img src="images/re.gif">
   <%}else{%>
     <img src="images/level.gif" width="<%=wid%>" height="16">
   <%}%>
           
           <%=article.getSubject()%></a> 
          <% if(article.getReadcount()>=20){%>
         <img src="images/hot.gif" border="0"  height="16"><%}%> </td>
    <td align="center"  width="100"> 
       <a href="mailto:<%=article.getEmail()%>"><%=article.getWriter()%></a></td>
    <td align="center"  width="150"><%= sdf.format(article.getReg_date())%></td>
    <td align="center"  width="50"><%=article.getReadcount()%></td>
    <td align="center" width="100" ><%=article.getIp()%></td>
  </tr>
     <%}%>
</table>
<%}}catch(Exception e){%>0개<% }%>




</body>
</html>
