package com.spring.controller;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

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
	
	
	// == 예매하기 클릭 시, 좌석선택 및 시간, 할인 팝업창 띄우기 == //
	@RequestMapping(value="/reservePopUp.action")
	public ModelAndView requiredLogin_reservePopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {

/*
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		mav.addObject("loginuser", loginuser);
		
		String showNum = request.getAttribute("showNum");
		ShowVO show = service.getShowInfo(showNum); // 공연 전체 정보를 집어넣을 필요 있을까?
		
		mav.addObject("show", show);
*/
		mav.setViewName("reserve/seat.notiles");
		return mav;
	}
	
	
	// == 결제 실행 API 띄우기 == //
	@RequestMapping(value="/payPopUp.action")
	public ModelAndView requiredLogin_payPopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	/*
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		mav.addObject("loginuser", loginuser);
		
		String showNum = request.getAttribute("showNum");
		ShowVO show = service.getShowInfo(showNum); // 공연 전체 정보를 집어넣을 필요 있을까?
		
		mav.addObject("show", show);
*/
//		HashMap<String, String> payMap = new HashMap<>(); // 결제창에 보낼 정보 여러개일까..?
//		mav.addObject("payMap", payMap);
		
		String sum = request.getParameter("sum");
		
		mav.addObject("sum", sum);
		
		mav.setViewName("reserve/paymentGateway.jsp");
		return mav;
	}
	
	// == 결제 후 에매 확인 창 띄우기 == //
	@RequestMapping(value="/reserveCheck.action")
	public ModelAndView requriedLogin_reserveCheck(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 예매 db 에 예메 확인 처리 ㄱㄱ
		
		return mav;
	}
	
	
}
