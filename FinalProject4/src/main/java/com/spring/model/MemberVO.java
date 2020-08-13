package com.spring.model;

import java.util.Calendar;

public class MemberVO {

	private int idx;              // 회원번호(시퀀스로 데이터가 들어온다)
	private String userid;        // 회원아이디
	private String name;          // 회원명
	private String pwd;           // 비밀번호 (SHA-256 암호화 대상  단방향암호화)
	private String email;         // 이메일    (AES-256 암호화/복호화 대상  양방향암호화)
	private String hp1;           // 휴대폰
	private String hp2;           //       (AES-256 암호화/복호화 대상    양방향암호화)
	private String hp3;           //       (AES-256 암호화/복호화 대상    양방향암호화)
	private String postcode;      // 우편번호
	private String address;       // 주소
	private String detailAddress; // 상세주소
	private String extraAddress;  // 참고항목
	private String gender;        // 성별     남자 : 1 / 여자 : 2
	private String birthyyyy;     // 생년
	private String birthmm;       // 생월
	private String birthdd;       // 생일
	private int coin;             // 코인액
	private int point;            // 포인트
	private String registerday;   // 가입일자
	private int status;           // 회원탈퇴유무   1:사용가능(가입중) / 0:사용불능(탈퇴) 
	private String isSMS;		  // sms 수신여부
	private String isEMAIL;	      // email 수신여부
	
	
	private String lastLoginDate;     // 마지막으로 로그인 한 날짜시간 기록용
	private String lastPwdChangeDate; // 마지막으로 암호를 변경한 날짜시간 기록용
	
	private boolean requirePwdChange = false; 
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지났으면 true
	// 마지막으로 암호를 변경한 날짜가 현재시각으로 부터 3개월이 지나지 않았으면 false 
	
	private boolean idleStatus = false;  // 휴면유무(휴면이 아니라면 false, 휴면이면  true)
	// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지났으면 true(휴면으로 지정)
	// 마지막으로 로그인 한 날짜시간이 현재시각으로 부터 1년이 지나지 않았으면 false 
	
	private String clientip; // 클라이언트의 IP 주소
	
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	private int gradelevel; // 등급레벨
	private int pwdchangegap; // 로그인시 현재날짜와 최근 마지막으로 암호를 변경한 날짜와의 개월수 차이 (3개월 동안 암호를 변경 안 했을시 암호를 변경하라는 메시지를 보여주기 위함)
	private int lastlogindategap; // 로그인시 현재날짜와 최근 마지막으로 로그인한 날짜와의 개월수 차이 (12개월 동안 로그인을 안 했을 경우 해당 로그인계정을 비활성화 시키려고 함) 

	
	////////////////// ~~~ API ~~~ //////////////////////
	private String kakaoStatus;
	private String naverStauts;
	
	/////////////////// 쿠키 시험 /////////////////////////
	private boolean useCookie;
	
	public MemberVO() { }
	
	public MemberVO(int idx, String userid, String name, String pwd, String email, String hp1, String hp2, String hp3,
			String postcode, String address, String detailAddress, String extraAddress, String gender, String birthyyyy, String birthmm,
			String birthdd, int coin, int point, String registerday, int status,
			String clientip, String kakaoStatus, String naverStatus, String isSMS, String isEMAIL) {
		this.idx = idx;
		this.userid = userid;
		this.name = name;
		this.pwd = pwd;
		this.email = email;
		this.hp1 = hp1;
		this.hp2 = hp2;
		this.hp3 = hp3;
		this.postcode = postcode;
		this.address = address;
		this.detailAddress = detailAddress;
		this.extraAddress = extraAddress;
		this.gender = gender;
		this.birthyyyy = birthyyyy;
		this.birthmm = birthmm;
		this.birthdd = birthdd;
		this.coin = coin;
		this.point = point;
		this.registerday = registerday;
		this.status = status;
		
		this.clientip = clientip;
		
		this.kakaoStatus = kakaoStatus;
		this.naverStauts = naverStatus;
		
		this.isSMS = isSMS;
		this.isEMAIL = isEMAIL;
	}

	public int getIdx() {
		return idx;
	}

	public void setIdx(int idx) {
		this.idx = idx;
	}

	public String getUserid() {
		return userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getHp1() {
		return hp1;
	}

	public void setHp1(String hp1) {
		this.hp1 = hp1;
	}

	public String getHp2() {
		return hp2;
	}

	public void setHp2(String hp2) {
		this.hp2 = hp2;
	}

	public String getHp3() {
		return hp3;
	}

	public void setHp3(String hp3) {
		this.hp3 = hp3;
	}

	public String getPostcode() {
		return postcode;
	}

	public void setPostcode(String postcode) {
		this.postcode = postcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getDetailAddress() {
		return detailAddress;
	}

	public void setDetailAddress(String detailAddress) {
		this.detailAddress = detailAddress;
	}
	
	public String getExtraAddress() {
		return extraAddress;
	}

	public void setExtraAddress(String extraAddress) {
		this.extraAddress = extraAddress;
	}
	
	public String getGender() {
		return gender;
	}

	public void setGender(String gender) {
		this.gender = gender;
	}

	public String getBirthyyyy() {
		return birthyyyy;
	}

	public void setBirthyyyy(String birthyyyy) {
		this.birthyyyy = birthyyyy;
	}

	public String getBirthmm() {
		return birthmm;
	}

	public void setBirthmm(String birthmm) {
		this.birthmm = birthmm;
	}

	public String getBirthdd() {
		return birthdd;
	}

	public void setBirthdd(String birthdd) {
		this.birthdd = birthdd;
	}

	public int getCoin() {
		return coin;
	}

	public void setCoin(int coin) {
		this.coin = coin;
	}

	public int getPoint() {
		return point;
	}

	public void setPoint(int point) {
		this.point = point;
	}

	public String getRegisterday() {
		return registerday;
	}

	public void setRegisterday(String registerday) {
		this.registerday = registerday;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	public String getLastLoginDate() {
		return lastLoginDate;
	}

	public void setLastLoginDate(String lastLoginDate) {
		this.lastLoginDate = lastLoginDate;
	}

	public String getLastPwdChangeDate() {
		return lastPwdChangeDate;
	}

	public void setLastPwdChangeDate(String lastPwdChangeDate) {
		this.lastPwdChangeDate = lastPwdChangeDate;
	}

	public boolean isRequirePwdChange() {
		return requirePwdChange;
	}

	public void setRequirePwdChange(boolean requirePwdChange) {
		this.requirePwdChange = requirePwdChange;
	}

	public boolean isIdleStatus() {
		return idleStatus;
	}

	public void setIdleStatus(boolean idleStatus) {
		this.idleStatus = idleStatus;
	}

	public String getClientip() {
		return clientip;
	}

	public void setClientip(String clientip) {
		this.clientip = clientip;
	}
	
	
	/////////////////////////////////////////////////////////
	public String getAllHp() {
		return hp1+"-"+hp2+"-"+hp3;
	}
	
	
	public int getAge() {
		int age = 0;
		
		Calendar currentDate = Calendar.getInstance(); 
		// 현재날짜와 시간을 얻어온다.
		
		int currentYear = currentDate.get(Calendar.YEAR);
		
		age =  currentYear - Integer.parseInt(birthyyyy) + 1;
		
		return age;
	}
	
	public String getSexual() {
		if("1".equalsIgnoreCase(gender)) {
			return "남자";
		}
		else {
			return "여자";
		}
	}

	
	////////////////////////////////////////////////////////////////////////////////////////////////////////
	
	public int getGradelevel() {
		return gradelevel;
	}

	public void setGradelevel(int gradelevel) {
		this.gradelevel = gradelevel;
	}

	public int getPwdchangegap() {
		return pwdchangegap;
	}

	public void setPwdchangegap(int pwdchangegap) {
		this.pwdchangegap = pwdchangegap;
	}

	public int getLastlogindategap() {
		return lastlogindategap;
	}

	public void setLastlogindategap(int lastlogindategap) {
		this.lastlogindategap = lastlogindategap;
	}


	
	////////////////////////////////////////////////
	
	public String getKakaoStatus() {
		return kakaoStatus;
	}

	public void setKakaoStatus(String kakaoStatus) {
		this.kakaoStatus = kakaoStatus;
	}

	public String getNaverStauts() {
		return naverStauts;
	}

	public void setNaverStauts(String naverStauts) {
		this.naverStauts = naverStauts;
	}

	public String getIsSMS() {
		return isSMS;
	}

	public void setIsSMS(String isSMS) {
		this.isSMS = isSMS;
	}

	public String getIsEMAIL() {
		return isEMAIL;
	}

	public void setIsEMAIL(String isEMAIL) {
		this.isEMAIL = isEMAIL;
	}

	//////////////////////////////////////////////////
	public boolean isUseCookie() {
		return useCookie;
	}

	public void setUseCookie(boolean useCookie) {
		this.useCookie = useCookie;
	}
	///////////////////////////////////////////////////
	
	
	
	
}
