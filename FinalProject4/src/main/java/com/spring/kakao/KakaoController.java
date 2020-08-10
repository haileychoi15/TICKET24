package com.spring.kakao;


import java.io.UnsupportedEncodingException;
import java.security.GeneralSecurityException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.spring.common.AES256;
import com.spring.common.Sha256;
import com.spring.model.MemberVO;
import com.spring.service.InterMemberService;


@Controller
public class KakaoController {

    @Autowired
    private KakaoAPI kakao;
    
	@Autowired // Type에 따라 알아서 Bean 을 주입해준다.
	private InterMemberService service;
    
	@Autowired
	private AES256 aes;
	
	//카카오로그인 성공시 callback호출 메소드
	@RequestMapping(value="/KakaoLoginEnd.action")
	public ModelAndView KakaoLoginEnd(ModelAndView mav, HttpServletRequest request, @RequestParam("code") String code) {
		
		//System.out.println("code : " +code);
        String access_Token = kakao.getAccessToken(code);
        //System.out.println("controller access_token : " + access_Token);
		
        HashMap<String, Object> userInfo = kakao.getUserInfo(access_Token);
        System.out.println("login Controller : " + userInfo);
        
        String id = (String) userInfo.get("id");
        String name = (String) userInfo.get("nickname");
        String email = (String) userInfo.get("email");
        String gender = (String) userInfo.get("gender");
        
        String clientip = request.getRemoteAddr(); // 클라이언트 ip 주소
        
        if(gender.equalsIgnoreCase("male")) {
        	gender = "1";
        }
        else {
        	gender = "2";
        }
        
        //System.out.println("id : " + id);
        //System.out.println("gender : " + gender);
		
		HashMap<String, String> paraMap = new HashMap<>();
		//paraMap.put("userid", id);
		paraMap.put("name", name);
		paraMap.put("email", email);
		paraMap.put("gender", gender);
		paraMap.put("clientip", clientip);
		
		try {
			paraMap.put("email", aes.encrypt(email));
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		} catch (GeneralSecurityException e) {
			e.printStackTrace();
		}
		
		// System.out.println("암호화 email : " + paraMap.get("email"));
		
		// System.out.println("userid : " + paraMap.get("userid"));
		
		
		MemberVO loginuser = service.kakaoMember(paraMap);	// 회원 정보가 있는지 확인
		
		//System.out.println(loginuser);
		
		if(loginuser == null) {
			
			String msg = "기본 정보를 입력해주세요.";
			
			paraMap.put("email", email); // 원래의 이메일(암호화 안한거)
			
			mav.addObject("msg", msg);
			mav.addObject("paraMap", paraMap);
			mav.setViewName("member/kakaoRegister.notiles");
			
			return mav;
		}
		
		else {
			loginuser.setEmail(email);
			
			try {
				email = aes.encrypt(email);
				service.kakaoStatus(email);
			} catch (UnsupportedEncodingException | GeneralSecurityException e) {
				e.printStackTrace();
			}
			
			HttpSession session = request.getSession();
			session.setAttribute("loginuser", loginuser);
			
			mav.setViewName("member/loginEnd.notiles");
	        
			return mav;
		}
	}
	
	
	@RequestMapping(value="/kakaoRegister.action", method= {RequestMethod.POST})
	public ModelAndView kakaoRegister(ModelAndView mav, HttpServletRequest request) {
		
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
			
			int n = service.kakaoRegister(membervo);
			
			String msg = "";
			String loc = "";
			
			if(n==1) {
				msg = "회원가입 성공";
				loc = "https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=0ce82228a182b543337d77406ca58a08&redirect_uri=http://localhost:9090/board/KakaoLoginEnd.action";
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
