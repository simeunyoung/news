<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.*"%>
<%
String id = (String) session.getAttribute("memId");						//id = 세션값memId
%>
<%
MemberDAO dao = MemberDAO.getInstance();
%>
<%
TreeSet<String> pressSet = dao.selectPress();							//pressSet = 전체언론사이름 넣기
%>
<%
String exist = dao.selectExist(id);										//exist = id에 해당하는 현재 언론사구독목록(String)
%>
<%
String[] pressNames = pressSet.toArray(new String[pressSet.size()]); 	//pressNames = 전체언론사이름을 배열로 바꿈	TreeSet ->String[]
%>
<%
String[] existArray = null;												//existArray = @로 언론사를 구분하고있는 exist변수를 split()매소드로 배열로 변환
if (exist == null) {	
	existArray = new String[1];
	existArray[0] = "-";
} else {
	existArray = exist.split("@");
}
%>


<%
ArrayList<MemberDTO> reporterList = dao.memForType("-1");				//reporterList 모든기자의 id, name, 구독목록(기자)를 가지고있는DTO들을 담은 리스트
%>
<%
String sub = dao.subscribeR(id);										//sub = id에 해당하는 reportersubscribe
%>

<%
String[] subscribe = null;
%>
<%
if (sub == null) {							
	subscribe = new String[1];
	subscribe[0] = "_";
} else {
%>
<%
subscribe = sub.split("@");												//subscribe = sub을 split으로 나눈 String[] 배열
}
%>
<%
String[] subscribe2 = new String[reporterList.size()];					//reporterList의 사이즈만큼배열선언(구독한기자수)
%>
<%
String[] nameArray = new String[reporterList.size()];					//reporterList의 사이즈만큼배열선언(구독한기자수)
%>
<%
for (int i = 0; i < reporterList.size(); i++) {							//기자수만큼 반복해주고
%>
<%
MemberDTO ddd = reporterList.get(i);									//reporterList 리스트에서 인덱스 순서대로 DTO꺼내기
%>
<%
String reporterId = ddd.getId();										//Name, id차례대로 꺼내서 배열에 넣어주기
subscribe2[i] = reporterId;	
String reporterName = ddd.getName();									
nameArray[i] = reporterName;
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>CODENEWS</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
		<script>		<%-- 전체선택하게 해주는 script--%>		
				function selectAll01(selectAll)  {				
					  const checkboxes 
					     = document.querySelectorAll('#tab01 input[type="checkbox"]');
					  
					  checkboxes.forEach((checkbox) => {
					    checkbox.checked = selectAll.checked
					  })
					}
				
				function selectAll02(selectAll)  {
					  const checkboxes 
					     = document.querySelectorAll('#tab02 input[type="checkbox"]');
					  
					  checkboxes.forEach((checkbox) => {
					    checkbox.checked = selectAll.checked
					  })
					}
				</script>
<style>

</style>
<body>
	<jsp:include page="/member/header.jsp" />
	<div class="page-wrap">
	
	<ul class="tab">
		<li class="tab-menu active" data-tab="tab01">언론사 구독목록</li>
		<li class="tab-menu" data-tab="tab02">기자 구독목록</li>
		<li class="tab-menu" data-tab="tab03">스크랩목록</li>
	</ul>
	<div class="tab-content active" id="tab01">
		<form action="pressFormPro.jsp?id=<%=id%>" method="get">
			<table class="press-table">
				<tbody>
					<tr>
						<td>
							<input type="checkbox" id="allChk" name="allChk" value="전체" onclick="selectAll01(this)"/>
							<label for="allChk">전체선택</label>
						</td>
					</tr>
					<tr>
						<td>
						<div class="row center">
					<%				
					boolean isChecked = false;									
					for (int i = 0; i < pressNames.length; i++) {					//전체언론사와 현재구독되어있는 언론사비교
						isChecked = false;											//구독되어있으면 isChecked가 true
						for (int z = 0; z < existArray.length; z++) {
							isChecked = pressNames[i].equals(existArray[z]);
							if (isChecked) {
					%>
					<div class="press-chk">
						<div><%=pressNames[i]%></div>								<%-- true일때 checked된 checkbox생성 --%>
						<div>					<%-- name을 반복되는 i값으로 key값을 1씩증가해서 파라미터넘김--%>									
							<input type="checkbox" id="chk<%=i %>" name="<%=i%>" value="<%=pressNames[i]%>" checked />
							<label for="chk<%=i%>"></label>
						</div>
					</div>
<%-- 					<%=pressNames[i]%><input type="checkbox" name="<%=i%>" --%>
<%-- 						value="<%=pressNames[i]%>" checked /> --%>
					<%
					break;
					}
					}
					if (!isChecked) {
					%>
					<div class="press-chk">
						<div><%=pressNames[i]%></div>								<%-- false일때 일반 checkbox생성 --%>
						<div>
							<input type="checkbox" id="chk<%=i %>" name="<%=i%>" value="<%=pressNames[i]%>">
							<label for="chk<%=i%>"></label>
						</div>
					</div>
<%-- 					<%=pressNames[i]%><input type="checkbox" name="<%=i%>" --%>
<%-- 						value="<%=pressNames[i]%>" /> --%>
					<%
					}
					}
					%>
					<input type="hidden" name="id" value="<%=id%>">
			</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="center">
								<input type="submit" class="submit-btn" value="적용">
							</div>
						</td>
					
					</tr>
					
				
				
					
				</tbody>
			</table>
		</form>
	</div>
	<div class="tab-content" id="tab02">
		<form action="reporterPro.jsp?id=<%=id%>" method="get">
			<table class="press-table">
				<thead>
					<tr>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>
							<input type="checkbox" id="allChk" name="allChk" value="전체" onclick="selectAll02(this)"/>
							<label for="allChk">전체선택</label>
						</td>
					</tr>
					<tr>
						<td>
						<div class="row center">
					<%
					for (int i = 0; i < subscribe2.length; i++) {				//구독한 기자 비교해서 있으면 true없으면 true
						boolean isChecked2 = false;						
						for (int z = 0; z < subscribe.length; z++) {
							 if(subscribe2[i] != null){
							isChecked2 = subscribe2[i].equals(subscribe[z]);
							 }
							if (isChecked2) {
					%>
					<div class="press-chk">										<%-- 위와 같은방식 --%>
						<div><%=nameArray[i]%></div>
						<div>						
							<input type="checkbox" id="check<%=i %>" name="<%=i%>" value="<%=subscribe2[i]%>" checked />
							<label for="check<%=i%>"></label>
						</div>
					</div>
					<%
					break;
					}
					}
					if (!isChecked2) {
					%>
					<div class="press-chk">
						<div><%=nameArray[i]%></div>
						<div>
							<input type="checkbox" id="check<%=i %>" name="<%=i%>" value="<%=subscribe2[i]%>">
							<label for="check<%=i%>"></label>
						</div>
					</div>
					<%
					}
					}
					%>
					<input type="hidden" name="id" value="<%=id%>">						 <%--현재 session Id값도 파라미터로 같이전달 --%>
					
					</div>
						</td>
					</tr>
					<tr>
						<td>
							<div class="center">
								<input type="submit" class="submit-btn" value="선택완료">
							</div>
						</td>
					</tr>
					
				</tbody>
			</table>
		</form>
	</div>
	<%
	NewsDAO ndao = NewsDAO.getInstance();
	%>
	<%
	String newsString = ndao.newsscrap(id);				//뉴스 구독목록 출력
	if(newsString == null){
		newsString = "";
	}
	%>
	<%-- DAO 만들어야됨 (구독한기사 출력)--%>
	<%
	String[] newsArray = newsString.split("@");			//newsArray = 구독목록 출력한거 String[] 배열로 변화
	%>
	<div class="tab-content" id="tab03">
		<table>
			<thead>
				<tr>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th>NO</th>
					<th>TITLE</th>
					<th>NAME</th>
					<th>PRESS</th>
					<th>DATE</th>
				</tr>

				<%
				for (int i = 1; i < newsArray.length; i++) {
				%>				<%-- 구독목록 출력한 배열 수만큼 반복해서 출력--%>
				<%			
				if (newsArray[i] != "" && newsArray[i] != null) {				
					NewsDTO ndto = ndao.getCon(Integer.parseInt(newsArray[i]));
				%>
				<tr>
					<td><%=ndto.getNum()%></td>
					<td><a
						href="/project1/news/content.jsp?num=<%=ndto.getNum()%>"> <%=ndto.getTitle()%>
					</a></td>
					<td><%=ndto.getNick()%></td>
					<td><%=ndto.getPress()%></td>
					<td><%=ndto.getReg()%></td>
				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>
	</div>
	</div>
	<jsp:include page="/member/footer.jsp"></jsp:include>
</body>

<script>
	const li = document.querySelectorAll(".tab .tab-menu");

	li.forEach(function(elem) {
		elem.addEventListener("click", function() {
			const tabId = this.getAttribute("data-tab");

			li.forEach(function(elem) {
				elem.classList.remove("active");
			});
			document.querySelectorAll(".tab-content").forEach(function(elem) {
				elem.classList.remove("active");
			});

			this.classList.add("active");
			document.querySelector("#" + tabId).classList.add("active");
		});
	});
</script>
</html>