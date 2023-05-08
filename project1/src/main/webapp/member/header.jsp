<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<link href="/project1/resource/css/style.css" rel="stylesheet">

</head>
<%
	MemberDAO manager = MemberDAO.getInstance();
	String id = (String) session.getAttribute("memId");
	String num = request.getParameter("num");
	int check = manager.typeCheck(id); // 멤버 타입 체크 메서드
%>

<body>
	<header>
		<nav>
			<a href="/project1/news/main.jsp">CODENEWS</a>
			<ul>
				<li><a href="/project1/company/introduce.jsp">회사소개</a>
					<ul>
						<li><a href="/project1/company/introduce.jsp">사이트 소개</a></li>
						<li><a href="/project1/company/introduce.jsp?pageNum=1">팀원	소개</a></li>
					</ul>
				</li>
				<li><a href="/project1/news/list.jsp">뉴스</a>
					<ul>
						<li><a href="/project1/news/list.jsp">전체</a></li>
						<li><a href="/project1/news/newstypelist.jsp?newstype=java">자바</a></li>
						<li><a href="/project1/news/newstypelist.jsp?newstype=Python">파이썬</a></li>
						<li><a href="/project1/news/newstypelist.jsp?newstype=JavaScript">자바스크립트</a></li>
					</ul>
				</li>
				<li><a href="/project1/company/introduce.jsp?pageNum=2">파트너십</a>
					<ul>
						<li><a href="/project1/company/introduce.jsp?pageNum=2">언론사리스트/<br>기자리스트	</a></li>
						<!-- 비회원 진입시 로그인 창으로 이동 -->
						<%
							if (id != null) {
						%>
							<li><a href="/project1/company/pressForm.jsp">구독현황</a></li>
						<%
							} else {
						%>
							<li><a href="/project1/member/loginForm.jsp?loNum=1">구독현황</a></li>
						<%
							}
						%>
					</ul></li>
				<li><a href="/project1/helper/svmain.jsp">고객센터</a>
					<ul>
						<li><a href="/project1/admin/faqList.jsp">FAQ</a></li>
						<li><a href="/project1/admin/qnaList.jsp">Q&A</a></li>
						<li><a href="/project1/admin/journalistForm.jsp">기자신청</a></li>
						<li><a href="/project1/admin/qnaList.jsp">제보하기</a></li>
					</ul></li>
					
				<%
					if (check == 2) { // 멤버 타입이 관리자면
				%>
					<li><a href="/project1/admin/journalistList.jsp">기자신청 현황</a></li>
				<%
					}
				%>
			</ul>
			<%
				if (id == null) { // 비회원 일때
			%>
			<div class="flex-wrap">
			
				<div>
					<a href="/project1/member/loginForm.jsp">로그인</a>
				</div>
				<div>
					<a href="/project1/member/inputForm.jsp">회원가입</a>
				</div>
			</div>
			<%
				} else { // 회원일 때
			%>
			<div class="flex-wrap">
				<div>
					<a href="javascript:;"><%=id %> 님</a>
				</div>
				<div>
					<a
						href="/project1/member/user_mypage_form.jsp?id=<%=id%>&pageType=1">마이페이지</a>
				</div>
				<div>
					<a href="/project1/member/logout.jsp">로그아웃</a>
				</div>
			</div>
			<%
				}
			%>
		</nav>

		<div class="search-wrap">
			<!-- 검색 select -->
			<select id="search-select" onchange="changeSelection()">
				<option value="all">통합검색</option>
				<option value="date">날짜별</option>
			</select>

			<div class="search-form-wrap">
				<!-- 통합검색 -->
				<form action="/project1/news/searchPro.jsp" method="get">
					<div class="search-all-wrap" id="all-search">
						<input type="search" name="search" class="search-input" /> 
						<input type="submit" class="search-btn" />
					</div>
				</form>
				<!-- 날짜별검색 -->
				<form action="/project1/news/searchPro.jsp" method="get">
					<div class="input-row" id="date-search-form">
						<span class="title">조회기간</span>
						<div class="row-mobile">
							<div class="form-input-group">
								<input type="date" class="date" name="startDate" id="startDate"
									value="<%=new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date())%>">
							</div>
							<span class="date-division">~</span>
							<div class="form-input-group">
							<!-- 오늘날짜로 설정 -->
								<input type="date" class="date" name="endDate" id="endDate"
									value="<%=java.time.LocalDate.now()%>"	min="<%=java.time.LocalDate.now()%>"> 
							</div>
						</div>
						<div class="form-input-group radio-group">
							<div class="square-radio-group">
								<!-- date 파라미터 보냄 -->
								<a href="/project1/news/searchPro.jsp?date=today">오늘</a>
								<a href="/project1/news/searchPro.jsp?date=week">일주일</a> 
								<a href="/project1/news/searchPro.jsp?date=month">한달</a>
								<a href="/project1/news/searchPro.jsp?date=year">일년</a>
							</div>
						</div>
						<div class="submit-wrap">
							<input type="submit" class="search-btn">
						</div>
					</div>
				</form>
			</div>
		</div>
		<script>
			// 날짜 검색 
			// 오늘 날짜를 구합니다.
			var toDate = new Date();
			// 오늘 이전 날짜를 선택하지 못하게 합니다.
			var inputDate = document.getElementById('endDate');
			inputDate.min = toDate.toISOString().split('T')[0];

			
			// select 선택에 따라 보여주기
			function changeSelection() {
				var selectedElement = document.getElementById("search-select");

				// 선택한 option의 value, 텍스트
				var optionVal = selectedElement.options[selectedElement.selectedIndex].value;
				if (optionVal == "all") { // value가 all이면
					document.getElementById("all-search").style.display = "block";
					document.getElementById("date-search-form").style.display = "none";

				} else if (optionVal == "date") { // value가 date면
					document.getElementById("date-search-form").style.display = "flex";
					document.getElementById("all-search").style.display = "none";

				}
			}
			
			
// 			function checkDate() {
// 				var myDate = document.getElementById("startDate").value; //startDate의 value
// 				var minDate = document.getElementById("startDate").min; //startDate의 최소값

// 				if (myDate < minDate) { // 시작날짜가 시작날짜의 최소값보다 작으면 시작날짜를 최소값으로 설정
// 					document.getElementById("startDate").value = minDate;
// 				}
// 			}
		</script>
	</header>
</body>
</html>