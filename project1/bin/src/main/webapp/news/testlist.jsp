<%@ page contentType = "text/html; charset=UTF-8" %>
<%@ page import="news.NewsDAO"%>
<%@ page import="news.NewsDTO"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>


<%
	request.setCharacterEncoding("UTF-8");
    
	int pageSize = 20;
    int currentPage = Integer.parseInt("1"); // pageNum
 	int startRow = (currentPage - 1) * pageSize + 1; // (1-1)*10+1 = 1
    int endRow = currentPage * pageSize; // 1*10 = 10

    NewsDAO data = NewsDAO.getInstance();
    List list = data.gettexts(startRow, endRow); // 글 조회해오는 곳 1~10을 보내는 것

    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
%>

<head>
<title>Test용</title>
</head>

<button onClick="window.location.reload()">새로고침</button>
<center>
	<b>(임시)list</b>
	<table width="700">
		<tr>
			<td align="right"><a href="writeForm.jsp">글쓰기</a> <%-- 글작성하는 링크로 된 글씨버튼 --%></td>
		</tr>
	</table>


	<table border="1" width="700" cellpadding="0" cellspacing="0"
		align="center">
		<tr height="30">
			<td align="center" width="70">글 번호</td>
			<td align="center" width="230">기사</td>
			<td align="center" width="100">기자</td>
			<td align="center" width="120">작성일</td>
			<td align="center" width="80">시청수</td>
			<td align="center" width="100">비고</td>
		</tr>

		<%  
if (list.size() == 0){ out.println("작성된 글이 없습니다.");
} else{
for(int a=0 ; a< list.size() ; a++) {	
	NewsDTO text = (NewsDTO) list.get(a); //Object(list)형 --> DTO형으로 꺼내주고 있다. 
	
%>
		<tr height="30">
			<td align="center" width="70"><%=text.getNum()%></td>
			<%-- 글번호 --%>
			<td width="250"><a
				href="content.jsp?num=<%=text.getNum()%>"><h2><%=text.getTitle()%></h2></a> <%-- 제목 --%>
				<h5><%=text.getCon()%></h5>
			<td align="center" width="100"><a href="company.jsp"><%=text.getId()%></a></td>
			<td align="center" width="120"><%= sdf.format(text.getReg())%></td>
			<td align="center" width="80"><%=text.getViews()%></td>
			<%-- 조회수 --%>
			<td align="center" width="100"></td>
		</tr>
		<%	}	}%>
		
	</table>
</center>