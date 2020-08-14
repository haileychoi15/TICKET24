package com.spring.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.sql.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Random;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.WebUtils;

import com.spring.common.AES256;
import com.spring.common.Sha256;
import com.spring.model.MemberVO;
import com.spring.naver.NaverLoginBO;
import com.spring.service.InterMemberService;

@Controller
public class MemberController {

	@Autowired
	private InterMemberService service;
	
	@Autowired
	private AES256 aes;
	
	
	/////////////////~~ 네이버 등록 ~~/////////////////////////
	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	///////////////////////////////////////////////////
	
	
	// 로그인 페이지 //
	@RequestMapping(value="/login.action")
	public ModelAndView login(ModelAndView mav, HttpSession session) {
		
		/* 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 */
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);

		System.out.println("네이버:" + naverAuthUrl);
		//네이버
		//model.addAttribute("url", naverAuthUrl);
		mav.addObject("url", naverAuthUrl);
		
		mav.setViewName("member/login.notiles");
	
		return mav;
	}
	
	
	// 로그아웃 //
	@RequestMapping(value="/logout.action")
	public ModelAndView logout(HttpServletRequest request, ModelAndView mav, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO)session.getAttribute("loginuser");
		
		String userid = loginuser.getUserid();
		
		session.invalidate();
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		
		if(loginCookie != null) {
			loginCookie.setMaxAge(0);
			loginCookie.setPath("/");
			response.addCookie(loginCookie);
			
			Date sessionLimit = new Date(System.currentTimeMillis());
			
    		HashMap<String, Object> map = new HashMap<String, Object>();
    		map.put("userid", userid);
    		map.put("sessionId", session.getId());
    		map.put("sessionLimit", sessionLimit);
			
			service.keepLogin(map);
			
		}
		
		String msg = "로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/yes24.action";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	// == 일반 회원가입 == //
	@RequestMapping(value="/register.action")
	public ModelAndView register(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		
		// System.out.println(method);
		if("GET".equalsIgnoreCase(method)) {
			mav.setViewName("member/join.notiles");
		}
		else {
			
			try {
			
				String name = request.getParameter("name");
				String userid = request.getParameter("userid");
				String pwd = request.getParameter("pwd");
				String email = request.getParameter("email");
				String hp1 = request.getParameter("mobile1");
				String hp2 = request.getParameter("mobile2");
				String hp3 = request.getParameter("mobile3");
				String postcode = request.getParameter("postcode");
				String address = request.getParameter("address");
				String detailAddress = request.getParameter("detailaddress");
				
				String isSMS = request.getParameter("is-sms");
				String isEMAIL = request.getParameter("is-email");
				
				if(isSMS == null) {
					isSMS = "0";
				}
				if(isEMAIL == null) {
					isEMAIL = "0";
				}
				
				//String extraAddress= request.getParameter("extraAddress");
				//String gender = request.getParameter("gender");
				//String birthyyyy = request.getParameter("birthyyyy");
				//String birthmm = request.getParameter("birthmm");
				//String birthdd = request.getParameter("birthdd");
				
				// *** 클라이언트의 IP 주소 알아오기 *** //
				//String clientip = request.getRemoteAddr();
				
				MemberVO membervo = new MemberVO();
				membervo.setName(name);
				membervo.setUserid(userid);
				membervo.setPwd(Sha256.encrypt(pwd));
				membervo.setEmail(aes.encrypt(email));
				membervo.setHp1(hp1);
				membervo.setHp2(aes.encrypt(hp2));
				membervo.setHp3(aes.encrypt(hp3));
				membervo.setPostcode(postcode);
				membervo.setAddress(address);
				membervo.setDetailAddress(detailAddress);
				membervo.setIsSMS(isSMS);
				membervo.setIsEMAIL(isEMAIL);
				
				/*membervo.setExtraAddress(extraAddress);
				membervo.setGender(gender);
				membervo.setBirthyyyy(birthyyyy);
				membervo.setBirthmm(birthmm);
				membervo.setBirthdd(birthdd);
				membervo.setClientip(clientip);*/
				
				//System.out.println("sms : " + isSMS);
				//System.out.println("email : " + isEMAIL);
				
				int n = service.register(membervo);
				
				String msg = "";
				String loc = "";
				
				if(n==1) {
					msg = "회원가입 성공";
					loc = request.getContextPath() + "/yes24.action";
				}
				else {
					msg = "회원가입 실패";
					loc = "javascript:history.back()";
				}
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
				
				
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
		}
		
		return mav;
	}
	
	
	// == 아이디 중복 확인 == //
	@ResponseBody
	@RequestMapping(value="/member/idDuplicateCheck.action", produces="text/plain;charset=UTF-8")
	public String idDuplicateCheck(HttpServletRequest request) {
		
		String userid = request.getParameter("userid");
		
		String id = service.idDuplicateCheck(userid);
		// System.out.println("id : " + id);
		
		boolean isUse = false;
		if(id == null) {
			isUse = true;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isUse", isUse);	
				
		return jsonObj.toString();
		
	}
	
	
	// == 이메일 중복 확인 == //
	@ResponseBody
	@RequestMapping(value="/member/emailDuplicateCheck.action", produces="text/plain;charset=UTF-8")
	public String emailDuplicateCheck(HttpServletRequest request) {
		
		String email = request.getParameter("email");
		
		String i = "";
		
		try {
			
			i = service.emailDuplicateCheck(aes.encrypt(email));
			
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		boolean isUse = false;
		if(i == null) {
			isUse = true;
		}
		
		JSONObject jsonObj = new JSONObject();
		jsonObj.put("isUse", isUse);	
				
		return jsonObj.toString();
		
	}
	
	// === #41. 로그인 처리하기 === //
	@RequestMapping(value="/loginEnd.action", method= {RequestMethod.POST})
	public ModelAndView loginEnd(HttpServletRequest request, ModelAndView mav, HttpServletResponse response) {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
		String keepLogin = request.getParameter("keepLogin");
		
		//System.out.println("keepLogin : " + keepLogin);
		
		HashMap<String, String> paraMap = new HashMap<>();
		paraMap.put("userid", userid);
		paraMap.put("pwd", Sha256.encrypt(pwd));
		
		MemberVO loginuser = service.getLoginMember(paraMap);
		
		HttpSession session = request.getSession();
		
		if(loginuser == null) {
			String msg = "아이디 또는 암호가 틀립니다.";
			String loc = "javascript:history.back()";
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			//  /WEB-INF/views/msg.jsp 파일을 생성한다.
		}
		
		else {
			if(loginuser.isIdleStatus() == true) {
				// 로그인을 한지 1년이 지나서 휴면상태에 빠진 경우
				
				String msg = "로그인을 한지 1년이 지나서 휴면상태에 빠졌습니다. 관리자에게 문의 바랍니다.";
				String loc = "javascript:history.back()";
				
				mav.addObject("msg", msg);
				mav.addObject("loc", loc);
				
				mav.setViewName("msg");
			}
			
			else {
			    if(loginuser.isRequirePwdChange() == true) {
			    	// 암호를 최근 3개월 동안 변경하지 않은 경우 
			    	session.setAttribute("loginuser", loginuser);
			    	
			    	String msg = "암호를 최근 3개월 동안 변경하지 않으셨습니다. 암호변경을 위해 나의정보 페이지로 이동합니다.";
					String loc = request.getContextPath()+"/myinfo.action";
					
					mav.addObject("msg", msg);
					mav.addObject("loc", loc);
					
					mav.setViewName("msg");
			    }
			    
			    else {
			    	// 아무런 이상없이 로그인 하는 경우 
			    	session.setAttribute("loginuser", loginuser);
			    	
			    	if( keepLogin != null) {
			    		Cookie cookie = new Cookie("loginCookie", session.getId());
			    		cookie.setPath("/");
			    		cookie.setMaxAge(60*60*24*7); // 7일
			    		response.addCookie(cookie);
			    		
			    		Date sessionLimit = new Date(System.currentTimeMillis() + (1000*60*60*24*7));
			    		
			    		System.out.println("login session : " + session.getId());
			    		
			    		HashMap<String, Object> map = new HashMap<String, Object>();
			    		map.put("userid", userid);
			    		map.put("sessionId", session.getId());
			    		map.put("sessionLimit", sessionLimit);
			    		
			    		// 세션 id 와 유효시간 저장
			    		service.keepLogin(map);
			    		
			    	}
			    	
			    	if(session.getAttribute("gobackURL") != null) {
			    		// 세션에 저장된 돌아갈 페이지 주소(gobackURL)가 있다라면 
			    		
			    		String gobackURL = (String) session.getAttribute("gobackURL");
			    		mav.addObject("gobackURL", gobackURL); // request 영역에 저장시키는 것이다.
			    		
			    		session.removeAttribute("gobackURL");  // 중요!!!!
			    	}
			    	
			    	mav.setViewName("member/loginEnd.notiles");
			    }
			}
			
		}
		
		return mav;
	}
	
	
	// === 마이페이지 ===//
	@RequestMapping(value="/modifyInfo.action")
	public ModelAndView modifyInfo(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		
		//System.out.println("idx : " + idx);
		if(loginuser != null || loginCookie != null) {
			MemberVO mvo = service.modifyInfo(String.valueOf(loginuser.getIdx()));
			
			try {
				mvo.setHp2(aes.decrypt(mvo.getHp2()));
				mvo.setHp3(aes.decrypt(mvo.getHp3()));
				mvo.setEmail(aes.decrypt(mvo.getEmail()));
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			mav.addObject("mvo", mvo);
			mav.setViewName("member/modifyInfo.notiles");
		}
		else {
			mav.setViewName("member/login.notiles");
		}
		
		return mav;
	}
	
	
	// === 회원 수정 === //
	@RequestMapping(value="/modifyEnd.action", method= {RequestMethod.POST})
	public ModelAndView modifyEnd(ModelAndView mav, HttpServletRequest request) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String idx = String.valueOf(loginuser.getIdx());
		String pwd = request.getParameter("pwd");
		
		if(!pwd.equalsIgnoreCase("")) {
			pwd = Sha256.encrypt(pwd);
		}
		
		HashMap<String, String> paraMap = new HashMap<>();
		
		paraMap.put("idx", idx);
		paraMap.put("pwd", pwd);
		paraMap.put("name", request.getParameter("name"));
		paraMap.put("postcode", request.getParameter("postcode"));
		paraMap.put("address", request.getParameter("address"));
		paraMap.put("address", request.getParameter("address"));
		paraMap.put("detailAddress", request.getParameter("detailAddress"));
		paraMap.put("hp1", request.getParameter("hp1"));
		try {
			paraMap.put("hp2", aes.encrypt(request.getParameter("hp2")));
			paraMap.put("hp3", aes.encrypt(request.getParameter("hp3")));
			paraMap.put("email", aes.encrypt(request.getParameter("email")));
		} catch (UnsupportedEncodingException | GeneralSecurityException e) {
			e.printStackTrace();
		}

		
		String isSMS = request.getParameter("isSMS");
		String isEMAIL = request.getParameter("isEMAIL");
		
		if(isSMS == null) {
			isSMS = "0";
		}
		if(isEMAIL == null) {
			isEMAIL = "0";
		}
		paraMap.put("isSMS", isSMS);
		paraMap.put("isEMAIL", isEMAIL);
		
		//System.out.println("sms : " +isSMS);
		//System.out.println("email : " +isEMAIL);
		
		int n = service.modifyEnd(paraMap);

		String msg = "";
		String loc = "";
		
		if(n==1) {
			msg = "수정이 완료되었습니다.";
			loc = request.getContextPath() + "/yes24.action";
		}
		else {
			msg = "수정 실패했습니다.";
			loc = "javascript:history.back()";
		}
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	
	// == 회원탈퇴 == //
	@RequestMapping(value="/infoDelete.action", method= {RequestMethod.POST})
	public ModelAndView infoDelete(HttpServletRequest request, ModelAndView mav, HttpServletResponse response) {
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		String idx = String.valueOf(loginuser.getIdx());
		String pwd = request.getParameter("pwd");
		
		HashMap<String, String> paraMap = new HashMap<String, String>();
		
		paraMap.put("idx", idx);
		paraMap.put("pwd", Sha256.encrypt(pwd));
		
		int n = service.infoDelete(paraMap);
		

		String msg = "";
		String loc = "";
		
		if(n==1) {
			
			
			session.invalidate();
			
			Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
			
			if(loginCookie != null) {
				loginCookie.setMaxAge(0);
				loginCookie.setPath("/");
				response.addCookie(loginCookie);
			}
			
			msg = "회원 탈퇴되었습니다.";
			loc = request.getContextPath() + "/yes24.action";
		}
		else {
			msg = "다시 시도해주세요.";
			loc = "javascript:history.back()";
		}
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		
		return mav;
	}
	
	
	@RequestMapping(value="/findID.action")
	public ModelAndView findID(HttpServletRequest request, ModelAndView mav) {
		
		String method = request.getMethod();
		
		if("get".equalsIgnoreCase(method)) {
			mav.setViewName("member/findID.notiles");	
		}
		else {
			
			String name = request.getParameter("name");
			String mobile = request.getParameter("mobile");
			
			try {
				mobile = mobile.substring(0,3) + aes.encrypt(mobile.substring(3,7)) + aes.encrypt( mobile.substring(7));
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			HashMap<String, String> paraMap = new HashMap<String,String>();
			
			paraMap.put("name", name);
			paraMap.put("mobile", mobile);
			
			String userid = service.findID(paraMap);
			
			if(userid != null) {
				mav.addObject("userid", userid);
				mav.setViewName("member/findIDResult.notiles");
			}
			else {
				String loc = "javascript:history.back()";
				String msg = "다시 입력해주세요.";
				
				mav.addObject("loc", loc);
				mav.addObject("msg", msg);
				mav.setViewName("msg");
				
			}
			
		}
		
		
		return mav;
	}
	
	
	@RequestMapping(value="/findPW.action")
	public ModelAndView findPW(HttpServletRequest request ,ModelAndView mav) {
		
		String method = request.getMethod();
		
		if("get".equalsIgnoreCase(method)) {
			mav.addObject("method", method);
		}
		else {
			String userid = request.getParameter("userid");
			String email = request.getParameter("email");
			
			HashMap<String, String> paraMap = new HashMap<String, String>();
			
			try {
				paraMap.put("userid", userid);
				paraMap.put("email", aes.encrypt(email));
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			String findPW = service.findPW(paraMap);
			
			// System.out.println("findPW : " + findPW);
			
			int n = 0;
			
			if(findPW != null) {
				n = 1;
				
				Random rnd = new Random();
				String certificationCode = "";
				
				char randchar = ' ';
				for(int i = 0; i<5; i++) {
					randchar = (char) (rnd.nextInt('z' - 'a' + 1) + 'a');
					certificationCode += randchar;
				}
			
				int randnum = 0;
				for(int i=0;i<7;i++) {
					randnum = rnd.nextInt(9 - 0 + 1) + 0;
					certificationCode += randnum;
				}
				
				GoogleMail mail = new GoogleMail();
				
				HttpSession session = request.getSession();
				
				try {
					mail.sendmail(email, certificationCode);
					session.setAttribute("certificationCode", certificationCode);
				} catch (Exception e) {
					e.printStackTrace();
					n = -1;
				}
				
			}
			else {
				n = 0;
			}
			
			mav.addObject("n", n);
			mav.addObject("userid", userid);
			mav.addObject("email", email);
			mav.addObject("method", method);
			
		}
		
		mav.setViewName("member/findPW.notiles");
		
		return mav;
	}
	
	
	// == 인증코드 검사 == //
	@RequestMapping(value="/verifyCertification.action")
	public ModelAndView verifyCertification(HttpServletRequest request ,ModelAndView mav) {
		
		String userid = request.getParameter("userid");
		String userCertificationCode = request.getParameter("userCertificationCode");
		
		HttpSession session = request.getSession();
		String certificationCode = (String) session.getAttribute("certificationCode");
		
		String msg = "";
	 	String loc = "";
	 	
	 	if( certificationCode.equals(userCertificationCode) ) {
	 		mav.addObject("userid", userid);
	 		mav.setViewName("member/updatePW.notiles");
	 	}
	 	else {
	 		msg = "발급된 인증코드가 아닙니다. 인증코드를 다시 발급받으세요.";
	 		loc = request.getContextPath()+"/findPW.action";
			
			mav.addObject("loc", loc);
			mav.addObject("msg", msg);
			mav.setViewName("msg");
	 	}

	 	
	 	
		return mav;
	}
	
	
	@RequestMapping(value="/updatePW.action")
	public ModelAndView updatePW(HttpServletRequest request ,ModelAndView mav) {
		
		String method = request.getMethod();
		String userid = request.getParameter("userid");
		
		if("post".equalsIgnoreCase(method)) {
			String pwd = request.getParameter("pwd");
			
			HashMap<String, String> paraMap = new HashMap<>();
			
			paraMap.put("userid", userid);
			paraMap.put("pwd", Sha256.encrypt(pwd));
			
			int n = service.updatePW(paraMap);
			
			String loc = "";
			String msg = "";
			
			if(n == 1) {
				loc = request.getContextPath() + "/login.action";
				msg = "비밀번호가 변경되었습니다. 바뀐 비밀번호로 로그인해주세요.";
			}
			else {
				loc = "javascript:history.back()";
				msg = "다시 입력해주세요.";
			}
			mav.addObject("loc", loc);
			mav.addObject("msg", msg);
			mav.setViewName("msg");
			
		}
		else {
			
			mav.setViewName("member/updatePW.notiles");
			
		}
		
		
		return mav;
	}
	
	
	// -- 마이페이지 보기 -- //
	@RequestMapping(value="/myPage.action")
	public ModelAndView myPage(HttpServletRequest request, ModelAndView mav) {
		
		
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		Cookie loginCookie = WebUtils.getCookie(request, "loginCookie");
		
		if(loginuser != null || loginCookie != null) {
		
			List<HashMap<String,String>> pointList = service.pointList(loginuser.getUserid());
			
			//System.out.println("pointList : " + pointList.size());
			//System.out.println(pointList.get(0).get("fk_rev_date"));
			
			mav.addObject("pointList", pointList);
			mav.setViewName("member/myPage.tiles1");
		}
		else {
			mav.setViewName("member/login.notiles");
		}
		
		return mav;
	}
	
	
}
