<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDTO"%>
<%@ page import = "member.MemberDTO"%>
<%@ page import = "helper.SvcenterDAO"%>
<%@ page import = "helper.SvcenterDTO"%>
<%@ page import = "java.text.SimpleDateFormat"%>
<%@ page import = "java.util.List"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<%-- 1대1문의를 작성했을 시 따로 내 문의글만 따로 목록으로 출력하는 게시판 --%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%!
	int pageSize = 20; // 한 페이지에서 보여줄 게시물 수
	SimpleDateFormat sdf = new SimpleDateFormat("yy.MM.dd HH:mm:ss");
%>

<%
	String id = (String)session.getAttribute("memId");

	String pageNum = request.getParameter("pageNum");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int count = 0;
	int number = 0;
	
	List svcenterList = null;
	SvcenterDAO svDAO = SvcenterDAO.getInstance();							
	count = svDAO.getMySvcenterCount(id);							//세션에서 받아온 id가 작성한 글이 테이블에 몇개가 있는지 확인 있다면 1 없으면 0
	if(count > 0){													//글이 있는 경우 작동
		svcenterList = svDAO.getMySvcenter(id,startRow,endRow); 	
	}
	number = count - (currentPage - 1) * pageSize;
%>

<title>CODENEWS</title>
<jsp:include page="/member/header.jsp" />

<center><b>1대1문의목록(전체 글 : <%=count%>)</b>	<%-- 본인이 작성한 글이 있다면 몇개가 있는지 나타냄 --%>
<table width = "700">
	<tr>
		<td align = "right">
		<%if(session.getAttribute("memId") == null){%>
			<a href = "/project1/member/loginForm.jsp">로그인</a>		<%-- 만약 로그인 상태가 아니면 전체글 목록은 0으로 표시가 될 것이고 로그인을 할 수 있게 만들어 둠 --%>
		<%}else{%>
			<a href = "/project1/admin/qnaWrite.jsp">글쓰기</a>
			<a href = "/project1/member/logout.jsp">로그아웃</a>
		<%}%>
		</td>
	</tr>
</table>


<%if(count == 0){%>						<%-- 작성한 글이 없을 시 해당 페이지에 출력하는 곳 --%>
&nbsp;&nbsp;&nbsp;&nbsp;
<table align = "center" width = "700" border = "1" cellpadding = "0" cellspacing = "0">
	<tr>
		<td align = "center">작성하신 글이 없습니다.</td>
</table>

<%}else{%>								<%-- 작성한 글이 있을 경우 게시판을 만들고 출력 --%>
&nbsp;&nbsp;&nbsp;&nbsp;
<center><b>1대1문의목록</b>
<table ailgn = "center" width = "800" border = "1" cellspacing = "0" cellpadding = "0">
	<tr height = "30">
		<td align = "center" width = "50">글번호</td>
		<td align = "center" width = "500">제 목</td>
		<td align = "center" width = "100">작성자</td>
		<td align = "center" width = "100">문의날짜</td>
		
	<%
		for(int i = 0 ; i < svcenterList.size() ; i++){						//위에서 검색한 값이 리스트에 저장이 되어있기에 반복문을 사용해서 리스트에 저장된 값으 수만큼 반복하여 하나씩 꺼내서 svdto에 저장
			AdminDTO adto = (AdminDTO)svcenterList.get(i);
	%>
	
	<tr height = "20">
		<td align = "center" width = "50"><%=number--%></td>
		<td align = "center" width = "200"><a href = "/project1/admin/qnaContent.jsp?num=<%=adto.getNum()%>&pageNum=<%=currentPage%>"><%=adto.getTitle()%></a></td>
		<td align = "center" width = "100"><%=adto.getId()%></td>
		<td align = "center" width = "100"><%=sdf.format(adto.getReg())%></td>
	</tr>
	<%}%>
</table>
<%}%>

<form align = "center">
	<%
		if(count > 0){
			int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
			
			int startPage = (int)(currentPage / 10) * 10 + 1;
			int pageBlock = 10;
			
			int endPage = startPage + pageBlock - 1;
			
			if(endPage > pageCount) endPage = pageCount;
			
		if(startPage > 10){%>
		<a href = "myquestion.jsp ? pageNum = <%=startPage - 10%>">[이전]</a>
	<%}
		for(int i = startPage ; i <= endPage ; i++){%>
		<a href = "myquestion.jsp ? pageNum = <%=i%>">[<%=i%>]</a>
	<%}
		if(endPage < pageCount){%>
		<a href = "myquestion.jsp ? pageNum = <%=startPage + 10%>">[다음]</a>
	<%
		}
	}
%> 
</form>
<jsp:include page="/member/footer.jsp"></jsp:include>