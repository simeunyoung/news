<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="news.NewsDAO" %>
<title>��� ���� ����</title>

<%
int num = Integer.parseInt(request.getParameter("num")); // num �Ķ���͸� int Ÿ������ �����ؼ� ��������


NewsDAO method = NewsDAO.getInstance();
method.deleteAdminNews(num); // num�� �ش� �ϴ� ���ڵ带 �޼ҵ�� ���̺� �ȿ� �ִ� ���ڵ� ����


response.sendRedirect("list.jsp"); //sendRedirect�� ����ϸ� �ڵ� ���ΰ�ħ�� Pro���������� �ٷ� ������ location���� �̵�

%>
