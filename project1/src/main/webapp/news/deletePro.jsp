<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="news.NewsDAO" %>
<title>기사 삭제 진행</title>

<%
int num = Integer.parseInt(request.getParameter("num")); // num 파라미터를 String에서 int 타입으로 변환 후 가져오기 
String pw = request.getParameter("pw"); // Form 페이지에서 넣은 pw 파라미터 가져오기

NewsDAO method = NewsDAO.getInstance();
int formcheck = method.deleteNews(num,pw); // Form에서 가져온 파라미터를 deleteNews()메소드에 적용

if(formcheck == 1) { // 메소드가 정상적으로 작동 할 때 값이 1로 되는데 해당 변수가 1일 때는 설정한 위치로 이동
response.sendRedirect("list.jsp");
} else {// 아닐 때는 스크립트로 비밀번호가 틀렸다고 알려주고 뒤로가기
%> 
<script>       
alert("비밀번호가 맞지 않습니다");
history.go(-1);
</script>
<%}%>