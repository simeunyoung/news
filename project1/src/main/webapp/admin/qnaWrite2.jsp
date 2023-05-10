<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="admin.AdminDAO"%>
<%@ page import="member.MemberDTO"%>

<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>

<%
	AdminDAO dao = AdminDAO.getInstance();
	String memId = (String)session.getAttribute("memId");
	MemberDTO dto = dao.setMember(memId);
	if(memId == null) {dto.setMemberType("0");}
%>
<jsp:include page="/member/header.jsp" />

<script src="helper.js"></script>
<title>Q&A</title>

<body onload="begin()">
	<div class="page-wrap qna2">
		<div class="write-form-wrap">
		<h2 class="write-tit">Q&A</h2>
			<form method="post" name="qnaform" action="qnaPro.jsp" onsubmit="return check()">
				<table>
				<colgroup>
					<col style="width:30%;">
					<col style="width:70%;">
				</colgroup>
					<tr height="30">
						<td align="center">문의유형</td>
						<td align="center">
							<select name="questionType">
								<option value='0'>선택</option>
								<option value='1'>자바(Java)</option>
								<option value='2'>파이썬(Python)</option>
								<option value='3'>자바스크립트(JavaScript)</option>
								<option value='4' selected>뉴스 제보하기</option>
								<option value='5'>제휴 및 문의하기</option>
								<option value='6'>신고하기</option>
							</select>
						</td>
					</tr>
					<%if(memId == null) {%>
					<tr height="30">
						<td align="center" width="150">아이디</td>
						<td align="center">
							<input type="hidden" name="id" value="비회원">비회원
							<input type="hidden" name="memberType" value="0" />
						</td>
					</tr>
					<tr height="30">
						<td align="center">작성자</td>
						<td><input type="text" name="name" size="50" placeholder="이름" /></td>
					</tr>
					<tr height="30">
						<td align="center">이메일</td>
						<td><input type="text" name="email" size="50" placeholder="이메일" /></td>
					</tr>
					<tr height="30">
						<td align="center">연락처(선택사항)</td>
						<td><input type="text" name="tel" size="50" placeholder="연락처" /></td>
					</tr>
					<%} else {%>
					<tr height="30">
						<td align="center" width="150">아이디</td>
						<td align="center">
							<input type="hidden" name="id" value="<%=dto.getId()%>" /><%=dto.getId()%>
							<input type="hidden" name="memberType" value="<%=dto.getMemberType()%>" />
						</td>
					</tr>
					<tr height="30">
						<td align="center">작성자</td>
						<td align="center"><input type="hidden" name="name" value="<%=dto.getName()%>" /><%=dto.getName()%></td>
					</tr>
					<tr height="30">
						<td align="center">이메일</td>
						<td><input type="text" name="email" value="<%=dto.getEmail()%>" size="70" /></td>
					</tr>
					<tr height="30">
						<td align="center">연락처</td>
						<td><input type="text" name="tel" value="<%=dto.getTel()%>" size="70" /></td>
					</tr>
					<%}%>
					<tr height="30">
						<td align="center">제목</td>
						<td><input type="text" name="title" size="70" /></td>
					</tr>
					<tr height="30">
						<td align="center">글 비밀번호</td>
						<td><input type="password" name="pw" size="70" placeholer="글 비밀번호" /></td>
					</tr>
					<tr height="30">
						<td align="center">문의내용</td>
						<td><textarea cols="70" rows="10" name="con"></textarea></td>
					</tr>
					<tr>
						<td colspan="2" align="center">
							<div class="button-wrap">
								<input type="submit" class="submit-btn" value="작성" />
								<input type="button" class="white-btn" value="취소" onclick="location='qnaList.jsp'" />
							</div>
						</td>
					</tr>
				</table>
			</form>
		</div>
	</div>
</body>
<jsp:include page="/member/footer.jsp"></jsp:include>