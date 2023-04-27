<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.GijaDAO"%>
<%request.setCharacterEncoding("UTF-8");%>
<%-- 신청받은 것을 임시테이블에 저장 후 게시판으로 이동을 해야하는데 아직 미완성 --%>

<jsp:useBean id = "gdto" scope = "page" class = "helper.GijaDTO">
	<jsp:setProperty name = "gdto" property = "*"/>
</jsp:useBean>

<%		
	String id = (String)session.getAttribute("memId");
	gdto.setId(id);

	GijaDAO gdao = GijaDAO.getInstance();
	gdao.insertGija(id, gdto); 
	
	response.sendRedirect("gijaapList.jsp");
%>