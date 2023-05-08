<%@page import="member.MemberDAO"%>
<%@page import="member.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 정보</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<%
	String id = (String)session.getAttribute("memId");
	String num = request.getParameter("num");
	String id2 = request.getParameter("id");
	String pageType = request.getParameter("pageType");
	MemberDAO user = MemberDAO.getInstance();
	MemberDTO member = user.getMember(id2);
		
	int check = user.typeCheck(id); // 멤버타입 체크
	if(id == null){
		id = "";
	}
%>
<body>
	<div class="card mb-3">
		<%
			if (num == null) { // 정보만 보여주는 폼
		%>
		<div class="card-body info-wrap">
			<div class="row">
				<div class="col-sm-3">
					<h6 class="mb-0">NAME</h6>
				</div>
				<div class="col-sm-9 text-secondary">
					<%=member.getName()%>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-sm-3">
					<h6 class="mb-0">NICKNAME</h6>
				</div>
				<div class="col-sm-9 text-secondary">
					<%=member.getNick()%>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-sm-3">
					<h6 class="mb-0">EMAIL</h6>
				</div>
				<div class="col-sm-9 text-secondary">
					<%=member.getEmail()%>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-sm-3">
					<h6 class="mb-0">TEL</h6>
				</div>
				<div class="col-sm-9 text-secondary">
					<%=member.getTel()%>
				</div>
			</div>
			<hr>
			<div class="row">
				<div class="col-sm-3">
					<h6 class="mb-0">BIRTHDATE</h6>
				</div>
				<div class="col-sm-9 text-secondary">
					<%=member.getBirthdate()%>
				</div>
			</div>
			<hr>

			<div class="row">
				<div class="col-sm-12">
				<%if(id.equals(id2)){ // 본인이면 수정하기 버튼 활성화
				%>
					<a class="white-btn"
						onclick="location='user_mypage_form.jsp?num=1&id=<%=id%>&pageType=<%=pageType%>'">수정하기</a>
					<%} %>
				</div>
			</div>
			<input type="hidden" name="membertype" value="<%=member.getMemberType()%>">
		</div>

		<%
		} else if (num.equals("1")) { // 정보 수정하는 폼
		%>
		<form action="updatePro.jsp" method="post">
			<div class="card-body">

				<div class="row">
					<div class="col-sm-3">
						<h6 class="mb-0">ID</h6>
					</div>
					<div class="col-sm-9 text-secondary">
						<%=member.getId()%>
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-sm-3">
						<h6 class="mb-0">PW</h6>
					</div>
					<div class="col-sm-9 text-secondary">
						<input type="text" name="pw" value="<%=member.getPw()%>">
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-sm-3">
						<h6 class="mb-0">NAME</h6>
					</div>
					<div class="col-sm-9 text-secondary">
						<input type="text" name="name" value="<%=member.getName()%>">
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-sm-3">
						<h6 class="mb-0">NICKNAME</h6>
					</div>
					<div class="col-sm-9 text-secondary">
						<input type="text" name="nick" value="<%=member.getNick()%>">
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-sm-3">
						<h6 class="mb-0">EMAIL</h6>
					</div>
					<div class="col-sm-9 text-secondary">
						<input type="text" name="email" value="<%=member.getEmail()%>">
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-sm-3">
						<h6 class="mb-0">TEL</h6>
					</div>
					<div class="col-sm-9 text-secondary">
						<input type="text" name="tel" value="<%=member.getTel()%>">
					</div>
				</div>
				<hr>
				<div class="row">
					<div class="col-sm-3">
						<h6 class="mb-0">BIRTHDATE</h6>
					</div>
					<div class="col-sm-9 text-secondary">
						<input type="text" name="birthdate"
							value="<%=member.getBirthdate()%>">
					</div>
				</div>
				<input type="hidden" name="memberType"
							value="<%=member.getMemberType()%>">
				<hr>
				<%-- 프로필 편집 --%>
				<div class="row">
					<div class="col-sm-12">
						<input type="submit" class="btn btn-info" name="update" value="적용" />
						<input type="hidden" name="pageType" value="<%=pageType%>">
						<a class="btn btn-info" onclick="location='user_mypage_form.jsp?id=<%=id%>&pageType=<%=pageType%>'">취소</a>
					</div>
				</div>
			</div>
		</form>
		<%
			}
		%>
	</div>
</body>
</html>