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
import com.spring.model.QnaVO;

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
	// 공지사항 글 1개 보기 페이지로 이동(조회수 증가)
	@Override
	public NoticeVO getNoticeView(String seq, String userid) {
		
		NoticeVO notivo = dao.getView(seq);
		
		if(!"admin".equals(userid)) {		// 관리자가 아니라면
			dao.setAddReadCount(seq); 		// 글 조회수 1증가 하기
		}
		notivo = dao.getView(seq);
		
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
		
		// 사용자가 qna 문의를 등록할 때 groupno 는 최대값의 +1 로 준다.
		// qna 테이블에서 groupno 컬럼의 최대값 구하기
		int groupno = dao.getGroupnoMax()+1;
		
		paraMap.put("groupno", String.valueOf(groupno));
	
		int n = dao.qnaAdd(paraMap);
		return n;
	}

	// 로그인한 회원의 예매공연목록과 예매공연코드 가져오기
	@Override
	public List<HashMap<String, String>> reserveTitleList(int idx) {
		List<HashMap<String, String>> reserveTitleList = dao.reserveTitleList(idx);
		return reserveTitleList;
	}

	// qna 글목록 보여주기
	@Override
	public List<QnaVO> qnaList(HashMap<String, String> paraMap) {
		List<QnaVO> qnaList = dao.qnaList(paraMap);
		return qnaList;
	}

	// 총 qna 개수
	@Override
	public int getTotalQnaCount(HashMap<String, String> paraMap) {
		int n = dao.getTotalQnaCount(paraMap);
		return n;
	}

	
	// qna 글 1개 보기 페이지로 이동(조회수 증가 없음)
	@Override
	public QnaVO getQnaViewWithNoAddCount(String seq, String userid) {
		
		if("admin".equals(userid)) {
			dao.setAdminRead(seq); // 관리자가 Qna 글 1개 보기 클릭시 Adminread 상태를 0 -> 1로 바꿈.
		}
		
		QnaVO qnavo = dao.getQnaView(seq);
		return qnavo;
	}

	// Qna 답변 등록하기
	@Override
	public int qnaAddAdmin(QnaVO qvo) {
		int n = dao.qnaAddAdmin(qvo);
		dao.updateAdminans(qvo.getFk_seq()); // 관리자가 답변등록시 해당 참조글번호 fk_seq 의 문의글을 답변완료로 업데이트
		return n;
	}

	// 공지사항 글 등록하기(첨부파일 X)
	@Override
	public int noticeAdd(NoticeVO notivo) {
		int n = dao.noticeAdd(notivo); // 첨부파일이 없는 경우
		return 0;
	}

	// 공지사항 글 등록하기(첨부파일 O)
	@Override
	public int noticeAdd_withFile(NoticeVO notivo) {
		int n = dao.noticeAdd_withFile(notivo); // 첨부파일이 있는 경우
		return 0;
	}
	
}
