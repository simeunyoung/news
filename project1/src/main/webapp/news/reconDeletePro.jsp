<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.NewsDAO" %>
<title>댓글 삭제</title>

<% int num = Integer.parseInt(request.getParameter("num")); // num 파라미터 int로 가져오기. 이 num의 경우 댓글 num 파라미터 값이다.
NewsDAO method = NewsDAO.getInstance();
method.deleteRecon(num); //해당 Pro 페이지를 오기 전에 세션과 작성자가 일치할 때만 버튼이 보이기 때문에 num의 파라미터만 가져온다.
int connum = Integer.parseInt(request.getParameter("connum")); // 게시글 파라미터 값 가져오기

response.sendRedirect("content.jsp?num="+connum); // 게시글 파라미터를 이용해서 해당 content로 이동
%>
<script>
alert("댓글이 삭제되었습니다.")
</script>