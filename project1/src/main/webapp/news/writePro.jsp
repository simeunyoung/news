<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import = "java.sql.Timestamp"%>
<%@ page import = "news.NewsDAO"%>

<%request.setCharacterEncoding("UTF-8"); %>
<title>WritePro 페이지</title>

<jsp:useBean id="dto" class="news.NewsDTO" />
<jsp:setProperty property="*" name="dto" />

<%
// useBean과 setProperty를 사용해서 form문에서 가져온 값들을 전부 저장한다.
    dto.setReg(new Timestamp(System.currentTimeMillis())); //날짜 가져오기
	dto.setIp(request.getRemoteAddr()); // ip 가져오기
	
	String id = (String)session.getAttribute("memId");
	dto.setId(id); // 아이디를 직접 가져오기
	String nick = request.getParameter("nick");
	dto.setNick(nick); // 닉을 직접 가져오기

    NewsDAO news = NewsDAO.getInstance();
    news.insert(dto); // form문에서 전달받은 값들을 insert 메소드에 전달하여 레코드를 추가한다.
    response.sendRedirect("list.jsp"); // 작성 후 이동할 경로 및 이동시 새로고침한 상태로 이동할 수 있게 sendRedirect를 사용해준다.
%>














