<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="member.MemberDTO"%>

<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	String pageNum2 = request.getParameter("pageNum2");
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm:ss"); // 작성일자 양식

	int pageSize = 10; // 한 페이지에서 보여줄 게시물 수

	if(pageNum2 == null) {
		pageNum2 = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum2);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	List qnaReconList = null;
	
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	MemberDTO dto2 = dao.setMember(memId);
	if(memId == null) {
		dto2.setId("비회원");
		dto2.setName("비회원");
		dto2.setMemberType("0");
	}
	int count = dao.qnaReconCount(num);
	if(count > 0) {
		qnaReconList = dao.qnaReconList(num,startRow,endRow);
	}
%>

<%	if(count == 0) {%>
	<table align="center">
		<tr height="30">
			<td align="center">댓글이 없습니다.</td>
		</tr>
	</table>
<%	} else {%>
<form align="center">
	<table align="center">
		<tr height="30">
			<td align="center">댓글 고유번호</td>
			<td align="center">내용</td>
			<td align="center">작성자</td>
			<%if(dto2.getMemberType().equals("2")) {%>
			<td align="center">IP</td>
			<%}%>
			<td align="center">댓글삭제</td>
	<%for(int i = 0; i < qnaReconList.size(); i++) {
	AdminDTO dto = (AdminDTO)qnaReconList.get(i);%>
		<tr height="30">
			<td align="center"><%=dto.getNum()%></td>
			<td align="center"><%=dto.getRecon()%></td>
			<td align="center"><%=dto.getId()%>(<%=dto.getName()%>)</td>
			<%if(dto2.getMemberType().equals("2")) {%>
			<td align="center"><%=dto.getIp()%></td>
			<%}%>
			<td align="center"><input type="button" value="삭제" onclick="location='qnaReconDelete.jsp?num=<%=dto.getNum()%>'" />
		</tr>
<%	}%>
	</table>
</form>
<div class="pagination">
<form align="center">
<%
	if(count > 0) {
		int pageCount = count / pageSize + (count % pageSize == 0? 0:1);
		
		int startPage = (int)(currentPage / 20) * 20 + 1;
		int pageBlock = 20;
		int endPage = startPage + pageBlock -1;
			
		if(endPage > pageCount) {
			endPage = pageCount;
		}%>
<%		if(startPage > 20) {%>
			<a href="qnaContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>&pageNum2=<%=startPage - 20%>">[이전]</a>
<%		}
		for(int i = startPage; i <= endPage; i++) {%>
			<a href="qnaContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>&pageNum2=<%=i%>">[<%=i%>]</a>
<%		}
		if(endPage < pageCount) { %>
			<a href="qnaContent.jsp?num=<%=num%>&pageNum=<%=pageNum%>&pageNum2=<%=startPage + 20%>">[다음]</a>
<%		}
	}%>
<%}%>
</form>
</div>

<form action="qnaReconPro.jsp">
	<table align="center">
		<tr>
			<td>
				<input type="hidden" name="id" value="<%=dto2.getId()%>" />
				<input type="hidden" name="name" value="<%=dto2.getName()%>" />
				<input type="hidden" name="num2" value="<%=num%>"/>
				<input type="hidden" name="pageNum" value="<%=pageNum%>" />
				<textarea name="recon" placeholder="댓글내용"></textarea>
				<input type="submit" value="입력" />
			</td>
		</tr>
	</table>
</form>