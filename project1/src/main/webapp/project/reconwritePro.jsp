<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp"%>
<%@ page import = "project.NewsDAO"%>
<title>reconwritePro 페이지</title>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="dto" class="project.NewsDTO" />
<jsp:setProperty property="*" name="dto" />

<%

    dto.setReg(new Timestamp(System.currentTimeMillis())); //날짜 가져오기
	dto.setIp(request.getRemoteAddr()); // ip 가져오기
	String id = request.getParameter("id");
	dto.setId(id); // 작성자 : 아이디로 가져오기

    NewsDAO news = NewsDAO.getInstance();
    news.insertRecon(dto);
  
%>
 <script language="JavaScript">      
             
         alert("댓글이 작성되었습니다.");
         history.go(-1);
       
 </script>
 <meta http-equiv="Refresh" >