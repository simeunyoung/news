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
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>CODENEWS</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<body>
<jsp:include page="/member/header.jsp" />
	
	<%
	String pageNum = request.getParameter("pageNum");		//pageNum 파라미터를 받음
	if (pageNum == null) {									//파라미터가 없으면 pageNum 변수에 0대입
		pageNum = "0";
	}
	if (pageNum.equals("0")) {								//pageNum이 0일 때 보여주는 페이지(사이트소개)
	%>
	<main class="page-wrap">
		<section id="intro">
			<h1>사이트소개</h1>
		</section>

		<section id="mission">
			<h2>(사진넣을 곳)</h2>
			<p>우리 사이트는 XXXX입니다.</p>
		</section>

	</main>
	<%
	} else if (pageNum.equals("1")) {						//pageNum이 1일 때 보여주는 페이지(팀원소개)
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
	} else if (pageNum.equals("2")) {						//pageNum이 2일 때 보여주는 페이지(언론사/기자리스트)
	%>
	<div class="page-wrap">
		<section id="intro">
			<h1>전체 목록</h1>
			<table>
				<tr>
					<th width=300px>언론사</th>
					<th width=800px>기자</th>
				</tr>

				<%	
				TreeSet<String> pressList = dao.selectPress();		//TreeSet타입으로 언론사이름 출력
				Object[] pressArray = pressList.toArray();			//배열로 변환
				String element;										
				String press;
				for (int i = 0; i < pressList.size(); i++) {		//언론사 수 만큼 반복
					press = (String) pressArray[i];					//Object 타입에서 String 타입으로 변환
					element = press;
				%>
				<tr>
					<td>											<%-- 언론사이름 대문자로 출력--%>
						<a href="pressPage.jsp?press=<%=element%>"><%=element.toUpperCase()%></a>		
					</td>
					<td>
						<%											 //기자이름 대문자로 출력
						ArrayList<MemberDTO> reporterList = dao.selectReporter(press);
						for (int z = 0; z < reporterList.size(); z++) {
						%> <a
						href="/project1/member/user_mypage_form.jsp?pageType=2&id=<%=reporterList.get(z).getId()%>"><%=reporterList.get(z).getName()%></a>&nbsp;&nbsp;&nbsp;
						<%
						}
						%>
					</td>
				</tr>
				<%
				}
				%>
			</table>
		</section>
	</div>
	<%
	}
	%>
<jsp:include page="/member/footer.jsp"></jsp:include>
</body>
</html>


