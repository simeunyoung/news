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
	int check = manager.userCheck(id,pw); // 로그인 아이디,비밀번호 체크
	
	if(check == 1){
		session.setAttribute("memId", id);
		%>
		<%=auto %><%
		if(auto != null){
			Cookie coo1 = new Cookie("cooId", id);
			Cookie coo2 = new Cookie("cooPw", pw);
			Cookie coo3 = new Cookie("cooAu", auto);
			coo1.setMaxAge(60*60*24);
			coo1.setPath("/");
			coo2.setMaxAge(60*60*24);
			coo2.setPath("/");
			coo3.setMaxAge(60*60*24);
			coo3.setPath("/");
			response.addCookie(coo1);
			response.addCookie(coo2);
			response.addCookie(coo3);
		}
		


		if(loNum == "1"){
			response.sendRedirect("/project1/company/pressForm.jsp");
			// 구독현황에서 넘어왔으면 구독현황 페이지로 보내주기
		}else{
			 response.sendRedirect("/project1/news/main.jsp");

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