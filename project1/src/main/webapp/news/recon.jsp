<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>

<b>댓글</b>

<%
String loginuser = (String) session.getAttribute("memId");
int num = Integer.parseInt(request.getParameter("num")); // 액션태그에 전달 받은 num 파라미터 값
MemberDAO memdao = MemberDAO.getInstance();
MemberDTO userinfo = memdao.getmember(loginuser);
String usernick = null;
String usertype = null;
if (loginuser != null) { // 세션을 가지고 있을 때 적용
	usernick = userinfo.getNick();
	usertype = userinfo.getMemberType();
}

String title = request.getParameter("title"); // 액션태그에서 가져온 파라미터
String con = request.getParameter("con"); // 액션 태그에서 가져온 파라미터
// + -->
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}

int pageSize = 5;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
int reconcount = 0;
int number = 0;

NewsDAO method = NewsDAO.getInstance();
reconcount = method.getReconCount(title, con); // recon 갯수를 알아내는 메소드
List recons = method.getRecon(title, con, startRow, endRow); // recon을 조건에 맞게 가져오는 메소드
// <-- +
%>
<%
if (session.getAttribute("memId") == null) {
%>

<%
} else {
// recon 페이지에서 reconForm을 생성하고 데이터 값을 전달해서 Pro페이지로 이동
%>

<form action="reconwritePro.jsp" method="post" class="flexthing">
	<input type="hidden" name="id" value="<%=loginuser%>"> 
	<input type="hidden" name="nick" value="<%=userinfo.getNick()%>"> 
	<input type="hidden" name="title" value="<%=title%>"> 
	<input type="hidden" name="con" value="<%=con%>"> 
	<input type="hidden" name="contentpage" value="<%=num%>"> 
	<div class="recon-wrap">
		<input type="text" class="textarea_box" name="recon" placeholder="권리침해, 욕설 및 특정 대상을 비하하는 내용을 게시할 경우 이용약관 및 관련법률에 의해 제재될 수 있습니다.">
		<input type="submit" value="입력" class="submit-btn">
	</div>
	
</form>
<%
}
%>


<%
if (recons != null) {

	number = reconcount - (currentPage - 1) * pageSize; //+

	for (int rnum = 0; rnum < recons.size(); rnum++) {
		NewsDTO recontext = (NewsDTO) recons.get(rnum); //Object(list)형 --> DTO형으로 꺼내주고 있다.
%>
<div class="recon-box">
	<div class="recon-top">
		<div class="recon-info">
			<p><%=recontext.getNick()%></p>
			<p><%=recontext.getReg()%></p>
		</div>
		<div class="recon-btn-wrap">
				<%
				String dbnick = method.getNick(recontext.getNick());
				if (session.getAttribute("memId") == null) {
				}else if (dbnick.equals(usernick)) {
				%>
				<a href="reconUpdateForm.jsp?num=<%=recontext.getNum()%>&connum=<%=num%>"><i class="fa-regular fa-pen-to-square" style="color: #bfbfbf;"></i></a>
				<span>|</span>			
				<a href="reconDeletePro.jsp?num=<%=recontext.getNum()%>&connum=<%=num%>"><i class="fa-solid fa-trash-can" style="color: #bfbfbf;"></i></a>
				
				<%
				} else if (usertype.equals("2")) {
				%>
				<a
					href="reconDeletePro.jsp?num=<%=recontext.getNum()%>&connum=<%=num%>"><i class="fa-solid fa-trash-can" style="color: #bfbfbf;"></i></a>
				
				<%
				}
				%>
		</div>
	</div>
	<div class="recon-cont"><%=recontext.getRecon()%></div>
</div>

<%
}
} else {
%>
<div class="no-list">
	현재 존재하는 댓글이 없습니다.
</div>
<%
}
%>

<div class="pagination">
	<%
	if (reconcount > 0) {
		int pageCount = reconcount / pageSize + (reconcount % pageSize == 0 ? 0 : 1);
		int startPage = (int) (currentPage / 10) * 10 + 1;
		int pageBlock = 5;
		int endPage = startPage + pageBlock - 1;
		if (endPage > pageCount) {
			endPage = pageCount;
		}
		if (startPage > 10) {
	%>
	<a href="content.jsp?num=<%=num%>&pageNum=<%=startPage - 10%>"> [이
		전]</a>
	<%
	}
	for (int i = startPage; i <= endPage; i++) {
	%>
	<a href="content.jsp?num=<%=num%>&pageNum=<%=i%>"> [<%=i%>]
	</a>
	<%-- content페이지에서 pagenum으로 recon 페이지만 이동하게 설정 --%>
	<%
	}
	if (endPage < pageCount) {
	%>
	<a href="content.jsp?num=<%=num%>&pageNum=<%=startPage + 10%>"> [다
		음]</a>
	<%
	}
	}
	%>
</div>


