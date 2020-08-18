package com.spring.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hpsf.Array;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.spring.model.MemberVO;
import com.spring.service.InterPayService;

@Component
@Controller
public class PayController {

	@Autowired
	private InterPayService service;
	
	// == 예매하기 클릭 시, 좌석선택 및 시간, 할인 팝업창 띄우기 == //
	@RequestMapping(value="/reservePopUp.action")
	/*public ModelAndView requiredLogin_reservePopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {*/
	public ModelAndView reservePopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
/*
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		mav.addObject("loginuser", loginuser);
		
		String showNum = request.getAttribute("prodID");
*/
		String showNum = "1";
		mav.addObject("showNum", showNum);
		
		HashMap<String, String> getShowRsvInfo = new HashMap<>();
		getShowRsvInfo = service.getShowRsvInfo(showNum);
		mav.addObject("getShowRsvInfo", getShowRsvInfo);
		
		List<String> getShowDay = new ArrayList<>();
		getShowDay = service.getShowDay(showNum);
		mav.addObject("getShowDay", getShowDay);
		
		List<HashMap<String, String>> getShowTime = new ArrayList<>();
		getShowTime = service.getShowTime(showNum);
		mav.addObject("getShowTime", getShowTime);
		
		// 좌석타입종류
		List<HashMap<String, String>> getSeatType = new ArrayList<>();
		getSeatType = service.getSeatType(showNum);
		mav.addObject("getSeatType", getSeatType);
		
		mav.setViewName("reserve/seat.notiles");
		return mav;
	}
	
	// == 시간, 회차에 따른 좌석상태 ajax == //
	@ResponseBody
	@RequestMapping(value="/seatStatus.action", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	/*public String requiredLogin_seatStatus(HttpServletRequest request, HttpServletResponse response) {*/
	public String seatStatus(HttpServletRequest request, HttpServletResponse response) {
	
		String showDay = request.getParameter("showDay");
		String showRound = request.getParameter("showRound");
		String showNum = request.getParameter("prodID");
		
		HashMap<String, String> seatMap = new HashMap<>();
		seatMap.put("showDay", showDay);
		seatMap.put("showRound", showRound);
		seatMap.put("showNum", showNum);
		String dateID = service.getDateId(seatMap);
		
		JSONArray jsonArr = new JSONArray();
		
		List<HashMap<String, String>> getSeatStatus = service.getSeatStatus(dateID);
		
		if(getSeatStatus != null) {
			for(HashMap<String, String> seatStatus : getSeatStatus ) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("date_id", seatStatus.get("date_id"));
				jsonObj.put("prod_id", seatStatus.get("prod_id"));
				jsonObj.put("seattype_id", seatStatus.get("seattype_id"));
				jsonObj.put("seat_type", seatStatus.get("seat_type"));
				jsonObj.put("seat_name", seatStatus.get("seat_name"));
				jsonObj.put("seat_price", seatStatus.get("seat_price"));
				jsonObj.put("seat_status", seatStatus.get("seat_status"));
				jsonObj.put("date_id", seatStatus.get("date_id"));
				jsonObj.put("seat_color", seatStatus.get("seat_color"));
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
		
	
	
	// == 결제 실행 API 띄우기 == //
	@RequestMapping(value="/payPopUp.action")
	/*public ModelAndView requiredLogin_payPopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {*/
	public ModelAndView payPopUp(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	/*
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		mav.addObject("loginuser", loginuser);
*/
		
		String payMethodNum = request.getParameter("payNum"); // 결제 방법
		
		String payShowName = request.getParameter("payShowName"); // 공연 코드
		String paySum = request.getParameter("paySum"); // 공연 금액 다시 확인해봐야 함
		String seatId = request.getParameter("seatId"); // 좌석코드
		String payStatus = "1"; // ( 무통장입금이면 결제대기, 바로 결제완료라면 결제완료, 취소할경우 취소 )
		String email = "";
		
		
		/*
		좌석코드		예매페이지 ( 여러개일 경우 : 데이터 여러개 )
		공연일시코드	예매페이지
		예매자이메일	예매페이지
		예매수		예매페이지
		예매일자		default
		예매가격		예매페이지
		수령방법		예매페이지
		결제방법		예매페이지 
		*/
		
		System.out.println("공연이름 :" + seatId);
		
		
		
		if("1".equals(payMethodNum)) { // 신용카드 결제일 경우
			mav.setViewName("reserve/paymentGateway.notiles");
		}
		else { // 무통장입금일 경우
			
			// 무통장입금일 경우 트랜잭션
			
			mav.setViewName("reserve/payComplete.notiles");
		}
		
		return mav;
	}
	
	// == 결제 실행 API 띄우기 == //
	@RequestMapping(value="/payComplete.action")
	/*public ModelAndView requiredLogin_payComplete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {*/
	public ModelAndView payComplete(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
	/*
		HttpSession session = request.getSession();
		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
		
		mav.addObject("loginuser", loginuser);
		
		String showNum = request.getAttribute("showNum");
		ShowVO show = service.getShowInfo(showNum); // 공연 전체 정보를 집어넣을 필요 있을까?
		
		mav.addObject("show", show);
*/
//			HashMap<String, String> payMap = new HashMap<>(); // 결제창에 보낼 정보 여러개일까..?
//			mav.addObject("payMap", payMap);
		
		
		// 결제 성공했을 경우 트랜잭션
		
		mav.setViewName("reserve/payComplete.notiles");
		return mav;
	}
	
	// == 결제 후 에매 확인 창 띄우기 == //
	@RequestMapping(value="/reserveCheck.action")
	public ModelAndView requriedLogin_reserveCheck(HttpServletRequest request, HttpServletResponse response, ModelAndView mav) {
		
		// 예매 db 에 예메 확인 처리 ㄱㄱ
		
		return mav;
	}
	
	// == 사용가능한 쿠폰 목록가져오기 == //
	@ResponseBody
	@RequestMapping(value="/takeCoupon.action", method= {RequestMethod.POST}, produces="text/plain;charset=UTF-8")
	/*public String requriedLogin_takeCoupon(HttpServletRequest request, HttpServletResponse response) {*/
	public String takeCoupon(HttpServletRequest request, HttpServletResponse response) {
	
//		HttpSession session = request.getSession();
//		MemberVO loginuser = (MemberVO) session.getAttribute("loginuser");
//		
//		String userid = loginuser.getUserid();
		String userid = "guzi10";

		JSONArray jsonArr = new JSONArray();
		
		List<HashMap<String, String>> takeCoupon = service.takeCoupon(userid);
		
		if(takeCoupon != null) {
			for(HashMap<String, String> coupon : takeCoupon ) {
				JSONObject jsonObj = new JSONObject();
				jsonObj.put("coupon_dc", coupon.get("coupon_dc"));
				jsonObj.put("coupon_name", coupon.get("coupon_name"));
				
				jsonArr.put(jsonObj);
			}
		}
		
		return jsonArr.toString();
	}
	
	
}
