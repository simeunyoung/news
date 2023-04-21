<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="header.jsp"></jsp:include>
<title>CodeNews에 오신걸 환영합니다.</title>
<%-- main에서 사용될 코드
1. main의 div에서 내부 div 태그를 이용해서 영역을 4가지로 분리
	div 1		div 2
	div 3		div 4
main div : display flex를 사용해서 배열을 맞춰 준다.
div 1 : topiclist.jsp <재가공 예정>
div 2 : company 언론사.jsp <재가공 예정>
div 3 : list.jsp <재가공 예정>
div 4 : company 기자.jsp <재가공 예정>

2. 
 --%>

<%request.setCharacterEncoding("UTF-8"); %>

<div class="main_box">
	<div class="left_box">
		<div class="topic_box">
		<input type="button" value="테스트리스트로 이동" onClick="location='testlist.jsp'" >
		</div>
		<div class="list_box"></div>
	</div>
	<div class="right_box">
		<div class="companyc_box"></div>
		<div class="companyw_box"></div>
	</div>
</div>

<style>
*{
	margin:0;
	padding:0;
	box-sizing:border-box;
}
.main_box {
display: flex;
width: 100%;
height: 100%;
}
.left_box {
width: 75%;
height: 100%;
}
.right_box {
width: 25%;
height: 100%;
}
.topic_box{
border: 1px solid #ddd;
border-radius: 4px;
padding: 4px;
font-size: 14px;
width: 100%;
height: 50%;
}
.list_box{
border: 1px solid #ddd;
border-radius: 4px;
padding: 4px;
font-size: 14px;
width: 100%;
height: 50%;
}
.companyc_box{
border: 1px solid #ddd;
border-radius: 4px;
padding: 4px;
font-size: 14px;
width: 100%;
height: 40%;
}
.companyw_box{
border: 1px solid #ddd;
border-radius: 4px;
padding: 4px;
font-size: 14px;
width: 100%;
height: 60%;
}
</style>

