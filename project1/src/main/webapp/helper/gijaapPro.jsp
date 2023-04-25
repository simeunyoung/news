<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "svcenter.GijaDAO"%>
<%-- 신청받은 것을 임시테이블에 저장 후 게시판으로 이동 --%>

<jsp:useBean id = mbDTO scope = "page" class = "member.MemberDTO">
	<jsp:setProperty name = "mbDTO" property = "*"/>
</jsp:useBean>

<jsp:useBean id = "gdto" class = "svcenter.GijaDTO"/>

<%	
	gdto.setId(mbDTO.getId());
	gdto.setName(mbDTO.getName());
	gdto.setPress(mbDTO.getPress());
	gdto.setEmail(mbDTO.getEmail());
	gdto.setTel(mbDTO.getTel());
	//gdto.setMembertype(mbDTO.getMembertype());
	
	GijaDAO gdao = GijaDAO.getInstance();
	gdao.insertGija(gdto);
	
	response.sendRedirect("gijaapList.jsp");
%>