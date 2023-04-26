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
	list-style: none;
}

nav li {
	float: left;
	width: 150px;
	height: 60px;
}

nav a {
	display: flex;
	color: #fff;
	text-align: center;
	padding: 14px 16px; /* 링크 내부 여백 */
	text-decoration: none;
	height: 100%;
	box-sizing: border-box;
	align-items: center;
	justify-content: center;
}

nav a:hover {
	text-decoration: underline;
	color: #fff; /* 링크 텍스트 색상 변경 */
}

nav ul ul {
	display: none; /* 하위 메뉴 숨김 */
	position: absolute; /* 절대 위치 지정 */
	top: 60px; /* 부모 요소 아래에 배치 */
	z-index: 1;
}

nav ul li:hover>ul {
	display: inherit; /* 부모 항목에 마우스 오버 시 하위 메뉴 표시 */
}

nav ul ul li {
	float: none; /* 하위 메뉴를 좌측 정렬 */
	position: relative; /* 상대 위치 지정 */
	background: #111;
}

nav ul ul ul {
	position: absolute;
	left: 100%; /* 하위 하위 메뉴를 오른쪽으로 이동 */
	top: 0;
}

.container {
	margin-top: 20px;
}

.main-breadcrumb {
	display: none;
}

/* header */
.search-wrap {
	position: relative;
}

.search-input {
	width: 100%;
	height: 50px;
	font-size: 28px;
}

input[type="submit"].search-btn {
	background: url("/project1/resource/img/ico-search.png") no-repeat
		center/contain;
	width: 30px;
	height: 30px;
	position: absolute;
	top: 10px;
	right: 10px;
	padding: 0;
	border: 0;
	cursor: pointer;
	font-size: 0;
}
input[type="date"]{border:0;height:38px;}
input::-webkit-search-decoration, input::-webkit-search-cancel-button,
	input::-webkit-search-results-button, input::-webkit-search-results-decoration
	{
	display: none;
}
.input-row{
    display: flex;
   
    align-items: center;
    
    justify-content: flex-start;
    width: 100%;
    min-height: 38px;
}
.input-row .row-mobile{
    display: flex;
  
    align-items: center;
   
    justify-content: center;
}
.input-row .form-input-group{
    height: 38px;
    border: solid 1px #bcbfc7;
    border-radius: 4px;
    background: #ffffff;
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
  
    align-items: center;
    
    justify-content: space-between;
    position: relative;
}
.input-row .form-input-group .square-radio-group{
    display: flex;
    
    align-items: center;
    
    justify-content: center;
    height: 100%;
    border-radius: 0 4px 4px 0;
}
.input-row .form-input-group .square-radio-group [type="radio"] {
    display: none;
}
.input-row .form-input-group .square-radio-group [type="radio"] + label, .square-radio-group [type="radio"]+label {
    display: -webkit-box;
    display: -ms-flexbox;
    display: flex;
   
    align-items: center;
    
    justify-content: center;
    width: 70px;
    height: 100%;
    border: 1px solid #bcbfc7;
    margin-left: -1px;
    position: relative;
    z-index: 1;
    cursor: pointer;
}
.input-row .form-input-group .square-radio-group [type="radio"]:checked + label {
    z-index: 10;
    border: solid 1px #ec2741;
    margin-left: -1px;
    }
    .input-row .form-input-group .square-radio-group [type="radio"] + label:hover {
    background-color: rgba(242,152,134,0.5);
    border: solid 1px #ec2741;
    transition: 0.1s linear;
    z-index: 10;
    }
    #date-search-form{display:none;}
</style>
</head>
<%
MemberDAO manager = MemberDAO.getInstance();
String id = (String) session.getAttribute("memId");
int check = manager.typeCheck(id);
%>
<body>
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
					<li><a href="/project1/news/newstypelist.jsp?newstype=Java">자바</a></li>
					<li><a href="/project1/news/newstypelist.jsp?newstype=Python">파이썬</a></li>
					<li><a
						href="/project1/news/newstypelist.jsp?newstype=JavaScript">자바스크립트</a></li>
				</ul></li>
			<li><a href="/project1/company/">파트너십</a>
				<ul>
					<li><a href="/project1/company/pressPage.jsp">언론사리스트</a></li>
					<li><a href="/project1/company/introduce.jsp?pageNum=2">기자리스트</a></li>
					<li><a href="/project1/company/">제보하기</a></li>
				</ul></li>
			<li><a href="/project1/helper/svmain.jsp">고객센터</a>
				<ul>
					<li><a href="/project1/helper/qalist.jsp">Q&A</a></li>
					<li><a href="/project1/helper/questionForm.jsp">1:1문의하기</a></li>
					<li><a href="/project1/helper/">기자신청</a></li>
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
				<a href="/project1/member/user_mypage_form.jsp?id=<%=id%>">마이페이지</a>
			</div>
			<div>
				<a href="/project1/member/logout.jsp">로그아웃</a>
			</div>
		</div>
		<%
		}
		%>
	</nav>
	<script>
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
	document.getElementById('startDate').valueAsDate = new Date();
	</script>

	<select id="search-select" onchange="changeSelection()">
		<option value="all">통합검색</option>
		<option value="date">날짜별</option>
	</select>

	<div>
		<form action="/project1/news/searchPro.jsp" method="get">
			<div class="search-wrap" id="all-search">
				<input type="search" name="search" class="search-input" /> <input
					type="submit" class="search-btn" />
			</div>
		</form>
		<form action="/project1/news/searchPro.jsp" method="get">
		<div class="input-row" id="date-search-form">
			<span class="title">조회기간</span>
			<div class="row-mobile">
				<div class="form-input-group">
					<input type="date" name="startDate" id="startDate">
				</div>
				<span class="date-division">~</span>
				<div class="form-input-group">
					<input type="date" name="endDate" id="endDate">
				</div>
			</div>
			<div class="form-input-group radio-group">
				<div class="square-radio-group">
					<input type="radio" id="today" value="" name="radio-group"
						> <label class="first" for="today"><span>오늘</span></label>
					<input type="radio" id="7" value="" name="radio-group"> <label
						for="7"><span>7일</span></label> <input type="radio" id="30"
						value="" name="radio-group"> <label for="30"><span>30일</span></label>
					<input type="radio" id="90" value="" name="radio-group"> <label
						for="90"><span>90일</span></label> <input type="radio" id="180"
						value="" name="radio-group"> <label class="last" for="180"><span>180일</span></label>
				</div>
			</div>
			<input type="submit" value="검색">
		</div>
		</form>
	</div>
</body>
</html>