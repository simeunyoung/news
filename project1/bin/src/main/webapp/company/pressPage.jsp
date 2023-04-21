<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberDTO" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "revalue.RevalueDAO"%>
<%@ page import = "revalue.RevalueDTO"%>
<% MemberDAO dao = MemberDAO.getInstance(); %>
<% String press = request.getParameter("press");%>
<% RevalueDAO rv = RevalueDAO.getInstance();%>
<% String id = (String)session.getAttribute("memId");%>


<html>
<head>
<%-- css파일 경로 지정 --%>
<link href = "mypage.css" rel = "stylesheet" type = "text/css">
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
              <li class="breadcrumb-item active" aria-current="page">언론사페이지</li>
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
                    <img src="https://bootdey.com/img/Content/avatar/avatar7.png" alt="Admin" class="rounded-circle" width="150">
                    <%-- 이름, 나머지 글자들 크기 및 글자색 조정 --%>
                    <div class="mt-3">
                      <h4><%=press.toUpperCase()%></h4>
                      <button class="btn btn-primary">구독하기</button>
                    </div>
                  </div>
                </div>
              </div>
              <%-- 항목에 대한 정보는 li태그로 시작, 아이콘 및 제목은 h6태그 내에 svg 태그로 나타냄, span태그로 링크 --%>
              
            </div>
            
            <%-- 프로필 카드 생성 --%>
            <div class="col-md-8">
              <div class="card mb-3">
                <div class="card-body">
                  <div class="row">
                    <div class="col-sm-3">
                      <h6 class="mb-0">기자목록</h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      <%ArrayList<MemberDTO> reporterList = dao.selectReporter(press);
					for(int z = 0 ; z < reporterList.size() ; z++){%>
					<a href="journalist_mypage_form.jsp?id=<%=reporterList.get(z).getId()%>"><%=reporterList.get(z).getName()%></a>&nbsp;&nbsp;&nbsp;
					<%} %>
                    </div>
                  </div>
                  
                  
                  <hr>
                  <%-- 프로필 편집 --%>
                  <div class="row">
                    <div class="col-sm-12">
                    </div>
                  </div>
                </div>
              </div>

              <div class="row gutters-sm">
                <div class="col-sm-6 mb-3">
                  <div class="card h-100">
                    <div class="card-body">
                      <h6 class="d-flex align-items-center mb-3"><i class="material-icons text-info mr-5">관련 기사</i></h6>
                      <%
                      // 임시 !!!
                      List articleList = new ArrayList();
                      	int count = 0;
                      	int number = 0;
                      	int currentPage = 0;
                      	int pageSize = 0;
                      %>
                    	<i class="material-icons text-info mr-2">내가 쓴 댓글(<%=count %>)</i>
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
													<%-- 임시 !!<td><%=sdf.format(article.getReg()) %></td> --%>											
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
        </div>
    </div>
</body>
</html>