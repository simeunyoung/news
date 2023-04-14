
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
    

<html>
<head>
<%-- css파일 경로 지정 --%>
<link href = "mypage.css" rel = "stylesheet" type = "text/css">
<%
	String id = (String)session.getAttribute("memId");

	MemberDAO manager = MemberDAO.getInstance();
	MemberDTO member = manager.getMember(id);
	

		if(id == null){
			%>
			<script>
				location='/project1/member/loginForm.jsp';
			</script>
			<%
			
		}else{
%>

</head>
<body onload="sessionCheck()">
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
              <li class="breadcrumb-item active" aria-current="page">ueser Profile</li>
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
                      <h4>user</h4>
                      <p class="text-secondary mb-1">Full Stack Developer</p>
                      <p class="text-muted font-size-sm">Bay Area, San Francisco, CA</p>
                      <button class="btn btn-outline-primary">탈퇴하기</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            
            <%-- 프로필 카드 생성 --%>
            <div class="col-md-8">
              <div class="card mb-3">
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
                  <%-- 프로필 편집 --%>
                  <div class="row">
                    <div class="col-sm-12">
                      <a class="btn btn-info " target="__blank" href="https://www.bootdey.com/snippets/view/profile-edit-data-and-skills">Edit</a>
                    </div>
                  </div>
                </div>
              </div>

              <div class="row gutters-sm">
                <div class="col-sm-6 mb-3">
                  <div class="card h-100">
                    <div class="card-body">
                      <h6 class="d-flex align-items-center mb-3"><i class="material-icons text-info mr-2">assignment</i>Project Status</h6>
                     
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
<%} %>
