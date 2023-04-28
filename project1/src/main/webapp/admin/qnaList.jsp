<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="member.MemberDTO"%>

<%
	int pageSize = 10; // 한 페이지에서 보여줄 게시물 수
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm:ss");
	
	String pageNum = request.getParameter("pageNum"); // 현재 페이지를 받아옴 request는 리턴값이 String
	if(pageNum == null) {
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum); // String을 int로 변환
	int startRow = (currentPage - 1) * pageSize + 1; // (1페이지 - 1) * 20 + 1 = 1
	int endRow = currentPage * pageSize; // 1페이지 x 20개
	List qnaList = null; // 게시물 목록을 보여줄 리스트 선언
	
	AdminDAO dao = AdminDAO.getInstance(); // dao 객체 불러옴
	String memId = (String)session.getAttribute("memId");
	MemberDTO dto2 = dao.setMember(memId);
	if(memId == null) {dto2.setMemberType("0");}
	int count = dao.getQnaCount(); // db 게시물 수
	
	qnaList = dao.qnaList(startRow, endRow);
%>

<a href="/project1/admin/siteMap.jsp">사이트맵</a><br />

<title>Q&A 게시판</title>
memId = <%=memId%>
<center><h2>Q&A 게시판</h2></center>

<hr />

<center><h3>Q&A목록(<%=count%>)</h3></center>

<table align="center" width="700">
	<tr>
		<td align="right"><input type="button" value="글쓰기" onclick="location='qnaWrite.jsp'" /></td>
	</tr>
</table>

<form>
	<table align="center" width="700" border="1" cellspacing="0" cellpadding="0">
		<tr height="30">
			<td align="center" width="150">문의유형</td>
			<td align="center" width="80">고유번호</td>
			<td align="center" width="250">제목</td>
			<td align="center" width="80">조회수</td>
		</tr>
<%	for(int i = 0; i < qnaList.size(); i++) {
		AdminDTO dto = (AdminDTO)qnaList.get(i);%>
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
			<td align="center"><a href="qnaContent.jsp?num=<%=dto.getNum()%>&pageNum=<%=currentPage%>"><%=dto.getTitle()%></a></td>
			<td align="center"><%=dto.getReadCount()%>
		</tr>
<%	}%>
	</table>
</form>

<form align="center">
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count % pageSize == 0? 0:1);
		
		int startPage = (int)(currentPage / 10) * 10 + 1;
		int pageBlock = 10;
		int endPage = startPage + pageBlock -1;
		
		if(endPage > pageCount) {
			endPage = pageCount;
		}
		
		if(startPage > 10) {%>
			<a href="qnaList.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
<%		} 
		for(int i = startPage; i <= endPage; i++) {%>
			<a href="qnaList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%		}
		if(endPage < pageCount) {%>
			<a href="qnaList.jsp?pageNum=<%=startPage + 10%>">[다음]</a>
<%		}
	}%>
</form>