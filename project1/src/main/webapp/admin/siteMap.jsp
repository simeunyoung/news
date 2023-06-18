<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<center><h2>사이트맵(테스트페이지)</h2></center>

<%String sid = (String)session.getAttribute("sid");%>
sid = <%=sid%>

<hr>

<h3>관리자</h3>
<a href="journalistForm.jsp">기자변경 폼 v</a> &nbsp;
<a href="journalistPro.jsp">기자변경 프로 v</a> &nbsp;<br />
<a href="journalistList.jsp">기자변경 리스트</a> &nbsp;
<a href="journalistListPro.jsp">기자변경 리스트 프로</a> &nbsp;

<hr>

<h3>문의</h3>
<a href="qnaWrite.jsp">QNA 작성 v</a> &nbsp;
<a href="qnaList.jsp">QNA 목록 v</a> &nbsp;
<a href="qnaContent.jsp?num=38&pageNum=38">QNA 내용 v</a> &nbsp; <br />
<a href="/project1/helper/1-1Form.jsp">1:1 문의작성 v</a> &nbsp;
<a href="1-1List.jsp">1:1 문의목록 v</a> &nbsp;
<a href="1-1Content.jsp?num=54&pageNum=1">1:1 내용 v</a>

<hr>

<h3>로그인</h3>
<a href="/project1/login/signupForm.jsp">회원가입 v</a> &nbsp;
<a href="/project1/login/signinForm.jsp">로그인 v</a> &nbsp;
<a href="/project1/login/logout.jsp">로그아웃 v</a>
