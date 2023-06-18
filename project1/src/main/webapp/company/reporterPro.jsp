<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="java.util.*"%>
<% MemberDAO dao = MemberDAO.getInstance();%>
<% String id = request.getParameter("id");%>
<% ArrayList<MemberDTO> list = dao.memForType("-1");%>		<%-- list = 전체기자의 DTO목록--%>
<% int size = list.size();%>								<%-- 전체기자수 --%>
<% StringBuilder sb = new StringBuilder(); %>				<%-- 전체기자 수 만큼 반복해서 파라미터값 sb에 추가--%>
<%for (int i = 0; i <= size+1; i++) {						
  if (request.getParameter(Integer.toString(i)) != null) {
    sb.append("@" + request.getParameter(Integer.toString(i)));
  }
}
String result = sb.toString();%>
<% dao.RSubscribe(id, result);%>					<%-- id에 구독전체목록 추가--%>
		<script>
			alert("구독완료");			
			location.replace("/project1/company/pressForm.jsp?id=<%=id %>");
		</script>




