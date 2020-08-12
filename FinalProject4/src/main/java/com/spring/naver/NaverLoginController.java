package com.spring.naver;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
 
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.spring.common.AES256;
import com.spring.common.Sha256;
import com.spring.model.MemberVO;
import com.spring.naver.NaverLoginBO;
import com.spring.service.InterMemberService;

@Controller
public class NaverLoginController {

	/* NaverLoginBO */
	private NaverLoginBO naverLoginBO;
	private String apiResult = null;
	
	@Autowired
	private void setNaverLoginBO(NaverLoginBO naverLoginBO) {
		this.naverLoginBO = naverLoginBO;
	}
	
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private InterMemberService service;
	
	@Autowired
	private AES256 aes;

	/*
	// === #40. 로그인 폼 페이지 요청 === //
	@RequestMapping(value="/NaverLogin.action")
	public ModelAndView login(ModelAndView mav, Model model, HttpSession session) {
		
		 네이버아이디로 인증 URL을 생성하기 위하여 naverLoginBO클래스의 getAuthorizationUrl메소드 호출 
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		//https://nid.naver.com/oauth2.0/authorize?response_type=code&client_id=sE***************&
		//redirect_uri=http%3A%2F%2F211.63.89.90%3A8090%2Flogin_project%2Fcallback&state=e68c269c-5ba9-4c31-85da-54c16c658125
		System.out.println("네이버:" + naverAuthUrl);
		
		
		//네이버
		session.setAttribute("naverAuthUrl", naverAuthUrl);
		mav.addObject("url", naverAuthUrl);
		mav.setViewName("member/loginform.notiles");
		
		return mav;

	}
	*/
	
	//네이버 로그인 성공시 callback호출 메소드
	@RequestMapping(value = "/NaverLoginEnd.action")
	public ModelAndView NaverLoginEnd(ModelAndView mav, HttpServletRequest request, Model model, @RequestParam String code, @RequestParam String state, HttpSession session) throws IOException, ParseException {
		
		
		OAuth2AccessToken oauthToken;
		oauthToken = naverLoginBO.getAccessToken(session, code, state);
		
		//1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLoginBO.getUserProfile(oauthToken); //String형식의 json데이터
		
		System.out.println(apiResult);
		/** apiResult json 구조
		{"resultcode":"00","message":"success","response":{"id":"60851465","gender":"M","email":"guzi1010@naver.com","name":"\uae40\uc9c4\uc601","birthday":"10-10"}}
		**/
		
		
		//2. String형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);
		JSONObject jsonObj = (JSONObject) obj;
		
		//3. 데이터 파싱
		//Top레벨 단계 _response 파싱
		JSONObject response_obj = (JSONObject)jsonObj.get("response");
		
		//response의 값 파싱
		//String id = (String)response_obj.get("id");
		String name = (String)response_obj.get("name");
		String email = (String)response_obj.get("email");
		String gender = (String)response_obj.get("gender");
		
		String clientip = request.getRemoteAddr(); // 클라이언트 ip 주소
		// System.out.println(gender);
		
        if(gender.equalsIgnoreCase("M")) {
        	gender = "1";
        }
        else {
        	gender = "2";
        }
        
        HashMap<String, String> paraMap = new HashMap<>();
        
        try {
			paraMap.put("email", aes.encrypt(email));
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		}
        
        MemberVO loginuser = service.kakaoMember(paraMap);
		
        
		if(loginuser == null) {

			
			String msg = "먼저 회원 등록해주세요.";
			
			paraMap.put("email", email); // 원래의 이메일(암호화 안한거)
			paraMap.put("gender", gender);
			paraMap.put("name", name);
			paraMap.put("naver", "1");
			
			mav.addObject("msg", msg);
			mav.addObject("paraMap", paraMap);
			mav.setViewName("member/join.notiles");
			
			return mav;
		}
		else {
			loginuser.setEmail(email);
			
			try {
				email = aes.encrypt(email);
				service.naverStatus(email);
			} catch (GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			
			session.setAttribute("loginuser", loginuser);
			
			mav.setViewName("member/loginEnd.notiles");
	        
			return mav;
			
		}
		
		//session.setAttribute("sessionId", id); //세션 생성
		//model.addAttribute("result", apiResult);
		
	}

	
	@RequestMapping(value="/naverRegister.action", method= {RequestMethod.POST})
	public ModelAndView naverRegister(ModelAndView mav, HttpServletRequest request, HttpSession session) {
		
		String naverAuthUrl = naverLoginBO.getAuthorizationUrl(session);
		
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
			
			//membervo.setExtraAddress(extraAddress);
			//membervo.setGender(gender);
			//membervo.setBirthyyyy(birthyyyy);
			//membervo.setBirthmm(birthmm);
			//membervo.setBirthdd(birthdd);
			//membervo.setClientip(clientip);
			
			int n = service.naverRegister(membervo);
			
			String msg = "";
			String loc = "";
			
			if(n==1) {
				msg = "회원가입 성공";
				loc = naverAuthUrl;
			}
			else {
				msg = "회원가입 실패";
				loc = "javascript:history.back()";
			}
			
			mav.addObject("msg", msg);
			mav.addObject("loc", loc);
			
			mav.setViewName("msg");
			
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		
		
		return mav;
	}
	
	
	
}
