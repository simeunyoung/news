<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>
<title>CODENEWS</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<jsp:include page="/member/header.jsp"></jsp:include>
<%
request.setCharacterEncoding("UTF-8");

String loginuser = null;
loginuser = (String) session.getAttribute("memId"); // 세션 지정
String memtype = null; // 로그인한 유저의 멤버 타입 변수

// null값은 0으로 지정
// 로그인한 유저의 정보를 가져온 뒤 memtype변수에 저장
if (loginuser == null) {
	memtype = "0";
} else {
	MemberDAO memdao = MemberDAO.getInstance();
	MemberDTO usertype = memdao.getmember(loginuser);
	MemberDTO mem = memdao.getmember(loginuser);
	String press = mem.getPress();

	memtype = usertype.getMemberType();
}

// 날짜, 시간을 지정된 형식으로 변환하기 위해 객체 생성
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

// 현재 페이지 번호를 pageNum변수에 저장
// 값이 null일때 1로 지정
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}

int pageSize = 10; // 한 페이지에 표시될 게시글의 개수
int currentPage = Integer.parseInt(pageNum); // 현재 페이지 번호를 저장
int startRow = (currentPage - 1) * pageSize + 1; // 페이지 시작 번호
int endRow = currentPage * pageSize; // 페이지 끝 번호
int newscount = 0; // 전체 게시글 수를 저장 할 변수
int number = 0; // 게시글의 번호를 저장 할 변수

List newsList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newscount = newsPro.getNewsCount(); // 추가 DAO

// 게시글이 하나라도 있을 경우 해당 페이지의 게시글을 변수에 저장
if (newscount > 0) {
	newsList = newsPro.getNews(startRow, endRow); // 추가 DAO
}

// 현재 페이지에서 게시글 번호를 매기기 위해 변수에 게시글 번호를 저장
number = newscount - (currentPage - 1) * pageSize;
%>

<body>
	<div class="page-wrap">
		<div class="boxname_link">
			<div class="boxname">
				<h3>전체 뉴스</h3>
			</div>
			<div align="right" class="boxname">
				<%
				// admin일때 글쓰기 활성화
				if (memtype.equals("2")) {
				%>
				<button class="button" onclick="location='writeForm.jsp'">
					<b class="white-btn">글쓰기</b>
				</button>
				<%
				// 기자일때 글쓰기 활성화
				} else if (memtype.equals("-1")) {
				%>
				<button class="button" onclick="location='writeForm.jsp'">
					<b class="white-btn">글쓰기</b>
				</button>
				<%
				// 비회원일 경우 버튼 위치에 메시지 출력
				} else if (memtype.equals("0")) {
				%>
				현재 비로그인 중입니다.
				<%
				}
				%>
			</div>
		</div>


		<%
		if (newscount == 0) { // 게시글이 없을 때
		%>
		<div class="no-list">
			<h3>죄송합니다.. 현재 뉴스 목록에 기사가 없습니다.</h3>
			<h4>
				뉴스를 준비 중입니다.<br /> 나중에 다시 이용하여 주시기 바랍니다.
			</h4>
		</div>

		<%
		} else {
		%>

		<table>
			<colgroup>
				<col style="width:5%;"/>
				<col style="width:50%;"/>
				<col style="width:10%;"/>
				<col style="width:15%;"/>
				<col style="width:15%;"/>
				<col style="width:5%;"/>
			</colgroup>
			<tr>
				<th>작성 번호</th>
				<th>뉴스(내용)</th>
				<th>작성자</th>
				<th>언론사</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		<%
		// newsList에서 NewsDTO에 저장되어있는 정보를 한 행씩 출력
		for (int i = 0; i < newsList.size(); i++) {
			NewsDTO article = (NewsDTO)newsList.get(i);
		%>
		
			<tr>
				<%-- 최신글이 가장 위에 위치하도록 목록에서 역순으로 번호를 부여 --%>
				<td><%=number--%></td>
				<td class="click" onclick="location='content.jsp?num=<%=article.getNum()%>'">
					<div><%=article.getTitle()%></div>
					
				</td>
				<td><%=article.getId()%></td>
				<td><%=article.getPress()%></td>
				<td><%=sdf.format(article.getReg())%></td>
				<td><%=article.getViews()%></td>
			</tr>
		
		<%
		if (i != newsList.size()) {
		%>

		<%
		}
		}%>
		</table>
		<%
		}
		%>
		<div class="pagination">
			<%
			if (newscount > 0) {
				int pageCount = newscount / pageSize + (newscount % pageSize == 0 ? 0 : 1);
				int startPage = (int) (currentPage / 10) * 10 + 1;
				int pageBlock = 10;
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount) {
					endPage = pageCount;
				}
				if (startPage > 10) {
			%>
			<a href="list.jsp?pageNum=<%=startPage - 10%>"> [이 전]</a>
			<%
			}
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
			<%
			}
			if (endPage < pageCount) {
			%>
			<a href="list.jsp?pageNum=<%=startPage + 10%>"> [다 음]</a>
			<%
			}
			}
			%>
		</div>
		</div>
		<jsp:include page="/member/footer.jsp"></jsp:include>
</body>


