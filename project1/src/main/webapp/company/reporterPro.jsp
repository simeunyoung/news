<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="java.util.*"%>
<% MemberDAO dao = MemberDAO.getInstance();%>
<% String id = request.getParameter("id");%>
<% ArrayList<MemberDTO> list = dao.memForType("-1");%>
<% int size = list.size();%>
<% StringBuilder sb = new StringBuilder(); %>
<%for (int i = 0; i <= size+1; i++) {
  if (request.getParameter(Integer.toString(i)) != null) {
    sb.append("@" + request.getParameter(Integer.toString(i)));
  }
}
String result = sb.toString();%>
<% dao.RSubscribe(id, result);%>
		<script>
			alert("구독완료");
			location.replace("/project1/company/pressForm.jsp?id=<%=id %>");
		</script>




