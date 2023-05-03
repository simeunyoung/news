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
<style>

</style>
</head>
<%
MemberDAO manager = MemberDAO.getInstance();
String id = (String) session.getAttribute("memId");
int check = manager.typeCheck(id);
%>
<body>
<header>
	<nav>
		<a href="/project1/news/main.jsp">CODENEWS</a>
		<ul>
			<li><a href="/project1/company/">회사소개</a>
				<ul>
					<li><a href="/project1/company/introduce.jsp">사이트 소개</a></li>
					<li><a href="/project1/company/introduce.jsp?pageNum=1">팀원
							소개</a></li>
				</ul></li>
			<li><a href="/project1/news/list.jsp">뉴스</a>
				<ul>
					<li><a href="/project1/news/list.jsp">전체</a></li>
					<li><a href="/project1/news/newstypelist.jsp?newstype=java">자바</a></li>
					<li><a href="/project1/news/newstypelist.jsp?newstype=Python">파이썬</a></li>
					<li><a
						href="/project1/news/newstypelist.jsp?newstype=JavaScript">자바스크립트</a></li>
				</ul></li>
			<li><a href="/project1/company/">파트너십</a>
				<ul>
					<li><a href="/project1/company/introduce.jsp?pageNum=2">언론사리스트/<br>기자리스트</a></li>
					<li><a href="/project1/admin/qnaList.jsp">제보하기</a></li>
				</ul></li>
			<li><a href="/project1/helper/svmain.jsp">고객센터</a>
				<ul>
					<li><a href="/project1/admin/faqList.jsp">FAQ</a></li>
					<li><a href="/project1/admin/qnaList.jsp">Q&A</a></li>
					<li><a href="/project1/admin/journalistForm.jsp">기자신청</a></li>
				</ul></li>
			<%
			if (check == 1) {
			%>
			<li><a href="#">관리자</a>
				<ul>
					<li><a href="#">1</a></li>
					<li><a href="#">2</a></li>
					<li><a href="#">3</a></li>
					<li><a href="#">4</a></li>
				</ul></li>
			<%
			}
			%>
		</ul>
		<%
		if (id == null) {
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
		} else {
		%>
		<div class="flex-wrap">
			<div>
				<a href="/project1/member/user_mypage_form.jsp?id=<%=id%>&pageType=1">마이페이지</a>
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
					<input type="search" name="search" class="search-input" /> <input
						type="submit" class="search-btn" />
				</div>
			</form>
			<!-- 날짜별검색 -->
			<form action="/project1/news/searchPro.jsp" method="get">
			<div class="input-row" id="date-search-form">
				<span class="title">조회기간</span>
				<div class="row-mobile">
					<div class="form-input-group">
						<input type="date" class="date" name="startDate" id="startDate" 
						value="<%= new java.text.SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date()) %>"
						 >
					</div>
					<span class="date-division">~</span>
					<div class="form-input-group">
						<input type="date" class="date" name="endDate" id="endDate" value="<%= java.time.LocalDate.now() %>" min="<%= java.time.LocalDate.now() %>">
					</div>
				</div>
				<div class="form-input-group radio-group">
					<div class="square-radio-group">
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
		
		  // 오늘 날짜를 구합니다.
		  var toDate = new Date();
		  // 오늘 이전 날짜를 선택하지 못하게 합니다.
		  var inputDate = document.getElementById('endDate');
		  inputDate.min = toDate.toISOString().split('T')[0];
		
	function changeSelection(){
		var selectedElement = document.getElementById("search-select");
	    
	    // 선택한 option의 value, 텍스트
	    var optionVal = selectedElement.options[selectedElement.selectedIndex].value;
	  	if(optionVal == "all"){
	  		document.getElementById("all-search").style.display ="block";
	  		document.getElementById("date-search-form").style.display ="none";
	  		
	  		
	  	}else if(optionVal == "date"){
	  		document.getElementById("date-search-form").style.display ="flex";
	  		document.getElementById("all-search").style.display ="none";
	  		
	  	}
	}
	function checkDate() {
		  var myDate = document.getElementById("startDate").value;
		  var minDate = document.getElementById("startDate").min;
		  
		  if (myDate < minDate) {
		    document.getElementById("startDate").value = minDate;
		  }
		}

	</script>
	</header>
</body>
</html>