<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "news.NewsDAO"%>

<%
NewsDAO newsdao = NewsDAO.getInstance();
int num = Integer.parseInt(request.getParameter("num"));
String news_scrap = request.getParameter("news_scrap");
String loginuser = (String)session.getAttribute("memId");

newsdao.unsave_news(news_scrap, num, loginuser);
%>
<script>
//해당 뉴스 페이지로 이동 이때 num, 스크랩 정보를 전달
location.replace("/project1/news/content.jsp?&num=<%=num%>&news_scrap=<%=news_scrap%>");
</script>