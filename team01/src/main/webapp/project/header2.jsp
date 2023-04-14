<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link href="News.css" rel="stylesheet" type="text/css">
<%request.setCharacterEncoding("UTF-8"); %>
<div class="header">
	<br />
	<table>

		<tr>
			<td width="73%" rowspan="2"><img src="mainpage.png"
				onclick="location='main.jsp'" width="300" height="45" /></td>
			<td>&nbsp; <a href="listhottopic.jsp" class="menu"><font
					color="#OO5397"><b>topic</b></a></font> &nbsp;
			</td>
			<td>&nbsp; <a href="listPython.jsp" class="menu"><font
					color="#OO5397"><b>Python</b></a></font> &nbsp;
			</td>
			<td>&nbsp; <a href="listJava.jsp" class="menu"><font
					color="#OO5397"><b>Java</b></a></font> &nbsp;
			</td>
			<td>&nbsp; <a href="listJavaSript.jsp" class="menu"><font
					color="#OO5397"><b>JavaScript</b></a></font> &nbsp;
			</td>
			<td>&nbsp; <a href="listPartner.jsp" class="menu"><font
					color="#OO5397"><b>partnership</b></a></font> &nbsp;
			</td>
			<td>&nbsp; <a href="listhtml.jsp" class="menu"><font
					color="#OO5397"><b>SiteMap</b></a></font> &nbsp;
			</td>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>

			<td colspan="3">
				<form align="right">
					<img src="research.png" width="15" height="15" />&nbsp;<input
						type="text" name="research" /> <input type="submit" value="검색" />
				</form>
			</td>
		</tr>
	</table>

</div>

<style>
.header {
	background-color: #f3f5f7;
	margin: 10px;
	border-radius: 4px;
	border: 1px solid #ddd;
	padding: 10px;
	width: 98%;
}

.menu {
	font-size: 18px;
	font-face: Arial;
}
</style>