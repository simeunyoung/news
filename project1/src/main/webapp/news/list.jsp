<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>  
<title>���� ����Ʈ ���� div�±� Ȱ���Ͽ� ������ũ</title>
<jsp:include page="header2.jsp"></jsp:include>
<%
request.setCharacterEncoding("UTF-8");
int pageSize = 10;
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = request.getParameter("pageNum");

if(pageNum == null){
pageNum = "1";
}

int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;
int newscount = 0;
int number = 0;

List newsList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newscount = newsPro.getNewsCount(); // �߰� DAO

if(newscount > 0){
newsList = newsPro.getNews(startRow, endRow); // �߰� DAO
}

number = newscount - (currentPage - 1) * pageSize;
%>


<div class="form_box">

<h3>��� ����(�ѷ�����) <button onclick="location='writeForm.jsp'" >�� ����</button></h3>

<%  if(newscount == 0){ // �Խñ��� ���� �� %>
<br /><br /><br /><br /><br /> <center> <h3>�˼��մϴ�.. ���� ���� ��Ͽ� ��簡 �����ϴ�.</h3>
<h4> ������ �غ� ���Դϴ�.<br /> ���߿� �ٽ� �̿��Ͽ� �ֽñ� �ٶ��ϴ�. </h4>
</center> <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
<% }else{ %>

<div class="table_box">
<div class="one_box" align="center"><b>�ۼ� ��ȣ</b></div>
<div class="two_box" align="center"><b>����(����)</b></div>
<div class="three_box" align="center"><b>�ۼ���</b></div>
<div class="four_box" align="center"><b>��л�</b></div>
<div class="five_box" align="center"><b>�ۼ���</b></div>
<div class="six_box" align="center"><b>��ȸ��</b></div>
</div><hr />
<% for(int i = 0; i < newsList.size(); i++){
NewsDTO article = (NewsDTO)newsList.get(i); %>
<div>
<a href="content.jsp?num=<%=article.getNum()%>"><font color="#000000">
<div class="text_box">
<div class="one_box" align="center"><%=number--%></div>
<div class="two_see" >
<b><font size="4px" color="#000000"><%=article.getTitle() %></font></b><br /><br />&nbsp;&nbsp;<%=article.getCon() %></div>
<div class="three_box" align="center"><%=article.getNick() %></div>
<div class="four_box" align="center"><%=article.getPress() %> </div>
<div class="five_box" align="center"><%=sdf.format(article.getReg()) %> </div>
<div class="six_box" align="center"><%=article.getViews() %> </div>
</div></font></a></div>
<% if(i != newsList.size()){ %>

<%} } } %>
<div align="center">
<%
if(newscount > 0){
int pageCount = newscount / pageSize + (newscount % pageSize == 0 ? 0 : 1);
int startPage = (int)(currentPage / 10) * 10 + 1;
int pageBlock = 10;
int endPage = startPage + pageBlock - 1;
if(endPage > pageCount){
endPage = pageCount;
}
if(startPage > 10){%>
<a href="list.jsp?pageNum=<%=startPage - 10 %>"> [�� ��]</a>
<%} for(int i = startPage; i <= endPage; i++){%>
<a href="list.jsp?pageNum=<%=i%>"> [<%=i %>]
</a>
<%}if(endPage < pageCount){ %>
<a href="list.jsp?pageNum=<%=startPage + 10%>"> [�� ��]</a>
<% } } %>

</div>



<style>
*{
margin:0;
padding:0;
box-sizing:border-box;
}

.form_box {
background-color: #ffffff;
margin: 10px;
border-radius: 4px;
border: 1px solid #ddd;
padding: 10px;
}
.text_box {
display: flex;
background-color: #ffffff;
margin: 3px;
border-radius: 4px;
border: 1px solid #ddd;
padding: 2px;
width: 100%;
}
.table_box {
display: flex;
height: 5%;
width: 100%;
margin:0;
padding:0;
box-sizing:border-box;
}

.one_box {
margin: 10px;
padding: 10px;
width: 7%;
}
.two_box {
margin: 10px;
padding: 10px;
width: 60%;
}
.two_see {
margin: 10px;
padding: 10px;
width: 60%;
text-overflow: ellipsis;  
overflow : hidden;
display: -webkit-box;
-webkit-line-clamp: 4;
-webkit-box-orient: vertical;
}
.three_box {
margin: 10px;
padding: 10px;
width: 10%;
}
.four_box {
margin: 10px;
padding: 10px;
width: 8%;
}
.five_box {
margin: 10px;
padding: 10px;
width: 10%;
}
.six_box {
margin: 10px;
padding: 10px;
width: 5%;
}

</style>