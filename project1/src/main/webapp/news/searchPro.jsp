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
<%
String pageNum = request.getParameter("pageNum");
if(pageNum == null){ pageNum = "1"; }

int pageSize = 10;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
int newscount = 0;
int number = 0;

List newsList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newscount = newsPro.getNewsCount(); // 추가 DAO

if(newscount > 0){
newsList = newsPro.getNews(startRow, endRow); // 추가 DAO
}

number = newscount - (currentPage - 1) * pageSize;
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
<div class="table_box">
<div class="one_box" align="center"><b>작성 번호</b></div>
<div class="two_box" align="center"><b>뉴스(내용)</b></div>
<div class="three_box" align="center"><b>작성자</b></div>
<div class="four_box" align="center"><b>언론사</b></div>
<div class="five_box" align="center"><b>작성일</b></div>
<div class="six_box" align="center"><b>조회수</b></div>
</div>
<% 
        for (int i = 0 ; i < searchList.size() ; i++) {
          NewsDTO dto = (NewsDTO)searchList.get(i);
%>
<div>
<a href="content.jsp?num=<%=dto.getNum()%>"><font color="#000000">
<div class="text_box">
<div class="one_box" align="center"><%=number--%></div>
<div class="two_see" >
<b><font size="4px" color="#000000"><%=dto.getTitle() %></font></b><br /><br />&nbsp;&nbsp;<%=dto.getCon() %></div>
<div class="three_box" align="center"><%=dto.getId() %></div>
<div class="four_box" align="center"><%=dto.getPress() %> </div>
<div class="five_box" align="center"><%=sdf.format(dto.getReg()) %> </div>
<div class="six_box" align="center"><%=dto.getViews() %> </div>
</div></font></a></div>
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
