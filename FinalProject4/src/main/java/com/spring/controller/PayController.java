package com.spring.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.spring.service.InterPayService;

@Component
@Controller
public class PayController {

	@Autowired
	private InterPayService service;
	
	
	// == 회원 수정 페이지 비밀번호 확인 == //
	@RequestMapping(value="/Member/MyPage_reconfirm.action")
	public ModelAndView requiredLogin_reconfirm(ModelAndView mav) {
		return mav;
	}
	
	
	// == 회원 수정 페이지 == //
	@RequestMapping(value="/Member/userInfoUpt.action")
	public ModelAndView requiredLogin_userInfoUpt(ModelAndView mav) {
		return mav;
	}
	
	
	// == 테스트 메인페이지 == //
	@RequestMapping(value="/index.action")
	public ModelAndView index(ModelAndView mav) {
		mav.setViewName("main/index.tiles1");
		return mav;
	}
	
	
	// == 예매하기 클릭 시, 결제 팝업창 띄우기 == //
	@RequestMapping(value="/payPopUp.action")
	public ModelAndView requiredLogin_payPopUp(HttpServletRequest request, ModelAndView mav) {
		
//		HttpSession session = request.getSession();
//		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		
//		mav.addObject("loginuser", loginuser);
//		
//		String showNum = request.getAttribute("showNum");
//		ShowVO show = service.getShowInfo(show);
//		
//		mav.addObject("show", show);
		
		mav.setViewName("pay/seat.notiles");
		return mav;
	}
	
	
	// == 결제 실행 API 띄우기 == //
	
}
