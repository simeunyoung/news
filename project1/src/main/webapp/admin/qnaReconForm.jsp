<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="member.MemberDTO"%>

<%
	int num2 = (int)request.getAttribute("num2");
	int pageSize = 20; // 한 페이지에서 보여줄 게시물 수
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm:ss"); // 작성일자 양식

	String pageNum = request.getParameter("pageNum");
	if(pageNum == null) {
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	List qnaReconList = null;
	
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	MemberDTO dto2 = dao.setMember(memId);
	if(memId == null) {
		dto2.setId("비회원");
		dto2.setName("비회원");}
	int count = dao.qnaReconCount();
	if(count > 0) {
		qnaReconList = dao.qnaReconList(num2,startRow,endRow);
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
	<%for(int i = 0; i < qnaReconList.size(); i++) {
	AdminDTO dto = (AdminDTO)qnaReconList.get(i);%>
		<tr height="30">
			<td align="center"><%=dto.getNum()%></td>
			<td align="center"><%=dto.getId()%>(<%=dto.getName()%>)</td>
			<td align="center"><%=dto.getRecon()%></td>
			<td align="center"><%=dto.getIp()%></td>
		</tr>
<%	}%>
	</table>
</form>

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
			<a href="qnaReconForm.jsp?pageNum2=<%=startPage - 20%>">[이전]</a>
<%		}
		for(int i = startPage; i <= endPage; i++) {%>
			<a href="qnaReconForm.jsp?pageNum2=<%=i%>">[<%=i%>]</a>
<%		}
		if(endPage < pageCount) { %>
			<a href="qnaReconForm.jsp?pageNum2=<%=startPage + 20%>">[다음]</a>
<%		}
	}%>
</form>
<%}%>

<form action="qnaReconPro.jsp">
	<table align="center">
		<tr>
			<td>
				<input type="hidden" name="id" value="<%=dto2.getId()%>" />
				<input type="hidden" name="name" value="<%=dto2.getName()%>" />
				<input type="hidden" name="num2" value="<%=num2%>"/>
				<textarea name="recon" placeholder="댓글내용"></textarea>
				<input type="submit" value="입력" />
			</td>
		</tr>
	</table>
</form>