<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>

<b>���</b>

<%
String loginuser = (String) session.getAttribute("memId");
int num = Integer.parseInt(request.getParameter("num")); // �׼��±׿� ���� ���� num �Ķ���� ��
MemberDAO memdao = MemberDAO.getInstance();
MemberDTO userinfo = memdao.getmember(loginuser);
String usernick = null;
String usertype = null;
if (loginuser != null) { // ������ ������ ���� �� ����
	usernick = userinfo.getNick();
	usertype = userinfo.getMemberType();
}

String title = request.getParameter("title"); // �׼��±׿��� ������ �Ķ����
String con = request.getParameter("con"); // �׼� �±׿��� ������ �Ķ����
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
reconcount = method.getReconCount(title, con); // recon ������ �˾Ƴ��� �޼ҵ�
List recons = method.getRecon(title, con, startRow, endRow); // recon�� ���ǿ� �°� �������� �޼ҵ�
// <-- +
%>
<%
if (session.getAttribute("memId") == null) {
%>

<%
} else {
// recon ���������� reconForm�� �����ϰ� ������ ���� �����ؼ� Pro�������� �̵�
%>

<form action="reconwritePro.jsp" method="post" class="flexthing">
	<input type="hidden" name="id" value="<%=loginuser%>"> 
	<input type="hidden" name="nick" value="<%=userinfo.getNick()%>"> 
	<input type="hidden" name="title" value="<%=title%>"> 
	<input type="hidden" name="con" value="<%=con%>"> 
	<input type="hidden" name="contentpage" value="<%=num%>"> 
	<div class="recon-wrap">
		<input type="text" class="textarea_box" name="recon" placeholder="�Ǹ�ħ��, �弳 �� Ư�� ����� �����ϴ� ������ �Խ��� ��� �̿��� �� ���ù����� ���� ����� �� �ֽ��ϴ�.">
		<input type="submit" value="�Է�" class="submit-btn">
	</div>
	
</form>
<%
}
%>


<%
if (recons != null) {

	number = reconcount - (currentPage - 1) * pageSize; //+

	for (int rnum = 0; rnum < recons.size(); rnum++) {
		NewsDTO recontext = (NewsDTO) recons.get(rnum); //Object(list)�� --> DTO������ �����ְ� �ִ�.
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
	���� �����ϴ� ����� �����ϴ�.
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
	<a href="content.jsp?num=<%=num%>&pageNum=<%=startPage - 10%>"> [��
		��]</a>
	<%
	}
	for (int i = startPage; i <= endPage; i++) {
	%>
	<a href="content.jsp?num=<%=num%>&pageNum=<%=i%>"> [<%=i%>]
	</a>
	<%-- content���������� pagenum���� recon �������� �̵��ϰ� ���� --%>
	<%
	}
	if (endPage < pageCount) {
	%>
	<a href="content.jsp?num=<%=num%>&pageNum=<%=startPage + 10%>"> [��
		��]</a>
	<%
	}
	}
	%>
</div>


