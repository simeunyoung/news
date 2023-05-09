<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.*"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>

<b>���</b>
<br />
<br />
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
System.out.println(title+" "+ con);
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
		<input type="text" class="textarea_box" name="recon" placeholder="����� �Է����ּ���.">
		<input type="submit" value="�Է�" class="submit_button">
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
<div align="right">
	<%=recontext.getReg()%>
	<%
	if (session.getAttribute("memId") == null) {
	} else if (usernick.equals(recontext.getId())) {
	%>
	<a
		href="reconUpdateForm.jsp?num=<%=recontext.getNum()%>&connum=<%=num%>"><font
		color="#808080">����</font></a>&nbsp;
	<%-- not fixed --%>
	/&nbsp;<a
		href="reconDeletePro.jsp?num=<%=recontext.getNum()%>&connum=<%=num%>"><font
		color="#808080">����</font></a>
	<%-- not fixed --%>
	<%
	} else if (usertype.equals("2")) {
	%>
	<a
		href="reconDeletePro.jsp?num=<%=recontext.getNum()%>&connum=<%=num%>"><font
		color="#808080">����</font></a>
	<%-- not fixed --%>
	<%
	}
	%>
</div>
<b><%=recontext.getNick()%></b>
<font color="#808080">#<%=recontext.getId()%></font>
[ IP :
<%=recontext.getIp()%>
]

<%=recontext.getRecon()%>

<hr />
<%
}
} else {
%>
<center>
	���� �����ϴ� ����� �����ϴ�.
</center>
<%
}
%>

<div align="center">
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


