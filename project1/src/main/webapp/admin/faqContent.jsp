<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="member.MemberDTO"%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/dbaea98925.js" crossorigin="anonymous"></script>
<script src="/project1/resource/js/script.js"></script>

<%
	int num = Integer.parseInt(request.getParameter("num")); // getParameter는 항상String이여서 parseInt로 변환후 대입
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 날짜형식 2023-05-01 13:00:00 형태로 변환
	
	AdminDAO dao = AdminDAO.getInstance(); // dao 객체 불러옴
	String memId = (String)session.getAttribute("memId"); // memId에 세션 대입
	AdminDTO dto = dao.faqGet(num); // num으로 faq정보 불러옴
	MemberDTO dto2 = dao.setMember(memId); // 세션id로 회원정보 불러옴
	if(dto2.getMemberType() == null) {dto2.setMemberType("0");} // 비로그인의 경우 멤버타입 0으로 지정
%>
<jsp:include page="/member/header.jsp" />

<title>FAQ 게시판</title>

<div class="page-wrap content">
	<div class="content-box cont">
	<h3>FAQ</h3>
	<div class="cont-top">
			<div class="cont-top-left"># <%=dto.getNum()%></div>
			<div class="cont-top-right"><i class="fa-solid fa-eye" style="color: #bfbfbf;"></i> <%=dto.getReadCount()%></div>
		</div>
<form>
	<table>
		<colgroup>
			<col style="width:20%">
			<col style="width:80%">
		</colgroup>
		<tr height="30">
			<td>문의유형</td>
			<td> 
				<%
				if(dto.getQuestionType().equals("1")) {
					out.println("자바");
				} else if(dto.getQuestionType().equals("2")) {
				  	out.println("파이썬");
				} else if(dto.getQuestionType().equals("3")) {
					out.println("자바스크립트");
				} else if(dto.getQuestionType().equals("4")) {
					out.println("뉴스 제보하기");
				} else if(dto.getQuestionType().equals("5")) {
					out.println("제휴 및 일반문의");
				} else if(dto.getQuestionType().equals("6")) {
					out.println("신고하기");
				} else if(dto.getQuestionType().equals("0")) {
					out.println("미선택");
				} else {
					out.println("오류오류오류오류오류오류");
				}
				%>
			</td>
		</tr>
		<tr height="30">
			<td>작성자</td>
			<td> <%=dto.getId()%>(<%=dto.getName()%>님)
		</tr>
		<tr height="30">
			<td>제목</td>
			<td> <%=dto.getTitle()%></td>
		</tr>
		<tr height="300">
			<td>내용</td>	
			<td><%=dto.getCon()%></td>
		</tr>
		<tr height="30">
			<td>작성일자</td>
			<td> <%=sdf.format(dto.getReg())%></td>
		</tr>
	</table>
	<div class="buttom-wrap">
		<input type="button" class="white-btn" value="목록" onclick="location='faqList.jsp'" />
		<!-- 글을 삭제하기위해 num과 pageNum을 보냄 -->
		<%if(dto2.getMemberType().equals("2")) {%>
		<input type="button" class="white-btn" value="삭제" onclick="location='faqDelete.jsp?num=<%=num%>&pageNum=<%=pageNum%>'" />
		<%}%>
	</div>
</form>
</div>
</div>

<jsp:include page="/member/footer.jsp"></jsp:include>