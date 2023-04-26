<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.MemberDAO" %>
<%@ page import = "member.MemberDTO" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ page import = "news.NewsDTO"%>
<%@ page import = "news.NewsDAO"%>
<% MemberDAO dao = MemberDAO.getInstance(); %>
<% String press = request.getParameter("press");%>
<% NewsDAO rv = NewsDAO.getInstance();%>
<% String id = "test";//(String)session.getAttribute("memId");%>
<% String exist = dao.selectExist(id);%>
<% if(exist == null){exist = "";}%>
<%=exist%>
<% String[] parts = exist.split("@");
	boolean include = false;
	for (String part : parts) {
    if (part.equals(press)) {
        include = true;
        break;
    }
}
%>
<script>
function deletePageHistoryAndRedirect() {
	  // 쿠키에서 현재 페이지 방문 기록 삭제
	  var cookies = document.cookie.split(';');
	  for (var i = 0; i < cookies.length; i++) {
	    var cookie = cookies[i].trim();
	    if (cookie.startsWith('pageHistory=')) {
	      document.cookie = cookie.split('=')[0] + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
	      break;
	    }
	  }

	  // 다음 페이지로 이동
	  location.replace('pressPro.jsp?press=<%=press%>&exist=<%=exist%>&id=<%=id%>');
	}
function deletePageHistoryAndRedirect1() {
	  // 쿠키에서 현재 페이지 방문 기록 삭제
	  var cookies = document.cookie.split(';');
	  for (var i = 0; i < cookies.length; i++) {
	    var cookie = cookies[i].trim();
	    if (cookie.startsWith('pageHistory=')) {
	      document.cookie = cookie.split('=')[0] + '=; expires=Thu, 01 Jan 1970 00:00:00 UTC; path=/;';
	      break;
	    }
	  }

	  // 다음 페이지로 이동
	  location.replace('pressDelete.jsp?press=<%=press%>&exist=<%=exist%>&id=<%=id%>');
	}

</script>
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
                    <%-- 이름, 나머지 글자들 크기 및 글자색 조정 --%>
                    <div class="mt-3">
                      <h4><%=press.toUpperCase()%></h4>
                      <% if(!include){%>
                      <button class="btn btn-primary" onclick= "deletePageHistoryAndRedirect()">구독하기</button>
                      <%}else{%>
                      <button class="btn btn-primary" onclick= "deletePageHistoryAndRedirect1()">구독취소</button>
                      <%}%>
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
					<a href="/project1/member/journalist.jsp?id=<%=reporterList.get(z).getId()%>"><%=reporterList.get(z).getName()%></a>&nbsp;&nbsp;&nbsp;
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
                      //
                      ArrayList<NewsDTO> articleList = rv.selectArticle(press);				
                      	int count = articleList.size();

                      %>
                    	<i class="material-icons text-info mr-2">관련 기사 수(<%=count %>)</i>
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
												<th>PRESS</th>
												<th>DATE</th>												
											</tr>
											<%for(int i = 0 ; i < articleList.size() ; i++){%>
												<tr>
													<td><%=articleList.get(i).getNum() %></td>
													<td>
														<a href="/project1/news/content.jsp?num=<%=articleList.get(i).getNum()%>">
															<%=articleList.get(i).getTitle() %>
														</a>
													</td>
													<td><%=articleList.get(i).getId() %></td>
													<td><%=press.toUpperCase()%></td>
													<td><%=articleList.get(i).getReg() %></td>
													<%-- 임시 !!<td><%=sdf.format(article.getReg()) %></td> --%>											
												</tr>
										</table>
										<%}} %>
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