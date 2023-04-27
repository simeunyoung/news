<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="news.NewsDTO" %>
<%@ page import="news.NewsDAO" %>
<%@ page import="java.util.*" %>
<%@ page import="member.MemberDTO" %>
<%@ page import="member.MemberDAO" %>

<jsp:include page="/member/header.jsp"></jsp:include>
<jsp:useBean id="dto" class="member.MemberDTO" />
<title>글 확인</title>
<%
String loginuser = (String)session.getAttribute("memId");

request.setCharacterEncoding("UTF-8");

int num = Integer.parseInt(request.getParameter("num")); //list에서 파라미터 값으로 게시글 보게 설정하기
String currentPage = request.getParameter("currentPage");

NewsDAO method = NewsDAO.getInstance();
NewsDTO text = method.getCon(num);

String title = text.getTitle();
String con = text.getCon();
%>
접속자 정보 : <%= loginuser%><br /><br /><hr />

<div class="content_box">
<div class="con1"><div class="conl"><b>뉴스 종류 : </b><%=text.getNewstype()%></div><div class="conr"><b>조회수 : </b><%=text.getViews()%></div></div>
<div class="con1"><b>Title : </b><%=text.getTitle()%></div>
<div class="con1"><div class="conl"><b>작성자 : </b><a href = "/project1/member/user_mypage_form.jsp?id=<%=text.getId()%>"><%=text.getNick()%></a>&nbsp;&nbsp;&nbsp;<b>언론사 : </b><%=text.getPress()%></div><div class="conr"><b>작성일 : </b><%=text.getReg()%></div></div>
<div class="con1"><b>내용 : </b><%=text.getCon()%></div><br />
<div align="right">
<%if(session.getAttribute("memId") == null) {%>
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">
<%}else if(loginuser.equals("admin")){%>
<input type="button" class="button" value="삭제하기" onclick="location='deleteForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">
<%}else if(loginuser.equals(text.getId())){ %>
<input type="button" class="button" value="수정하기" onclick="location='updateForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="삭제하기" onclick="location='deleteForm.jsp?num=<%=text.getNum()%>'">
<input type="button" class="button" value="돌아가기" onclick="location='list.jsp'">	
<%}%>

</div>
<br />

<%-- ========================= 경계선 ========================= --%>

<div class="recon_box">
<jsp:include page="recon.jsp">
<jsp:param value="<%=text.getTitle()%>" name="title"/>
<jsp:param value="<%=text.getCon()%>" name="con"/>
<jsp:param value="<%=num%>" name="num"/>
</jsp:include>
</div></div>
 

<style>
.button {
	background-color: #475d9f;
	border: 1px solid #323f6b;
	color: #ffffff;
	border-radius: 4px;
	padding: 2px 8px;
	font-size: 14px;
}	
.content_box{
background-color: #ffffff;
border-radius: 4px;
border: 1px solid #ddd;
padding: 10px;
}
.con_box{
background-color: #f5f4ee;
border-radius: 4px;
border: 1px solid #ddd;
padding: 10px;
}
.con1{
display: flex;
width: 100%;
}
.conl{
width: 80%;
}
.conr{
width: 20%;
}
.flexthing{
display: flex;
}
.recon_box{
background-color: #eff5ee;
border-radius: 4px;
border: 1px solid #ddd;
padding: 10px;
}
.textarea_box {
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 4px;
	margin: 3px 0;
	font-size: 14px;
	width: 90%;
	height: 80px;
}
.submit_button {
	background-color: #475d9f;
	color: #ffffff;
	border: 1px solid #ddd;
	border-radius: 8px;
	padding: 4px;
	margin: 3px 0;
	font-size: 20px;
	width: 80px;
	height: 80px;
}
</style>
















    
    