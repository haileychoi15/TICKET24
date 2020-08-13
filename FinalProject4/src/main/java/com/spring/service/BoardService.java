package com.spring.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.common.AES256;
import com.spring.mail.GoogleMail;
import com.spring.model.FaqVO;
import com.spring.model.InterBoardDAO;
import com.spring.model.NoticeVO;

@Service
public class BoardService implements InterBoardService {

	@Autowired
	private InterBoardDAO dao;
	
	@Autowired
	private AES256 aes;
	
	@Autowired
	private GoogleMail mail;

	
	// FAQ 리스트(검색어 있음)
	@Override
	public List<FaqVO> faqList(HashMap<String, String> paraMap) {
		List<FaqVO> faqList = dao.faqList(paraMap);
		return faqList;
	}


	// 총 공지글 개수
	@Override
	public int getTotalNoticeCount(HashMap<String, String> paraMap) {
		int n = dao.getTotalNoticeCount(paraMap);
		return n;
	}

	// 페이징처리한 공지글 리스트
	@Override
	public List<NoticeVO> noticeListWithPaging(HashMap<String, String> paraMap) {
		List<NoticeVO> noticeList = dao.noticeListWithPaging(paraMap);
		return noticeList;
	}

	// 공지사항 글 1개 보기 페이지로 이동(조회수 증가 없음)
	@Override
	public NoticeVO getNoticeViewWithNoAddCount(String seq) {
		NoticeVO notivo = dao.getView(seq);
		return notivo;
	}


	// 총 공지글 개수
	@Override
	public int getTotalFaqCount(HashMap<String, String> paraMap) {
		int n = dao.getTotalFaqCount(paraMap);
		return n;
	}

	
	// Qna 문의 등록하기
	@Override
	public int qnaAdd(HashMap<String, String> paraMap) {
		int n = dao.qnaAdd(paraMap);
		return n;
	}
	
}
