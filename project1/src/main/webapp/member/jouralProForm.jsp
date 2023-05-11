<%@page import="java.net.URLEncoder"%>
<%@page import="member.MemberDTO"%>
<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CODENEWS</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="https://kit.fontawesome.com/dbaea98925.js" crossorigin="anonymous"></script>
<script src="/project1/resource/js/script.js"></script>
</head>

<%

	String id = (String) session.getAttribute("memId");
	String id2 = request.getParameter("id");
	String num = request.getParameter("num");
	String pageType = request.getParameter("pageType");
	MemberDTO dto = new MemberDTO();
	MemberDAO dao = MemberDAO.getInstance();
	dto = dao.getMember(id); // id에 해당하는 정보 가져오기
	if(id == null){
		id = "";
	}
    
	// 구독하기
	String bookList = dao.selectBookList(id); // 구독목록 가져오기

	if(bookList == null){bookList = "";}

	String [] books = bookList.split("@"); // @ 기준으로 나눠서 list에 저장
	
		boolean include = false;
		for(String book : books){ // 나눈 아이디 목록 하나씩 비교
			if(book.equals(id2)){
				include = true;
				break;
			}
		}

%>

<script>
// 프로필 사진 변경하기 
	function setThumbnail(event){
		var reader = new FileReader();
		
		reader.onload = function(event){ // 이미지 선택하면 속성 변경
			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);
			img.setAttribute("class", "rounded-circle");
			img.setAttribute("width", "150");
			document.querySelector("div#image_container img").remove(); // 기존이미지 삭제
			document.querySelector("div#image_container").appendChild(img); // 새로운 이미지 넣기
		};
		
		reader.readAsDataURL(event.target.files[0]);
	}
	
	function imgUpdate(){ // 이미지 수정 버튼
		target = document.getElementsByClassName("imgUpdate");
		target[0].style.display = 'flex';
	}
	</script>
<body>
<!-- include 기자 프로필 폼 -->
	<div class="card">
		<div class="card-body">
			<div>
				<div id="image_container">
				<%if(id.equals(id2)){ %>
					<button type="button" class="modify-btn" onclick="imgUpdate()"><i class="fa-solid fa-pen fa-lg" style="color:#fff;"></i></button>
				<%} %>

				<%if(dto == null) {%>
					<img src="/project1/resource/img/profile01.jpg" class="rounded-circle" width="150">
				<%} else {%>
					<%if(dto.getImg()==null || dto.getImg().equals("null")){ %><!-- 가져올 이미지가 없으면 기본 프로필사진 -->
						<img src="/project1/resource/img/profile01.jpg" class="rounded-circle" width="150">
					<%}else{ %>
						<img src="/project1/resource/img/<%=dto.getImg()%>" class="rounded-circle" width="150">	
					<%}%>		
				<%}%>
				</div>
				
					<form action="imgUpload.jsp?pageType=<%=pageType %>" method="post" enctype="multipart/form-data">
						<div class="imgUpdate">
							<input type="file"	name="save" id="profile-pic" onchange="setThumbnail(event)"> <!-- 선택한 이미지 보여주고 pro로 보냄 -->
							<div>
								<input type="submit" class="upload-btn" >
							</div>
						</div>
					</form>
				

				<div class="mt-3">
					<h4 class="name"><%=id2 %>님</h4>
						<%if(id != null && id.equals(id2)){%><!-- 본인이면 탈퇴하기 활성화 -->
					<div class="flex-center"><button type="button" class="white-btn" onclick="location='deleteForm.jsp?pageType=2'">탈퇴하기</button></div>
						<%}else{ %>
							 <% if(!include){%><!-- 구독 중이면 취소, 아니면 구독하기 버튼 활성화 -->
		                      	<div class="flex-center"><button type="button" class="submit-btn" onclick="location='bookmarkPro.jsp?id=<%=id%>&id2=<%=id2%>&books=<%=bookList%>'">구독하기</button></div>
		                      <%}else{%>
		                      	<div class="flex-center"><button type="button" class="submit-btn" onclick="location='bookmarkDelete.jsp?id=<%=id%>&id2=<%=id2%>&books=<%=bookList%>'">구독취소</button></div>
                      		<%}%>
                      		<div><button type="button" class="bookmark-btn" onclick="location='/project1/company/pressForm.jsp'">구독현황 <i class="fa-solid fa-right-long"></i> </button></div>
						<%} %>
				</div>
			</div>
		</div>
	</div>
</body>
</html>