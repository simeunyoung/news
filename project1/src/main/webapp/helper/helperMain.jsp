<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<table align="right">
	<tr align="right">
		<td align="right">
			<input type="button" value="기자신청" onclick="location='qnaForm.jsp'" />
			<input type="button" value="1:1문의" onclick="location='qnaForm.jsp'" />
		</td>
	</tr>
</table>
<br />
<jsp:include page="qnaList.jsp"></jsp:include>
<jsp:include page="qnaForm.jsp"></jsp:include>
