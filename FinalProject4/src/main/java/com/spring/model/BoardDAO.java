package com.spring.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class BoardDAO implements InterBoardDAO {
	
	@Resource
	private SqlSessionTemplate sqlsession;

	// FAQ 리스트(검색어 있음)
	@Override
	public List<FaqVO> faqList(HashMap<String, String> paraMap) {
		List<FaqVO> faqList = sqlsession.selectList("finalproject4.faqList", paraMap);
		return faqList;
	}

	
	// 총 공지글 개수
	@Override
	public int getTotalNoticeCount(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("finalproject4.getTotalNoticeCount", paraMap);
		return n;
	}


	// 페이징처리한 공지글 리스트
	@Override
	public List<NoticeVO> noticeListWithPaging(HashMap<String, String> paraMap) {
		List<NoticeVO> noticeList = sqlsession.selectList("finalproject4.noticeListWithPaging", paraMap);
		return noticeList;
	}

	
	// 공지사항 글 1개 보기 페이지로 이동(조회수 증가 없음)
	@Override
	public NoticeVO getView(String seq) {
		NoticeVO notivo = sqlsession.selectOne("finalproject4.getView", seq);
		return notivo;
	}


	// 공지사항 글 1개 보기 조회수 증가
	@Override
	public void setAddReadCount(String seq) {
		sqlsession.update("finalproject4.setAddReadCount", seq);
		
	}

	
	// 총 faq 개수
	@Override
	public int getTotalFaqCount(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("finalproject4.getTotalFaqCount", paraMap);
		return n;
	}

	
	// Qna 문의 등록하기
	@Override
	public int qnaAdd(HashMap<String, String> paraMap) {
		int n = sqlsession.insert("finalproject4.qnaAdd", paraMap);
		return n;
	}

	// 로그인한 회원의 예매공연목록과 예매공연코드 가져오기
	@Override
	public List<HashMap<String, String>> reserveTitleList(String userid) {
		List<HashMap<String, String>> reserveTitleList = sqlsession.selectList("finalproject4.reserveTitleList", userid);
		return reserveTitleList;
	}

	// qna 글목록 보여주기
	@Override
	public List<QnaVO> qnaList(HashMap<String, String> paraMap) {
		List<QnaVO> qnaList = sqlsession.selectList("finalproject4.qnaList", paraMap);
		return qnaList;
	}

	// 총 qna 개수
	@Override
	public int getTotalQnaCount(HashMap<String, String> paraMap) {
		int n = sqlsession.selectOne("finalproject4.getTotalQnaCount", paraMap);
		return n;
	}

	// qna 테이블에서 groupno 컬럼의 최대값 구하기
	@Override
	public int getGroupnoMax() {
		int max = sqlsession.selectOne("finalproject4.getGroupnoMax");
		return max;
	}

	// qna 글 1개 보기 페이지로 이동(조회수 증가 없음)
	@Override
	public QnaVO getQnaView(String seq) {
		QnaVO qnavo = sqlsession.selectOne("finalproject4.getQnaView", seq);
		return qnavo;
	}

	// Qna 답변 등록하기
	@Override
	public int qnaAddAdmin(QnaVO qvo) {
		int n = sqlsession.insert("finalproject4.qnaAddAdmin", qvo);
		return n;
	}

	// 공지사항 글 등록하기(첨부파일 X)
	@Override
	public int noticeAdd(NoticeVO notivo) {
		int n = sqlsession.insert("finalproject4.noticeAdd", notivo);
		return n;
	}

	// 공지사항 글 등록하기(첨부파일 O)
	@Override
	public int noticeAdd_withFile(NoticeVO notivo) {
		int n = sqlsession.insert("finalproject4.noticeAdd_withFile", notivo);
		return n;
	}

	// 관리자가 Qna 글 1개 보기 클릭시 Adminread 상태를 0 -> 1로 바꿈.
	@Override
	public void setAdminRead(String seq) {
		sqlsession.update("finalproject4.setAdminRead", seq);
		
	}

	// 관리자가 답변등록시 해당 참조글번호 fk_seq 의 문의글을 답변완료로 업데이트
	@Override
	public void updateAdminans(String fk_seq) {
		sqlsession.update("finalproject4.updateAdminans", fk_seq);
		
	}

	// Qna 답변 수정하기
	@Override
	public int qnaEditAdmin(QnaVO qvo) {
		int n = sqlsession.update("finalproject4.qnaEditAdmin", qvo);
		return n;
	}

	// Qna 답변 삭제하기
	@Override
	public int qnaDelAdmin(String qna_id) {
		int n = sqlsession.update("finalproject4.qnaDelAdmin", qna_id);
		return n;
	}

	// 공지 삭제하기 
	@Override
	public int noticeDel(String notice_id) {
		int n = sqlsession.update("finalproject4.noticeDel", notice_id);
		return n;
	}

	// 공지 수정하기
	@Override
	public int noticeEdit(NoticeVO notivo) {
		int n = sqlsession.update("finalproject4.noticeEdit", notivo);
		return n;
	}

	// 공연명으로 티켓오픈일자 검색 
	@Override
	public List<ProdVO> ticketopenSearchList(String prod_title) {
		List<ProdVO> ticketopenSearchList = sqlsession.selectList("finalproject4.ticketopenSearchList", prod_title);
		return ticketopenSearchList;
	}
	
}
