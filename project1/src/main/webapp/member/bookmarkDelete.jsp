<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	MemberDAO dao = MemberDAO.getInstance();
	String id = (String) session.getAttribute("memId");
	String id2 = request.getParameter("id2");
	String books = request.getParameter("books");%> 
	<%=books%>
	<%if(books == null){
		books ="";
	}
	dao.bookMarkDelete(id, id2, books);
	response.sendRedirect("user_mypage_form.jsp?id="+id2+"&pageType=2");
%>
