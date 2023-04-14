<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>


<jsp:useBean id="dto" class="project.newsDTO" />
<jsp:setProperty property="*" name="dto" />

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
              <li class="breadcrumb-item active" aria-current="page">Journalist Profile</li>
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
                      <h4>journalist</h4>
                      <p class="text-secondary mb-1">Full Stack Developer</p>
                      <p class="text-muted font-size-sm">Bay Area, San Francisco, CA</p>
                      <button class="btn btn-primary">Follow</button>
                      <button class="btn btn-outline-primary">Message</button>
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
                      <h6 class="mb-0">Full Name</h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      Kenneth Valdez
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <h6 class="mb-0">Email</h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      fip@jukmuh.al
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <h6 class="mb-0">Phone</h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      (239) 816-9029
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <h6 class="mb-0">Mobile</h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      (320) 380-4539
                    </div>
                  </div>
                  <hr>
                  <div class="row">
                    <div class="col-sm-3">
                      <h6 class="mb-0">Address</h6>
                    </div>
                    <div class="col-sm-9 text-secondary">
                      Bay Area, San Francisco, CA
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
                      <h6 class="d-flex align-items-center mb-3"><i class="material-icons text-info mr-5">나의 기사</i></h6>
                    	<%-- 기자의 기사 넣을 부분 --%>
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

