<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="member.MemberDAO"%>
<title>CODENEWS</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<jsp:include page="/member/header.jsp"></jsp:include>
<%
request.setCharacterEncoding("UTF-8");

String loginuser = null;
loginuser = (String) session.getAttribute("memId"); // ���� ����
String memtype = null; // �α����� ������ ��� Ÿ�� ����

// null���� 0���� ����
// �α����� ������ ������ ������ �� memtype������ ����
if (loginuser == null) {
	memtype = "0";
} else {
	MemberDAO memdao = MemberDAO.getInstance();
	MemberDTO usertype = memdao.getmember(loginuser);
	MemberDTO mem = memdao.getmember(loginuser);
	String press = mem.getPress();

	memtype = usertype.getMemberType();
}

// ��¥, �ð��� ������ �������� ��ȯ�ϱ� ���� ��ü ����
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

// ���� ������ ��ȣ�� pageNum������ ����
// ���� null�϶� 1�� ����
String pageNum = request.getParameter("pageNum");
if (pageNum == null) {
	pageNum = "1";
}

int pageSize = 10; // �� �������� ǥ�õ� �Խñ��� ����
int currentPage = Integer.parseInt(pageNum); // ���� ������ ��ȣ�� ����
int startRow = (currentPage - 1) * pageSize + 1; // ������ ���� ��ȣ
int endRow = currentPage * pageSize; // ������ �� ��ȣ
int newscount = 0; // ��ü �Խñ� ���� ���� �� ����
int number = 0; // �Խñ��� ��ȣ�� ���� �� ����

List newsList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newscount = newsPro.getNewsCount(); // �߰� DAO

// �Խñ��� �ϳ��� ���� ��� �ش� �������� �Խñ��� ������ ����
if (newscount > 0) {
	newsList = newsPro.getNews(startRow, endRow); // �߰� DAO
}

// ���� ���������� �Խñ� ��ȣ�� �ű�� ���� ������ �Խñ� ��ȣ�� ����
number = newscount - (currentPage - 1) * pageSize;
%>

<body>
	<div class="page-wrap">
		<div class="boxname_link">
			<div class="boxname">
				<h3>��ü ����</h3>
			</div>
			<div align="right" class="boxname">
				<%
				// admin�϶� �۾��� Ȱ��ȭ
				if (memtype.equals("2")) {
				%>
				<button class="button" onclick="location='writeForm.jsp'">
					<b class="white-btn">�۾���</b>
				</button>
				<%
				// �����϶� �۾��� Ȱ��ȭ
				} else if (memtype.equals("-1")) {
				%>
				<button class="button" onclick="location='writeForm.jsp'">
					<b class="white-btn">�۾���</b>
				</button>
				<%
				// ��ȸ���� ��� ��ư ��ġ�� �޽��� ���
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
		<div class="no-list">
			<h3>�˼��մϴ�.. ���� ���� ��Ͽ� ��簡 �����ϴ�.</h3>
			<h4>
				������ �غ� ���Դϴ�.<br /> ���߿� �ٽ� �̿��Ͽ� �ֽñ� �ٶ��ϴ�.
			</h4>
		</div>

		<%
		} else {
		%>

		<table>
			<colgroup>
				<col style="width:5%;"/>
				<col style="width:50%;"/>
				<col style="width:10%;"/>
				<col style="width:15%;"/>
				<col style="width:15%;"/>
				<col style="width:5%;"/>
			</colgroup>
			<tr>
				<th>�ۼ� ��ȣ</th>
				<th>����(����)</th>
				<th>�ۼ���</th>
				<th>��л�</th>
				<th>�ۼ���</th>
				<th>��ȸ��</th>
			</tr>
		<%
		// newsList���� NewsDTO�� ����Ǿ��ִ� ������ �� �྿ ���
		for (int i = 0; i < newsList.size(); i++) {
			NewsDTO article = (NewsDTO)newsList.get(i);
		%>
		
			<tr>
				<%-- �ֽű��� ���� ���� ��ġ�ϵ��� ��Ͽ��� �������� ��ȣ�� �ο� --%>
				<td><%=number--%></td>
				<td class="click" onclick="location='content.jsp?num=<%=article.getNum()%>'">
					<div><%=article.getTitle()%></div>
					
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
		<div class="pagination">
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
			<a href="list.jsp?pageNum=<%=i%>">[<%=i%>]</a>
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
		</div>
		<jsp:include page="/member/footer.jsp"></jsp:include>
</body>


