<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp"%>
<%@ page import = "project.NewsDAO"%>

<title>WritePro 페이지</title>

<jsp:useBean id="dto" class="project.NewsDTO" />
<jsp:setProperty property="*" name="dto" />

<%
    dto.setReg(new Timestamp(System.currentTimeMillis())); //날짜 가져오기
	dto.setIp(request.getRemoteAddr()); // ip 가져오기
	
	String id = request.getParameter("id");
	dto.setId(id); // 작성자 : 아이디로 가져오기

    NewsDAO news = NewsDAO.getInstance();
    news.insert(dto);
%>

<%--
<div class="box">

글 작성 완료
</div>


<style>
.box {
background-color: #ffffff;
border: 1px solid #ddd;
}
</style> --%>














