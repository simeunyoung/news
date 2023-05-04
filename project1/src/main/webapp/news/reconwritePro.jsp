<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp"%>
<%@ page import = "news.NewsDAO"%>
<title>reconwritePro 페이지</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class="news.NewsDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	int num = Integer.parseInt(request.getParameter("contentpage"));
    dto.setReg(new Timestamp(System.currentTimeMillis())); //날짜 가져오기
	dto.setIp(request.getRemoteAddr()); // ip 가져오기
	String id = request.getParameter("id");
	String nick = request.getParameter("nick");
	dto.setId(id);
	dto.setNick(nick);
	
    NewsDAO news = NewsDAO.getInstance();
    news.insertRecon(dto);
    
    response.sendRedirect("content.jsp?num="+num);
%>
 <script language="JavaScript">      
             
         alert("댓글이 작성되었습니다.");       
 </script>
