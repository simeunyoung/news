<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.List"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="helper.SvcenterDAO"%>
<%@ page import="helper.SvcenterDTO"%>
<%@ page import="member.MemberDTO"%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<%-- 뉴스 제보가 들어오면 들어온 걸 게시판으로 보여주는 페이지 --%>
<%
	int pageSize = 20;
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm:ss");
	
	String pageNum = request.getParameter("pageNum");
	String id = (String)session.getAttribute("memId");
	
	if(pageNum == null){pageNum = "1";}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	List qnaList = null;
	
	AdminDAO dao = AdminDAO.getInstance();
	MemberDTO dto2 = dao.setMember(id);
	if(id == null){dto2.setMemberType("0");}
	SvcenterDAO svdao = SvcenterDAO.getInstance();
	int count = svdao.jeboCount();
	
	if(count > 0){
		qnaList = svdao.jaboList(startRow, endRow);
	}
	
	int number = count - (currentPage - 1) * pageSize;
%>

<jsp:include page="/member/header.jsp"/>

<title>뉴스제보목록</title>
<center><b>뉴스제보목록(전체 글 : <%=count%>)</b>
<table align = "center" width = "1000">
	<tr>
		<td align = "right"><input type = "button" value = "제보하기" onclick="location='/project1/admin/qnaWrite.jsp'"/></td>
	</tr>
</table>

<%if(count == 0){%>
	<table align = "center" width="1000" border="1" cellspacing="0" cellpadding="0">
		<tr height = "30">
			<td align = "center">제보받은 글이 없습니다</td>
		</tr>
	</table>
<%}else{%>
<center><b>뉴스제보목록</b>
	<form>
		<table>
			<tr height = "30">
				<td align = "center" width = "50">순번</td>
				<td align = "center" width = "150">문의유형</td>
				<td align = "center" width = "80">고유번호</td>
				<td align = "center" width = "250">제목</td>
				<td align = "center" width = "150">작성자</td>
				<td align = "center" width = "200">작성일</td>
				<td align = "center" width = "80">조회수</td>
				<%if(dto2.getMemberType().equals("2")){%>
				<td align = "center" width = "150">IP</td>
				<td align = "center" width = "100">블라인드</td>
				<%}%>
			
			<%
				for(int i = 0 ; i < qnaList.size() ; i++){
					AdminDTO adto = (AdminDTO)qnaList.get(i);
			%>
			
			<tr height = "30">
				<td align = "center"><%=number--%></td>
				<td algin = "center"><%if(adto.getQuestionType().equals("4")){out.println("뉴스제보");}%>				
				<td align = "center"><%=adto.getNum()%></td>
				<td align = "center"><a href="/project1/admin/qnaContent.jsp?num=<%=adto.getNum()%>&pageNum=<%=currentPage%>"><%=adto.getTitle()%></a></td>
				<td align = "center"><%=adto.getId()%>(<%=adto.getName()%>님)</td>
				<td align = "center"><%=sdf.format(adto.getReg())%></td>
				<td align = "center"><%=adto.getReadCount()%></td>
				<%if(dto2.getMemberType().equals("2")){%>
				<td align = "center"><%=adto.getIp()%></td>
				<td align = "center">
			</td>
		<%}%>
	</tr>
	<%}%>
		</table>
	</form>
	<div class="pagination">
	<form align = "center">
<%}%>

<%
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
		
		int startPage = (int)(currentPage / 20) * 20 + 1;
		int pageBlock = 20;
		int endPage = startPage + pageBlock - 1;
		
	if(endPage > pageCount){
		endPage = pageCount;
	}
	
	if(startPage > 20){%>
		<a href="/project1/admin/qnaList.jsp?pageNum=<%=startPage - 20%>">[이전]</a>
<%  }
	for(int i = startPage ; i <= endPage ; i++){%>
		<a href="/project1/admin/qnaList.jsp?pageNum=<%=i%>">[<%=i%>]</a>
<%  }
	if(endPage < pageCount){%>
		<a href="/project1/admin/qnaList.jsp?pageNum=<%=startPage + 20%>">[다음]</a>
	<%}%>
<%}%>
</form>
</div>
<jsp:include page="/member/footer.jsp"></jsp:include>