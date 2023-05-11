<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="java.util.List"%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%
	int num = Integer.parseInt(request.getParameter("num")); // request.getParameter는 리턴타입이 String이라서 Integer를 이용해서 숫자로 변환
	String pageNum = request.getParameter("pageNum");
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	
	AdminDTO dto = dao.qnaGet(num);
	MemberDTO dto2 = dao.setMember(memId);
	if(memId == null) {dto2.setMemberType("0");}
	
	int pageSize = 20;
	
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
%>
<jsp:include page="/member/header.jsp" />

<title>Q&A 게시판</title>

<div class="page-wrap content">
	<div class="content">
		<h3>Q&A 내용</h3>
		<div>
			<div><%=dto.getNum()%></div>
			<div><%=dto.getReadCount()%></div>
		</div>
		<form>
			<table>
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
					<td align="center" colspan="2">제목 : <%=dto.getTitle()%></td>
				</tr>
				<tr height="30">
					<td align="center" colspan="2">작성자 : <%=dto.getId()%>(<%=dto.getName()%>님)</td>
				</tr>
				<%if(dto2.getMemberType().equals("2")) {%>
				<tr height="30">
					<td align="center" width="400">이메일 : <%=dto.getEmail()%></td>
					<td align="center">연락처 : <%=dto.getTel()%></td>
				</tr>
				<%}%>
				<tr height="300">
					<td align="center" colspan="2"><%=dto.getCon()%></td>
				</tr>
				<tr height="30">
					<td align="center" colspan="2">작성일자 : <%=sdf.format(dto.getReg())%></td>
				</tr>
				<tr height="30">
					<td align="center" colspan="2">
						<input type="button" value="목록" onclick="location='qnaList.jsp'" />
						<%if(dto.getId().equals(dto2.getId()) || dto2.getMemberType().equals("2")) {%> <!-- 작성자 아이디가 동일하거나 어드민이면 삭제가능 -->
						<input type="button" value="수정" onclick="location='qnaUpdateForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'" />
						<input type="button" value="삭제" onclick="location='qnaDeleteForm.jsp?num=<%=num%>&pageNum=<%=pageNum%>'" />
						<%}%>
					</td>
				</tr>
			</table>
		</form>
	</div>
</div>
<jsp:include page="/admin/qnaReconForm.jsp">
<jsp:param value="<%=num%>" name="num2" />
<jsp:param value="<%=pageNum%>" name="pageNum" />
</jsp:include>
<jsp:include page="/member/footer.jsp"></jsp:include>