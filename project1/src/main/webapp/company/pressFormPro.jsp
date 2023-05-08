<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO"%>
<% MemberDAO dao = MemberDAO.getInstance();%>
<% String id = request.getParameter("id");%>
<% int size = request.getParameterMap().size()-1;%>				<%-- size = 받은파라미터의 개수에서 -1 한값 --%>
<% StringBuilder sb = new StringBuilder(); %>				
<%for (int i = 0; i <= size; i++) {								//1=aaa 이런식으로 파라미터값오면
  if (request.getParameter(Integer.toString(i)) != null) {		//차례대로 sb(StringBuilder)에 @넣어서 추가
    sb.append("@" + request.getParameter(Integer.toString(i)));
  }
}
String result = sb.toString();%> 	<%-- StringBuilder -> String 타입으로 변환 후 session 에 맞는 id값 넣기--%>
<% dao.PSubscribe(id, result);%>
		<script>
			alert("구독완료");
			location.replace("/project1/company/pressForm.jsp?id=<%=id%>");		<%-- 원래 페이지로 이동--%>
		</script>



<!DOCTYPE html>
<html>
<head>

<title>Insert title here</title>
</head>
<body>

</body>
</html>