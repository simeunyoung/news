<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "news.RatingDAO"%>
<%request.setCharacterEncoding("UTF-8");%>
<%-- 기사 좋아요 버튼 눌렀을 때 오는 페이지 --%>
 
<jsp:useBean id = "rDTO" class = "news.RatingDTO"/>
<jsp:setProperty name = "rDTO" property = "*"/>

<%
	String id = (String)session.getAttribute("memId");
	int num = Integer.parseInt(request.getParameter("num"));
	
	RatingDAO rDAO = RatingDAO.getInstance();
	int chack = rDAO.goodinsert(id,num,rDTO);   
	
	if(chack == 1){%>
		<meta http-equiv="Refresh" content="0;url=content.jsp?num=<%=num%>">
<%}else{%>
		<script language = "JavaScript">
			alert("한번만 평가 하실 수 있습니다");
			history.go(-1);
		</script>
<%}%>
