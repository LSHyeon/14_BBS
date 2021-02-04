<%@page import="com.bc.mybatis.BBS_DAO"%>
<%@page import="com.bc.mybatis.BBSVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 삭제요청한 데이터를 DB에서 삭제처리
	삭제실패(댓글이 있는경우) : 댓글이 있어서 삭제 할 수 없다 메시지 표시
	삭제후 화면 전환 : 목록페이지로 이동
 --%>
<%
   System.out.println("session bvo : " + session.getAttribute("bvo"));
   //전달받은 데이터 추출 : 세션에 있는 bvo
   String b_idx = ((BBSVO)session.getAttribute("bvo")).getB_idx();

   //DB 데이터 삭제 처리
   try {
      BBS_DAO.delete(b_idx);
      //정상삭제 처리 되었을 때
      response.sendRedirect("list.jsp?cPage=" + session.getAttribute("cPage"));
   }catch (Exception e) {
%>
      <script>
         alert("[삭제실패] 댓글이 있는 경우 삭제할 수 없습니다.\n"
               + "게시글 내용을 삭제하거나, 관리자에게 문의");
         location.href ="view.jsp?b_idx=${bvo.b_idx}&cPage=${cPage}";
      </script>
<%
   }
%>























