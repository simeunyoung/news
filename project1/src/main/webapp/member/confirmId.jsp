<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 중복확인</title>
<link href="/project1/resource/css/style.css" rel="stylesheet"/>
</head>
<%	
	// 인코딩 방식 utf-8로 지정
	request.setCharacterEncoding("utf-8"); 

	String id = request.getParameter("id");
	MemberDAO manager = MemberDAO.getInstance();
	int check = manager.confirmId(id);

%>

<body>
<% if(check == 1) {%>
	<div>
		<p><%=id%> 이미 사용중인 아이디입니다.</p>
		<form action="confirmId.jsp" method="post" name="checkForm">
			<p>다른 아이디를 선택하세요.</p>
			<input type="text" name="id"> <input type="submit" value="아이디 중복확인" />
		</form>
	</div>
	<% } else { %>
	<div>
		<p> 입력하신 <%=id %>는 사용 가능한 아이디입니다.</p>
		<input type="button" value="닫기" onclick="setId()"/>
	</div>
<% } %>
</body>
<script>
	function setId(){
		// opener : 새 창의 부모페이지 (기존 페이지:inputform.jsp)
		opener.document.userinput.id.value="<%=id%>";
		self.close();
	}
</script>
</html>