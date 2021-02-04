<%@page import="com.bc.mybatis.BBS_DAO"%>
<%@page import="com.bc.mybatis.BBSVO"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 전달받은 데이터를 사용해서 DB데이터 수정 후 상세페이지로 이동 --%>
<%
	request.setCharacterEncoding("UTF-8");

	//파일저장 위치
	String path = "c:/MyStudy/temp";
	
	MultipartRequest mr = new MultipartRequest(
			request, path, (10 * 1024 * 1024),
			"UTF-8", new DefaultFileRenamePolicy());
	
	//세션에 있는 데이터 사용 b_idx 값 찾기
	BBSVO b = (BBSVO)session.getAttribute("bvo");
	String b_idx = b.getB_idx();
	//((BBSVO)session.getAttribute("bvo")).getB_idx(); 가능
	
	
	//사용할 데이터 준비
	BBSVO bvo = new BBSVO();
	
	bvo.setB_idx(b_idx);
	bvo.setSubject(mr.getParameter("subject"));
	bvo.setWriter(mr.getParameter("writer"));
	bvo.setContent(mr.getParameter("content"));
	bvo.setIp(request.getRemoteAddr());
	
	//파일정보
	if (mr.getFile("file_name") != null) {
		bvo.setFile_name(mr.getFilesystemName("file_name"));
		bvo.setOri_name(mr.getOriginalFileName("file_name"));
	} else {
		bvo.setFile_name("");
		bvo.setOri_name("");
	}
	
	//DB 데이터 수정 요청
	BBS_DAO.update(bvo);
	
	//화면전환(상세페이지)
	response.sendRedirect("view.jsp?b_idx=" + b_idx + "&cPage=" + session.getAttribute("cPage"));	
%>