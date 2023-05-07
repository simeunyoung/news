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
<script src="/project1/resource/js/script.js"></script>
</head>

<%

	String id = (String) session.getAttribute("memId");
	String id2 = request.getParameter("id");
	String num = request.getParameter("num");
	String pageType = request.getParameter("pageType");
	MemberDTO dto = new MemberDTO();
	MemberDAO dao = MemberDAO.getInstance();
	dto = dao.getMember(id);
	if(id == null){
		id = "";
	}
    
	// 구독하기
	String bookList = dao.selectBookList(id);

	if(bookList == null){bookList = "";}

	String [] books = bookList.split("@");
	
		boolean include = false;
		for(String book : books){
			if(book.equals(id2)){
				include = true;
				break;
			}
		}

%>

<style>
.imgUpdate{display:none;}
</style>
<script>
//onchange="setThumbnail(event)"
	function setThumbnail(event){
		var reader = new FileReader();
		
		reader.onload = function(event){
			var img = document.createElement("img");
			img.setAttribute("src", event.target.result);
			img.setAttribute("class", "rounded-circle");
			img.setAttribute("width", "150");
			document.querySelector("div#image_container img").remove();
			document.querySelector("div#image_container").appendChild(img);
		};
		
		reader.readAsDataURL(event.target.files[0]);
	}
	
	function imgUpdate(){
		target = document.getElementsByClassName("imgUpdate");
		target[0].style.display = 'block';
	}
	</script>
<body>
	<div class="card">
		<div class="card-body">
			<%-- 자식요소들을 정렬 --%>
			<div class="d-flex flex-column align-items-center text-center">
				<%-- 이미지 가져오고 크기 조정 --%>
				<div id="image_container">
				<button type="button" onclick="imgUpdate()">img수정</button>
				
				<%if(dto == null) {
				} else {%>
				<%if(dto.getImg()==null){ %>
					<img src="/project1/resource/img/profile01.jpg" class="rounded-circle" width="150">
				<%}else{ %>
					<img src="/project1/resource/img/<%=dto.getImg()%>" class="rounded-circle" width="150">	
				<%}%>		
				<%}%>
				</div>
				<div class="imgUpdate">
				<form action="imgUpload.jsp?pageType=<%=pageType %>" method="post" 
					enctype="multipart/form-data">
					<input type="file"	name="save" id="profile-pic" onchange="setThumbnail(event)"> 
					<input type="submit" value="업로드">
				</form>
				</div>
				
				<%-- 이름, 나머지 글자들 크기 및 글자색 조정 --%>
				<div class="mt-3">
					<h4>기자</h4>
					<p class="text-secondary mb-1">Full Stack Developer</p>
					<p class="text-muted font-size-sm">Bay Area, San Francisco, CA</p>
						<%if(id != null && id.equals(id2)){%>
					<button class="btn btn-outline-primary"
						onclick="location='deleteForm.jsp'">탈퇴하기</button>
						<%}else{ %>
							 <% if(!include){%>
		                      	<button class="btn btn-primary" onclick="location='bookmarkPro.jsp?id=<%=id%>&id2=<%=id2%>&books=<%=bookList%>'">구독하기</button>
		                      <%}else{%>
		                      	<button class="btn btn-primary" onclick="location='bookmarkDelete.jsp?id=<%=id%>&id2=<%=id2%>&books=<%=bookList%>'">구독취소</button>
                      		<%}%>
						<%} %>
				</div>
			</div>
		</div>
	</div>
</body>
</html>