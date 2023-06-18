<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "news.RatingDAO"%>
<%@ page import = "news.RatingDTO"%>
<%request.setCharacterEncoding("UTF-8");%>
<%-- 기사 좋아요 버튼 눌렀을 때 오는 페이지 --%>
<jsp:useBean id = "dto" class = "news.RatingDTO"/>
<jsp:setProperty name = "dto" property = "*"/>

<%
	
	String id = (String) session.getAttribute("memId");
	int num = Integer.parseInt(request.getParameter("num"));
	
	RatingDAO dao = RatingDAO.getInstance();
	int chack = dao.goodinsert(id,num,dto);
	
	if(chack == 1){%>
		<meta http-equiv="Refresh" content="0;url=content.jsp?num=<%=num%>">
<%}else{%>
	<script language = "JavaScript">
		alert("평가가 취소되었습니다");		
	</script>
<% response.sendRedirect("content.jsp?num="+num+"");}%>