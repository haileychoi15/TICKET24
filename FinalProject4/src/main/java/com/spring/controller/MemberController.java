package com.spring.controller;

import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

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
	public ModelAndView logout(HttpServletRequest request, ModelAndView mav) {
		
		HttpSession session = request.getSession();
		session.invalidate();
		
		String msg = "로그아웃 되었습니다.";
		String loc = request.getContextPath()+"/yes24.action";
		
		mav.addObject("msg", msg);
		mav.addObject("loc", loc);
		
		mav.setViewName("msg");
		
		return mav;
	}
	
	
	// == 일반 회원가입 == //
	@RequestMapping(value="/register.action", produces="text/plain;charset=UTF-8")
	public ModelAndView register(ModelAndView mav, HttpServletRequest request) {
		
		String method = request.getMethod();
		
		// System.out.println(method);
		if("GET".equalsIgnoreCase(method)) {
			mav.setViewName("member/register.notiles");
		}
		else {
			
			try {
			
				String name = request.getParameter("name");
				String userid = request.getParameter("userid");
				String pwd = request.getParameter("pwd");
				String email = request.getParameter("email");
				String hp1 = request.getParameter("hp1");
				String hp2 = request.getParameter("hp2");
				String hp3 = request.getParameter("hp3");
				String postcode = request.getParameter("postcode");
				String address = request.getParameter("address");
				String detailAddress = request.getParameter("detailAddress");
				String extraAddress= request.getParameter("extraAddress");
				String gender = request.getParameter("gender");
				String birthyyyy = request.getParameter("birthyyyy");
				String birthmm = request.getParameter("birthmm");
				String birthdd = request.getParameter("birthdd");
				
				// *** 클라이언트의 IP 주소 알아오기 *** //
				String clientip = request.getRemoteAddr();
				
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
				membervo.setExtraAddress(extraAddress);
				membervo.setGender(gender);
				membervo.setBirthyyyy(birthyyyy);
				membervo.setBirthmm(birthmm);
				membervo.setBirthdd(birthdd);
				membervo.setClientip(clientip);
				
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
	public ModelAndView loginEnd(HttpServletRequest request, ModelAndView mav) {
		
		String userid = request.getParameter("userid");
		String pwd = request.getParameter("pwd");
		
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
	
	
	
	
	
	
}
