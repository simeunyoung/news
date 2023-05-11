<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="news.RatingDAO"%>
<%@ page import="news.RatingDTO"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/dbaea98925.js" crossorigin="anonymous"></script>
<script src="/project1/resource/js/script.js"></script>

<jsp:include page="/member/header.jsp"></jsp:include>
<jsp:useBean id="dto" class="member.MemberDTO" />

<title>CODENEWS</title>
<%
String loginuser = (String) session.getAttribute("memId"); //loginPro에서 생성된 세션을 가져오기

request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num")); //list에서 파라미터 값으로 게시글 보게 설정하기
String currentPage = request.getParameter("currentPage"); // 현재 페이지 정보를 저장하기 위해 변수 선언

NewsDAO method = NewsDAO.getInstance();
NewsDTO text = method.getCon(num); // num이라는 파라미터를 가지고 있는 레코드를 가져오는 메소드

String title = text.getTitle(); // 변수 선언
String con = text.getCon(); // 변수 선언
String news_scrap = method.newsscrap(loginuser); // 현재 로그인한 사용자의 스크랩한 뉴스목록을 가져와 변수에 저장

RatingDAO rDAO = RatingDAO.getInstance();
RatingDTO rDTO = rDAO.getRatingDTO(num); //기사평점 테이블의 good과 bad 그리고 total의 값을 각각 합쳐서 값을 꺼내옴

// 사용자가 현재 뉴스를 스크랩한것인지 확인하는 코드
// 스크랩이 null인경우 ""로 초기화
// 초기화 시킨 이유는 split()을 사용할때 null인 경우에 NullPointerException이 발생함 때문에 초기화 시켜줌
if (news_scrap == null) {
	news_scrap = "";
}
// @기준으로 스크랩한 뉴스 목록에서 하나의 뉴스를 구분하기 위해 @ 기준으로 분할하여 저장
String[] parts = news_scrap.split("@");
// parts배열의 요소인 part를 현재 뉴스 num과 비교 만약 num이 news_scrap에 포함 되어있으면 true를 반환
boolean include = false;
for (String part : parts) {
	if (part.equals(Integer.toString(num))) {
		include = true;
		break;
	}
}

String usertype = null;
MemberDTO userinfo = null;

String admin = "2";
String normaluser = "1";
String writer = "-1";

if (loginuser != null) { //로그인을 했을 때
	MemberDAO memdao = MemberDAO.getInstance();
	userinfo = memdao.getmember(loginuser); // 세션을 통해서 member 테이블의 데이터를 가져온다.
	usertype = userinfo.getMemberType(); // 가져온 데이터 중에 맴버의 종류를 변수로 선언
}
// 싫어요가 30개 이상일 때
if (rDTO.getBad() >= 30 && session.getAttribute("memId") == null) {
%>
<script type="text/javascript">
	alert("해당 게시글은 많은 이용자에 의해 블라인드 처리된 게시글 입니다.");
	history.go(-1);
</script>
<%
} else if (rDTO.getBad() >= 30 && (usertype.equals(normaluser) || usertype.equals(writer))) {
%>
<script type="text/javascript">
	alert("해당 게시글은 많은 이용자에 의해 블라인드 처리된 게시글 입니다.");
	history.go(-1);
</script>
<%
} else {
%>
<div class="page-wrap content">
	<div class="content-box">
		<div class="cont-top">
			<div class="cont-top-left"><%=text.getPress()%></div>
			<div class="cont-top-center"><%=text.getNewstype()%></div>
			<div class="cont-top-right"><i class="fa-solid fa-eye" style="color: #bfbfbf;"></i> <%=text.getViews()%></div>
		</div>
		<div class="cont-title"><%=text.getTitle()%></div>
		<div class="cont-mid">
			<div class="cont-mid-left">
				<div class="cont-mid-press"><i class="fa-regular fa-user" style="color: #bdbdbd;"></i> <%=text.getNick()%>
					<!-- 				<b>작성자 : </b><a -->
					<%-- 					href="/project1/member/user_mypage_form.jsp?id=<%=text.getId()%>&pageType=2"><%=text.getNick()%></a> --%>
				</div>
				| <div class="cont-mid-date">
					 <i class="fa-regular fa-clock" style="color: #bdbdbd;"></i> 
					 입력 : <%=text.getReg()%></div>
			</div>
			<div class="cont-right-wrap">
				<%-- 버튼을 누르면 url복사 가능 --%>
				<button id="copyButton"><i class="fa-solid fa-share-from-square fa-lg" style="color: #fff;"></i></button>
			
				<div class="book-btn">
					<%
					// include가 flase인 경우 스크랩되지 않은 뉴스이기때문에 스크랩하기 버튼 활성화
					if (!include) {
						// 세션이 없다면 버튼을 클릭했을때 메세지 창을 띄움
						if (session.getAttribute("memId") == null) {
					%>
					<button onclick="alert('로그인 후 사용 가능합니다.');"><i class="fa-regular fa-star fa-xl" style="color: #fff;"></i></button>
					<%
					// 로그인이 되었을때 스크랩 가능
					} else {
					%>
					<%-- 버튼을 누르면 메시지 출력 및 news_scrap.jsp로 이동, 각 3개의 파라미터를 함께 전달 --%>
					<button
						onclick="alert('스크랩 되었습니다.'); location='news_scrap.jsp?num=<%=num%>&news_scrap=<%=news_scrap%>&loginuser=<%=loginuser%>';"><i class="fa-regular fa-star fa-xl" style="color: #fff;"></i></button>
					<%
					}
					// 스크랩되었던 뉴스라면 버튼을 눌렀을때 스크랩 취소 가능
					} else if (include) {
					%>
					<%-- 버튼을 누르면 메시지 출력 및 news_scrap_delete.jsp로 이동, 각 3개의 파라미터를 함께 전달 --%>
					<button
						onclick="alert('스크립트 취소 되었습니다.'); location='news_scrap_delete.jsp?num=<%=num%>&news_scrap=<%=news_scrap%>&loginuser=<%=loginuser%>';"><i class="fa-solid fa-star fa-xl" style="color: #fff;"></i></button>
					<%
					}
					%>
				</div>
				<div class="cont-mid-right">
					<%-- 각 버튼을 누를때 글자크기 변경 --%>
					<button type="button" class="button" onclick="changeFontSize('small')">가</button>
					<button type="button" class="button" onclick="changeFontSize('normal')">가</button>
					<button type="button" class="button" onclick="changeFontSize('large')">가</button>
				</div>
			</div>
		</div>
		<div class="cont-content">
			<p class="cont-cont-press">[<%=text.getPress()%>]</p>
			<div id="content"><%=text.getCon()%></div>
			<a href="/project1/member/user_mypage_form.jsp?id=<%=text.getId()%>&pageType=2" class="cont-cont-jn"><%=text.getNick()%> 기자</a>
		</div>
		<div class="cont-like">
		<%
				if (loginuser != null) { // 로그인을 했을 때 					
					if (!loginuser.equals(text.getId())) {
		%>
				<%-- 세션에서 받아온 id값이 있어야 되고 기사를 작성한 본인은 평점을 달지 못하게 설정 --%>			
			<div class="like-box">
				<button type="button" name="good" class="good-btn" onclick="location.href='gisagood.jsp?num=<%=text.getNum()%>'">
					<i class="fa-solid fa-heart fa-2xl" style="color: #ff2e2e;"></i>
				</button>
					<p class="like-box-txt">좋아요</p>
					<p><%=rDTO.getGood()%></p>
			</div>
			<div class="bad-box">
				<button type="button" name="bad" class="bad-btn" onclick="location.href='gisabad.jsp?num=<%=text.getNum()%>'">
					<i class="fa-solid fa-poo fa-2xl" style="color: #674428;"></i>
				</button>
					<p class="like-box-txt">별로에요</p>
					<p><%=rDTO.getBad()%></p>
			</div>
					<%
					}
					%>
				<%
				}
				%>
		</div>
			<div class="button-wrap">
				<%
				if (loginuser != null) { //로그인을 했을 때

					if (loginuser.equals(text.getId())) {
				%>
				<%-- 세션과 작성자가 일치할 때 --%>
				<button type="button" class="button"
					onclick="location='deleteForm.jsp?num=<%=text.getNum()%>'">
					<i class="fa-solid fa-trash-can fa-lg" style="color: #8a8a8a;"></i>
				</button>
				<button type="button" class="button" value="수정하기"
					onclick="location='updateForm.jsp?num=<%=text.getNum()%>'">
					<i class="fa-regular fa-pen-to-square fa-lg" style="color: #8a8a8a;"></i>
				</button>
				<button type="button" class="button" value="돌아가기"
					onclick="location='list.jsp'">
					<i class="fa-solid fa-rotate-left fa-lg" style="color: #8a8a8a;"></i>
				</button>
				<%
				} else if (usertype.equals(admin)) {
				%>
				<%-- 세션과 운영자의 종류가 일치할 때 --%>
				<button type="button" class="button" value="삭제하기"
					onclick="location='deleteForm.jsp?num=<%=text.getNum()%>'">
					<i class="fa-solid fa-trash-can fa-lg" style="color: #8a8a8a;"></i>
				</button>
				<button type="button" class="button" value="돌아가기"
					onclick="location='list.jsp'">
					<i class="fa-solid fa-rotate-left fa-lg" style="color: #8a8a8a;"></i>
				</button>
				<%
				} else if (usertype.equals(normaluser)) {
				%>
				<%-- 세션이 일반 유저일 때 --%>
				<button type="button" class="button" value="돌아가기"
					onclick="location='list.jsp'">
					<i class="fa-solid fa-rotate-left fa-lg" style="color: #8a8a8a;"></i>
				</button>
				<%
				}
				}
				//끝난 곳
				if (session.getAttribute("memId") == null) {
				%>
				<%-- 비로그인 일 때 --%>
				<button type="button" class="button" value="돌아가기"
					onclick="location='list.jsp'">
					<i class="fa-solid fa-rotate-left fa-lg" style="color: #8a8a8a;"></i>
				</button>
				<%
				}
				%>
			</div>
			

			<%-- ========================= 경계선 ========================= --%>
			<%-- include 액션태그를 사용해서 JSP파일을 content와 합친다. --%>
			<%-- 해당 include 액션 태그에서 사용할 파라미터를 전달하는 역활을 한다. --%>
			<div class="recon_box">
				<jsp:include page="recon.jsp">
					<jsp:param value="<%=text.getTitle()%>" name="title" />
					<jsp:param value="<%=text.getCon()%>" name="con" />
					<jsp:param value="<%=num%>" name="num" />
				</jsp:include>
			</div>
	</div>
</div>
<jsp:include page="/member/footer.jsp"></jsp:include>


<script>
	// 기사 내용 글자의 크기를 변경하는 기능
	function changeFontSize(size) {
		// document.getElementById를 사용하여 content요소를 가지고 옴
		// document.getElementById는 특정 ID를 가진 HTML요소를 가져오는 메서드
		var content = document.getElementById('content');
		if (size === 'small') {
			content.style.fontSize = '16px';
		} else if (size === 'normal') {
			content.style.fontSize = '20px';
		} else if (size === 'large') {
			content.style.fontSize = '24px';
		}
	}
</script>


<script>
// -엘리먼트, 요소 같은 의미-
	// copyButton변수 선언
	// id 속성 값이 copyButton인 요소를 할당(버튼 역할을 하는 HTML요소)
	var copyButton = document.getElementById('copyButton');
	// click 이벤트 리스너는 copyButton이 클릭될때 실행
	// function()은 버튼 클릭시에 실행되는 코드(익명함수)
	copyButton.addEventListener('click', function() {
		// url변수에 현재 URL을 할당
		var url = window.location.href;
		// 임시 input 엘리먼트 생성
		// document.createElement()를 사용해 새로운 input요소 생성하고, tempInput 변수에 할당
		var tempInput = document.createElement("input"); 
		// tempInput 요소의 value 속성을 현재 url값으로 설정
		tempInput.setAttribute("value", url);
		// tempInput 요소를 현재 페이지의 body 요소의 자식 요소로 추가(tempInput 요소가 현재 페이지의 body요소에 추가 됨)
		document.body.appendChild(tempInput);
		// tempInput 요소 선택
		tempInput.select(); 
		// 복사 명령 실행
		// execCommand()를 사용해 선택된 텍스트를 클립보드에 복사
		document.execCommand("copy"); 
		// input 엘리먼트 삭제
		// tempInput 요소 삭제
		document.body.removeChild(tempInput); 
		alert("URL이 복사되었습니다.");
	});
</script>


<%
}
%>
