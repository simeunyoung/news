<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>
<title>���� ����Ʈ ���� div�±� Ȱ���Ͽ� ������ũ</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<jsp:include page="/member/header.jsp"></jsp:include>
<%
request.setCharacterEncoding("UTF-8");

String loginuser = null;
loginuser = (String) session.getAttribute("memId");
String memtype = null;

if (loginuser == null) {
	memtype = "0";
} else {
	MemberDAO memdao = MemberDAO.getInstance();
	MemberDTO usertype = memdao.getmember(loginuser);

	memtype = usertype.getMemberType();
}

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}

int pageSize = 10;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
int newscount = 0;
int number = 0;

List newsList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newscount = newsPro.getNewsCount(); // �߰� DAO

if (newscount > 0) {
	newsList = newsPro.getNews(startRow, endRow); // �߰� DAO
}

number = newscount - (currentPage - 1) * pageSize;
%>

������ ���� :
<%=loginuser%>


<body>
	<div class="form_box">
		<div class="boxname_link">
			<div class="boxname">
				<h3>��� ����(�ѷ�����)</h3>
			</div>
			<div align="right" class="boxname">
				<%
				if (memtype.equals("2")) {
				%>
				<button class="button" onclick="location='writeForm.jsp'">
					<b>�۾���</b>
				</button>
				<%
				} else if (memtype.equals("-1")) {
				%>
				<button class="button" onclick="location='writeForm.jsp'">
					<b>�۾���</b>
				</button>
				<%
				} else if (memtype.equals("0")) {
				%>
				���� ��α��� ���Դϴ�.
				<%
				}
				%>
			</div>
		</div>


		<%
		if (newscount == 0) { // �Խñ��� ���� ��
		%>
		<br />
		<br />
		<br />
		<br />
		<br />
		<center>
			<h3>�˼��մϴ�.. ���� ���� ��Ͽ� ��簡 �����ϴ�.</h3>
			<h4>
				������ �غ� ���Դϴ�.<br /> ���߿� �ٽ� �̿��Ͽ� �ֽñ� �ٶ��ϴ�.
			</h4>
		</center>
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<br />
		<%
		} else {
		%>

		<table>
			<tr>
				<th>�ۼ� ��ȣ</th>
				<th>����(����)</th>
				<th>�ۼ���</th>
				<th>��л�</th>
				<th>�ۼ���</th>
				<th>��ȸ��</th>
			</tr>
		</table>
		<table>
		<%
		for (int i = 0; i < newsList.size(); i++) {
			NewsDTO article = (NewsDTO) newsList.get(i);
		%>
		
			<tr>
				<td><%=number--%></td>
				<td>
					<div onclick="location='content.jsp?num=<%=article.getNum()%>'"><%=article.getTitle()%></div>
					<div><%=article.getCon()%></div>
				</td>
				<td><%=article.getId()%></td>
				<td><%=article.getPress()%></td>
				<td><%=sdf.format(article.getReg())%></td>
				<td><%=article.getViews()%></td>
			</tr>
		
		<%
		if (i != newsList.size()) {
		%>

		<%
		}
		}%>
		</table>
		<%
		}
		%>
		<div align="center">
			<%
			if (newscount > 0) {
				int pageCount = newscount / pageSize + (newscount % pageSize == 0 ? 0 : 1);
				int startPage = (int) (currentPage / 10) * 10 + 1;
				int pageBlock = 10;
				int endPage = startPage + pageBlock - 1;
				if (endPage > pageCount) {
					endPage = pageCount;
				}
				if (startPage > 10) {
			%>
			<a href="list.jsp?pageNum=<%=startPage - 10%>"> [�� ��]</a>
			<%
			}
			for (int i = startPage; i <= endPage; i++) {
			%>
			<a href="list.jsp?pageNum=<%=i%>"> [<%=i%>]
			</a>
			<%
			}
			if (endPage < pageCount) {
			%>
			<a href="list.jsp?pageNum=<%=startPage + 10%>"> [�� ��]</a>
			<%
			}
			}
			%>
		</div>
		<jsp:include page="/member/footer.jsp"></jsp:include>
</body>


