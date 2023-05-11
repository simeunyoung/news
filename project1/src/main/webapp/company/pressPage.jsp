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
<% String id = (String)session.getAttribute("memId");%>
<% String exist = dao.selectExist(id);%>
<% if(exist == null){exist = "";}%>
<% String[] parts = exist.split("@");					//part = 현재구독목록을 배열로 변환한것(String[])
	boolean include = false;							//include = part에 파라미터로 받은 press가 equals면 true 아니면 false
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

	  // 다음 페이지로 이동(history를 남기지 않고 이동)		//파라미터 press, exist, id 전달
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

	  // 다음 페이지로 이동(history를 남기지 않고 이동)		//파라미터 press, exist, id 전달
	  location.replace('pressDelete.jsp?press=<%=press%>&exist=<%=exist%>&id=<%=id%>');
	}

</script>
<html>
<head>
<title>CODENEWS</title>
<%-- css파일 경로 지정 --%>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
<body>
<jsp:include page="/member/header.jsp" />

<div class="container">
    <div class="page-wrap press">
          <nav aria-label="breadcrumb" class="main-breadcrumb">
            <ol class="breadcrumb">
              <%-- 각 항목별로 브레드스크럼 리스트의 일부가 됨 --%>
              <%-- 사용자가 이전 페이지 or 홈으로 돌아갈 수 있음 --%>
              <li class="breadcrumb-item"><a href="index.html">Home</a></li>
              <li class="breadcrumb-item active" aria-current="page">언론사페이지</li>
            </ol>
          </nav>
          <div class="press-wrap">
            <div>
              <div class="card profile flex-center">
                <div class="card-body">
                    <div>
                      <h4><%=press.toUpperCase()%></h4>
                      <% if(id == null){					//session id가 없으면 loginForm.jsp로 보내는 버튼%>
                      	<button class="submit-btn" onclick= "location.href='/project1/member/loginForm.jsp'">구독하기</button>
                      <% }else if(!include){				//현재 구독목록에 포함되어있지 않을때 버튼(pressPro.jsp로 보냄)%>
                      	<button class="submit-btn" onclick= "deletePageHistoryAndRedirect()">구독하기</button>
                      <%}else{								//현재 구독목록에 포함되어 있을때 버튼(pressDelete.jsp로 보냄)%>
                      	<button class="submit-btn" onclick= "deletePageHistoryAndRedirect1()">구독취소</button>
                      <%}%>
                    </div>
                </div>
              </div>
            </div>
            
          
            <div class="press-right">
              <div class="card js-list">
                <div class="card-body">
                    <h6>기자목록</h6>
                    <div class="js-item">
	                    <%ArrayList<MemberDTO> reporterList = dao.selectReporter(press);		//press에 해당하는 기자 출력
						for(int z = 0 ; z < reporterList.size() ; z++){%>
							<a href="/project1/member/user_mypage_form.jsp?id=<%=reporterList.get(z).getId()%>&pageType=2"><%=reporterList.get(z).getName()%></a>&nbsp;&nbsp;&nbsp;
						<%} %>
                    </div>
                  </div>
              </div>
                  <div class="card">
                    <div class="card-body">

                      <%
	                      ArrayList<NewsDTO> articleList = rv.selectArticle(press);			//매개변수로 준 언론사에 해당하는 기사들을 담은 ArrayList 리턴			
	                      	int count = articleList.size();

                      %>
                    	<p class="text-info">관련 기사 (3)</p>
                    	<%if(count == 0){ %>
							<div class="no-list">
								저장된 글이 없습니다.
							</div>
							<%}else { %>
								<table>
									<tr>
										<th>NO</th>
										<th>ID</th>
										<th>TITLE</th>
										<th>PRESS</th>
										<th>DATE</th>												
									</tr>			<%-- articleList에 담겨있는 기사들 출력 --%>
									<%for(int i = 0 ; i <3; i++){%>		
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
							
							<%}
									
									} %>
							</table>
                    </div>
                  </div>
            </div>
          </div>
        </div>
    </div>
    <jsp:include page="/member/footer.jsp"></jsp:include>
</body>
</html>