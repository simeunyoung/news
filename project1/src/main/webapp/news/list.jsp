<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>
<title>기존 리스트 파일 div태그 활용하여 리메이크</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<jsp:include page="/member/header.jsp"></jsp:include>
<%
request.setCharacterEncoding("UTF-8");

String loginuser = null;
loginuser = (String) session.getAttribute("memId");
String memtype = null;

if (loginuser == null) {
	memtype = "0";
} else {
	MemberDAO memdao = MemberDAO.getInstance();
	MemberDTO usertype = memdao.getmember(loginuser);

	memtype = usertype.getMemberType();
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}

int pageSize = 10;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
int newscount = 0;
int number = 0;

List newsList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newscount = newsPro.getNewsCount(); // 추가 DAO

if (newscount > 0) {
	newsList = newsPro.getNews(startRow, endRow); // 추가 DAO
}

number = newscount - (currentPage - 1) * pageSize;
%>

접속자 정보 :
<%=loginuser%>


<body>
	<div class="form_box">
		<div class="boxname_link">
			<div class="boxname">
				<h3>모든 뉴스(둘러보기)</h3>
			</div>
			<div align="right" class="boxname">
				<%
				if (memtype.equals("2")) {
				%>
				<button class="button" onclick="location='writeForm.jsp'">
					<b>글쓰기</b>
				</button>
				<%
				} else if (memtype.equals("-1")) {
				%>
				<button class="button" onclick="location='writeForm.jsp'">
					<b>글쓰기</b>
				</button>
				<%
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
		<br />
		<br />
		<br />
		<br />
		<br />
		<center>
			<h3>죄송합니다.. 현재 뉴스 목록에 기사가 없습니다.</h3>
			<h4>
				뉴스를 준비 중입니다.<br /> 나중에 다시 이용하여 주시기 바랍니다.
			</h4>
		</center>
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<%
		} else {
		%>

		<table>
			<tr>
				<th>작성 번호</th>
				<th>뉴스(내용)</th>
				<th>작성자</th>
				<th>언론사</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
		</table>
		<table>
		<%
		for (int i = 0; i < newsList.size(); i++) {
			NewsDTO article = (NewsDTO) newsList.get(i);
		%>
		
			<tr>
				<td><%=number--%></td>
				<td>
					<div onclick="location='content.jsp?num=<%=article.getNum()%>'"><%=article.getTitle()%></div>
					<div><%=article.getCon()%></div>
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
		<div align="center">
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
			<a href="list.jsp?pageNum=<%=i%>"> [<%=i%>]
			</a>
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
		<jsp:include page="/member/footer.jsp"></jsp:include>
</body>


