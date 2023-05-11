<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
<title>CODENEWS</title>

<%-- 
랜덤하게 sql 문에 가능한지 [ 자바 ] 5개가 나오게 한다.

int listnumber = 리스트명.size(); [ Complete ]
int random = (Math.random()*listnumber); [ Complete ]

for(int a=0;a<5;a++){
list news = 리스트명.get(random);
}


일주일 기간중에 글을 저장. [ Complete ]
slq = "reg between trunc(sysdate - 6) and trunc(sysdate)"

DAO 메소드 

public List getNews7days() throws Exception {
	List newsList = new ArrayList();
	try {
		conn = getConnection();
		sql = "select * from news where reg between trunc(sysdate - 6) and trunc(sysdate)";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		while (rs.next()) {
			NewsDTO article = new NewsDTO();
			article.setNum(rs.getInt("num"));
			article.setNick(rs.getString("nick"));
			article.setNewstype(rs.getString("newstype"));
			article.setTitle(rs.getString("title"));
			article.setCon(rs.getString("con"));
			article.setReg(rs.getTimestamp("reg"));
			article.setPw(rs.getString("pw"));
			article.setViews(rs.getInt("views"));
			article.setPress(rs.getString("press"));
			article.setIp(rs.getString("ip"));
			article.setId(rs.getString("id"));
			newsList.add(article);
		}
	} catch (Exception ex) {
		ex.printStackTrace();
	} finally {
		oracleClose();
	}
	return newsList;
}


버튼 활성화 ( 새로고침 )

 --%>
 
<% request.setCharacterEncoding("UTF-8");
SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

List newsList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newsList = newsPro.getNews7days(); // list 페이지 자료 수집

int listnumber = newsList.size();

%>
<jsp:include page="/member/header.jsp"></jsp:include>
<div align="right"><button  onClick="window.location.reload()">새로고침</button></div>
<div class="boxname_link">
<div class="boxname"><h2><font color="#708090"><b>모든 뉴스 ( 최신순 )</b></font></h2></div>
<div align="right" class="boxname"><a href="list.jsp"><font color="#808080"><b>더 많은 뉴스 보러가기&nbsp;&nbsp;</b></font></a></div>
</div><br />
<div class="list_group">
<% for(int i = 0; i < 5; i++){
	
int random = (int)(Math.random()*(listnumber-1));
NewsDTO article = (NewsDTO) newsList.get(random); %>
<%=listnumber %>
<a href="content.jsp?num=<%=article.getNum()%>"><div class="list_showcase">
<div align="right"><font color="#a9a9a9"><b><%=article.getNewstype() %>&nbsp;뉴스</b></font></div>
<b><font size="5px" color="#696969"><%=article.getTitle() %></font></b><br />
<b><font size="4px" color="#778899"><%=article.getId() %> 기자</font></b><br /><br />
<div class="make_short">&nbsp;&nbsp;<font color="#000000"><%=article.getCon() %></div><br /><br />
<div align="right"><b>작성일자 : <%=sdf.format(article.getReg()) %></b></div></font>

</div></a><% }%></div>
<jsp:include page="/member/footer.jsp"></jsp:include>
 
<style>
*{
margin:0;
padding:0;
box-sizing:border-box;
}
.boxname_link{
display: flex;
}
.boxname{
width: 50%;
}
.list_group{
display: flex;
width: 100%;
height: 85%;
}
.list_showcase{
margin:2;
padding:4;
width: 280px;
height: 100%;
border: 2px solid #ddd;
border-radius: 8px;
}
.make_short{
text-overflow: ellipsis;  
overflow : hidden;
display: -webkit-box;
-webkit-line-clamp: 12;
-webkit-box-orient: vertical;
}
</style> 
 
 
 