package com.bc.mybatis;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

// 게시글 + 댓글 처리용
public class BBS_DAO {

	// 게시글(BBS_T)의 전체 건수 조회
	public static int getTotalCount() {
		SqlSession ss = DBService.getFactory().openSession();
		int totalCount = ss.selectOne("BBS.totalCount");
		ss.close();
		
		return totalCount;
	}
	
	//페이지에 해당하는 글목록(게시글) 가져오기
	public static List<BBSVO> getList(Map<String, Integer> map) {
		SqlSession ss = DBService.getFactory().openSession();
		List<BBSVO> list = ss.selectList("BBS.list", map);
		ss.close();
		
		return list;
	}
	
	//게시글 번호에 해당하는 게시글 하나 조회
	public static BBSVO selectOne(String b_idx) {
		SqlSession ss = DBService.getFactory().openSession();
		BBSVO vo = ss.selectOne("BBS.one", b_idx);
		ss.close();
		
		return vo;
	}
	
	//게시글 입력 처리
	public static int insert(BBSVO bvo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.insert("BBS.insert", bvo);
		ss.close();
		
		return result;
	}
	
	//조회수 증가 처리
	public static int updateHit(int b_idx) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.update("BBS.hit", b_idx);
		ss.close();
		
		return result;
	}
	
	//게시글 수정
	public static int update(BBSVO bvo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.update("BBS.update", bvo);
		ss.close();
		
		return result;
	}
	
	//게시글 삭제
	public static int delete(String	b_idx) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.delete("BBS.delete", b_idx);
		ss.close();
		
		return result;
	}
	
	//================= 댓글 관련 =================
	public static List<CommVO> getcommList(String b_idx) {
		SqlSession ss = DBService.getFactory().openSession();
		List<CommVO> list = ss.selectList("BBS.commList", b_idx);
		ss.close();
		
		return list;
	}
	
	//댓글 입력
	public static int insertComment(CommVO cvo) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.insert("BBS.c_insert", cvo);
		ss.close();
		
		return result;
	}
	
	//댓글 삭제
	public static int deleteComment(String c_idx) {
		SqlSession ss = DBService.getFactory().openSession(true);
		int result = ss.delete("BBS.c_delete", c_idx);
		ss.close();
		
		return result;
	}
}





























