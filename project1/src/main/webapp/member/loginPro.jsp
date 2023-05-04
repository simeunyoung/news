<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String auto = request.getParameter("auto");
	String loNum = request.getParameter("loNum");

	
	Cookie [] cookies = request.getCookies();
	for(Cookie c : cookies){
		if(c.getName().equals("cooId")){id = c.getValue();}
		if(c.getName().equals("cooPw")){pw = c.getValue();}
		if(c.getName().equals("cooAu")){auto = c.getValue();}
	}
	
	MemberDAO manager = MemberDAO.getInstance();
	int check = manager.userCheck(id,pw);
	
	if(check == 1){
		session.setAttribute("memId", id);
		if(auto != null){
			Cookie coo1 = new Cookie("cooId", id);
			Cookie coo2 = new Cookie("cooPw", pw);
			Cookie coo3 = new Cookie("cooAuto", auto);
			coo1.setMaxAge(60*60*24);
			coo2.setMaxAge(60*60*24);
			coo3.setMaxAge(60*60*24);
			response.addCookie(coo1);
			response.addCookie(coo2);
			response.addCookie(coo3);
		}
		
		if(loNum.equals("null")){
			response.sendRedirect("/project1/news/main.jsp");
		}else{
			response.sendRedirect("/project1/company/pressForm.jsp"); 
		}
	} else if(check == 0){ %>
		<script>
			alert("비밀번호가 맞지 않습니다.");
			history.go(-1);
		</script>
	<%}else {%>
		<script>
			alert("아이디가가 맞지 않습니다.");
			history.go(-1);
		</script>
	<%}%>
	<%=loNum%>