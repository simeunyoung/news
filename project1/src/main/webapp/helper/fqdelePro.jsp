<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "helper.Svcenter1DAO"%>
<%@ page import = "java.sql.Timestamp"%>
<%request.setCharacterEncoding("UTF-8");%>
<%-- 자주묻는질문 글 삭제 --%>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	Svcenter1DAO svdao1 = Svcenter1DAO.getInstance();
	svdao1.deleteSvcenter1(num); 							//폼페이지에서 다시 한번 삭제를 눌렀을 때 해당 글번호를 받아와서 대입하고 삭제
	
	response.sendRedirect("svmain.jsp");					//삭제가 되었을 때 메인페이지로 이동
%>