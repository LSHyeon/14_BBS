<%@page import="com.bc.mybatis.BBS_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--전달받은 데이터를 DB에 댓글 입력 처리 
	입력 후 페이지 전환 : 상세페이지로 이동(댓글 입력상태 확인)--%>
<%
	request.setCharacterEncoding("UTF-8");
	
	//페이지 값 추출(상세페이지 이동시 전달할 값)
	String cPage = (String)session.getAttribute("cPage");
	
%>
	<%-- 전달받은 데이터 DB에 입력하기 위해 CommVO 객체에 담기 --%>
	<jsp:useBean id="cvo" class="com.bc.mybatis.CommVO" />
	<jsp:setProperty name="cvo" property="*" />
<%
	cvo.setIp(request.getRemoteAddr());
	System.out.println("cvo :" + cvo);
	
	//cvo 데이터 DB에 입력
	BBS_DAO.insertComment(cvo);
	
	//입력 후 화면전환(페이지 이동 처리)
	response.sendRedirect("view.jsp?b_idx=" + cvo.getB_idx() + "&cPage=" + cPage);
%>
