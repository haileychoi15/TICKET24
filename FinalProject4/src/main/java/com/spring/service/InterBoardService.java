package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.model.FaqVO;
import com.spring.model.NoticeVO;

public interface InterBoardService {

	List<FaqVO> faqList(HashMap<String, String> paraMap); // FAQ 리스트(검색어 있음)

	int getTotalNoticeCount(HashMap<String, String> paraMap); // 총 공지글 개수

	List<NoticeVO> noticeListWithPaging(HashMap<String, String> paraMap); // 페이징처리한 공지글 리스트

}
