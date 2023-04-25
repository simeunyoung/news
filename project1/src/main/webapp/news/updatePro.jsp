<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "news.NewsDAO" %>
<%@ page import = "java.sql.Timestamp" %>

<% 
 request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="text" scope="page" class="news.NewsDTO" />
   <jsp:setProperty name="text" property="*"/>
<%
	
	NewsDAO method = NewsDAO.getInstance();
    int updateClear = method.update(text);
	
    
if(updateClear == 1){
	  response.sendRedirect("list.jsp");
	  
}else{%>
      <script language="JavaScript">          
        alert("비밀번호를 틀리셨습니다.");//
        history.go(-1);
     </script>
<%}%>      