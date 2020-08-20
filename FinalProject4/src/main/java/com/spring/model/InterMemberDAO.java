package com.spring.model;

import java.util.HashMap;
import java.util.List;

import com.spring.model.MemberVO;

public interface InterMemberDAO {

	MemberVO getLoginMember(HashMap<String, String> paraMap); // 로그인 처리하기 
	void setLastLoginDate(HashMap<String, String> paraMap);   // 마지막으로 로그인 한 날짜시간 변경(기록)하기
	
	
	/////////////////// ~~ 카카오 ~~ ///////////////////////// 
	MemberVO kakaoMember(HashMap<String, String> paraMap); // 카카오 회원으로 등록이 되어있는지 확인
	
	String idDuplicateCheck(String userid); // 아이디 중복 유무
	
	int kakaoRegister(MemberVO membervo); // 카카오 회원가입
	
	String emailDuplicateCheck(String email); // 이메일 중복 유무
	
	int register(MemberVO membervo); // 일반 회원가입
	
	void kakaoStatus(String email); // 카카오 로그인시 kakaoStatus 1로 변경
	void naverStauts(String email); // 네이버 로그인시 naverStatus 1로 변경
	
	int naverRegister(MemberVO membervo); // 네이버 회원 가입
	
	MemberVO modifyInfo(String idx); // 회원 수정 페이지
	
	int modifyEnd(HashMap<String, String> paraMap); // 회원 수정
	
	void keepLogin(HashMap<String, Object> map); // 세션id, 유효시간 저장
	
	MemberVO checkUserWithSessionKey(String sessionId);
	
	int infoDelete(HashMap<String, String> paraMap); // 회원 탈퇴
	
	String findID(HashMap<String, String> paraMap); // 아이디 찾기
	String findPW(HashMap<String, String> paraMap); // 비밀번호 찾기
	
	int updatePW(HashMap<String, String> paraMap); // 비밀번호 변경
	
	List<HashMap<String, String>> pointList(String userid); // 적립금 내역
	List<HashMap<String, String>> qnaList(String userid); // 나의 문의 내역
	List<HashMap<String, String>> couponList(String userid); // 쿠폰 내역
	List<HashMap<String, String>> qnaList2(String userid); // 관리자 답변 내역
	
	String qnaCount(String userid); // 내 문의 개수
	String couponCount(String userid); // 내 쿠폰 개수
	
	List<HashMap<String, String>> myReserveList(String userid); // 내 예매 내역
	List<HashMap<String, String>> myReviewList(String userid); // 내 리뷰 내역
	List<HashMap<String, String>> myLikeList(String userid);	// 내 선호 공연 내역
	
	String reserveCount(String userid);	// 내 예매 개수
	String reviewCount(String userid); // 내 리뷰 개수
	String likeCount(String userid); // 선호 공연 개수
	
	
	int myReviewDelete(HashMap<String, String> paraMap);	// 마이티켓에서 내 리뷰 삭제
	int updateReviewEnd(HashMap<String, String> paraMap);	// 마이티켓에서 내 리뷰 수정
	
	
	
	
	
}
