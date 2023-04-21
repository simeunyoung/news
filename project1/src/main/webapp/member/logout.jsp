<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<title>로그아웃</title>

<%
	Cookie [] cookies = request.getCookies();
	for(Cookie c : cookies){
		if(c.getName().equals("cooId")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
		if(c.getName().equals("cooPw")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
		if(c.getName().equals("cooAu")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
	}
	session.invalidate();
	response.sendRedirect("/project1/profile/main.jsp");
%>