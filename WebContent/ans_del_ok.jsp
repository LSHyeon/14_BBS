<%@page import="com.bc.mybatis.BBS_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--전달받은 파라미터 값을 사용해서 DB데이터 삭제 처리 (댓글삭제)
	삭제 후 화면전환 : 게시글 상세페이지(view.jsp)로 이동	
--%>
<%
	request.setCharacterEncoding("UTF-8");

	String c_idx = request.getParameter("c_idx");
	String b_idx = request.getParameter("b_idx");
	
	//DB데이터 삭제 처리(c_idx 값 사용)
	BBS_DAO.deleteComment(c_idx);
	
	//화면 전환 : view.jsp(게시글번호, 페이지번호 전달)
	//게시글 번호 : 파라미터 값 사용
	//페이지 번호 : 세션에 저장된 "cPage"값 사용
	String cPage = (String)session.getAttribute("cPage");
	
	response.sendRedirect("view.jsp?b_idx=" + b_idx + "&cPage=" + cPage);
%>