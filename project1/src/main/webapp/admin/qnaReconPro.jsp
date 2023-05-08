<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%request.setCharacterEncoding("UTF-8");%>

<jsp:useBean id="dto" class="admin.AdminDTO" />
<jsp:setProperty property="*" name="dto" />

<%
	dto.setIp(request.getRemoteAddr());
	String num = request.getParameter("num2");
	String pageNum = request.getParameter("pageNum");
	AdminDAO dao = AdminDAO.getInstance();
	int result = dao.qnaReconInsert(dto);
%>
	<%if(result == 1) {%>
	<script>
		alert("작성되었습니다");
		window.location.href ="/project1/admin/qnaContent.jsp?num=<%=dto.getNum2()%>&pageNum=<%=pageNum%>";
	</script>
	<%} else {%>
	<script>
		alert("오류발생");
		window.location.href ="/project1/admin/qnaContent.jsp?num=<%=dto.getNum2()%>&pageNum=<%=pageNum%>";
	</script>
	<%}%>