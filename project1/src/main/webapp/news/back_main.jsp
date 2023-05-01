<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<title>CodeNews에 오신걸 환영합니다.</title>
<%-- main에서 사용될 코드
1. main의 div에서 내부 div 태그를 이용해서 영역을 4가지로 분리
div 1 div 2
div 3 div 4
main div : display flex를 사용해서 배열을 맞춰 준다.
div 1 : topiclist.jsp <재가공 예정>
div 2 : company 언론사.jsp <재가공 예정>
div 3 : list.jsp <재가공 예정>
div 4 : company 기자.jsp <재가공 예정>

2.
 --%>
<%
request.setCharacterEncoding("UTF-8");

String loginuser = (String) session.getAttribute("memId");

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");

String pageNum = "1";
int pageSize = 5;
int currentPage = Integer.parseInt(pageNum);
int startRow = (currentPage - 1) * pageSize + 1;
int endRow = currentPage * pageSize;

List newsList = null;
NewsDAO newsPro = NewsDAO.getInstance();
newsList = newsPro.getNews(startRow, endRow); // 추가 DAO
%>
<jsp:include page="/member/header.jsp"></jsp:include>
<input type="button" value="리스트로 이동" onClick="location='list.jsp'">
<input type="button" value="sessionTest"
	onClick="location='sessiontest.jsp'">
접속자 정보 :
<%=loginuser%>
<div class="main_box">
	<div class="left_box">		
		
		<div class="list_box">
			<div class="boxname_link">
				<div class="boxname">
					<h2>
						<font color="#708090"><b>모든 뉴스 ( 최신순 )</b></font>
					</h2>
				</div>
				<div align="right" class="boxname">
					<a href="list.jsp"><font color="#808080"><b>더 많은 뉴스
								보러가기&nbsp;&nbsp;</b></font></a>
				</div>
			</div>
			<br />
			<div class="list_group">
				<%
				for (int i = 0; i < newsList.size(); i++) {
					NewsDTO article = (NewsDTO) newsList.get(i);
				%>
				<a href="content.jsp?num=<%=article.getNum()%>"><div
						class="list_showcase">

						<div align="right">
							<font color="#a9a9a9"><b><%=article.getNewstype()%>&nbsp;뉴스</b></font>
						</div>
						<b><font size="5px" color="#696969"><%=article.getTitle()%></font></b><br />
						<b><font size="4px" color="#778899"><%=article.getId()%>
								기자</font></b><br /> <br />
						<div class="make_short">
							&nbsp;&nbsp;<font color="#000000"><%=article.getCon()%>
						</div>
						<br /> <br />
						<div align="right">
							<b>작성일자 : <%=sdf.format(article.getReg())%></b>
						</div>
						</font>

					</div></a>
				<%
				}
				%>
			</div>
		</div>
	</div>
	<div class="right_box">
		<div class="companyc_box">
			<div class="boxname_link">
				<div class="boxname">
					<h2>
						<font color="#708090"><b>함께하는 기자</b></font>
					</h2>
				</div>
				<div align="right" class="boxname">
					<a href="list.jsp"><font color="#808080"><b>더 많은 기자
								보러가기&nbsp;&nbsp;</b></font></a>
				</div>
			</div>
			<br /> for문 시작 (기자이름 언론사 작성한글수량(타입별) 해당기자프로필로이동링크 구독버튼)
			<div class="rightbox_list"></div>
		</div>


		<div class="companyw_box">
			<div class="boxname_link">
				<div class="boxname">
					<h2>
						<font color="#708090"><b>함께하는 언론사</b></font>
					</h2>
				</div>
				<div align="right" class="boxname">
					<a href="list.jsp"><font color="#808080"><b>더 많은 언론사
								보러가기&nbsp;&nbsp;</b></font></a>
				</div>
			</div>
			<br /> for문 시작 (언론사 활동중인기자인원 해당언론사소속기자전체작성글수량(타입별) 구독버튼)
			<div class="rightbox_list"></div>

		</div>
	</div>

</div>
<jsp:include page="/member/footer.jsp"></jsp:include>
<style>
.rightbox_list{
width: 460px;
height: 100px;
border: 2px solid #ddd;
border-radius: 8px;
}
.boxname_link{
display: flex;
}
.boxname{

}
.topic_onlyone{
width: 750px;
height: 410px;
border: 2px solid #ddd;
border-radius: 8px;
}
.topic_other{
width: 730px;
height: 125px;
border: 2px solid #ddd;
border-radius: 8px;
margin:2;
padding:4;
}
.make_short{
text-overflow: ellipsis;  
overflow : hidden;
display: -webkit-box;
-webkit-line-clamp: 12;
-webkit-box-orient: vertical;

}
.list_showcase{
margin:2;
padding:4;
width: 280px;
height: 100%;
border: 2px solid #ddd;
border-radius: 8px;
}
.list_group{
display: flex;
width: 100%;
height: 85%;
}
.main_box {
display: flex;
gap:10px;
width: 100%;
height: 100%;
}
.left_box {
width: 73%;
height: 100%;
}
.right_box {
width: 25%;
height: 100%;
}
.topic_box{
border: 1px solid #ddd;
border-radius: 4px;
padding: 4px;
font-size: 14px;
width: 100%;
height: 50%;
margin-bottom:10px;
}
.list_box{
border: 1px solid #ddd;
border-radius: 4px;
padding: 4px;
font-size: 14px;
width: 100%;
height: 50%;
}
.companyc_box{
border: 1px solid #ddd;
border-radius: 4px;
padding: 4px;
font-size: 14px;
width: 100%;
height: 40%;
margin-bottom:10px;
}
.companyw_box{
border: 1px solid #ddd;
border-radius: 4px;
padding: 4px;
font-size: 14px;
width: 100%;
height: 60%;
}
</style>