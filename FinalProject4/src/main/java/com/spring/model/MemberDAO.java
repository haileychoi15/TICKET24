package com.spring.model;

import java.util.HashMap;

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
	
	
	
	
	
}
