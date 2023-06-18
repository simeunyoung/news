<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%request.setCharacterEncoding("UTF-8");%><!-- 한글이 깨지지않도록 인코딩을 지정해줌 -->

<jsp:useBean id="dto" class="admin.AdminDTO" /> <!-- dto위치지정 및 객체생성 -->
<jsp:setProperty property="*" name="dto" /> <!-- dto 객체에 전달받은 파라미터를 set -->

<%
	dto.setIp(request.getRemoteAddr()); // dto에 아이피 set

	AdminDAO dao = AdminDAO.getInstance(); // dao 객체 불러옴
	dao.faqInsert(dto); // dto를 토대로 db에 입력
	response.sendRedirect("faqList.jsp"); // 리스트로 다시보냄
%>