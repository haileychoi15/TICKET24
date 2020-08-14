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
	public List<HashMap<String, String>> reserveTitleList(int idx) {
		List<HashMap<String, String>> reserveTitleList = sqlsession.selectList("finalproject4.reserveTitleList", idx);
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
	
}
