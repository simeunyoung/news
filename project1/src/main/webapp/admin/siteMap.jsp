<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<center><h2>사이트맵(테스트페이지)</h2></center>

<%String memId = (String)session.getAttribute("memId");%>
memId = <%=memId%>

<hr>

<h3>관리자</h3>
<a href="journalistForm.jsp">기자신청 폼 v</a> &nbsp;
<a href="journalistPro.jsp">기자신청 프로 v</a> &nbsp; <br />
<a href="journalistList.jsp">기자변경 리스트 v</a> &nbsp;
<a href="journalistListPro.jsp">기자변경 리스트 프로 v</a> &nbsp;


<hr>

<h3>문의</h3>
<a href="qnaWrite.jsp">QNA 작성 v</a> &nbsp;
<a href="qnaList.jsp">QNA 목록 v</a> &nbsp;
<a href="qnaContent.jsp?num=59&pageNum=1">QNA 내용 v</a> &nbsp; <br />
<a href="1-1Write.jsp">1:1 문의작성 v</a> &nbsp;
<a href="1-1List.jsp">1:1 문의목록 v</a> &nbsp;
<a href="1-1Content.jsp?num=43&pageNum=1">1:1 내용 v</a>

<hr>

<h3>로그인</h3>
<a href="/project1/member/inputForm.jsp">회원가입 v</a> &nbsp;
<a href="/project1/member/loginForm.jsp">로그인 v</a> &nbsp;
<a href="/project1/member/logout.jsp">로그아웃 v</a>
