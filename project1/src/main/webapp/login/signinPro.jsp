<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.LoginDAO" %>
<jsp:useBean id="dto" class="admin.LoginDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	LoginDAO dao = LoginDAO.getInstance();
	dto.setIp(request.getRemoteAddr());
	
	boolean check = dao.signIn(dto.getId(), dto.getPw());
	if(check) {
		session.setAttribute("sid", dto.getId());
		session.setAttribute("stype", dto.getType());%>
		<script>
			history.go(-1);
		</script>
<%	} else {%>
		<script>
			alert("아이디와 비밀번호를 확인해주세요");
			history.go(-1);
		</script>
<%	}%>
