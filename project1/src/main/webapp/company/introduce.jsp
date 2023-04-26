<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>

<%
MemberDAO dao = MemberDAO.getInstance();
%>

<%--회사소개 페이지--%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>회사 이름 - 소개</title>
<link rel="stylesheet" href="style.css">
<link href="mypage.css" rel="stylesheet" type="text/css">
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
	<%
	String pageNum = request.getParameter("pageNum");
	if (pageNum == null) {
		pageNum = "0";
	}
	if (pageNum.equals("0")) {
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
	<%
	} else if (pageNum.equals("1")) {
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
	<%
	} else if (pageNum.equals("2")) {
	%>
	<main>
		<section id="intro">
			<h1>언론사/기자</h1>
			<style>
td {
	text-align: center;
}
</style>
			<table border="1">
				<tr>
					<td width=300px>언론사</td>
					<td width=800px>기자</td>
				</tr>

				<%
				TreeSet<String> pressList = dao.selectPress();
				Object[] pressArray = pressList.toArray();
				String element;
				String press;
				for (int i = 0; i < pressList.size(); i++) {
					press = (String) pressArray[i];
					element = press;
				%>
				<tr>
					<td><h1>
							<a href="pressPage.jsp?press=<%=element%>"><%=element.toUpperCase()%><br />
						</h1></td>
					<td>
						<%
						ArrayList<MemberDTO> reporterList = dao.selectReporter(press);
						for (int z = 0; z < reporterList.size(); z++) {
						%> <a
						href="/project1/member/journalist.jsp?id=<%=reporterList.get(z).getId()%>"><%=reporterList.get(z).getName()%></a>&nbsp;&nbsp;&nbsp;
						<%
						}
						%>
					</td>
				</tr>
				<%
				}
				%>
			</table>
	</main>
	<%
	}
	%>
	<footer>
		<p>Copyright &copy; 1조</p>
	</footer>

	<script src="script.js"></script>
</body>
</html>


