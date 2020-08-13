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
	
	
}
