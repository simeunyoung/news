<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "news.NewsDAO" %>
<%@ page import = "java.sql.Timestamp" %>

<% 
 request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="text" scope="page" class="news.NewsDTO" />
   <jsp:setProperty name="text" property="*"/>
<%
	// form문에서 전달한 값을 useBean과 setProperty로 받아낸 뒤 update메소드에 값들을 넣어 레코드 값들을 바꿔준다.
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