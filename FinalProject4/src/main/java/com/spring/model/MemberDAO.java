package com.spring.model;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.spring.model.MemberVO;

@Repository 
public class MemberDAO implements InterMemberDAO {

	@Resource
	private SqlSessionTemplate sqlsession;

	
	
	// === 로그인 처리하기 === //
	@Override
	public MemberVO getLoginMember(HashMap<String, String> paraMap) {
		MemberVO loginuser = sqlsession.selectOne("finalproject4.getLoginMember", paraMap);
		return loginuser;
	}
	
	// 마지막으로 로그인 한 날짜시간 변경(기록)하기
	@Override
	public void setLastLoginDate(HashMap<String, String> paraMap) {
		sqlsession.update("finalproject4.setLastLoginDate", paraMap);
	}

	
	///////////// ~~~ 카카오 ~~~ //////////////
	
	@Override
	public MemberVO kakaoMember(HashMap<String, String> paraMap) {

		MemberVO loginuser = sqlsession.selectOne("finalproject4.kakaoMember", paraMap);
		
		return loginuser;
	}
	
	// 아이디 중복 유무
	@Override
	public String idDuplicateCheck(String userid) {

		String id = sqlsession.selectOne("finalproject4.idDuplicateCheck", userid);
		
		return id;
	}

	
	// 카카오 회원가입
	@Override
	public int kakaoRegister(MemberVO membervo) {

		int n = sqlsession.insert("finalproject4.kakaoRegister", membervo);
		
		return n;
	}

	// 이메일 중복 유무
	@Override
	public String emailDuplicateCheck(String email) {

		String i = sqlsession.selectOne("finalproject4.emailDuplicateCheck", email);
		
		return i;
	}

	
	// 일반 회원 가입
	@Override
	public int register(MemberVO membervo) {

		int n = sqlsession.insert("finalproject4.register", membervo);
		
		return n;
	}

	// 카카오 로그인시 kakaoStatus 1로 변경
	@Override
	public void kakaoStatus(String email) {
		sqlsession.update("finalproject4.kakaoStatus", email);
	}

	// 네이버 로그인시 naverStatus 1로 변경
	@Override
	public void naverStauts(String email) {
		sqlsession.update("finalproject4.naverStatus", email);
	}

	// 네이버 회원가입
	@Override
	public int naverRegister(MemberVO membervo) {
		int n = sqlsession.insert("finalproject4.naverRegister", membervo);
		return n;
	}

	// 회원 수정 페이지
	@Override
	public MemberVO modifyInfo(String idx) {

		MemberVO mvo = sqlsession.selectOne("finalproject4.modifyInfo", idx);
		
		return mvo;
	}

	// 회원 수정
	@Override
	public int modifyEnd(HashMap<String, String> paraMap) {
		int n = sqlsession.update("finalproject4.modifyEnd", paraMap);
		return n;
	}

	// 세션 id, 유효시간
	@Override
	public void keepLogin(HashMap<String, Object> map) {
		sqlsession.update("finalproject4.keepLogin", map);
	}

	@Override
	public MemberVO checkUserWithSessionKey(String sessionId) {
		MemberVO mvo = sqlsession.selectOne("finalproject4.checkUserWithSessionKey", sessionId);
		return mvo;
	}

	// 회원 탈퇴
	@Override
	public int infoDelete(HashMap<String, String> paraMap) {
		int n = sqlsession.update("finalproject4.infoDelete", paraMap);
		return n;
	}

	// 아이디 찾기
	@Override
	public String findID(HashMap<String, String> paraMap) {

		String userid = sqlsession.selectOne("finalproject4.findID", paraMap);
		
		return userid;
	}

	// 비밀번호 찾기
	@Override
	public String findPW(HashMap<String, String> paraMap) {
		String findPW = sqlsession.selectOne("finalproject4.findPW", paraMap);
		return findPW;
	}

	// 비밀번호 변경
	@Override
	public int updatePW(HashMap<String, String> paraMap) {
		int n = sqlsession.update("finalproject4.updatePW", paraMap);
		return n;
	}

	// 적립금 내역
	@Override
	public List<HashMap<String, String>> pointList(String userid) {

		List<HashMap<String, String>> pointList = sqlsession.selectList("finalproject4.pointList", userid);
		
		return pointList;
	}

	// 나의 문의 내역
	@Override
	public List<HashMap<String, String>> qnaList(String userid) {
		List<HashMap<String, String>> qnaList = sqlsession.selectList("finalproject4.qnaList3", userid);
		return qnaList;
	}

	// 내 문의 개수
	@Override
	public String qnaCount(String userid) {
		String qnaCount = sqlsession.selectOne("finalproject4.qnaCount", userid);
		return qnaCount;
	}

	// 내 쿠폰 개수
	@Override
	public String couponCount(String userid) {
		String couponCount = sqlsession.selectOne("finalproject4.couponCount", userid);
		return couponCount;
	}

	// 쿠폰 내역
	@Override
	public List<HashMap<String, String>> couponList(String userid) {
		List<HashMap<String, String>> couponList = sqlsession.selectList("finalproject4.couponList", userid);
		return couponList;
	}

	// 관리자 답변 내역
	@Override
	public List<HashMap<String, String>> qnaList2(String userid) {

		List<HashMap<String, String>> qnaList2 = sqlsession.selectList("finalproject4.qnaList2", userid);
		return qnaList2;
	}

	// 내 예매 내역
	@Override
	public List<HashMap<String, String>> myReserveList(String userid) {
		List<HashMap<String, String>> myReserveList = sqlsession.selectList("finalproject4.myReserveList", userid);
		return myReserveList;
	}

	// 내 예매 개수
	@Override
	public String reserveCount(String userid) {
		String reserveCount = sqlsession.selectOne("finalproject4.reserveCount", userid);
		return reserveCount;
	}

	// 내 리뷰 내역
	@Override
	public List<HashMap<String, String>> myReviewList(String userid) {
		List<HashMap<String, String>> myReviewList = sqlsession.selectList("finalproject4.myReviewList", userid);
		return myReviewList;
	}

	// 내 리뷰 개수
	@Override
	public String reviewCount(String userid) {
		String reviewCount = sqlsession.selectOne("finalproject4.reviewCount", userid);
		return reviewCount;
	}

	// 내 선호 공연 내역
	@Override
	public List<HashMap<String, String>> myLikeList(String userid) {
		List<HashMap<String, String>> myLikeList = sqlsession.selectList("finalproject4.myLikeList", userid);
		return myLikeList;
	}

	
	// 선호 공연 개수
	@Override
	public String likeCount(String userid) {
		String likeCount = sqlsession.selectOne("finalproject4.likeCount", userid);
		return likeCount;
	}

	
	// 마이티켓에서 내 리뷰 삭제
	@Override
	public int myReviewDelete(HashMap<String, String> paraMap) {

		int n = sqlsession.update("finalproject4.myReviewDelete", paraMap);
		return n;
	}

	// 마이티켓에서 내 리뷰 수정
	@Override
	public int updateReviewEnd(HashMap<String, String> paraMap) {

		int n = sqlsession.update("finalproject4.updateReviewEnd", paraMap);
		return n;
	}
	
	
	
	
	
}
