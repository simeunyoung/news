<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "news.NewsDAO"%>
<%request.setCharacterEncoding("UTF-8");%>
<%-- 기사 좋아요 버튼 눌렀을 때 오는 페이지(아직 작업중) --%>
<%-- 
<jsp:useBean id = "data" class = "news.NewsDTO"/>
<jsp:setProperty name = "data" property = "*"/>

<%
	int good = Integer.parseInt(request.getParameter("good"));
	String id = (String)session.getAttribute("memId");
	int num = Integer.parseInt(request.getParameter("num"));
	data.setId(id);
	data.setNum(num);
	
	String pageNum = request.getParameter("pageNum");
	
	NewsDAO nDAO = NewsDAO.getInstance();
	int chack = nDAO.goodinsert(id, data);
	
	if(chack == 1){%>
		<meta http-equiv="Refresh" content="0;url=content.jsp?num=<%=num%>">
<%}else{%>
		
<%}%>
--%>