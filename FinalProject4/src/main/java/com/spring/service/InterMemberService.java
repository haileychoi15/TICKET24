package com.spring.service;

import java.util.HashMap;
import java.util.List;

import com.spring.model.MemberVO;

public interface InterMemberService {

	MemberVO getLoginMember(HashMap<String, String> paraMap); // 로그인 처리하기  
	
	
	/////////////////////////// ~~카카오~~ /////////////////////////////////
	MemberVO kakaoMember(HashMap<String, String> paraMap); // 카카오 회원으로 등록이 되어있는지 확인

	String idDuplicateCheck(String userid); // 아이디 중복 유무

	int kakaoRegister(MemberVO membervo); // 카카오 회원가입

	String emailDuplicateCheck(String email); // 이메일 중복 유무

	int register(MemberVO membervo); // 일반 회원 가입

	void kakaoStatus(String email); // 카카오 로그인시 kakaoStatus 1로 변경

	void naverStatus(String email); // 네이버 로그인시 naverStatus 1로 변경

	int naverRegister(MemberVO membervo); // 네이버 회원가입

	MemberVO modifyInfo(String idx); // 회원수정 페이지

	int modifyEnd(HashMap<String, String> paraMap); // 회원 수정


	void keepLogin(HashMap<String, Object> map); // 쿠키 세션

	MemberVO checkUserWithSessionKey(String sessionId);

	int infoDelete(HashMap<String, String> paraMap); // 회원 탈퇴

	String findID(HashMap<String, String> paraMap); // 아이디 찾기

	String findPW(HashMap<String, String> paraMap); // 비밀번호 찾기

	int updatePW(HashMap<String, String> paraMap); // 비밀번호 변경

	List<HashMap<String, String>> pointList(String userid); // 포인트 적립 내역



	
}
