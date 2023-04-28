<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "news.NewsDAO"%>
<%request.setCharacterEncoding("UTF-8");%>
<%-- 기사 싫어요를 눌렀을 때 동작하는 페이지(아직 작업중) --%>
<%--
<jsp:useBean id = "data" class = "news.NewsDTO"/>
<jsp:setProperty name = "data" property = "*"/>

<%
	int bad = Integer.parseInt(request.getParameter("bad"));
	String id = (String)session.getAttribute("memid");
	int num = Integer.parseInt(request.getParameter("num"));
	data.setId(id);
	data.setBad(bad);
	data.setNum(num);
	
	String pageNum = request.getParameter("pageNum");
	
	NewsDAO nDAO = NewsDAO.getInstance();
	nDAO.badinsert(id, data);
%>
--%>