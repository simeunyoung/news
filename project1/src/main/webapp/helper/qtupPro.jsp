<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.SvcenterDAO"%>
<%@ page import = "java.sql.Timestamp"%>
<% request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id = "svdto" scope = "page" class = "helper.SvcenterDTO">
	<jsp:setProperty name = "svdto" property = "*"/>
</jsp:useBean>

<%
	String pageNum = request.getParameter("pageNum");
	
	SvcenterDAO svdao = SvcenterDAO.getInstance();
	int check = svdao.updateSvcenter(svdto); 
	
	if(check == 1){%>
	<meta http-equiv="Refresh" content="0;url=svmain.jsp?pageNum=<%=pageNum%>">
<%}else{%>
	<script language = "JavaScript">
	<!-- 
		alert("비밀번호가 맞지 않습니다");
		history.go(-1);
	 -->
	</script>
<%}%>