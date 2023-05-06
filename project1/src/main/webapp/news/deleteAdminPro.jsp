<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import ="news.NewsDAO" %>
<title>기사 삭제 진행</title>

<%
int num = Integer.parseInt(request.getParameter("num")); // num 파라미터를 int 타입으로 변경해서 가져오기


NewsDAO method = NewsDAO.getInstance();
method.deleteAdminNews(num); // num에 해당 하는 레코드를 메소드로 테이블 안에 있는 레코드 삭제


response.sendRedirect("list.jsp"); //sendRedirect를 사용하면 자동 새로고침과 Pro페이지에서 바로 설정한 location으로 이동

%>
