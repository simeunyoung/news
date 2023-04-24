<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"    pageEncoding="UTF-8"%>
 
<%request.setCharacterEncoding("UTF-8"); %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<style>
nav {
  background-color: #333; /* 네비게이션 바 배경색 */
  height: 60px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

nav ul {
  margin: 0;
  padding: 0;
  list-style: none; /* 목록 점 제거 */
}

nav li {
  float: left; /* 목록 항목을 좌측으로 정렬 */
  width: 150px;
  height:60px;
}

nav a {
  display: flex;
  color: #fff; /* 링크 텍스트 색상 */
  text-align: center;
  padding: 14px 16px; /* 링크 내부 여백 */
  text-decoration: none;
  height: 100%;
    box-sizing: border-box;
   
    align-items: center;
    justify-content: center;
}

nav a:hover {
  text-decoration:underline;
  color: #fff; /* 링크 텍스트 색상 변경 */
}

nav ul ul {
  display: none; /* 하위 메뉴 숨김 */
  position: absolute; /* 절대 위치 지정 */
  top:60px; /* 부모 요소 아래에 배치 */
  z-index:1;
}

nav ul li:hover > ul {
  display: inherit; /* 부모 항목에 마우스 오버 시 하위 메뉴 표시 */
}

nav ul ul li {
  float: none; /* 하위 메뉴를 좌측 정렬 */
  position: relative; /* 상대 위치 지정 */
  background:#111;
}

nav ul ul ul {
  position: absolute;
  left: 100%; /* 하위 하위 메뉴를 오른쪽으로 이동 */
  top:0;

}

.container{margin-top:20px;}
.main-breadcrumb{display:none;}

</style>
</head>
<%
	MemberDAO manager = MemberDAO.getInstance();
	String id = (String) session.getAttribute("memId");
	int check = manager.typeCheck(id);
%>
<body>
<nav>
	<a href="main.jsp">CODENEWS</a>
  <ul>
    <li><a href="#">회사소개</a>
      <ul>
        <li><a href="#">사이트 소개</a></li>
        <li><a href="#">팀원 소개</a></li>
      </ul>
    </li>
    <li><a href="#">뉴스</a>
      <ul>
      	<li><a href="#">전체</a></li>
        <li><a href="#">자바</a></li>
        <li><a href="#">파이썬</a></li>
        <li><a href="#">자바스크립트</a></li>
      </ul>
    </li>
    <li><a href="#">파트너십</a>
      <ul>
      	<li><a href="#">언론사리스트</a></li>
        <li><a href="#">기자리스트</a></li>
        <li><a href="#">제보하기</a></li>
      </ul>
    </li>
    <li><a href="#">고객센터</a>
      <ul>
      	<li><a href="#">Q&A</a></li>
        <li><a href="#">1:1문의하기</a></li>
        <li><a href="#">신고하기</a></li>
        <li><a href="#">기자신청</a></li>
      </ul>
    </li>
    <%if(check == 1){ %>
 	<li><a href="#">관리자</a>
      <ul>
      	<li><a href="#">1</a></li>
        <li><a href="#">2</a></li>
        <li><a href="#">3</a></li>
        <li><a href="#">4</a></li>
      </ul>
    </li>
    <%} %>
  </ul>
  <% if(id == null) {%>
  <div class="flex-wrap">
  	<div><a href="/project1/member/loginForm.jsp">로그인</a></div>
  	<div><a href="/project1/member/inputForm.jsp">회원가입</a></div>
  </div>
  <%}else{ %>
  <div class="flex-wrap">
 	<div><a href="/project1/member/user_mypage_form.jsp?id=<%=id%>">마이페이지</a></div>
  	<div><a href="/project1/member/logout.jsp">로그아웃</a></div>
  </div>
  <%} %>
</nav>

</body>
</html>