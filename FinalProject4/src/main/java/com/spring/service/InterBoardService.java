package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.model.FaqVO;
import com.spring.model.NoticeVO;
import com.spring.model.QnaVO;

public interface InterBoardService {

	List<FaqVO> faqList(HashMap<String, String> paraMap); // FAQ 리스트(검색어 있음)

	int getTotalNoticeCount(HashMap<String, String> paraMap); // 총 공지글 개수

	List<NoticeVO> noticeListWithPaging(HashMap<String, String> paraMap); // 페이징처리한 공지글 리스트

	NoticeVO getNoticeViewWithNoAddCount(String seq); // 공지사항 글 1개 보기 페이지로 이동(조회수증가없음)

	NoticeVO getNoticeView(String seq, String userid); // 공지사항 글 1개 보기 페이지로 이동(조회수증가)

	int getTotalFaqCount(HashMap<String, String> paraMap); // 총 faq 개수

	int qnaAdd(HashMap<String, String> paraMap); // Qna 문의 등록하기

	List<HashMap<String, String>> reserveTitleList(int idx); // 로그인한 회원의 예매공연목록과 예매공연코드 가져오기

	List<QnaVO> qnaList(HashMap<String, String> paraMap); // qna 글목록 보여주기

	int getTotalQnaCount(HashMap<String, String> paraMap); // 총 qna 건수

	QnaVO getQnaViewWithNoAddCount(String seq, String userid); // qna 글 1개 보기 페이지로 이동

	int qnaAddAdmin(QnaVO qvo); // Qna 답변 등록하기

	int noticeAdd(NoticeVO notivo); // 공지사항 글 등록하기(첨부파일 X)

	int noticeAdd_withFile(NoticeVO notivo); // 공지사항 글 등록하기(첨부파일 O)

}
