<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="news.NewsDAO" %>
<title>��� ���� ����</title>

<%
int num = Integer.parseInt(request.getParameter("num"));


NewsDAO method = NewsDAO.getInstance();
method.deleteAdminNews(num);


response.sendRedirect("list.jsp");
%>
