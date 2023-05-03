<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>


<%
MemberDAO dao = MemberDAO.getInstance();
%>

<%--회사소개 페이지--%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<!DOCTYPE html>
<html lang="en">
<jsp:include page="/member/header.jsp"></jsp:include>
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
						href="/project1/member/user_myPage_form.jsp?pageType=2&id=<%=reporterList.get(z).getId()%>"><%=reporterList.get(z).getName()%></a>&nbsp;&nbsp;&nbsp;
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
<jsp:include page="/member/footer.jsp"></jsp:include>

</body>
</html>


