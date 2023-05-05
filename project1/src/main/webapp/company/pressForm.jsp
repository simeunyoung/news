<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.MemberDAO"%>
<%@ page import="member.MemberDTO"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="news.NewsDAO"%>
<%@ page import="java.util.*"%>
<%
String id = (String) session.getAttribute("memId");
%>
<%
MemberDAO dao = MemberDAO.getInstance();
%>
<%
TreeSet<String> pressSet = dao.selectPress();
%>
<%
String exist = dao.selectExist(id);
%>
<%
String[] pressNames = pressSet.toArray(new String[pressSet.size()]);
%>
<%
String[] existArray = null;
if (exist == null) {
	existArray = new String[1];
	existArray[0] = "-";
} else {
	existArray = exist.split("@");
}
%>


<%
ArrayList<MemberDTO> reporterList = dao.memForType("-1");
%>
<%
String sub = dao.subscribeR(id);
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
subscribe = sub.split("@");
}
%>
<%
String[] subscribe2 = new String[reporterList.size()];
%>
<%
String[] nameArray = new String[reporterList.size()];
%>
<%
for (int i = 0; i < reporterList.size(); i++) {
%>
<%
MemberDTO ddd = reporterList.get(i);
%>
<%
String reporterId = ddd.getId();
subscribe2[i] = reporterId;
String reporterName = ddd.getName();
nameArray[i] = reporterName;
}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>구독</title>
<link href="/project1/resource/css/style.css" rel="stylesheet">
<script src="/project1/resource/js/script.js"></script>
</head>
		<script>
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
			<table>
				<tbody>
					<tr>
						<td>
							<input type="checkbox" id="allChk" name="allChk" value="전체" onclick="selectAll01(this)"/>
							<label for="allChk">전체선택</label>
						</td>
					</tr>
					<tr>
						<td>
							<%
					boolean isChecked = false;
					for (int i = 0; i < pressNames.length; i++) {
						isChecked = false;
						for (int z = 0; z < existArray.length; z++) {
							isChecked = pressNames[i].equals(existArray[z]);
							if (isChecked) {
					%>
					<%=pressNames[i]%><input type="checkbox" name="<%=i%>"
						value="<%=pressNames[i]%>" checked />
					<%
					break;
					}
					}
					if (!isChecked) {
					%>
					<%=pressNames[i]%><input type="checkbox" name="<%=i%>"
						value="<%=pressNames[i]%>" />
					<%
					}
					}
					%>
					<input type="hidden" name="id" value="<%=id%>">
					<input type="submit" value="선택완료">
			
						</td>
					</tr>
			
					
				
				
					
				</tbody>
			</table>
		</form>
	</div>
	<div class="tab-content" id="tab02">
		<form action="reporterPro.jsp?id=<%=id%>" method="get">
			<table>
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
					<%
					for (int i = 0; i < subscribe2.length; i++) {
						boolean isChecked2 = false;
						for (int z = 0; z < subscribe.length; z++) {
							isChecked2 = subscribe2[i].equals(subscribe[z]);
							if (isChecked2) {
					%>
					<%=nameArray[i]%><input type="checkbox" name="<%=i%>"
						value="<%=subscribe2[i]%>" checked="true">
					<%
					break;
					}
					}
					if (!isChecked2) {
					%>
					<%=nameArray[i]%><input type="checkbox" name="<%=i%>"
						value="<%=subscribe2[i]%>">
					<%
					}
					}
					%>
					<input type="hidden" name="id" value="<%=id%>">
					<input type="submit" value="선택완료">
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
	String newsString = ndao.newsscrap(id);
	if(newsString == null){
		newsString = "";
	}
	%>
	<%-- DAO 만들어야됨 (구독한기사 출력)--%>
	<%
	String[] newsArray = newsString.split("@");
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
				%>
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