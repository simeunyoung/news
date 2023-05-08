<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="member.MemberDTO"%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%
	int num = Integer.parseInt(request.getParameter("num")); // getParameter는 항상String이여서 parseInt로 변환후 대입
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); // 날짜형식 2023-05-01 13:00:00 형태로 변환
	
	AdminDAO dao = AdminDAO.getInstance(); // dao 객체 불러옴
	String memId = (String)session.getAttribute("memId"); // memId에 세션 대입
	AdminDTO dto = dao.faqGet(num); // num으로 faq정보 불러옴
	MemberDTO dto2 = dao.setMember(memId); // 세션id로 회원정보 불러옴
	if(memId == null) {dto.setMemberType("0");} // 비로그인의 경우 멤버타입 0으로 지정
%>
<jsp:include page="/member/header.jsp" />

<title>FAQ 게시판</title>
<center><h3>FAQ</h3></center>

<hr />
<br />

<form>
	<table align="center" width="800" border="1" cellspacing="0">
		<tr height="30">
			<td align="center" width="400">글 고유번호 : <%=dto.getNum()%></td>
			<td align="center">조회수 : <%=dto.getReadCount()%></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">문의유형 : 
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
			<td align="center" colspan="2">작성자 : <%=dto.getId()%>(<%=dto.getName()%>님)
		</tr>
		<tr height="30">
			<td align="center" colspan="2">제목 : <%=dto.getTitle()%></td>
		</tr>
		<tr height="300">
			<td align="center" colspan="2"><%=dto.getCon()%></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">작성일자 : <%=sdf.format(dto.getReg())%></td>
		</tr>
		<tr height="30">
			<td align="center" colspan="2">
				<input type="button" value="목록" onclick="location='faqList.jsp'" />
				<!-- 글을 삭제하기위해 num과 pageNum을 보냄 -->
				<%if(dto2.getMemberType().equals("2")) {%>
				<input type="button" value="삭제" onclick="location='faqDelete.jsp?num=<%=num%>&pageNum=<%=pageNum%>'" />
				<%}%>
			</td>
		</tr>
	</table>
</form>
<jsp:include page="/member/footer.jsp"></jsp:include>