package com.spring.model;

import java.util.HashMap;
import java.util.List;

public interface InterBoardDAO {

	List<FaqVO> faqList(HashMap<String, String> paraMap); // FAQ 리스트(검색어 있음)

	int getTotalNoticeCount(HashMap<String, String> paraMap); // 총 공지글 개수

	List<NoticeVO> noticeListWithPaging(HashMap<String, String> paraMap); // 페이징처리한 공지글 리스트

	NoticeVO getView(String seq); // 공지사항 글 1개 보기 페이지로 이동(조회수 증가 없음)

	int getTotalFaqCount(HashMap<String, String> paraMap); // 총 faq 개수

}
