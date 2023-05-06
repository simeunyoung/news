<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.NewsDAO" %>
<% request.setCharacterEncoding("UTF-8");%>
<title>댓글 변경 완료</title>
<jsp:useBean id="data" class="news.NewsDTO"/>
<jsp:setProperty name="data" property="*" />
<% 
int connum = Integer.parseInt(request.getParameter("connum")); // 게시글 파라미터 값
NewsDAO method = NewsDAO.getInstance();
method.reconupdate(data); // usebean과 setProperty를 사용해서 가져온 값을 전부 reconupdate 메소드에 넣는다.

response.sendRedirect("content.jsp?num="+connum);
%>


