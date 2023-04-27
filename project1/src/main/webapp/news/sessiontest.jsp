<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>

<%
String loginuser = (String)session.getAttribute("memId");
MemberDAO memdao = MemberDAO.getInstance();
MemberDTO usertype = memdao.getmember(loginuser);
%> 

<%=usertype.getMemberType()%>
<%=usertype.getNick()%>
<%=usertype.getName()%>