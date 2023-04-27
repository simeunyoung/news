<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.NewsDAO" %>
<% request.setCharacterEncoding("UTF-8");%>
<title>댓글 변경 완료</title>
<jsp:useBean id="data" class="news.NewsDTO"/>
<jsp:setProperty name="data" property="*" />
<% 
int connum = Integer.parseInt(request.getParameter("connum"));
NewsDAO method = NewsDAO.getInstance();
method.reconupdate(data);

response.sendRedirect("content.jsp?num="+connum);
%>


