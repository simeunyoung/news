<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "helper.Svcenter1DAO"%>
<%@ page import = "helper.Svcenter1DTO"%>
<%@ page import = "member.MemberDTO"%>
<%@ page import = "member.MemberDAO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.List"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%-- 고객센터 메인페이지 --%>
<%String id = (String)session.getAttribute("memId");
	if(id == null || id != null){%>				<%-- 로그인을 안한 유저도 들어올 수 있게 설정 --%>
<%!
	int pageSize = 10;
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm:ss"); // 날짜형식 설정
%>

<%
	MemberDAO mbDAO = MemberDAO.getInstance();
	MemberDTO mbdto = mbDAO.getMember(id);
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum); // String을 int로 변환
	int startRow = (currentPage - 1) * pageSize + 1; // (1페이지 - 1) * 20 + 1 = 1
	int endRow = currentPage * pageSize; // 1페이지 x 20개
	List faqList = null; // 게시물 목록을 보여줄 리스트 선언
	
	AdminDAO dao = AdminDAO.getInstance(); // dao 객체 불러옴
	String memId = (String)session.getAttribute("memId"); // 세션정보 불러옴
	MemberDTO dto2 = dao.setMember(memId); // 세션정보로 회원정보 불러옴
	if(memId == null) {dto2.setMemberType("0");} // 비로그인의 경우 멤버타입 0 지정
	int count = dao.getfaqCount(); // db 게시물 수
	
	faqList = dao.faqList(startRow, endRow); // 로우넘값을 지정해 faq를 꺼냄
%>
<title>CODENEWS</title>
<!-- header -->
<jsp:include page="/member/header.jsp"></jsp:include>
<center><b>고객센터</b></center>
<table align = "center" width = "500" height = "60" border = "1" cellspacing = "0" cellpadding = "0">
	<tr>
		<%if(id != null){
		if(!mbdto.getMemberType().equals("2")){%>			<%-- id의 값은 있어야 되고 해당 id 멤버타입이 2가 아닐 경우에만 나오게 설정 --%>
		<td align = "center" colspan = "2">
			<a href = "/project1/admin/qnaWrite.jsp">1대1문의하기</a>
		</td>
	<%}%>
<%}%>
		<td align = "center" colspan = "2">
			<a href = "/project1/admin/qnaList.jsp">문의목록</a>
		</td>
	<%if(id != null){	
	if(mbdto.getMemberType().equals("1")){%>				<%-- id의 값은 있어야 되고 해당 id 멤버타입이 1일 경우에만 나오게 설정 --%>
		<td align = "center" colspan = "2">
			<a href = "/project1/admin/journalistForm.jsp">기자신청하기</a>
		</td>
	<%}%>	
<%}%>
		<td align = "center" colspan = "2">
			<a href = "myquestion.jsp">내문의목록</a>
		</td>
	</tr>		
</table>

<%
	if(count == 0){
%>
&nbsp;&nbsp;&nbsp;&nbsp;
<table width = "700" border = "1" cellpadding = "0" cellspacing = "0">
	<tr>
		<td>
		문의글이 없습니다.
		</td>
</table>

<% }else{ %>
<center><h3>FAQ 목록(<%=count%>)</h3></center>

<form>
	<table align="center" width="700" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td align="center" width="150">문의유형</td>
			<td align="center" width="80">고유번호</td>
			<td align="center" width="250">제목</td>
			<td align="center" width="80">조회수</td>
		</tr>
<%	for(int i = 0; i < faqList.size(); i++) {
		AdminDTO dto = (AdminDTO)faqList.get(i);%>
		<tr height="30">
			<td align="center">
				<%
				if(dto.getQuestionType().equals("1")) {
					out.println("자바");
				} else if(dto.getQuestionType().equals("2")) {
				  	out.println("파이썬");
				} else if(dto.getQuestionType().equals("3")) {
					out.println("자바스크립트");
				} else if(dto.getQuestionType().equals("4")) {
					out.println("뉴스제보");
				} else if(dto.getQuestionType().equals("5")) {
					out.println("제휴 및 일반문의");
				} else if(dto.getQuestionType().equals("6")) {
					out.println("신고");
				} else if(dto.getQuestionType().equals("0")) {
					out.println("미선택");
				} else {
					out.println("오류오류오류오류오류오류");
				}
				%>
			</td>
			<td align="center"><%=dto.getNum()%>
			<td align="center"><a href="/project1/admin/faqContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>"><%=dto.getTitle()%></a></td>
			<td align="center"><%=dto.getReadCount()%>
		</tr>
<%	}%>
	</table>
</form>

<form align="center">
<%
	if(count > 0) { // 글이 있는지 확인
		int pageCount = count / pageSize + (count % pageSize == 0? 0:1); // 23/10을 기준으로 2페이지는 무조건 나와야하고+(23%10이 딱 나누어 떨어지면 페이지가 더 필요없고 나머지가 있다면 페이지를 하나 더 늘려줘야해서 + 1
		
		int startPage = (int)(currentPage / 10) * 10 + 1; // 현재페이지가 13이면 스타트페이지는 11
		int pageBlock = 10; // 한 번에 보여줄 페이지 갯수
		int endPage = startPage + pageBlock -1; // 페이지블럭이 10이면 20 
		
		if(endPage > pageCount) { // 엔드페이지가 전체페이지보다 크면 전체페이지를 엔드페이지에 대입 (실제 전체페이지를 넘기면 안됨)
			endPage = pageCount;
		}
		
		if(startPage > 10) {%><!-- start페이지가 10개가 넘어가면 이전 페이지를 볼 수 있도록함 -->
			<a href="/project1/admin/faqList.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
<%		} 
		for(int i = startPage; i <= endPage; i++) {%><!-- 현재페이지 확인 -->
			<a href="/project1/admin/faqList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%		}
		if(endPage < pageCount) {%><!-- 전체페이지가 엔드페이지보다 작으면 다음 페이지를 볼 수 있도록 함 -->
			<a href="/project1/admin/faqList.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
			<%}%>
		<%}%>
	<%}%>
<%}%>
</form>
<jsp:include page="/member/footer.jsp"></jsp:include>