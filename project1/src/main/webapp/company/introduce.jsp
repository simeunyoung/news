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
			<h1><font size = "50">사이트소개</font></h1>
		</section><br /><br /><br /><br /><br />

		<section id="mission">
			<p><font size = "5"> &nbsp; 저희 팀은 뉴스 웹사이트를 만들어보았습니다. 우리 팀은 신문사 웹사이트를 모티브로 하여,<br /> 뉴스 기사를 작성하고 관리할 수 있는 기능과 함께 다양한 카테고리와 태그를 제공하여 쉽게<br /> 원하는 뉴스를 찾을 수 있도록 구성하였습니다.<br />

또한, 구독 기능을 제공하여 사용자들이 원하는 카테고리의 뉴스를 손쉽게 받아볼 수 있도록 하였으며,<br />검색 기능을 통해 빠르고 정확하게 원하는 뉴스를 검색할 수 있도록 구현하였습니다. <br />
우리 팀은 뉴스 웹사이트를 개발하며 다양한 기술들을 배우고 적용해보았습니다. <br />이를 통해 팀원들 간의 협업 능력을 향상시키고, 실제 개발 프로젝트에서 <br />필요한 기술과 역량을 키울 수 있었습니다.</font></p>
		</section>

	</main>
	<%
	} else if (pageNum.equals("1")) {						//pageNum이 1일 때 보여주는 페이지(팀원소개)
	%>
	<main>
		
		<section id="intro">
			<h1><font size = "50">팀원소개</font></h1>
			<img src="/project1/resource/img/1212.png" width="1000" height="800">
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


