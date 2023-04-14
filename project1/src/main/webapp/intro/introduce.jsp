<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*" %>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberDTO" %>

<% MemberDAO dao = MemberDAO.getInstance(); %>

<%--회사소개 페이지--%>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>회사 이름 - 소개</title>
	<link rel="stylesheet" href="style.css">
</head>
<body>
	<header>
		<nav>
			<ul>
				<li><a href="main.jsp">홈</a></li>&nbsp;
				<li><a href="introduce.jsp">사이트소개</a></li>&nbsp;
				<li><a href="introduce.jsp?pageNum=1">팀원소개</a></li>&nbsp;
				<li><a href="introduce.jsp?pageNum=2">언론사/기자</a></li>
				<li><a href="#">고객센터</a></li>
			</ul>
		</nav>
	</header>
	<%	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "0";
	}
	if(pageNum.equals("0")){
	%>
	<main>
		<section id="intro">
			<h1>사이트소개</h1>
		</section>
		
		<section id="mission">
			<h2>(사진넣을 곳)</h2>
			<p>우리 사이트는 XXXX입니다.</p>
		</section>

	</main>
	<% }
	else if(pageNum.equals("1")){
	%>
	<main>
		<section id="intro">
			<h1>팀원소개</h1>
			<p>우리 회사는 XXXX을(를) 제공하는 회사입니다.</p>
		</section>

		<section id="mission">
			<h2>미션</h2>
			<p>우리 회사의 미션은 XXXX입니다.</p>
		</section>

		<section id="vision">
			<h2>비전</h2>
			<p>우리 회사의 비전은 XXXX입니다.</p>
		</section>

		<section id="values">
			<h2>가치</h2>
			<ul>
				<li>가치1</li>
				<li>가치2</li>
				<li>가치3</li>
			</ul>
		</section>

		<section id="team">
			<h2>팀 소개</h2>
			<p>우리 회사의 팀은 XXXX로 구성되어 있습니다.</p>
		</section>  
	</main>
	<% }
	else if(pageNum.equals("2")){
	%>
	<main>
		<section id="intro">
			<h1>언론사/기자</h1>
			<style>
  			td {
   			text-align: center;
  			}
			</style>
			<table border ="1">
			<tr><td width = 300px>언론사</td><td width = 800px>기자</td></tr>
			<tr><td><h1>AAA</h1></td><td>
			<%ArrayList<MemberDTO> pressList = dao.select()%>
			
			
			<%for(int i = 0; i < pressList.size ; i++ ){ %>
			<%ArrayList<MemberDTO> list = dao.pressReporter("aaa");%>
			<a href="journalist_mypage_form.jsp?id=gija">gi 기자</a>&nbsp;&nbsp;&nbsp;
			<a href="journalist_mypage_form.jsp?id=gija1">gi1 기자</a>&nbsp;&nbsp;&nbsp;
			<a href="journalist_mypage_form.jsp?id=gija2">gi2 기자</a>&nbsp;&nbsp;&nbsp;
			<a href="journalist_mypage_form.jsp?id=gija3">gi3 기자</a>&nbsp;&nbsp;&nbsp;</td></tr>
			<tr><td><h1>BBB</h1></td><td>
			<%ArrayList<MemberDTO> list1 = dao.pressReporter("bbb");%>
			<a href="journalist_mypage_form.jsp?id=gija4">gi4 기자</a>&nbsp;&nbsp;&nbsp;
			<a href="journalist_mypage_form.jsp?id=gija5">gi5 기자</a>&nbsp;&nbsp;&nbsp;
			<a href="journalist_mypage_form.jsp?id=gija6">gi6 기자</a>&nbsp;&nbsp;&nbsp;</td></tr>
			<tr><td><h1>CCC</h1></td><td>
			<%ArrayList<MemberDTO> list2 = dao.pressReporter("ccc");%>
			<a href="journalist_mypage_form.jsp?id=gija7">gi7 기자</a>&nbsp;&nbsp;&nbsp;
			<a href="journalist_mypage_form.jsp?id=gija8">gi8 기자</a>&nbsp;&nbsp;&nbsp;
			<a href="journalist_mypage_form.jsp?id=gija9">gi9 기자</a>&nbsp;&nbsp;&nbsp;</td></tr>
			<tr><td><h1>DDD</h1></td><td>
			<%ArrayList<MemberDTO> list3 = dao.pressReporter("ddd");%>
			<a href="journalist_mypage_form.jsp?id=gija7">gi7 기자</a>&nbsp;&nbsp;&nbsp;
			<a href="journalist_mypage_form.jsp?id=gija8">gi8 기자</a>&nbsp;&nbsp;&nbsp;
			<a href="journalist_mypage_form.jsp?id=gija9">gi9 기자</a>&nbsp;&nbsp;&nbsp;</td></tr>
			<%} %>
			</table>

			<%=list.get(0).getId()%>
			
			
			
			
	</main>
	<% }%>
	<footer>
		<p>Copyright &copy; 1조</p>
	</footer>

	<script src="script.js"></script>
</body>
</html>


