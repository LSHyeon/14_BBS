<%@page import="com.bc.mybatis.CommVO"%>
<%@page import="java.util.List"%>
<%@page import="com.bc.mybatis.BBSVO"%>
<%@page import="com.bc.mybatis.BBS_DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%-- 전달받은 파라미터 값 사용 DB데이터 조회 후 화면 표시 
	1. 게시글 조회수 1증가
	2. 게시글(b_idx) 데이터 조회 후 화면 표시
	3. 게시글(b_idx)에 달린 댓글이 있으면 화면 표시
--%>
<%
	//파라미터 값 확인
	String b_idx = request.getParameter("b_idx");
	String cPage = request.getParameter("cPage");
	
	//1. 게시글 조회수 1증가
	BBS_DAO.updateHit(Integer.parseInt(b_idx));
	
	//2. 게시글(b_idx) 데이터 조회
	BBSVO bvo = BBS_DAO.selectOne(b_idx);
	System.out.println("view bvo : " + bvo);
	
	//3. 게시글(b_idx)에 작성된 댓글이 있으면 조회(검색, 찾기)
	List<CommVO> clist = BBS_DAO.getcommList(b_idx);
	System.out.println("view clist : " + clist);
	
	//EL, JSTL 사용을 위한 scope 상에 속성 등록하고 화면 표시
	session.setAttribute("bvo", bvo);
	session.setAttribute("cPage", cPage);
	//댓글은 현재 페이지 에서만 사용하기 때문에 page에 저장
	pageContext.setAttribute("clist", clist);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시글상세</title>
<style type="text/css">
	#bbs table {
	width: 580px;
	margin-left: 10px;
	border-collapse: collapse;
	font-size: 14px;
	}
	#bbs table caption {
		font-size: 20px;
		font-weight: bold;
		margin-bottom: 10px;
	}
	#bbs table th {
		background-color: lightsteelblue;
		border: 1px solid black;
		padding: 4px 10px;
		width: 15%;
	}
	#bbs table td {
		text-align: center;
		border: 1px solid black;
		padding: 4px 10px;
	}

</style>
<script>
	function modify_go() {
		document.frm.action ="modify.jsp";
		document.frm.submit();
	}
	
	function delete_go() {
		document.frm.action ="delete.jsp";
		document.frm.submit();
	}
	
	function list_go() {
		document.frm.action ="list.jsp";
		document.frm.submit();
	}
</script>

</head>
<body>

<div id="bbs">
<%-- 게시글 내용 표시 --%>
<form method="post" name="frm">
	<table>
		<caption>상세보기</caption>
		<tbody>
			<tr>
				<th>제목</th>
				<td>${bvo.subject }</td>
			</tr>
			<tr>
				<th>작성자</th>
				<td>${bvo.writer }</td>
			</tr>
			<tr>
				<th>첨부파일</th>
				<td>
				<c:if test="${empty bvo.file_name }">
					첨부파일 없음
				</c:if>
				<c:if test="${not empty bvo.file_name }">
					<a href="download.jsp?name=${bvo.file_name }">${bvo.file_name }</a> <%-- 실제 저장된 파일명 --%>
				</c:if>		
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>${bvo.content }</td>
			</tr>	
		</tbody>
		<tfoot>
			<tr>
				<td colspan="2">
					<input type="button" value="수 정" onclick="modify_go()">
					<input type="button" value="삭 제" onclick="delete_go()">
					<input type="button" value="목 록" onclick="list_go()">
					<input type="hidden" name="cPage" value="${cPage }">
				</td>
			</tr>
		</tfoot>
	</table>
</form>
<hr>

<%-- 게시글에 대한 댓글 작성 영역 --%>
<form action="ans_write_ok.jsp" method="post">
	<p>이름 : <input type="text" name="writer">
		비밀번호 : <input type="password" name="pwd"></p>
	<p>내용 : <textarea name="content" rows="4" cols="55"></textarea>
	<input type="submit" value="댓글 저장">
	<input type="hidden" name="b_idx" value="${bvo.b_idx }">
</form>

<hr>
댓글
<hr>
<%-- 게시글에 작성된 댓글 표시 영역 --%>
<c:forEach var="commVO" items="${clist }">
<div class="comment">
	<form action="ans_del.jsp" method="post">
		<p>이름 : ${commVO.writer } &nbsp; 날짜: ${commVO.write_date }</p>
		<p>내용 : ${commVO.content }</p>
		<input type="submit" value="댓글 삭제">
		<input type="hidden" name="c_idx" value="${commVO.c_idx }">
		<input type="hidden" name="pwd" value="${commVO.pwd }">
		<%-- 비밀번호 같은 경우, hidden으로 넘겨도 소스보기에서 보이기 때문에 DB에서 데이터를 가져와야하지만 그냥 사용 --%>
		<%-- 댓글 삭제처리후 게시글 상세페이지로 이동시 --%>
		<input type="hidden" name="b_idx" value="${commVO.b_idx }">
	</form>
</div>
<hr>
</c:forEach>

</div>

</body>
</html>






















