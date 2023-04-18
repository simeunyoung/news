
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@page import="revalue.RevalueDTO"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="revalue.RevalueDAO"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>

<html>
<head>
<%-- css파일 경로 지정 --%>
<link href="/project1/resource/css/mypage.css" rel="stylesheet" >
<link href="/project1/resource/css/style.css" rel="stylesheet" >

<%
	int pageSize = 10; // 한 페이지에 보여줄 목록의 수
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<%
	String id = (String)session.getAttribute("memId");
	String pageNum = request.getParameter("pageNum");
	String num = request.getParameter("num");
	
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage - 1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	
	List articleList = null;
	MemberDAO manager = MemberDAO.getInstance();
	RevalueDAO rv = RevalueDAO.getInstance();
	MemberDTO member = manager.getMember(id);
	
	int count = rv.getMyArticleCount(id);
	if(count > 0){
		articleList = rv.getMyArticles(id, startRow, endRow);
	}
	
	int number = count - (currentPage - 1) * pageSize;

		if(id == null){
%>
			<script>
				location='/project1/member/loginForm.jsp';
			</script>
<%
			
		}else{
%>

</head>
<body>
	<%-- 컨텐츠의 너비를 조정, 페이지의 레이아웃 조절 --%>
	<div class="container">
		<%-- 페이지에서 메인 컨텐츠를 감싸는 역할 --%>
		<div class="main-body">
			<%-- breadcrumb = 네비게이션 --%>
			<nav aria-label="breadcrumb" class="main-breadcrumb">
				<%-- 정렬된 목록을 나타냄 --%>
				<ol class="breadcrumb">
					<%-- 각 항목별로 브레드스크럼 리스트의 일부가 됨 --%>
					<%-- 사용자가 이전 페이지 or 홈으로 돌아갈 수 있음 --%>
					<li class="breadcrumb-item"><a href="index.html">Home</a></li>
					<li class="breadcrumb-item active" aria-current="page">ueser
						Profile</li>
				</ol>
			</nav>

			<%-- 열과 열 사이의 간격 조정 --%>
			<div class="row gutters-sm">
				<%-- col-mb-4 = mb는 중간 크기 화면 4는 가로크기, mb-3 = 하단 여백 --%>
				<div class="col-md-4 mb-3">
					<%-- card 본문을 감쌈 --%>
					<div class="card">
						<div class="card-body">
							<%-- 자식요소들을 정렬 --%>
							<div class="d-flex flex-column align-items-center text-center">
								<%-- 이미지 가져오고 크기 조정 --%>
								<img src="https://bootdey.com/img/Content/avatar/avatar7.png"
									alt="Admin" class="rounded-circle" width="150">
								<%-- 이름, 나머지 글자들 크기 및 글자색 조정 --%>
								<div class="mt-3">
									<h4>user</h4>
									<p class="text-secondary mb-1">Full Stack Developer</p>
									<p class="text-muted font-size-sm">Bay Area, San Francisco,
										CA</p>
									<button class="btn btn-outline-primary" onclick="location='deleteForm.jsp'">탈퇴하기</button>
								</div>
							</div>
						</div>
					</div>
				</div>

				<%-- 프로필 카드 생성 --%>
				
				<div class="col-md-8">
					<div class="card mb-3">
					<%if(num  == null){ %>
						<div class="card-body">
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">ID</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<%=member.getId() %>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">PW</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<%=member.getPw() %>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">NAME</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<%=member.getName() %>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">NICKNAME</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<%=member.getNick() %>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">EMAIL</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<%=member.getEmail() %>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">TEL</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<%=member.getTel() %>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">BIRTHDATE</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<%=member.getBirthdate() %>
								</div>
							</div>
							<hr>
						
							<div class="row">
								<div class="col-sm-12">
									<a class="btn btn-info"	onclick="location='user_mypage_form.jsp?num=1'">수정하기</a>
								</div>
							</div>
						</div>

					<% }else if(num.equals("1")){%>
					<form action="updatePro.jsp" method="post">
						<div class="card-body">
						
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">ID</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<%=member.getId() %>
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">PW</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input type="text" name="pw" value="<%=member.getPw() %>">
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">NAME</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input type="text" name="name" value="<%=member.getName() %>">
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">NICKNAME</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input type="text" name="nick" value="<%=member.getNick() %>">
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">EMAIL</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input type="text" name="email" value="<%=member.getEmail() %>">
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">TEL</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input type="text" name="tel" value="<%=member.getTel() %>">
								</div>
							</div>
							<hr>
							<div class="row">
								<div class="col-sm-3">
									<h6 class="mb-0">BIRTHDATE</h6>
								</div>
								<div class="col-sm-9 text-secondary">
									<input type="text" name="birthdate" value="<%=member.getBirthdate() %>">
								</div>
							</div>
						
							<hr>
							<%-- 프로필 편집 --%>
							<div class="row">
								<div class="col-sm-12">
									<input type="submit" class="btn btn-info" name="update" value="적용" />
									<a class="btn btn-info"	onclick="location='user_mypage_form.jsp'">취소</a>
								</div>
							</div>
						</div>
						</form>
					<%} %>
					</div>
							<div class="card">
								<div class="card-body">
									<h6 class="d-flex align-items-center mb-3">
										<i class="material-icons text-info mr-2">내가 쓴 댓글(<%=count %>)</i>
									</h6>
									<%if(count == 0){ %>
										<div>
											저장된 댓글이 없습니다.
										</div>
									<%}else { %>
										<table>
											<tr>
												<th>NO</th>
												<th>ID</th>
												<th>TITLE</th>
												<th>CONTENTS</th>
												<th>RECONTENTS</th>
												<th>IP</th>
												<th>DATE</th>												
											</tr>
											<%
											if(articleList != null){
												for(int i = 0; i < articleList.size(); i++){
													RevalueDTO article = (RevalueDTO)articleList.get(i);
											%>
												<tr>
													<td><%=number-- %></td>
													<td><%=article.getId() %></td>
													<td>
														<a href="news.jsp?num<%=article.getNum()%>&pageNum=<%=currentPage%>">
															<%=article.getTitle() %>
														</a>
													</td>
													<td><%=article.getCon() %></td>
													<td><%=article.getReCon() %></td>
													<td><%=article.getIp() %></td>
													<td><%=sdf.format(article.getReg()) %></td>											
												</tr>
											<%} %>
										</table>
									<%}} %>
									<%
										if(count > 0){
											// 하단 페이지 목록 번호 갯수 정하기
											int pageCount = count / pageSize + (count % pageSize == 0 ? 0 : 1);
											
											int startPage = (int)(currentPage/10) * 10 + 1;
											int pageBlock = 10;
											int endPage = startPage + pageBlock - 1;
											if(endPage > pageCount) { endPage = pageCount;}
											
											if(startPage > 10){ %>
												<a href="user_mypage_form.jsp?pageNum=<%=startPage - 10%>">[이전]</a>
											<%} 
											for(int i = startPage; i <= endPage; i++){%>
												<a href="user_mypage_form.jsp?pageNum=<%=i %>">[<%=i %>]</a>
											<%} 
											if(endPage < pageCount){%>
												<a href="user_mypage_form.jsp?pageNum=<%=startPage + 10 %>">[다음]</a>
											<%
										}
										}
									%>
									
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>	
</body>

</html>
<%}%>

