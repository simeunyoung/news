<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.MemberDAO"%>

<%
	MemberDAO dao = MemberDAO.getInstance();
	String id = (String) session.getAttribute("memId");
	String id2 = request.getParameter("id2");
	String books = request.getParameter("books");%> 
	<%=books%>
	<%if(books == null){
		books ="";
	}
	dao.bookMarkInsert(id, id2, books);
%>

