<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="admin.AdminDAO"%>

<%
	// 글을 특정하기 위해 num과 pageNum을 받아옴(pageNum 꼭 필요한것인지?) 
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	
	AdminDAO dao = AdminDAO.getInstance(); // dao를 불러옴
	AdminDTO dto = dao.faqGet(num); // num으로 faq정보를 불러옴
	
	int result = dao.faqDelete(dto); // dto에 있는 num 정보로 faq를 삭제 정상삭제의 경우 1이 return됨
	if(result == 1) {%>
		<script>
			alert("삭제되었습니다");
			window.location.href = "/project1/admin/faqList.jsp";
		</script>
	<%} else {%>
		<script>
			alert("오류발생");
			history.go(-1);
		</script>
	<%}%>